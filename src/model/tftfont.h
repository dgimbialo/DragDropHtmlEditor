#pragma once

#include <QImage>
#include <QMap>
#include <QString>
#include <QVector>

struct TftGlyph {
    int charCode = 0;
    int width = 0;
    int wordOffset = 0;
    QVector<uint8_t> bitmap; // packed row-major, ceil(width/8) bytes per row
    bool commented = false;

    int bytesPerRow() const { return (width + 7) / 8; }
    bool pixelAt(int x, int y, int bitmapHeight) const;
    void setPixel(int x, int y, int bitmapHeight, bool on);
    QImage toImage(int bitmapHeight) const;
};

class TftFont
{
public:
    TftFont() = default;

    bool loadFromFile(const QString &filePath);
    bool saveToFile(const QString &filePath) const;

    bool isValid() const { return m_valid; }
    QString filePath() const { return m_filePath; }
    QString fontName() const { return m_fontName; }

    int emHeight() const { return m_emHeight; }
    int topMargin() const { return m_topMargin; }
    int bottomMargin() const { return m_bottomMargin; }
    int firstChar() const { return m_firstChar; }
    int lastChar() const { return m_lastChar; }
    int bitmapHeight() const { return m_bitmapHeight; }
    int baseline() const { return m_baseline; }
    int maxWidth() const { return m_maxWidth; }

    int charCount() const { return m_lastChar - m_firstChar + 1; }
    const TftGlyph *glyph(int charCode) const;
    TftGlyph *glyphMutable(int charCode);
    QList<int> charCodes() const;

    int charWidth(int charCode) const;
    int textWidthPx(const QString &text) const;

    QImage renderGlyph(int charCode, uint32_t fgColor = 0xFFFFFFFF, uint32_t bgColor = 0x00000000) const;
    QImage renderText(const QString &text, uint32_t fgColor = 0xFFFFFFFF, uint32_t bgColor = 0x00000000) const;

    // Editing
    void setGlyphCommented(int charCode, bool commented);
    void removeGlyph(int charCode);
    void addGlyph(int charCode, int width);
    void setGlyphPixel(int charCode, int x, int y, bool on);
    void setGlyphWidth(int charCode, int newWidth);
    void setBitmapHeight(int newHeight);
    void deleteRow(int row);
    void deleteGlyphColumn(int charCode, int col);

    static QStringList availableFontFiles(const QString &directory);

private:
    bool parseAssembly(const QString &content);
    QString generateAssembly() const;

    bool m_valid = false;
    QString m_filePath;
    QString m_fontName;
    QString m_headerComment;

    int m_emHeight = 0;
    int m_topMargin = 0;
    int m_bottomMargin = 0;
    int m_firstChar = 0x20;
    int m_lastChar = 0x7E;
    int m_bitmapHeight = 0;
    int m_baseline = 0;
    int m_maxWidth = 0;

    QMap<int, TftGlyph> m_glyphs; // charCode -> glyph
};
