#include "htmlparser.h"

#include <QRegularExpression>

QVector<HtmlElementToken> HtmlParser::parseElements(const QString &html)
{
    QVector<HtmlElementToken> out;

    const QRegularExpression elementRe(
        R"((?is)<(button|label|div|output)\b([^>]*)>(.*?)</\1>)",
        QRegularExpression::DotMatchesEverythingOption | QRegularExpression::CaseInsensitiveOption);

    QRegularExpressionMatchIterator it = elementRe.globalMatch(html);
    while (it.hasNext()) {
        const QRegularExpressionMatch m = it.next();

        HtmlElementToken token;
        token.tag = m.captured(1).toLower();
        token.startOffset = m.capturedStart(0);
        token.endOffset = m.capturedEnd(0);
        token.innerHtml = m.captured(3);

        const QString attrs = m.captured(2);
        token.openingTag = QString("<%1%2>").arg(token.tag, attrs);
        token.closingTag = QString("</%1>").arg(token.tag);

        const QRegularExpression styleRe(R"re((?is)style\s*=\s*"([^"]*)")re");
        const QRegularExpressionMatch styleMatch = styleRe.match(token.openingTag);
        if (styleMatch.hasMatch()) {
            token.style = styleMatch.captured(1);
        }

        token.text = firstTextNode(token.innerHtml);
        token.hasEmbed = token.innerHtml.contains(QRegularExpression(R"((?is)<embed\b)") );

        out.push_back(token);
    }

    return out;
}

QString HtmlParser::styleValue(const QString &style, const QString &key)
{
    const QRegularExpression re(
        QString(R"((?i)(?:^|;)\s*%1\s*:\s*([^;]+))").arg(QRegularExpression::escape(key)));
    const QRegularExpressionMatch m = re.match(style);
    return m.hasMatch() ? m.captured(1).trimmed() : QString();
}

int HtmlParser::stylePxValue(const QString &style, const QString &key, int fallback)
{
    const QString value = styleValue(style, key);
    const QRegularExpression pxRe(R"((\d+))");
    const QRegularExpressionMatch m = pxRe.match(value);
    if (!m.hasMatch()) {
        return fallback;
    }
    return m.captured(1).toInt();
}

QString HtmlParser::firstTextNode(const QString &innerHtml)
{
    QString text = innerHtml;
    text.remove(QRegularExpression(R"((?is)<embed\b[^>]*>(?:\s*</embed>)?)"));
    text.replace(QRegularExpression(R"((?is)<br\s*/?>)"), "\n");
    text.remove(QRegularExpression(R"((?is)<[^>]+>)"));
    text.replace(QLatin1String("\\n"), QLatin1String("\n"));
    return text.trimmed();
}
