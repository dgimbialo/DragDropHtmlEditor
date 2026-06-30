#include "glypheditorwidget.h"

#include <QKeyEvent>
#include <QMouseEvent>
#include <QPainter>

GlyphEditorWidget::GlyphEditorWidget(QWidget *parent)
    : QWidget(parent)
{
    setMouseTracking(true);
    setFocusPolicy(Qt::StrongFocus);
}

void GlyphEditorWidget::setGlyph(int charCode, int glyphWidth, int bitmapHeight,
                                  const QVector<uint8_t> &bitmap)
{
    m_charCode = charCode;
    m_glyphWidth = glyphWidth;
    m_bitmapHeight = bitmapHeight;
    m_bitmap = bitmap;

    const int expectedBytes = ((glyphWidth + 7) / 8) * bitmapHeight;
    while (m_bitmap.size() < expectedBytes)
        m_bitmap.push_back(0);

    m_selection = QRect();
    m_dragging = false;
    m_selecting = false;
    m_drawing = false;
    m_selectedRow = -1;
    m_selectedCol = -1;

    setFixedSize(sizeHint());
    update();
}

void GlyphEditorWidget::clear()
{
    m_charCode = -1;
    m_glyphWidth = 0;
    m_bitmapHeight = 0;
    m_bitmap.clear();
    m_selection = QRect();
    m_dragging = false;
    m_selectedRow = -1;
    m_selectedCol = -1;
    setFixedSize(sizeHint());
    update();
}

void GlyphEditorWidget::setCellSize(int size)
{
    m_cellSize = qBound(4, size, 64);
    setFixedSize(sizeHint());
    update();
}

void GlyphEditorWidget::clearSelection()
{
    m_selection = QRect();
    m_dragging = false;
    m_selecting = false;
    update();
}

QSize GlyphEditorWidget::sizeHint() const
{
    if (m_glyphWidth <= 0 || m_bitmapHeight <= 0)
        return QSize(200, 200);
    return QSize(kHeaderSize + m_glyphWidth * m_cellSize + 1,
                 kHeaderSize + m_bitmapHeight * m_cellSize + 1);
}

QSize GlyphEditorWidget::minimumSizeHint() const
{
    if (m_glyphWidth <= 0 || m_bitmapHeight <= 0)
        return QSize(100, 100);
    return QSize(kHeaderSize + m_glyphWidth + 1, kHeaderSize + m_bitmapHeight + 1);
}

// ---------------------------------------------------------------------------
// Paint
// ---------------------------------------------------------------------------

