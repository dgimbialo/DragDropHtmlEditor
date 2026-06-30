#include "canvasbridge.h"

#include <QBuffer>
#include <QImage>
#include <QRegularExpression>

#include "../model/tftfontmanager.h"

static uint32_t parseCssColor(const QString &color)
{
    if (color.isEmpty())
        return 0xFF000000;

    // Handle CSS rgb(r,g,b) and rgba(r,g,b,a) which QColor can't parse
    static const QRegularExpression rgbRe(
        R"(rgba?\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*(?:,\s*([\d.]+)\s*)?\))");
    const auto m = rgbRe.match(color);
    if (m.hasMatch()) {
        const int r = qBound(0, m.captured(1).toInt(), 255);
        const int g = qBound(0, m.captured(2).toInt(), 255);
        const int b = qBound(0, m.captured(3).toInt(), 255);
        int a = 255;
        if (!m.captured(4).isEmpty())
            a = qBound(0, qRound(m.captured(4).toDouble() * 255.0), 255);
        return static_cast<uint32_t>((a << 24) | (r << 16) | (g << 8) | b);
    }

    const QColor qc(color);
    if (!qc.isValid())
        return 0xFF000000;

    return static_cast<uint32_t>(qc.rgba());
}

CanvasBridge::CanvasBridge(QObject *parent)
    : QObject(parent)
{
}

void CanvasBridge::elementSelectedFromJs(int elementIndex)
{
    emit elementSelected(elementIndex);
}

void CanvasBridge::elementMovedFromJs(int elementIndex, int x, int y)
{
    emit elementMoved(elementIndex, x, y);
}

void CanvasBridge::elementResizedFromJs(int elementIndex, int width, int height)
{
    emit elementResized(elementIndex, width, height);
}

void CanvasBridge::elementGeometryChangedFromJs(int elementIndex, int x, int y, int width, int height)
{
    emit elementGeometryChanged(elementIndex, x, y, width, height);
}

QString CanvasBridge::renderTftText(int fontSize, const QString &text,
                                    const QString &fgColor, const QString &bgColor)
{
    const uint32_t fg = parseCssColor(fgColor);
    const uint32_t bg = 0x00000000; // transparent background - the element's CSS bg handles it

    const QImage img = TftFontManager::instance().renderText(fontSize, text, fg, bg);
    if (img.isNull())
        return {};

    QByteArray ba;
    QBuffer buf(&ba);
    buf.open(QIODevice::WriteOnly);
    img.save(&buf, "PNG");

    return QStringLiteral("data:image/png;base64,") + QString::fromLatin1(ba.toBase64());
}
