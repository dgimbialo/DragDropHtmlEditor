#pragma once

#include <QString>

#include "htmlparser.h"

struct HtmlElementEdit {
    int x = 0;
    int y = 0;
    int width = 1;
    int height = 1;
    int fontSize = 12;
    QString text;
    QString fgColor;
    QString bgColor;
    QString textAlign;
    QString verticalTextAlign = "top";
    int borderWidth = 0;
    QString borderColor = "#ffffff";
    int marginTop = 0;
    int marginBottom = 0;
    int marginLeft = 0;
    int marginRight = 0;
};

class HtmlGenerator
{
public:
    static QString insertBeforeSectionEnd(const QString &html, const QString &elementHtml);
    static QString updateElement(const QString &html, const HtmlElementToken &token, const HtmlElementEdit &edit);
};
