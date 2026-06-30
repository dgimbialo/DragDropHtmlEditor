#include "htmlgenerator.h"

#include <QMap>
#include <QRegularExpression>
#include <QStringList>

#include "tftfontmetrics.h"
namespace {
QMap<QString, QString> parseStyle(const QString &style)
{
    QMap<QString, QString> map;
    const QStringList parts = style.split(';', Qt::SkipEmptyParts);
    for (const QString &part : parts) {
        const int colon = part.indexOf(':');
        if (colon < 0) {
            continue;
        }
        const QString key = part.left(colon).trimmed().toLower();
        const QString value = part.mid(colon + 1).trimmed();
        if (!key.isEmpty()) {
            map.insert(key, value);
        }
    }
    return map;
}

QString toStyle(const QMap<QString, QString> &map)
{
    QStringList out;
    for (auto it = map.constBegin(); it != map.constEnd(); ++it) {
        out.push_back(QString("%1:%2").arg(it.key(), it.value()));
    }
    return out.join("; ");
}

QString preserveEmbeds(const QString &innerHtml)
{
    QStringList embeds;
    const QRegularExpression embedRe(R"((?is)<embed\b[^>]*>(?:\s*</embed>)?)");
    QRegularExpressionMatchIterator it = embedRe.globalMatch(innerHtml);
    while (it.hasNext()) {
        embeds.push_back(it.next().captured(0));
    }
    return embeds.join("\n");
}
}

QString HtmlGenerator::insertBeforeSectionEnd(const QString &html, const QString &elementHtml)
{
    const QRegularExpression sectionCloseRe(R"((?is)</section>)");
    const QRegularExpressionMatch m = sectionCloseRe.match(html);
    if (!m.hasMatch()) {
        return html;
    }

    QString out = html;
    out.insert(m.capturedStart(0), QString("  %1\n").arg(elementHtml));
    return out;
}

QString HtmlGenerator::updateElement(const QString &html, const HtmlElementToken &token, const HtmlElementEdit &edit)
{
    QMap<QString, QString> styleMap = parseStyle(token.style);

    styleMap.insert("position", "absolute");
    styleMap.insert("left", QString("%1px").arg(edit.x));
    styleMap.insert("top", QString("%1px").arg(edit.y));
    styleMap.insert("width", QString("%1px").arg(edit.width));
    styleMap.insert("height", QString("%1px").arg(edit.height));
    styleMap.insert("font-size", QString("%1px").arg(edit.fontSize));
    styleMap.insert("font-family", TftFontMetrics::kFontFamily);
    styleMap.insert("box-sizing", "border-box");
    styleMap.remove("right");
    styleMap.remove("bottom");
    styleMap.remove("margin");
    styleMap.remove("inset");

    if (!edit.fgColor.isEmpty()) {
        styleMap.insert("color", edit.fgColor);
    }
    if (!edit.bgColor.isEmpty()) {
        styleMap.insert("background", edit.bgColor);
    }
    if (!edit.textAlign.isEmpty()) {
        styleMap.insert("text-align", edit.textAlign);
    }

    // Vertical text alignment via flexbox
    if (edit.verticalTextAlign == "center") {
        styleMap.insert("display", "flex");
        styleMap.insert("flex-direction", "column");
        styleMap.insert("justify-content", "center");
    } else if (edit.verticalTextAlign == "bottom") {
        styleMap.insert("display", "flex");
        styleMap.insert("flex-direction", "column");
        styleMap.insert("justify-content", "flex-end");
    } else {
        styleMap.remove("display");
        styleMap.remove("flex-direction");
        styleMap.remove("justify-content");
    }

    // Border
    if (edit.borderWidth > 0 && !edit.borderColor.isEmpty()) {
        styleMap.insert("border", QString("%1px solid %2").arg(edit.borderWidth).arg(edit.borderColor));
    } else {
        styleMap.remove("border");
    }
    styleMap.remove("margin-top");
    styleMap.remove("margin-bottom");
    styleMap.remove("margin-left");
    styleMap.remove("margin-right");
    if (edit.marginTop > 0) {
        styleMap.insert("padding-top", QString("%1px").arg(edit.marginTop));
    } else {
        styleMap.remove("padding-top");
    }
    if (edit.marginBottom > 0) {
        styleMap.insert("padding-bottom", QString("%1px").arg(edit.marginBottom));
    } else {
        styleMap.remove("padding-bottom");
    }
    if (edit.marginLeft > 0) {
        styleMap.insert("padding-left", QString("%1px").arg(edit.marginLeft));
    } else {
        styleMap.remove("padding-left");
    }
    if (edit.marginRight > 0) {
        styleMap.insert("padding-right", QString("%1px").arg(edit.marginRight));
    } else {
        styleMap.remove("padding-right");
    }

    QString newOpen = token.openingTag;
    const QString styleStr = toStyle(styleMap);
    if (newOpen.contains(QRegularExpression(R"((?is)style\s*=\s*"[^"]*")"))) {
        newOpen.replace(QRegularExpression(R"((?is)style\s*=\s*"[^"]*")"), QString("style=\"%1\"").arg(styleStr));
    } else {
        newOpen.replace('>', QString(" style=\"%1\">").arg(styleStr));
    }

    QString newInner;
    const QString embeds = preserveEmbeds(token.innerHtml);
    if (!embeds.isEmpty()) {
        newInner += embeds;
    }
    QString textHtml = edit.text.toHtmlEscaped();
    textHtml.replace(QLatin1Char('\n'), QStringLiteral("<br>"));
    newInner += textHtml;

    const QString replacement = newOpen + newInner + token.closingTag;

    QString out = html;
    out.replace(token.startOffset, token.endOffset - token.startOffset, replacement);
    return out;
}
