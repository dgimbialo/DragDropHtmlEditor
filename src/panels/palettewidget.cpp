#include "palettewidget.h"

#include <QAbstractItemView>
#include <QDrag>
#include <QMimeData>

namespace {
QString normalizeType(const QString &text)
{
    if (text.startsWith("Box", Qt::CaseInsensitive)) {
        return "div";
    }
    if (text.contains("Horizontal", Qt::CaseInsensitive)) {
        return "hline";
    }
    return text.toLower().trimmed();
}
}

PaletteWidget::PaletteWidget(QWidget *parent)
    : QListWidget(parent)
{
    setSelectionMode(QAbstractItemView::SingleSelection);
    setDragEnabled(true);
    setAlternatingRowColors(true);

    connect(this, &QListWidget::itemDoubleClicked, this, [this](QListWidgetItem *item) {
        if (item != nullptr) {
            emit elementRequested(item->text());
        }
    });

    populate();
}

void PaletteWidget::populate()
{
    addItem("Button");
    addItem("Label");
    addItem("Box / Div");
    addItem("Horizontal Line");
    addItem("Output");
}

void PaletteWidget::startDrag(Qt::DropActions supportedActions)
{
    Q_UNUSED(supportedActions);
    QListWidgetItem *item = currentItem();
    if (item == nullptr) {
        return;
    }

    auto *mimeData = new QMimeData();
    mimeData->setData("application/x-tft-element", normalizeType(item->text()).toUtf8());

    auto *drag = new QDrag(this);
    drag->setMimeData(mimeData);
    drag->exec(Qt::CopyAction);
}
