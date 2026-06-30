#include "tftfontmanager.h"

#include <QDir>
#include <QFileInfo>

TftFontManager &TftFontManager::instance()
{
    static TftFontManager mgr;
    return mgr;
}

TftFontManager::TftFontManager(QObject *parent)
    : QObject(parent)
{
}

void TftFontManager::loadBuiltinFonts(const QString &fontsDir)
{
    m_fontsDir = fontsDir;
    const QStringList files = TftFont::availableFontFiles(fontsDir);
    for (const QString &path : files)
        loadFontFile(path);
}

bool TftFontManager::loadFontFile(const QString &filePath)
{
    auto *font = new TftFont();
    if (!font->loadFromFile(filePath)) {
        delete font;
        return false;
    }

    const QString name = font->fontName();

    // Replace existing font with same name
    if (m_fonts.contains(name)) {
        delete m_fonts[name];
        m_fonts.remove(name);
    }

    m_fonts.insert(name, font);
    rebuildSizeMap();
    emit fontsChanged();
    return true;
}

void TftFontManager::unloadFont(const QString &fontName)
{
    if (m_fonts.contains(fontName)) {
        delete m_fonts[fontName];
        m_fonts.remove(fontName);
        rebuildSizeMap();
        emit fontsChanged();
    }
}

QStringList TftFontManager::fontNames() const
{
    return m_fonts.keys();
}

TftFont *TftFontManager::font(const QString &fontName)
{
    return m_fonts.value(fontName, nullptr);
}

const TftFont *TftFontManager::font(const QString &fontName) const
{
    return m_fonts.value(fontName, nullptr);
}

TftFont *TftFontManager::fontForSize(int emHeight)
{
    return m_sizeMap.value(emHeight, nullptr);
}

const TftFont *TftFontManager::fontForSize(int emHeight) const
{
    return m_sizeMap.value(emHeight, nullptr);
}

QList<int> TftFontManager::availableSizes() const
{
    QList<int> sizes = m_sizeMap.keys();
    std::sort(sizes.begin(), sizes.end());
    return sizes;
}

int TftFontManager::textWidthPx(int fontSize, const QString &text) const
{
    const TftFont *f = fontForSize(fontSize);
    if (!f)
        return 0;
    return f->textWidthPx(text);
}

int TftFontManager::charWidth(int fontSize, int charCode) const
{
    const TftFont *f = fontForSize(fontSize);
    if (!f)
        return 0;
    return f->charWidth(charCode);
}

QImage TftFontManager::renderText(int fontSize, const QString &text,
                                  uint32_t fgColor, uint32_t bgColor) const
{
    const TftFont *f = fontForSize(fontSize);
    if (!f)
        return {};
    return f->renderText(text, fgColor, bgColor);
}

void TftFontManager::rebuildSizeMap()
{
    m_sizeMap.clear();
    for (auto it = m_fonts.constBegin(); it != m_fonts.constEnd(); ++it) {
        const int em = it.value()->emHeight();
        if (!m_sizeMap.contains(em))
            m_sizeMap.insert(em, it.value());
    }
}
