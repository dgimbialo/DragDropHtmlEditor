#pragma once

#include <QListWidget>

class PaletteWidget : public QListWidget
{
    Q_OBJECT

public:
    explicit PaletteWidget(QWidget *parent = nullptr);

signals:
    void elementRequested(const QString &elementType);

private:
    void populate();
    void startDrag(Qt::DropActions supportedActions) override;
};
