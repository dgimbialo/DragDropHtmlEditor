#pragma once

#include <QWidget>
#include <QVector>
#include <QRect>
#include <QPoint>

class TftGlyph;

class GlyphEditorWidget : public QWidget
{
    Q_OBJECT

public:
    explicit GlyphEditorWidget(QWidget *parent = nullptr);

    void setGlyph(int charCode, int glyphWidth, int bitmapHeight,
                  const QVector<uint8_t> &bitmap);
    void clear();

    int glyphWidth() const { return m_glyphWidth; }
    int bitmapHeight() const { return m_bitmapHeight; }
    QVector<uint8_t> bitmap() const { return m_bitmap; }
    int charCode() const { return m_charCode; }

    int cellSize() const { return m_cellSize; }
    void setCellSize(int size);

    void clearSelection();

signals:
    void pixelChanged(int charCode, int x, int y, bool on);
    void glyphModified();
    void deleteRowRequested(int row);
    void deleteColumnRequested(int col);

protected:
    void paintEvent(QPaintEvent *event) override;
    void mousePressEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;
    void mouseReleaseEvent(QMouseEvent *event) override;
    void keyPressEvent(QKeyEvent *event) override;
    QSize sizeHint() const override;
    QSize minimumSizeHint() const override;

private:
    static constexpr int kHeaderSize = 18; // px reserved for row/col numbers

    QPoint cellFromPos(const QPoint &pos) const;
    QPoint gridOrigin() const { return {kHeaderSize, kHeaderSize}; }
    bool isInside(int x, int y) const;
    int byteIndex(int x, int y) const;
    bool pixelAt(int x, int y) const;
    void setPixel(int x, int y, bool on);
    bool pixelAtInBitmap(const QVector<uint8_t> &bmp, int bmpWidth, int x, int y) const;
    void commitDrag();

    int m_charCode = -1;
    int m_glyphWidth = 0;
    int m_bitmapHeight = 0;
    int m_cellSize = 16;
    QVector<uint8_t> m_bitmap;

    // Drawing mode
    bool m_drawing = false;
    bool m_drawValue = false;

    // Selection mode
    bool m_selecting = false;
    QPoint m_selStart;       // cell coord
    QPoint m_selEnd;         // cell coord
    QRect m_selection;       // normalized selected rect in cell coords (invalid = no selection)

    // Drag state
    bool m_dragging = false;
    QPoint m_dragStart;      // cell coord where drag began
    QPoint m_dragOffset;     // current drag offset in cells
    QVector<uint8_t> m_dragBitmap;  // snapshot of selected pixels
    int m_dragBmpWidth = 0;
    int m_dragBmpHeight = 0;

    // Header selection (row or column, -1 = none)
    int m_selectedRow = -1;
    int m_selectedCol = -1;
};
