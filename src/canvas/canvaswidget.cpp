#include "canvaswidget.h"

#include <QDragEnterEvent>
#include <QDropEvent>
#include <QMimeData>
#include <QRegularExpression>
#include <QVBoxLayout>
#include <QVariantMap>
#include <QWebChannel>
#include <QWebEnginePage>
#include <QWebEngineView>

#include "canvasbridge.h"

CanvasWidget::CanvasWidget(QWidget *parent)
    : QWidget(parent)
{
  setAcceptDrops(true);

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);

    m_webView = new QWebEngineView(this);
    layout->addWidget(m_webView);
    m_webView->page()->setBackgroundColor(m_viewerBackgroundColor);

  m_channel = new QWebChannel(m_webView->page());
  m_bridge = new CanvasBridge(this);
  m_channel->registerObject(QStringLiteral("canvasBridge"), m_bridge);
  m_webView->page()->setWebChannel(m_channel);

    connect(m_bridge, &CanvasBridge::elementSelected, this, &CanvasWidget::elementSelected);
    connect(m_bridge, &CanvasBridge::elementMoved, this, &CanvasWidget::elementMoved);
    connect(m_bridge, &CanvasBridge::elementResized, this, &CanvasWidget::elementResized);
    connect(m_bridge, &CanvasBridge::elementGeometryChanged, this, &CanvasWidget::elementGeometryChanged);
    connect(m_webView, &QWebEngineView::loadFinished, this, [this](bool ok) {
        if (ok) {
            installInteractionJs();
            setGridSettings(m_gridEnabled, m_gridStep, m_gridColor);
            applyViewerBackground();
            highlightElement(m_selectedElementIndex);
        }
    });

    loadPlaceholderHtml();
}

void CanvasWidget::loadPlaceholderHtml()
{
    // Simple starter screen that reflects the intended 480x320 target canvas.
    static const char kPlaceholderHtml[] = R"(
<!DOCTYPE html>
<html lang="uk">
<head>
<meta charset="utf-8" />
<title>TFT Preview</title>
</head>
<body style="margin:0; background:#fff; display:flex; align-items:center; justify-content:center; min-height:100vh;">
<section style="position:relative; width:480px; height:320px; background:#000; box-shadow:0 0 0 1px #2455ff; overflow:visible;">
  <label style="position:absolute; left:0; right:0; top:12px; margin:0 auto; width:max-content; color:#fff; font:700 20px 'Square721 BT', Tahoma, Geneva, sans-serif;">
    TFT HTML Editor Preview
  </label>
  <button style="position:absolute; left:20px; top:70px; width:200px; height:90px; border:0; background:#1c53ba; color:#fff; font:700 20px 'Square721 BT', Tahoma, Geneva, sans-serif;">
    Button
  </button>
  <div style="position:absolute; left:0; top:52px; width:480px; height:1px; background:#1c53ba;"></div>
</section>
</body>
</html>
)";

    setHtml(QString::fromUtf8(kPlaceholderHtml));
}

void CanvasWidget::setHtml(const QString &html)
{
    m_currentHtml = html;
    m_webView->setHtml(buildPreviewHtml(m_currentHtml));
}

QString CanvasWidget::html() const
{
    return m_currentHtml;
}

void CanvasWidget::highlightElement(int elementIndex)
{
    m_selectedElementIndex = elementIndex;
    const QString js = QString(R"(
(() => {
  window.__tftPendingSelectedIndex = %1;
  if (typeof window.__tftApplySelection === 'function') {
    window.__tftApplySelection(%1);
  }
})();
)").arg(elementIndex);
    m_webView->page()->runJavaScript(js);
}

  void CanvasWidget::setPreviewCentered(bool centered)
  {
    m_previewCentered = centered;
    if (!m_currentHtml.isEmpty()) {
      m_webView->setHtml(buildPreviewHtml(m_currentHtml));
      return;
    }
    applyViewerBackground();
  }

