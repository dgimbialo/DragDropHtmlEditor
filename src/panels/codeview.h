#pragma once

#include <QPlainTextEdit>

#include <QList>

class CodeView : public QPlainTextEdit
{
    Q_OBJECT

public:
    struct HighlightRange {
        int start = -1;
        int end = -1;
        QColor color;
    };

    explicit CodeView(QWidget *parent = nullptr);
    void setHighlightRanges(const QList<HighlightRange> &ranges);
};
