#include "tftfont.h"

#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QPainter>
#include <QRegularExpression>
#include <QTextStream>

// ---------------------------------------------------------------------------
// TftGlyph
// ---------------------------------------------------------------------------

bool TftGlyph::pixelAt(int x, int y, int bitmapHeight) const
{
    if (x < 0 || x >= width || y < 0 || y >= bitmapHeight)
        return false;
    const int bpr = bytesPerRow();
    const int idx = y * bpr + (x / 8);
    if (idx >= bitmap.size())
        return false;
    return (bitmap[idx] >> (x % 8)) & 1;
}

void TftGlyph::setPixel(int x, int y, int bitmapHeight, bool on)
{
    if (x < 0 || x >= width || y < 0 || y >= bitmapHeight)
        return;
    const int bpr = bytesPerRow();
    const int idx = y * bpr + (x / 8);
    if (idx >= bitmap.size())
        return;
    if (on)
        bitmap[idx] |= static_cast<uint8_t>(1u << (x % 8));
    else
        bitmap[idx] &= static_cast<uint8_t>(~(1u << (x % 8)));
}

QImage TftGlyph::toImage(int bitmapHeight) const
{
    if (width <= 0 || bitmapHeight <= 0)
        return {};
    QImage img(width, bitmapHeight, QImage::Format_ARGB32);
    img.fill(Qt::transparent);
    for (int y = 0; y < bitmapHeight; ++y)
        for (int x = 0; x < width; ++x)
            if (pixelAt(x, y, bitmapHeight))
                img.setPixel(x, y, 0xFFFFFFFF);
    return img;
}

// ---------------------------------------------------------------------------
// TftFont — parsing
// ---------------------------------------------------------------------------

bool TftFont::loadFromFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return false;

    const QString content = QString::fromUtf8(file.readAll());
    m_filePath = filePath;
    m_fontName = QFileInfo(filePath).completeBaseName();
    return parseAssembly(content);
}

// Helper: extract all hex bytes (0xNN) from a string
static QVector<uint8_t> parseHexBytes(const QString &line)
{
    QVector<uint8_t> bytes;
    static const QRegularExpression hexRe(R"(0x([0-9A-Fa-f]{1,2}))");
    auto it = hexRe.globalMatch(line);
    while (it.hasNext()) {
        bool ok = false;
        const uint8_t val = static_cast<uint8_t>(it.next().captured(1).toInt(&ok, 16));
        if (ok)
            bytes.push_back(val);
    }
    return bytes;
}

// Helper: extract decimal numbers from a string
static QVector<int> parseDecimals(const QString &line)
{
    QVector<int> nums;
    static const QRegularExpression decRe(R"(\b(\d+)\b)");
    auto it = decRe.globalMatch(line);
    while (it.hasNext()) {
        bool ok = false;
        const int val = it.next().captured(1).toInt(&ok);
        if (ok)
            nums.push_back(val);
    }
    return nums;
}

// Evaluate simple expression like "(  104 &0xff)" or "( 104 >>8)&0xff" or plain number
static int evaluateExpression(const QString &expr)
{
    const QString s = expr.trimmed();

    // Plain decimal
    bool ok = false;
    int val = s.toInt(&ok);
    if (ok)
        return val;

    // Plain hex
    if (s.startsWith("0x", Qt::CaseInsensitive)) {
        val = s.mid(2).toInt(&ok, 16);
        if (ok)
            return val;
    }

    // Expression: ( N &0xff ) or ( N >>8)&0xff
    static const QRegularExpression exprRe(R"(\(\s*(\d+)\s*(>>|&)\s*(0x[0-9a-fA-F]+|\d+)\s*\)\s*(?:&\s*(0x[0-9a-fA-F]+|\d+))?)");
    const auto m = exprRe.match(s);
    if (m.hasMatch()) {
        int base = m.captured(1).toInt();
        const QString op = m.captured(2);
        int operand = 0;
        const QString opStr = m.captured(3);
        if (opStr.startsWith("0x", Qt::CaseInsensitive))
            operand = opStr.mid(2).toInt(nullptr, 16);
        else
            operand = opStr.toInt();

        if (op == ">>")
            base = base >> operand;
        else if (op == "&")
            base = base & operand;

        if (!m.captured(4).isEmpty()) {
            int mask = 0;
            const QString maskStr = m.captured(4);
            if (maskStr.startsWith("0x", Qt::CaseInsensitive))
                mask = maskStr.mid(2).toInt(nullptr, 16);
            else
                mask = maskStr.toInt();
            base = base & mask;
        }
        return base;
    }

    return 0;
}