void CanvasWidget::setGridSettings(bool enabled, int step, const QColor &color)
{
    m_gridEnabled = enabled;
    m_gridStep = qMax(2, step);
    m_gridColor = color;

    const QString js = QString(R"(
  (() => {
    window.__tftGrid = {
      enabled: %1,
      step: %2,
      color: '%3'
    };
    if (typeof window.__tftApplyGrid === 'function') {
      window.__tftApplyGrid();
    }
  })();
  )")
                             .arg(enabled ? "true" : "false")
                             .arg(m_gridStep)
                             .arg(m_gridColor.name(QColor::HexRgb));
      m_webView->page()->runJavaScript(js);
  }

    void CanvasWidget::setViewerBackgroundColor(const QColor &color)
    {
      m_viewerBackgroundColor = color;
      m_webView->page()->setBackgroundColor(color);
      if (!m_currentHtml.isEmpty()) {
        m_webView->setHtml(buildPreviewHtml(m_currentHtml));
        return;
      }
      applyViewerBackground();
    }

void CanvasWidget::setActiveFontInfo(const QString &tftFontName, const QString &systemFontFamily)
{
    m_activeTftFont = tftFontName;
    m_activeSystemFont = systemFontFamily;
}

  QString CanvasWidget::previewBodyStyle() const
  {
    return QString("margin:0; background:%1; min-height:100vh; min-width:100vw; display:flex; align-items:%2; justify-content:%3; box-sizing:border-box; padding:%4; overflow:auto;")
      .arg(m_viewerBackgroundColor.name(QColor::HexRgb))
      .arg(m_previewCentered ? "center" : "flex-start")
      .arg(m_previewCentered ? "center" : "flex-start")
      .arg(m_previewCentered ? "20px" : "0px");
  }

  QString CanvasWidget::buildPreviewHtml(const QString &html) const
  {
    QString out = html;
    const QString bodyStyle = previewBodyStyle();
    const QRegularExpression bodyStyleRe(R"re((<body\b[^>]*style=")([^"]*)("))re", QRegularExpression::CaseInsensitiveOption);
    const QRegularExpression bodyOpenRe(R"re(<body\b([^>]*)>)re", QRegularExpression::CaseInsensitiveOption);

    if (out.contains(bodyStyleRe)) {
      out.replace(bodyStyleRe, QString("\\1%1\\3").arg(bodyStyle));
    } else if (out.contains(bodyOpenRe)) {
      out.replace(bodyOpenRe, QString("<body style=\"%1\"\\1>").arg(bodyStyle));
    }

    return out;
  }

  void CanvasWidget::dragEnterEvent(QDragEnterEvent *event)
  {
    if (event->mimeData()->hasFormat("application/x-tft-element")) {
      event->acceptProposedAction();
      return;
    }
    QWidget::dragEnterEvent(event);
  }

  void CanvasWidget::dropEvent(QDropEvent *event)
  {
    if (!event->mimeData()->hasFormat("application/x-tft-element")) {
      QWidget::dropEvent(event);
      return;
    }

    const QByteArray raw = event->mimeData()->data("application/x-tft-element");
    const QString type = QString::fromUtf8(raw);

    const QPoint viewPos = m_webView->mapFrom(this, event->position().toPoint());
    const QString js = QString(R"(
  (() => {
    const section = document.querySelector('section');
    if (!section) {
      return { x: 0, y: 0 };
    }
    const rect = section.getBoundingClientRect();
    const x = Math.max(0, Math.round(%1 - rect.left));
    const y = Math.max(0, Math.round(%2 - rect.top));
    return {
      x: Math.min(x, Math.max(0, Math.round(rect.width) - 1)),
      y: Math.min(y, Math.max(0, Math.round(rect.height) - 1))
    };
  })();
  )").arg(viewPos.x()).arg(viewPos.y());

    m_webView->page()->runJavaScript(js, [this, type](const QVariant &result) {
        const QVariantMap map = result.toMap();
        int x = map.value("x").toInt();
        int y = map.value("y").toInt();
        if (m_gridEnabled) {
            const int s = qMax(2, m_gridStep);
            x = qRound(x / static_cast<double>(s)) * s;
            y = qRound(y / static_cast<double>(s)) * s;
        }
        emit elementDropped(type, x, y);
    });

    event->acceptProposedAction();
}