void GlyphEditorWidget::paintEvent(QPaintEvent *)
{
    QPainter p(this);
    p.setRenderHint(QPainter::Antialiasing, false);

    p.fillRect(rect(), QColor(244, 246, 252));

    if (m_glyphWidth <= 0 || m_bitmapHeight <= 0) {
        p.setPen(QColor(128, 128, 128));
        p.drawText(rect(), Qt::AlignCenter, "No glyph selected");
        return;
    }

    const QPoint origin = gridOrigin();
    const QColor onColor(28, 34, 51);
    const QColor offColor(255, 255, 255);
    const QColor gridColor(198, 205, 220);

    // Draw cells
    for (int y = 0; y < m_bitmapHeight; ++y) {
        for (int x = 0; x < m_glyphWidth; ++x) {
            const QRect cell(origin.x() + x * m_cellSize,
                             origin.y() + y * m_cellSize,
                             m_cellSize, m_cellSize);
            p.fillRect(cell, pixelAt(x, y) ? onColor : offColor);
            p.setPen(gridColor);
            p.drawRect(cell);
        }
    }

    // Draw dragged pixels overlay
    if (m_dragging && m_selection.isValid()) {
        const QColor dragOnColor(28, 34, 200, 180);
        for (int dy = 0; dy < m_dragBmpHeight; ++dy) {
            for (int dx = 0; dx < m_dragBmpWidth; ++dx) {
                if (!pixelAtInBitmap(m_dragBitmap, m_dragBmpWidth, dx, dy))
                    continue;
                const int sx = m_selection.x() + dx + m_dragOffset.x();
                const int sy = m_selection.y() + dy + m_dragOffset.y();
                const QRect cell(origin.x() + sx * m_cellSize,
                                 origin.y() + sy * m_cellSize,
                                 m_cellSize, m_cellSize);
                p.fillRect(cell, dragOnColor);
            }
        }
    }

    // Grid border
    p.setPen(QPen(QColor(100, 100, 100), 1));
    p.drawRect(origin.x(), origin.y(),
               m_glyphWidth * m_cellSize, m_bitmapHeight * m_cellSize);

    // Row/column numbering
    QFont hdrFont = font();
    hdrFont.setPixelSize(qBound(7, m_cellSize * 2 / 3, 14));
    p.setFont(hdrFont);
    p.setPen(QColor(80, 80, 100));

    for (int x = 0; x < m_glyphWidth; ++x) {
        const QRect r(origin.x() + x * m_cellSize, 0, m_cellSize, kHeaderSize);
        p.drawText(r, Qt::AlignCenter, QString::number(x + 1));
    }
    for (int y = 0; y < m_bitmapHeight; ++y) {
        const QRect r(0, origin.y() + y * m_cellSize, kHeaderSize, m_cellSize);
        p.drawText(r, Qt::AlignCenter, QString::number(y + 1));
    }

    // Highlight selected row or column header
    if (m_selectedCol >= 0 && m_selectedCol < m_glyphWidth) {
        p.setPen(QPen(QColor(255, 60, 60), 2));
        p.setBrush(QColor(255, 60, 60, 50));
        p.drawRect(origin.x() + m_selectedCol * m_cellSize, origin.y(),
                   m_cellSize, m_bitmapHeight * m_cellSize);
        // Highlight header cell
        p.fillRect(origin.x() + m_selectedCol * m_cellSize, 0,
                   m_cellSize, kHeaderSize, QColor(255, 60, 60, 100));
    }
    if (m_selectedRow >= 0 && m_selectedRow < m_bitmapHeight) {
        p.setPen(QPen(QColor(255, 60, 60), 2));
        p.setBrush(QColor(255, 60, 60, 50));
        p.drawRect(origin.x(), origin.y() + m_selectedRow * m_cellSize,
                   m_glyphWidth * m_cellSize, m_cellSize);
        // Highlight header cell
        p.fillRect(0, origin.y() + m_selectedRow * m_cellSize,
                   kHeaderSize, m_cellSize, QColor(255, 60, 60, 100));
    }

    // Draw selection rect
    if (m_selection.isValid() && !m_dragging) {
        p.setPen(QPen(QColor(0, 120, 255), 2, Qt::DashLine));
        p.setBrush(QColor(0, 120, 255, 40));
        const QRect sel(origin.x() + m_selection.x() * m_cellSize,
                        origin.y() + m_selection.y() * m_cellSize,
                        m_selection.width() * m_cellSize,
                        m_selection.height() * m_cellSize);
        p.drawRect(sel);
    }

    // Draw selection rubber-band while selecting
    if (m_selecting) {
        const QRect norm = QRect(m_selStart, m_selEnd).normalized();
        p.setPen(QPen(QColor(0, 120, 255), 1, Qt::DashLine));
        p.setBrush(QColor(0, 120, 255, 30));
        const QRect band(origin.x() + norm.x() * m_cellSize,
                         origin.y() + norm.y() * m_cellSize,
                         (norm.width() + 1) * m_cellSize,
                         (norm.height() + 1) * m_cellSize);
        p.drawRect(band);
    }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

QPoint GlyphEditorWidget::cellFromPos(const QPoint &pos) const
{
    if (m_cellSize <= 0)
        return {-1, -1};
    const QPoint origin = gridOrigin();
    return {(pos.x() - origin.x()) / m_cellSize,
            (pos.y() - origin.y()) / m_cellSize};
}

bool GlyphEditorWidget::isInside(int x, int y) const
{
    return x >= 0 && x < m_glyphWidth && y >= 0 && y < m_bitmapHeight;
}

int GlyphEditorWidget::byteIndex(int x, int y) const
{
    const int bpr = (m_glyphWidth + 7) / 8;
    return y * bpr + (x / 8);
}

bool GlyphEditorWidget::pixelAt(int x, int y) const
{
    if (!isInside(x, y))
        return false;
    const int idx = byteIndex(x, y);
    if (idx >= m_bitmap.size())
        return false;
    return (m_bitmap[idx] >> (x % 8)) & 1;
}

void GlyphEditorWidget::setPixel(int x, int y, bool on)
{
    if (!isInside(x, y))
        return;
    const int idx = byteIndex(x, y);
    if (idx >= m_bitmap.size())
        return;

    if (on)
        m_bitmap[idx] |= static_cast<uint8_t>(1u << (x % 8));
    else
        m_bitmap[idx] &= static_cast<uint8_t>(~(1u << (x % 8)));
}

bool GlyphEditorWidget::pixelAtInBitmap(const QVector<uint8_t> &bmp, int bmpWidth, int x, int y) const
{
    const int bpr = (bmpWidth + 7) / 8;
    const int idx = y * bpr + (x / 8);
    if (idx >= bmp.size())
        return false;
    return (bmp[idx] >> (x % 8)) & 1;
}

void GlyphEditorWidget::commitDrag()
{
    if (!m_selection.isValid())
        return;

    // Erase original pixels
    for (int dy = 0; dy < m_dragBmpHeight; ++dy)
        for (int dx = 0; dx < m_dragBmpWidth; ++dx)
            if (pixelAtInBitmap(m_dragBitmap, m_dragBmpWidth, dx, dy))
                setPixel(m_selection.x() + dx, m_selection.y() + dy, false);

    // Stamp at new location
    for (int dy = 0; dy < m_dragBmpHeight; ++dy) {
        for (int dx = 0; dx < m_dragBmpWidth; ++dx) {
            if (!pixelAtInBitmap(m_dragBitmap, m_dragBmpWidth, dx, dy))
                continue;
            const int nx = m_selection.x() + dx + m_dragOffset.x();
            const int ny = m_selection.y() + dy + m_dragOffset.y();
            if (isInside(nx, ny))
                setPixel(nx, ny, true);
        }
    }

    // Move selection rect
    m_selection.translate(m_dragOffset);
    m_dragOffset = {0, 0};
    m_dragging = false;

    emit glyphModified();
    update();
}

// ---------------------------------------------------------------------------
// Mouse events
// ---------------------------------------------------------------------------

void GlyphEditorWidget::mousePressEvent(QMouseEvent *event)
{
    if (m_glyphWidth <= 0)
        return;

    const QPoint pos = event->pos();
    const QPoint origin = gridOrigin();

    // Left-click in header area: select entire row or column
    if (event->button() == Qt::LeftButton) {
        const bool inColHeader = pos.y() < kHeaderSize && pos.x() >= origin.x();
        const bool inRowHeader = pos.x() < kHeaderSize && pos.y() >= origin.y();

        if (inColHeader) {
            const int col = (pos.x() - origin.x()) / m_cellSize;
            if (col >= 0 && col < m_glyphWidth) {
                if (m_dragging)
                    commitDrag();
                m_selection = QRect();
                m_selectedRow = -1;
                m_selectedCol = col;
                update();
                return;
            }
        }
        if (inRowHeader) {
            const int row = (pos.y() - origin.y()) / m_cellSize;
            if (row >= 0 && row < m_bitmapHeight) {
                if (m_dragging)
                    commitDrag();
                m_selection = QRect();
                m_selectedCol = -1;
                m_selectedRow = row;
                update();
                return;
            }
        }
    }

    // Clear header selection on grid interaction
    m_selectedRow = -1;
    m_selectedCol = -1;

    const QPoint cell = cellFromPos(event->pos());

    // Right-click: start selection
    if (event->button() == Qt::RightButton) {
        if (m_dragging)
            commitDrag();
        m_selecting = true;
        m_selStart = cell;
        m_selEnd = cell;
        m_selection = QRect();
        update();
        return;
    }

    if (event->button() != Qt::LeftButton)
        return;

    // If clicking inside an existing selection, start drag
    if (m_selection.isValid() && m_selection.contains(cell)) {
        m_dragging = true;
        m_dragStart = cell;
        m_dragOffset = {0, 0};
        // Snapshot the selected region
        m_dragBmpWidth = m_selection.width();
        m_dragBmpHeight = m_selection.height();
        const int bpr = (m_dragBmpWidth + 7) / 8;
        m_dragBitmap.fill(0, bpr * m_dragBmpHeight);
        m_dragBitmap.resize(bpr * m_dragBmpHeight);
        for (int dy = 0; dy < m_dragBmpHeight; ++dy) {
            for (int dx = 0; dx < m_dragBmpWidth; ++dx) {
                if (pixelAt(m_selection.x() + dx, m_selection.y() + dy)) {
                    const int idx = dy * bpr + (dx / 8);
                    m_dragBitmap[idx] |= static_cast<uint8_t>(1u << (dx % 8));
                }
            }
        }
        return;
    }

    // Otherwise clear selection and draw
    if (m_dragging)
        commitDrag();
    m_selection = QRect();

    if (!isInside(cell.x(), cell.y()))
        return;

    m_drawing = true;
    m_drawValue = !pixelAt(cell.x(), cell.y());
    setPixel(cell.x(), cell.y(), m_drawValue);
    emit pixelChanged(m_charCode, cell.x(), cell.y(), m_drawValue);
    emit glyphModified();
    update();
}

void GlyphEditorWidget::mouseMoveEvent(QMouseEvent *event)
{
    const QPoint cell = cellFromPos(event->pos());

    // Selection rubber-band
    if (m_selecting && (event->buttons() & Qt::RightButton)) {
        m_selEnd = cell;
        update();
        return;
    }

    // Drag
    if (m_dragging && (event->buttons() & Qt::LeftButton)) {
        m_dragOffset = cell - m_dragStart;
        update();
        return;
    }

    // Drawing
    if (!m_drawing || !(event->buttons() & Qt::LeftButton))
        return;

    if (!isInside(cell.x(), cell.y()))
        return;

    if (pixelAt(cell.x(), cell.y()) != m_drawValue) {
        setPixel(cell.x(), cell.y(), m_drawValue);
        emit pixelChanged(m_charCode, cell.x(), cell.y(), m_drawValue);
        emit glyphModified();
        update();
    }
}

void GlyphEditorWidget::mouseReleaseEvent(QMouseEvent *event)
{
    if (event->button() == Qt::RightButton && m_selecting) {
        m_selecting = false;
        const QRect norm = QRect(m_selStart, m_selEnd).normalized();
        // Clamp to grid
        const int x1 = qBound(0, norm.x(), m_glyphWidth - 1);
        const int y1 = qBound(0, norm.y(), m_bitmapHeight - 1);
        const int x2 = qBound(0, norm.x() + norm.width(), m_glyphWidth - 1);
        const int y2 = qBound(0, norm.y() + norm.height(), m_bitmapHeight - 1);
        m_selection = QRect(QPoint(x1, y1), QPoint(x2, y2));
        if (m_selection.width() <= 0 || m_selection.height() <= 0)
            m_selection = QRect();
        update();
        return;
    }

    if (event->button() == Qt::LeftButton) {
        if (m_dragging) {
            commitDrag();
            return;
        }
        m_drawing = false;
    }
}

void GlyphEditorWidget::keyPressEvent(QKeyEvent *event)
{
    if (event->key() == Qt::Key_Delete) {
        if (m_selectedRow >= 0) {
            emit deleteRowRequested(m_selectedRow);
            m_selectedRow = -1;
            return;
        }
        if (m_selectedCol >= 0) {
            emit deleteColumnRequested(m_selectedCol);
            m_selectedCol = -1;
            return;
        }
    }
    QWidget::keyPressEvent(event);
}