bool TftFont::parseAssembly(const QString &content)
{
    m_valid = false;
    m_glyphs.clear();

    const QStringList lines = content.split('\n');

    // Phase 1: find the (non-commented) global label and header
    enum ParseState { LookingForHeader, ParsingHeader, ParsingCharMap, ParsingGlyphs };
    ParseState state = LookingForHeader;

    QString globalLabel;
    int headerBytesRead = 0;
    QVector<uint8_t> headerData;
    int charMapEntriesExpected = 0;
    int charMapEntriesRead = 0;

    struct CharEntry {
        int charCode;
        int width;
        int wordOffset;
        bool commented;
    };
    QVector<CharEntry> charEntries;

    // We also track the current glyph we're parsing bitmap data for
    int currentGlyphCharCode = -1;
    int currentGlyphBytesExpected = 0;
    int currentGlyphBytesRead = 0;
    int glyphEntryIdx = 0;

    // Header fields from .pbyte lines
    QVector<uint8_t> allHeaderBytes;

    // Collect all uncommented .pbyte lines to reconstruct the header
    // Strategy: 
    //  1. Find the .global label (non-commented)
    //  2. Parse the 12 header bytes
    //  3. Parse char map entries (3 bytes each)
    //  4. Parse glyph bitmap data

    // Save original header comment lines
    QStringList headerCommentLines;
    bool foundLabel = false;

    // Simpler approach: parse line by line, extracting structured data
    // We know the format:
    //   .pbyte EmHeight
    //   .pbyte TopMargin
    //   .pbyte BottomMargin
    //   .pbyte FirstCharLo, FirstCharHi
    //   .pbyte 0 (reserved)
    //   .pbyte LastCharLo, LastCharHi
    //   .pbyte 0 (reserved)
    //   .pbyte BitmapHeight
    //   .pbyte Baseline
    //   .pbyte MaxWidth
    //   then char map: .pbyte (offset & 0xff), (offset >>8)&0xff, width  ; for each char
    //   then glyph data

    // First pass: collect header comments and find the non-commented font section
    int lineIdx = 0;
    for (; lineIdx < lines.size(); ++lineIdx) {
        const QString line = lines[lineIdx].trimmed();
        if (line.isEmpty())
            continue;
        if (line.startsWith(';')) {
            headerCommentLines.append(lines[lineIdx]);
            continue;
        }
        if (line.contains(".include") || line.contains(".section"))
            continue;
        if (line.contains(".global")) {
            // Extract label name
            static const QRegularExpression globalRe(R"(\.global\s+(\w+))");
            auto m = globalRe.match(line);
            if (m.hasMatch()) {
                globalLabel = m.captured(1);
                if (globalLabel.startsWith('_'))
                    m_fontName = globalLabel.mid(1);
                else
                    m_fontName = globalLabel;
            }
            continue;
        }
        // Label line (e.g., "_Square_12:")
        if (line.endsWith(':')) {
            foundLabel = true;
            continue;
        }
        // First .pbyte after label = start of header
        if (foundLabel && line.contains(".pbyte")) {
            break;
        }
    }

    m_headerComment = headerCommentLines.join('\n');

    // Parse header: collect 12 values from .pbyte lines
    // Header byte order: EmHeight, TopMargin, BottomMargin, FirstCharLo, FirstCharHi, 
    //    reserved, LastCharLo, LastCharHi, reserved, BitmapHeight, Baseline, MaxWidth
    QVector<int> headerValues;

    for (; lineIdx < lines.size() && headerValues.size() < 12; ++lineIdx) {
        const QString line = lines[lineIdx].trimmed();
        if (line.isEmpty() || line.startsWith(';'))
            continue;
        if (!line.contains(".pbyte"))
            continue;

        // Extract the part after .pbyte
        const int pbIdx = line.indexOf(".pbyte");
        QString dataStr = line.mid(pbIdx + 6);
        // Remove comment
        const int commentIdx = dataStr.indexOf(';');
        if (commentIdx >= 0)
            dataStr = dataStr.left(commentIdx);

        // Split by comma and evaluate each
        const QStringList parts = dataStr.split(',');
        for (const QString &part : parts) {
            const QString p = part.trimmed();
            if (p.isEmpty())
                continue;
            headerValues.push_back(evaluateExpression(p));
            if (headerValues.size() >= 12)
                break;
        }
    }

    if (headerValues.size() < 12) {
        // Try minimal header (some fonts might differ)
        if (headerValues.size() >= 10) {
            // Pad missing values
            while (headerValues.size() < 12)
                headerValues.push_back(0);
        } else {
            return false;
        }
    }

    m_emHeight = headerValues[0];
    m_topMargin = headerValues[1];
    m_bottomMargin = headerValues[2];
    m_firstChar = headerValues[3] | (headerValues[4] << 8);
    // headerValues[5] = reserved
    m_lastChar = headerValues[6] | (headerValues[7] << 8);
    // headerValues[8] = reserved
    m_bitmapHeight = headerValues[9];
    m_baseline = headerValues[10];
    m_maxWidth = headerValues[11];

    if (m_bitmapHeight <= 0 || m_firstChar > m_lastChar)
        return false;

    const int numChars = m_lastChar - m_firstChar + 1;

    // Parse character map: 3 values per char (offsetLo, offsetHi, width)
    // Lines like: .pbyte (  104 &0xff), (  104 >>8)&0xff,  5      ; ' '
    int charsRead = 0;
    for (; lineIdx < lines.size() && charsRead < numChars; ++lineIdx) {
        QString line = lines[lineIdx].trimmed();
        if (line.isEmpty())
            continue;

        // Check if this is a commented-out char entry
        bool isCommented = false;
        if (line.startsWith(';')) {
            // Check if it's a commented .pbyte char map entry
            QString uncommented = line.mid(1).trimmed();
            if (uncommented.contains(".pbyte") && (uncommented.contains("&0xff") || uncommented.contains("&0xFF"))) {
                line = uncommented;
                isCommented = true;
            } else {
                continue; // Regular comment, skip
            }
        }

        if (!line.contains(".pbyte"))
            continue;

        // Check if this looks like a char map entry (has the offset expression pattern)
        if (!line.contains("&0x") && !line.contains("&0X") && !line.contains(">>"))
            break; // No more char map entries, moving to glyph data

        // Extract data part
        const int pbIdx = line.indexOf(".pbyte");
        QString dataStr = line.mid(pbIdx + 6);
        const int commentIdx = dataStr.indexOf(';');
        QString commentStr;
        if (commentIdx >= 0) {
            commentStr = dataStr.mid(commentIdx);
            dataStr = dataStr.left(commentIdx);
        }

        // Parse 3 expression values
        // Split carefully - need to handle parenthesized expressions with commas inside
        QVector<int> values;
        int depth = 0;
        QString current;
        for (const QChar &ch : dataStr) {
            if (ch == '(') {
                depth++;
                current += ch;
            } else if (ch == ')') {
                depth--;
                current += ch;
            } else if (ch == ',' && depth == 0) {
                const QString trimmed = current.trimmed();
                if (!trimmed.isEmpty())
                    values.push_back(evaluateExpression(trimmed));
                current.clear();
            } else {
                current += ch;
            }
        }
        const QString lastPart = current.trimmed();
        if (!lastPart.isEmpty())
            values.push_back(evaluateExpression(lastPart));

        if (values.size() >= 3) {
            CharEntry entry;
            entry.charCode = m_firstChar + charsRead;
            entry.wordOffset = values[0] | (values[1] << 8);
            entry.width = values[2];
            entry.commented = isCommented;
            charEntries.push_back(entry);
            charsRead++;
        }
    }

    // Now parse glyph bitmap data
    // Skip any comment lines to find the glyph data section
    // All remaining .pbyte lines contain glyph bitmap data

    // First, collect all remaining glyph bytes in order
    QVector<uint8_t> allGlyphBytes;
    QVector<int> commentedGlyphLines; // track which byte ranges are commented

    // We need to map glyph bytes back to each character
    // The word offsets in charEntries tell us where each glyph starts
    // But since we're reading a text file, we just read sequentially

    // Instead, let's read all remaining .pbyte data sequentially and 
    // assign to glyphs based on expected byte counts

    // Sort charEntries by wordOffset to determine order
    QVector<CharEntry> sortedEntries = charEntries;
    std::sort(sortedEntries.begin(), sortedEntries.end(),
              [](const CharEntry &a, const CharEntry &b) { return a.wordOffset < b.wordOffset; });

    // Read all remaining bytes
    struct GlyphDataBlock {
        int charCode;
        int width;
        int bytesNeeded;  // padded to PIC24 3-byte alignment
        int rawBytes;     // actual bitmap data bytes (unpadded)
        bool commented;
        QVector<uint8_t> data;
    };

    QVector<GlyphDataBlock> glyphBlocks;
    for (const auto &entry : sortedEntries) {
        GlyphDataBlock block;
        block.charCode = entry.charCode;
        block.width = entry.width;
        block.rawBytes = ((entry.width + 7) / 8) * m_bitmapHeight;
        // PIC24 .pbyte data is padded to multiples of 3 bytes per glyph
        block.bytesNeeded = ((block.rawBytes + 2) / 3) * 3;
        block.commented = entry.commented;
        glyphBlocks.push_back(block);
    }

    int currentBlock = 0;

    for (; lineIdx < lines.size() && currentBlock < glyphBlocks.size(); ++lineIdx) {
        QString line = lines[lineIdx].trimmed();
        if (line.isEmpty())
            continue;

        // Skip pure comment lines that aren't commented-out .pbyte data
        bool lineCommented = false;
        if (line.startsWith(';')) {
            QString uncommented = line.mid(1).trimmed();
            if (uncommented.contains(".pbyte") && uncommented.contains("0x")) {
                line = uncommented;
                lineCommented = true;
            } else {
                continue;
            }
        }

        if (!line.contains(".pbyte"))
            continue;

        // Parse hex bytes from this line
        const QVector<uint8_t> bytes = parseHexBytes(line);
        for (const uint8_t b : bytes) {
            if (currentBlock >= glyphBlocks.size())
                break;

            glyphBlocks[currentBlock].data.push_back(b);
            if (glyphBlocks[currentBlock].data.size() >= glyphBlocks[currentBlock].bytesNeeded) {
                currentBlock++;
            }
        }
    }

    // Build glyph map, trimming padding bytes
    for (const auto &block : glyphBlocks) {
        TftGlyph glyph;
        glyph.charCode = block.charCode;
        glyph.width = block.width;
        glyph.commented = block.commented;
        // Keep only the actual bitmap data, discard PIC24 3-byte padding
        glyph.bitmap = block.data.mid(0, block.rawBytes);

        // Ensure bitmap has exactly the right number of bytes
        const int expectedBytes = glyph.bytesPerRow() * m_bitmapHeight;
        if (glyph.bitmap.size() > expectedBytes)
            glyph.bitmap.resize(expectedBytes);
        else
            while (glyph.bitmap.size() < expectedBytes)
                glyph.bitmap.push_back(0);
        
        m_glyphs.insert(block.charCode, glyph);
    }

    // Back-fill entries from charEntries that might not have glyph data
    for (const auto &entry : charEntries) {
        if (!m_glyphs.contains(entry.charCode)) {
            TftGlyph glyph;
            glyph.charCode = entry.charCode;
            glyph.width = entry.width;
            glyph.commented = entry.commented;
            const int expectedBytes = glyph.bytesPerRow() * m_bitmapHeight;
            glyph.bitmap.resize(expectedBytes, 0);
            m_glyphs.insert(entry.charCode, glyph);
        }
    }

    m_valid = !m_glyphs.isEmpty();
    return m_valid;
}

