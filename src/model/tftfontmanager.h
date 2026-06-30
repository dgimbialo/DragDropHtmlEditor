#pragma once

#include <QMap>
#include <QObject>
#include <QString>

#include "tftfont.h"

class TftFontManager : public QObject
{
    Q_OBJECT

public:
    static TftFontManager &instance();

    void loadBuiltinFonts(const QString &fontsDir);
    bool loadFontFile(const QString &filePath);
    void unloadFont(const QString &fontName);

    QStringList fontNames() const;
    TftFont *font(const QString &fontName);
    const TftFont *font(const QString &fontName) const;

    TftFont *fontForSize(int emHeight);
    const TftFont *fontForSize(int emHeight) const;

    QList<int> availableSizes() const;

    int textWidthPx(int fontSize, const QString &text) const;
    int charWidth(int fontSize, int charCode) const;

    QImage renderText(int fontSize, const QString &text,
                      uint32_t fgColor = 0xFFFFFFFF,
                      uint32_t bgColor = 0x00000000) const;

    QString fontsDirectory() const { return m_fontsDir; }
    void setFontsDirectory(const QString &dir) { m_fontsDir = dir; }

signals:
    void fontsChanged();

private:
    explicit TftFontManager(QObject *parent = nullptr);

    QString m_fontsDir;
    QMap<QString, TftFont *> m_fonts; // fontName -> font
    QMap<int, TftFont *> m_sizeMap;   // emHeight -> font (first loaded wins)

    void rebuildSizeMap();
};