void CanvasWidget::installInteractionJs()
{
    static const char kInteractionJs1[] = R"(
  (() => {
    const initBridge = () => {
      if (!window.qt || !window.qt.webChannelTransport) {
        // Retry: transport may not be injected yet
        if (!window.__tftRetries) window.__tftRetries = 0;
        if (window.__tftRetries++ < 20) {
          setTimeout(initBridge, 50);
        }
        return;
      }

      if (!window.__tftGrid) {
        window.__tftGrid = { enabled: true, step: 10, color: '#2f4f8f' };
      }

      window.__tftApplyGrid = () => {
        const section = document.querySelector('section');
        if (!section) {
          return;
        }
        let overlay = document.getElementById('__tft-grid-overlay');
        if (!overlay) {
          overlay = document.createElement('div');
          overlay.id = '__tft-grid-overlay';
          overlay.style.position = 'absolute';
          overlay.style.left = '0';
          overlay.style.top = '0';
          overlay.style.right = '0';
          overlay.style.bottom = '0';
          overlay.style.pointerEvents = 'none';
          overlay.style.zIndex = '10000';
          section.appendChild(overlay);
        }
        if (!window.__tftGrid.enabled) {
          overlay.style.backgroundImage = 'none';
          return;
        }

        const step = Math.max(2, Number(window.__tftGrid.step || 10));
        const color = window.__tftGrid.color || '#2f4f8f';
        overlay.style.backgroundImage = `
          linear-gradient(to right, ${color}44 1px, transparent 1px),
          linear-gradient(to bottom, ${color}44 1px, transparent 1px)
        `;
        overlay.style.backgroundSize = `${step}px ${step}px`;
        overlay.style.backgroundPosition = '0 0';
      };

      window.__tftApplyGrid();

      new QWebChannel(window.qt.webChannelTransport, (channel) => {
        const bridge = channel.objects.canvasBridge;
        const allNodes = document.querySelectorAll('section button, section label, section div, section output');
        const nodes = Array.from(allNodes).filter(n => n.id !== '__tft-grid-overlay');
        const state = { selectedIndex: -1, resizeHandle: null };

        const fontCfg = window.__tftFontConfig || { useTft: true, tftFontName: '', systemFontFamily: '' };

        // Apply system font to a node (when system font is selected)
        const applySystemFont = (node) => {
          if (fontCfg.systemFontFamily) {
            node.style.fontFamily = "'" + fontCfg.systemFontFamily + "', sans-serif";
          }
        };

        // TFT bitmap font rendering: replace text in elements with rendered bitmap images
        const applyTftBitmapFont = (node) => {
          // If system font mode, apply font-family and skip bitmap rendering
          if (!fontCfg.useTft) {
            applySystemFont(node);
            return;
          }

          // Skip elements that have no visible text (e.g. horizontal lines)
          const style = window.getComputedStyle(node);
          const fontSize = parseInt(style.fontSize) || 12;
          const fgColor = style.color || '#ffffff';

          // Collect text content (excluding embed tags)
          let textContent = '';
          node.childNodes.forEach((child) => {
            if (child.nodeType === Node.TEXT_NODE) {
              textContent += child.nodeValue;
            }
          });
          textContent = textContent.replace(/\\n/g, '\n').trim();

          if (!textContent) return;

          // Request bitmap from C++ bridge
          bridge.renderTftText(fontSize, textContent, fgColor, 'transparent', (dataUri) => {
            if (!dataUri) return;

            // Create or update the bitmap image overlay
            let img = node.querySelector('img.__tft-bitmap');
            if (!img) {
              img = document.createElement('img');
              img.className = '__tft-bitmap';
              img.style.pointerEvents = 'none';
              img.style.position = 'relative';
              img.style.display = 'block';
              img.style.imageRendering = 'pixelated';
              img.style.flexShrink = '0';
              img.style.flexGrow = '0';
              img.style.objectFit = 'none';
              img.draggable = false;
            }
            img.onload = () => {
              img.style.width = img.naturalWidth + 'px';
              img.style.height = img.naturalHeight + 'px';
            };
            img.src = dataUri;

            // Hide original text nodes but keep embeds
            node.childNodes.forEach((child) => {
              if (child.nodeType === Node.TEXT_NODE) {
                child.__tftOriginal = child.nodeValue;
                child.nodeValue = '';
              }
            });

            // Check text-align to position the image
            const textAlign = style.textAlign || 'left';
            if (textAlign === 'center') {
              img.style.margin = '0 auto';
            } else if (textAlign === 'right') {
              img.style.marginLeft = 'auto';
              img.style.marginRight = '0';
            } else {
              img.style.margin = '0';
            }

            // Apply padding from the element
            const pt = parseInt(style.paddingTop) || 0;
            const pl = parseInt(style.paddingLeft) || 0;
            if (pt > 0) img.style.marginTop = pt + 'px';
            if (pl > 0 && textAlign === 'left') img.style.marginLeft = pl + 'px';

            // Insert bitmap image if not already present
            if (!img.parentNode) {
              node.appendChild(img);
            }
          });
        };

        const applyMultilineText = (node) => {
          let hasMultilineText = false;
          const walker = document.createTreeWalker(node, NodeFilter.SHOW_TEXT);
          const textNodes = [];

          while (walker.nextNode()) {
            const textNode = walker.currentNode;
            if (!textNode || !textNode.nodeValue || !textNode.nodeValue.includes('\\n')) {
              continue;
            }
            if (textNode.parentElement && textNode.parentElement.closest('embed')) {
              continue;
            }

            textNodes.push(textNode);
          }

          textNodes.forEach((textNode) => {
            textNode.nodeValue = textNode.nodeValue.replace(/\\n/g, '\n');
            hasMultilineText = true;
          });

          if (hasMultilineText && !node.style.whiteSpace) {
            node.style.whiteSpace = 'pre-wrap';
          }
        };

        nodes.forEach((node) => {
          applyMultilineText(node);
          applyTftBitmapFont(node);
        });
)";
        static const char kInteractionJs2[] = R"(
        const removeHandle = () => {
          if (state.resizeHandle && state.resizeHandle.parentElement) {
            state.resizeHandle.parentElement.removeChild(state.resizeHandle);
          }
          state.resizeHandle = null;
        };

        const parsePx = (value, fallback = 0) => {
          const v = parseInt(String(value || '').replace('px', ''), 10);
          return Number.isNaN(v) ? fallback : v;
        };

        const installHandle = (node, idx) => {
          removeHandle();
          const makeHandle = (name, cursor, stylePatch) => {
            const handle = document.createElement('div');
            handle.dataset.handle = name;
            handle.style.position = 'absolute';
            handle.style.width = '10px';
            handle.style.height = '10px';
            handle.style.background = '#f2d63c';
            handle.style.border = '1px solid #000';
            handle.style.cursor = cursor;
            handle.style.zIndex = '10001';
            Object.assign(handle.style, stylePatch);
            state.resizeHandle.appendChild(handle);

            let resizing = false;
            let startX = 0;
            let startY = 0;
            let startLeft = 0;
            let startTop = 0;
            let startW = 1;
            let startH = 1;

            const onMove = (ev) => {
              if (!resizing) {
                return;
              }

              let newLeft = startLeft;
              let newTop = startTop;
              let newWidth = startW;
              let newHeight = startH;
              const dx = ev.clientX - startX;
              const dy = ev.clientY - startY;

              if (name.includes('e')) {
                newWidth = Math.max(1, startW + dx);
              }
              if (name.includes('s')) {
                newHeight = Math.max(1, startH + dy);
              }
              if (name.includes('w')) {
                newWidth = Math.max(1, startW - dx);
                newLeft = startLeft + dx;
              }
              if (name.includes('n')) {
                newHeight = Math.max(1, startH - dy);
                newTop = startTop + dy;
              }

              if (window.__tftGrid && window.__tftGrid.enabled) {
                const s = Math.max(2, Number(window.__tftGrid.step || 10));
                newLeft = Math.round(newLeft / s) * s;
                newTop = Math.round(newTop / s) * s;
                newWidth = Math.max(1, Math.round(newWidth / s) * s);
                newHeight = Math.max(1, Math.round(newHeight / s) * s);
              }

              node.style.left = `${Math.max(0, Math.round(newLeft))}px`;
              node.style.top = `${Math.max(0, Math.round(newTop))}px`;
              node.style.width = `${Math.round(newWidth)}px`;
              node.style.height = `${Math.round(newHeight)}px`;
            };

            const onUp = () => {
              if (!resizing) {
                return;
              }
              resizing = false;
              window.removeEventListener('mousemove', onMove);
              window.removeEventListener('mouseup', onUp);
              const finalLeft = parsePx(node.style.left, parsePx(window.getComputedStyle(node).left, 0));
              const finalTop = parsePx(node.style.top, parsePx(window.getComputedStyle(node).top, 0));
              const finalW = parsePx(node.style.width, parsePx(window.getComputedStyle(node).width, 1));
              const finalH = parsePx(node.style.height, parsePx(window.getComputedStyle(node).height, 1));
              bridge.elementGeometryChangedFromJs(idx, finalLeft, finalTop, finalW, finalH);
            };

            handle.onmousedown = (ev) => {
              ev.preventDefault();
              ev.stopPropagation();
              resizing = true;
              startX = ev.clientX;
              startY = ev.clientY;
              startLeft = parsePx(node.style.left, parsePx(window.getComputedStyle(node).left, 0));
              startTop = parsePx(node.style.top, parsePx(window.getComputedStyle(node).top, 0));
              startW = parsePx(node.style.width, parsePx(window.getComputedStyle(node).width, 1));
              startH = parsePx(node.style.height, parsePx(window.getComputedStyle(node).height, 1));
              window.addEventListener('mousemove', onMove);
              window.addEventListener('mouseup', onUp);
            };

            return handle;
          };

          state.resizeHandle = document.createElement('div');
          state.resizeHandle.style.position = 'absolute';
          state.resizeHandle.style.inset = '0';
          state.resizeHandle.style.pointerEvents = 'none';
          state.resizeHandle.style.zIndex = '10001';
          node.appendChild(state.resizeHandle);

          makeHandle('nw', 'nwse-resize', { left: '-6px', top: '-6px', pointerEvents: 'auto' });
          makeHandle('ne', 'nesw-resize', { right: '-6px', top: '-6px', pointerEvents: 'auto' });
          makeHandle('sw', 'nesw-resize', { left: '-6px', bottom: '-6px', pointerEvents: 'auto' });
          makeHandle('se', 'nwse-resize', { right: '-6px', bottom: '-6px', pointerEvents: 'auto' });
          makeHandle('n', 'ns-resize', { left: '50%', top: '-6px', transform: 'translateX(-50%)', pointerEvents: 'auto' });
          makeHandle('s', 'ns-resize', { left: '50%', bottom: '-6px', transform: 'translateX(-50%)', pointerEvents: 'auto' });
          makeHandle('w', 'ew-resize', { left: '-6px', top: '50%', transform: 'translateY(-50%)', pointerEvents: 'auto' });
          makeHandle('e', 'ew-resize', { right: '-6px', top: '50%', transform: 'translateY(-50%)', pointerEvents: 'auto' });
        };

        window.__tftApplySelection = (index) => {
          state.selectedIndex = index;
          nodes.forEach((n, ni) => {
            n.style.outline = ni === index ? '2px dashed #f2d63c' : '';
            n.style.outlineOffset = ni === index ? '1px' : '';
          });
          removeHandle();
          if (index >= 0 && index < nodes.length) {
            installHandle(nodes[index], index);
          }
        };

        nodes.forEach((node, idx) => {
          node.style.cursor = 'pointer';
          let dragging = false;
          let moved = false;
          let startX = 0;
          let startY = 0;
          let baseLeft = 0;
          let baseTop = 0;

          const pointerMove = (ev) => {
            if (!dragging) {
              return;
            }
            moved = true;
            let nx = Math.max(0, baseLeft + (ev.clientX - startX));
            let ny = Math.max(0, baseTop + (ev.clientY - startY));
            if (window.__tftGrid && window.__tftGrid.enabled) {
              const s = Math.max(2, Number(window.__tftGrid.step || 10));
              nx = Math.round(nx / s) * s;
              ny = Math.round(ny / s) * s;
            }
            node.style.left = `${Math.round(nx)}px`;
            node.style.top = `${Math.round(ny)}px`;
          };

          const pointerUp = () => {
            if (!dragging) {
              return;
            }
            dragging = false;
            window.removeEventListener('mousemove', pointerMove);
            window.removeEventListener('mouseup', pointerUp);
            bridge.elementMovedFromJs(idx, parsePx(node.style.left), parsePx(node.style.top));
            window.__tftApplySelection(idx);
          };

          node.onmousedown = (ev) => {
            ev.preventDefault();
            ev.stopPropagation();
            bridge.elementSelectedFromJs(idx);
            window.__tftApplySelection(idx);

            dragging = true;
            moved = false;
            startX = ev.clientX;
            startY = ev.clientY;
            baseLeft = parsePx(node.style.left || window.getComputedStyle(node).left);
            baseTop = parsePx(node.style.top || window.getComputedStyle(node).top);
            window.addEventListener('mousemove', pointerMove);
            window.addEventListener('mouseup', pointerUp);
          };

          node.onclick = (ev) => {
            ev.preventDefault();
            ev.stopPropagation();
            if (moved) {
              return;
            }
            bridge.elementSelectedFromJs(idx);
            window.__tftApplySelection(idx);
          };
        });

        // Handle deselection when clicking on empty space
        if (section) {
          section.onclick = (ev) => {
            // If click is directly on section (empty space), deselect
            if (ev.target === section) {
              bridge.elementSelectedFromJs(-1);
              window.__tftApplySelection(-1);
            }
          };
        }

        const pending = Number(window.__tftPendingSelectedIndex);
        window.__tftApplySelection(Number.isFinite(pending) ? pending : state.selectedIndex);
      });
    };

    if (typeof QWebChannel === 'undefined') {
      const script = document.createElement('script');
      script.src = 'qrc:///qtwebchannel/qwebchannel.js';
      script.onload = initBridge;
      document.head.appendChild(script);
    } else {
      initBridge();
    }
  })();
   )";

    // Inject font configuration before running interaction JS
    const QString fontConfigJs = QString(R"(
  window.__tftFontConfig = {
    useTft: %1,
    tftFontName: '%2',
    systemFontFamily: '%3'
  };
  )").arg(m_activeTftFont.isEmpty() ? "false" : "true")
     .arg(m_activeTftFont)
     .arg(m_activeSystemFont);

    m_webView->page()->runJavaScript(fontConfigJs);
    const QString fullJs = QString::fromUtf8(kInteractionJs1) + QString::fromUtf8(kInteractionJs2);
    m_webView->page()->runJavaScript(fullJs);
}

  void CanvasWidget::applyViewerBackground()
  {
      const QString js = QString(R"(
  (() => {
    if (document && document.body) {
      document.body.style.cssText = '%1';
    }
  })();
  )")
          .arg(previewBodyStyle());
      m_webView->page()->runJavaScript(js);
  }