// ---------------------------------------------------------------------------
// TftFont — saving
// ---------------------------------------------------------------------------

bool TftFont::saveToFile(const QString &filePath) const
{
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
        return false;

    const QByteArray data = generateAssembly().toUtf8();
    return file.write(data) == data.size();
}

QString TftFont::generateAssembly() const
{
    QString out;
    QTextStream s(&out);

    // Header comments
    if (!m_headerComment.isEmpty()) {
        s << m_headerComment << "\n";
    } else {
        s << "; TFT Bitmap Font: " << m_fontName << "\n";
        s << "; EmHeight=" << m_emHeight << "  BitmapHeight=" << m_bitmapHeight << "\n";
    }

    s << "\t.include    \"cpu.inc\"\n";
    s << "\t.section    .font,code\n";

    const QString label = m_fontName.startsWith('_') ? m_fontName : ("_" + m_fontName);
    s << "\t.global\t" << label << "\n\n";
    s << label << ":\n";

    s << "\t.pbyte\t" << m_emHeight << "\t;Em Height\n";
    s << "\t.pbyte\t" << m_topMargin << "\t;Top Margin\n";
    s << "\t.pbyte\t" << m_bottomMargin << "\t;Bottom Margin\n";
    s << "\t.pbyte\t0x" << QString::number(m_firstChar & 0xFF, 16).rightJustified(2, '0')
      << ",0x" << QString::number((m_firstChar >> 8) & 0xFF, 16).rightJustified(2, '0')
      << "\t;first character code\n";
    s << "\t.pbyte\t0\t;reserved\n";
    s << "\t.pbyte\t0x" << QString::number(m_lastChar & 0xFF, 16).rightJustified(2, '0')
      << ",0x" << QString::number((m_lastChar >> 8) & 0xFF, 16).rightJustified(2, '0')
      << "\t;last character code\n";
    s << "\t.pbyte\t0\t;reserved\n";
    s << "\t.pbyte\t" << m_bitmapHeight << "\t;Bitmap Height\n";
    s << "\t.pbyte\t" << m_baseline << "\t;Baseline, from top of bitmap\n";
    s << "\t.pbyte\t" << m_maxWidth << "\t;Bitmap Width\n";

    // Calculate word offsets for each glyph
    // Header = 4 words (12 bytes)
    // Char map = numChars words (numChars * 3 bytes, since 3 bytes per entry = 1 word)
    const int numChars = m_lastChar - m_firstChar + 1;
    const int headerWords = 4; // 12 bytes / 3 bytes per word
    const int charMapWords = numChars; // 3 bytes per entry = 1 word each

    int glyphOffset = headerWords + charMapWords;

    struct GlyphInfo {
        int charCode;
        int width;
        int wordOffset;
        bool commented;
    };
    QVector<GlyphInfo> glyphInfos;

    for (int ch = m_firstChar; ch <= m_lastChar; ++ch) {
        GlyphInfo info;
        info.charCode = ch;
        if (m_glyphs.contains(ch)) {
            const TftGlyph &g = m_glyphs[ch];
            info.width = g.width;
            info.commented = g.commented;
        } else {
            info.width = 0;
            info.commented = true;
        }

        info.wordOffset = glyphOffset;

        const int rawBytes = ((info.width + 7) / 8) * m_bitmapHeight;
        const int paddedBytes = ((rawBytes + 2) / 3) * 3;
        const int words = paddedBytes / 3;
        glyphOffset += words;

        glyphInfos.push_back(info);
    }

    // Write char map
    for (const auto &info : glyphInfos) {
        const QString prefix = info.commented ? ";\t" : "\t";
        const int lo = info.wordOffset & 0xFF;
        const int hi = (info.wordOffset >> 8) & 0xFF;

        QString charLabel;
        if (info.charCode >= 0x20 && info.charCode <= 0x7E)
            charLabel = QString("'%1'").arg(QChar(info.charCode));
        else
            charLabel = QString("0x%1").arg(info.charCode, 2, 16, QChar('0'));

        s << prefix << QString(".pbyte\t(%1 &0xff), (%1 >>8)&0xff, %2\t\t; %3\n")
                 .arg(QString::number(info.wordOffset).rightJustified(5),
                      QString::number(info.width).rightJustified(2),
                      charLabel);
    }

    s << "\n";

    // Write glyph bitmap data
    for (const auto &info : glyphInfos) {
        const QString prefix = info.commented ? ";\t" : "\t";

        QString charLabel;
        if (info.charCode >= 0x20 && info.charCode <= 0x7E)
            charLabel = QString("'%1'").arg(QChar(info.charCode));
        else
            charLabel = QString("0x%1").arg(info.charCode, 2, 16, QChar('0'));

        s << "; Character " << QString::number(info.charCode, 16) << " " << charLabel << "\n";

        const TftGlyph *g = glyph(info.charCode);
        const int bpr = (info.width + 7) / 8;

        for (int row = 0; row < m_bitmapHeight; ++row) {
            s << prefix << ".pbyte\t";
            for (int b = 0; b < bpr; ++b) {
                int byteIdx = row * bpr + b;
                uint8_t val = 0;
                if (g && byteIdx < g->bitmap.size())
                    val = g->bitmap[byteIdx];
                s << "0x" << QString::number(val, 16).toUpper().rightJustified(2, '0');
                if (b + 1 < bpr)
                    s << ",";
            }

            // Visual comment showing pixels
            s << "\t\t\t;  |";
            for (int x = 0; x < info.width; ++x) {
                bool on = false;
                if (g)
                    on = g->pixelAt(x, row, m_bitmapHeight);
                s << (on ? '#' : ' ');
            }
            s << "|\n";
        }

        // Padding to multiple of 3 bytes
        const int rawBytes = bpr * m_bitmapHeight;
        const int paddedBytes = ((rawBytes + 2) / 3) * 3;
        const int padCount = paddedBytes - rawBytes;
        if (padCount > 0) {
            s << prefix << ".pbyte\t";
            for (int p = 0; p < padCount; ++p) {
                s << "0x00";
                if (p + 1 < padCount)
                    s << ",";
            }
            s << "\t\t;pad to multiple of 3 bytes\n";
        }
    }

    return out;
}

