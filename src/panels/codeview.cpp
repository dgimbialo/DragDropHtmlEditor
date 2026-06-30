#include "codeview.h"

#include <QColor>
#include <QTextCursor>
#include <QTextEdit>
#include <QTextFormat>

CodeView::CodeView(QWidget *parent)
    : QPlainTextEdit(parent)
{
    setReadOnly(false);
    setCenterOnScroll(true);
    setPlaceholderText("HTML code view (selection-synced) will appear here.");
}

void CodeView::setHighlightRanges(const QList<CodeView::HighlightRange> &ranges)
{
    QList<QTextEdit::ExtraSelection> selections;

    for (const HighlightRange &range : ranges) {
        if (range.start < 0 || range.end <= range.start) {
            continue;
        }

        QTextEdit::ExtraSelection selection;
        selection.format.setBackground(range.color);
        selection.format.setProperty(QTextFormat::FullWidthSelection, true);

        QTextCursor cursor(document());
        cursor.setPosition(range.start);
        cursor.setPosition(range.end, QTextCursor::KeepAnchor);
        selection.cursor = cursor;
        selections.push_back(selection);
    }

    setExtraSelections(selections);
}
