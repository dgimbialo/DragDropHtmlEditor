#pragma once

#include <QMap>
#include <QString>

class TftFontMetrics
{
public:
    static int textWidthPx(int fontSize, const QString &text);
    static QList<int> availableSizes();
    static constexpr const char *kFontFamily = "'Square721 BT', Tahoma, Geneva, sans-serif";

private:
    // Fallback tables (used when TftFontManager has no font for the size)
    static const QMap<QChar, int> &charWidths(int fontSize);
    static int defaultCharWidth(int fontSize);
};