// ---------------------------------------------------------------------------
// TftFont — accessors
// ---------------------------------------------------------------------------

const TftGlyph *TftFont::glyph(int charCode) const
{
    auto it = m_glyphs.constFind(charCode);
    return it != m_glyphs.constEnd() ? &it.value() : nullptr;
}

TftGlyph *TftFont::glyphMutable(int charCode)
{
    auto it = m_glyphs.find(charCode);
    return it != m_glyphs.end() ? &it.value() : nullptr;
}

QList<int> TftFont::charCodes() const
{
    return m_glyphs.keys();
}

int TftFont::charWidth(int charCode) const
{
    const TftGlyph *g = glyph(charCode);
    return g ? g->width : 0;
}

int TftFont::textWidthPx(const QString &text) const
{
    int total = 0;
    for (const QChar &ch : text) {
        if (ch == '\n')
            continue;
        total += charWidth(ch.unicode());
    }
    return total;
}

// ---------------------------------------------------------------------------
// TftFont — rendering
// ---------------------------------------------------------------------------

QImage TftFont::renderGlyph(int charCode, uint32_t fgColor, uint32_t bgColor) const
{
    const TftGlyph *g = glyph(charCode);
    if (!g || g->width <= 0 || m_bitmapHeight <= 0)
        return {};

    QImage img(g->width, m_bitmapHeight, QImage::Format_ARGB32);
    img.fill(bgColor);

    for (int y = 0; y < m_bitmapHeight; ++y) {
        for (int x = 0; x < g->width; ++x) {
            if (g->pixelAt(x, y, m_bitmapHeight))
                img.setPixel(x, y, fgColor);
        }
    }
    return img;
}

