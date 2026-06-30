#pragma once

#include <QVector>
#include <QString>

struct HtmlElementToken {
    QString tag;
    int startOffset = 0;
    int endOffset = 0;
    QString openingTag;
    QString innerHtml;
    QString closingTag;
    QString style;
    QString text;
    bool hasEmbed = false;
};

class HtmlParser
{
public:
    static QVector<HtmlElementToken> parseElements(const QString &html);
    static QString styleValue(const QString &style, const QString &key);
    static int stylePxValue(const QString &style, const QString &key, int fallback);
    static QString firstTextNode(const QString &innerHtml);
};
