#pragma once

#include <QMainWindow>

#include <QActionGroup>
#include <QString>
#include <QVector>

#include "model/htmlparser.h"
#include "panels/propertypanel.h"

namespace Ui { class MainWindowUi; }

class QAction;
class QCloseEvent;
class QMenu;
class QUndoStack;

class DocumentStateCommand;

class MainWindow : public QMainWindow
{
    Q_OBJECT

    friend class DocumentStateCommand;

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void onNewFile();
    void onOpenFile();
    void onSaveFile();
    void onDeleteSelectedElement();
    void onCopySelectedElement();
    void onPasteElement();
    void onDuplicateSelectedElement();
    void onPaletteElementRequested(const QString &elementType);
    void onCanvasElementDropped(const QString &elementType, int x, int y);
    void onCanvasElementSelected(int elementIndex);
    void onCanvasElementMoved(int elementIndex, int x, int y);
    void onCanvasElementResized(int elementIndex, int width, int height);
    void onCanvasElementGeometryChanged(int elementIndex, int x, int y, int width, int height);
    void onCodeCursorChanged();
    void onDocumentEdited(const PropertyPanel::DocumentData &data);
    void onPropertyPanelEdited(const PropertyPanel::ElementData &data);
    void onToggleGrid(bool enabled);
    void onConfigureGrid();
    void onConfigureViewerBackground();
    void onToggleCenterPreview(bool enabled);
    void onLoadFont();
    void onLoadFontDirectory();
    void onOpenFontEditor();
    void refreshFontListMenu();
    void refreshSystemFontMenu();
    void setActiveFont(const QString &fontName);
    void setActiveSystemFont(const QString &family);
    void onCloseFile();
    void addToRecentFiles(const QString &path);
    void rebuildRecentFilesMenu();
    void openFilePath(const QString &path);

private:
    void loadSettings();
    void saveSettings() const;
    void updateCodeViewFromCanvas();
    void updateCanvasFromCodeView();
    bool saveToPath(const QString &filePath);
    void refreshEditableElements();
    void selectElementAtCursor();
    void selectElementByIndex(int index, bool moveCodeCursor = true);
    bool tryCopyFocusedTextEdit();
    bool tryPasteFocusedTextEdit();
    void updateCodeHighlights(int index);
    void applyDocumentHtml(const QString &html, int selectedIndex);
    void pushDocumentChange(const QString &html, int selectedIndex, const QString &text);
    PropertyPanel::DocumentData currentDocumentData() const;
    void updateDirtyState();
    void updateWindowTitle();
    bool saveDocumentInteractively();
    QString offsetElementHtml(const QString &elementHtml, int dx, int dy) const;
    QString makeDefaultElementHtml(const QString &elementType, int x, int y) const;
    PropertyPanel::ElementData toPanelData(const HtmlElementToken &token) const;
    bool isTopLevelElement(int index) const;
    void applyScreenAlignment(PropertyPanel::ElementData &data) const;

protected:
    void closeEvent(QCloseEvent *event) override;

    Ui::MainWindowUi *ui;
    QActionGroup *m_fontActionGroup = nullptr;
    QUndoStack *m_undoStack = nullptr;

    QString m_currentFilePath;
    QVector<HtmlElementToken> m_elements;
    int m_selectedElementIndex = -1;
    bool m_blockCodeSync = false;
    bool m_blockCursorSync = false;
    bool m_applyingDocumentState = false;
    bool m_isDirty = false;

    bool m_gridEnabled = true;
    int m_gridStep = 10;
    QString m_gridColor = "#2f4f8f";
    QString m_viewerBackgroundColor = "#ffffff";
    bool m_centerPreviewEnabled = true;
    QString m_copiedElementHtml;
    QString m_lastSavedHtml;
    QString m_activeFont;          // name of currently selected font (empty = system)
    QString m_activeSystemFont;    // system font family (when no TFT font selected)
    bool m_skipCanvasReload = false;
};