QImage TftFont::renderText(const QString &text, uint32_t fgColor, uint32_t bgColor) const
{
    if (text.isEmpty() || m_bitmapHeight <= 0)
        return {};

    // Calculate total width
    int totalWidth = 0;
    for (const QChar &ch : text) {
        if (ch == '\n')
            continue;
        const TftGlyph *g = glyph(ch.unicode());
        totalWidth += g ? g->width : 0;
    }

    if (totalWidth <= 0)
        return {};

    QImage img(totalWidth, m_bitmapHeight, QImage::Format_ARGB32);
    img.fill(bgColor);

    int xPos = 0;
    for (const QChar &ch : text) {
        if (ch == '\n')
            continue;
        const TftGlyph *g = glyph(ch.unicode());
        if (!g)
            continue;

        for (int y = 0; y < m_bitmapHeight; ++y) {
            for (int x = 0; x < g->width; ++x) {
                if (g->pixelAt(x, y, m_bitmapHeight))
                    img.setPixel(xPos + x, y, fgColor);
            }
        }
        xPos += g->width;
    }

    return img;
}

// ---------------------------------------------------------------------------
// TftFont — editing
// ---------------------------------------------------------------------------

void TftFont::setGlyphCommented(int charCode, bool commented)
{
    if (m_glyphs.contains(charCode))
        m_glyphs[charCode].commented = commented;
}

