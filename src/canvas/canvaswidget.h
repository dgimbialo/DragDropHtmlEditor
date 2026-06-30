#pragma once

#include <QWidget>

#include <QColor>
#include <QString>

class QWebEngineView;
class QWebChannel;
class CanvasBridge;
class QDragEnterEvent;
class QDropEvent;

class CanvasWidget : public QWidget
{
    Q_OBJECT

public:
    explicit CanvasWidget(QWidget *parent = nullptr);
    void setHtml(const QString &html);
    QString html() const;
    void highlightElement(int elementIndex);
    void setGridSettings(bool enabled, int step, const QColor &color);
    void setViewerBackgroundColor(const QColor &color);
    void setPreviewCentered(bool centered);
    void setActiveFontInfo(const QString &tftFontName, const QString &systemFontFamily);

signals:
    void elementDropped(const QString &elementType, int x, int y);
    void elementSelected(int elementIndex);
    void elementMoved(int elementIndex, int x, int y);
    void elementResized(int elementIndex, int width, int height);
    void elementGeometryChanged(int elementIndex, int x, int y, int width, int height);

protected:
    void dragEnterEvent(QDragEnterEvent *event) override;
    void dropEvent(QDropEvent *event) override;

private:
    QString buildPreviewHtml(const QString &html) const;
    QString previewBodyStyle() const;
    void loadPlaceholderHtml();
    void installInteractionJs();
    void applyViewerBackground();

    QWebEngineView *m_webView = nullptr;
    QWebChannel *m_channel = nullptr;
    CanvasBridge *m_bridge = nullptr;
    QString m_currentHtml;
    int m_selectedElementIndex = -1;
    bool m_gridEnabled = true;
    int m_gridStep = 10;
    QColor m_gridColor = QColor("#2f4f8f");
    QColor m_viewerBackgroundColor = QColor("#ffffff");
    bool m_previewCentered = true;
    QString m_activeTftFont;
    QString m_activeSystemFont;
};
