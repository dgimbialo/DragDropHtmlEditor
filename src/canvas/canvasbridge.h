#pragma once

#include <QObject>
#include <QString>

class CanvasBridge : public QObject
{
    Q_OBJECT

public:
    explicit CanvasBridge(QObject *parent = nullptr);

    Q_INVOKABLE void elementSelectedFromJs(int elementIndex);
    Q_INVOKABLE void elementMovedFromJs(int elementIndex, int x, int y);
    Q_INVOKABLE void elementResizedFromJs(int elementIndex, int width, int height);
    Q_INVOKABLE void elementGeometryChangedFromJs(int elementIndex, int x, int y, int width, int height);
    Q_INVOKABLE QString renderTftText(int fontSize, const QString &text,
                                      const QString &fgColor, const QString &bgColor);

signals:
    void elementSelected(int elementIndex);
    void elementMoved(int elementIndex, int x, int y);
    void elementResized(int elementIndex, int width, int height);
    void elementGeometryChanged(int elementIndex, int x, int y, int width, int height);
};