void TftFont::removeGlyph(int charCode)
{
    m_glyphs.remove(charCode);
}

void TftFont::addGlyph(int charCode, int width)
{
    TftGlyph g;
    g.charCode = charCode;
    g.width = width;
    g.commented = false;
    const int expectedBytes = g.bytesPerRow() * m_bitmapHeight;
    g.bitmap.resize(expectedBytes, 0);
    m_glyphs.insert(charCode, g);

    if (charCode < m_firstChar)
        m_firstChar = charCode;
    if (charCode > m_lastChar)
        m_lastChar = charCode;
}

void TftFont::setGlyphPixel(int charCode, int x, int y, bool on)
{
    TftGlyph *g = glyphMutable(charCode);
    if (g)
        g->setPixel(x, y, m_bitmapHeight, on);
}

void TftFont::setGlyphWidth(int charCode, int newWidth)
{
    TftGlyph *g = glyphMutable(charCode);
    if (!g || newWidth <= 0)
        return;

    const int oldWidth = g->width;
    const int oldBpr = (oldWidth + 7) / 8;
    const int newBpr = (newWidth + 7) / 8;

    QVector<uint8_t> newBitmap(newBpr * m_bitmapHeight, 0);

    // Copy pixel by pixel (preserving what fits)
    const int copyWidth = qMin(oldWidth, newWidth);
    for (int y = 0; y < m_bitmapHeight; ++y) {
        for (int x = 0; x < copyWidth; ++x) {
            if (g->pixelAt(x, y, m_bitmapHeight)) {
                const int idx = y * newBpr + (x / 8);
                newBitmap[idx] |= static_cast<uint8_t>(1u << (x % 8));
            }
        }
    }

    g->width = newWidth;
    g->bitmap = newBitmap;
}

void TftFont::setBitmapHeight(int newHeight)
{
    if (newHeight <= 0 || newHeight == m_bitmapHeight)
        return;

    const int oldHeight = m_bitmapHeight;
    m_bitmapHeight = newHeight;

    // Resize every glyph bitmap
    for (auto it = m_glyphs.begin(); it != m_glyphs.end(); ++it) {
        TftGlyph &g = it.value();
        const int bpr = g.bytesPerRow();
        QVector<uint8_t> newBitmap(bpr * newHeight, 0);
        const int copyRows = qMin(oldHeight, newHeight);
        for (int y = 0; y < copyRows; ++y) {
            for (int b = 0; b < bpr; ++b) {
                const int oldIdx = y * bpr + b;
                if (oldIdx < g.bitmap.size())
                    newBitmap[y * bpr + b] = g.bitmap[oldIdx];
            }
        }
        g.bitmap = newBitmap;
    }

    // Update derived fields
    m_emHeight = m_bitmapHeight - m_topMargin - m_bottomMargin;
    if (m_emHeight < 1)
        m_emHeight = m_bitmapHeight;
}

void TftFont::deleteRow(int row)
{
    if (row < 0 || row >= m_bitmapHeight || m_bitmapHeight <= 1)
        return;

    const int newHeight = m_bitmapHeight - 1;

    for (auto it = m_glyphs.begin(); it != m_glyphs.end(); ++it) {
        TftGlyph &g = it.value();
        const int bpr = g.bytesPerRow();
        QVector<uint8_t> newBitmap(bpr * newHeight, 0);
        int dst = 0;
        for (int y = 0; y < m_bitmapHeight; ++y) {
            if (y == row)
                continue;
            for (int b = 0; b < bpr; ++b) {
                const int srcIdx = y * bpr + b;
                if (srcIdx < g.bitmap.size())
                    newBitmap[dst * bpr + b] = g.bitmap[srcIdx];
            }
            ++dst;
        }
        g.bitmap = newBitmap;
    }

    m_bitmapHeight = newHeight;
    m_emHeight = m_bitmapHeight - m_topMargin - m_bottomMargin;
    if (m_emHeight < 1)
        m_emHeight = m_bitmapHeight;
}

void TftFont::deleteGlyphColumn(int charCode, int col)
{
    TftGlyph *g = glyphMutable(charCode);
    if (!g || col < 0 || col >= g->width || g->width <= 1)
        return;

    const int oldWidth = g->width;
    const int newWidth = oldWidth - 1;
    const int newBpr = (newWidth + 7) / 8;

    QVector<uint8_t> newBitmap(newBpr * m_bitmapHeight, 0);

    for (int y = 0; y < m_bitmapHeight; ++y) {
        int dx = 0;
        for (int x = 0; x < oldWidth; ++x) {
            if (x == col)
                continue;
            if (g->pixelAt(x, y, m_bitmapHeight)) {
                const int idx = y * newBpr + (dx / 8);
                newBitmap[idx] |= static_cast<uint8_t>(1u << (dx % 8));
            }
            ++dx;
        }
    }

    g->width = newWidth;
    g->bitmap = newBitmap;
}

// ---------------------------------------------------------------------------
// TftFont — static helpers
// ---------------------------------------------------------------------------

QStringList TftFont::availableFontFiles(const QString &directory)
{
    QDir dir(directory);
    if (!dir.exists())
        return {};

    const QStringList filters = {"*.s"};
    QStringList result;
    const QFileInfoList entries = dir.entryInfoList(filters, QDir::Files, QDir::Name);
    for (const QFileInfo &fi : entries)
        result.push_back(fi.absoluteFilePath());
    return result;
}
