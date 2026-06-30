#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QAction>
#include <QApplication>
#include <QClipboard>
#include <QCoreApplication>
#include <QGuiApplication>
#include <QPlainTextEdit>
#include <QDir>
#include <QFile>
#include <QFileDialog>
#include <QFileInfo>
#include <QIODevice>
#include <QColorDialog>
#include <QInputDialog>
#include <QMap>
#include <QMenu>
#include <QMenuBar>
#include <QMessageBox>
#include <QRegularExpression>
#include <QSettings>
#include <QStringList>
#include <QSplitter>
#include <QStatusBar>
#include <QTextCursor>
#include <QToolBar>
#include <QUndoCommand>
#include <QUndoStack>
#include <QFontDatabase>

#include "canvas/canvaswidget.h"
#include "model/htmlgenerator.h"
#include "model/htmlparser.h"
#include "model/tftfontmetrics.h"
#include "model/tftfontmanager.h"
#include "panels/codeview.h"
#include "panels/palettewidget.h"
#include "panels/propertypanel.h"
#include "fonteditor/fonteditorwindow.h"

class DocumentStateCommand final : public QUndoCommand
{
public:
    DocumentStateCommand(MainWindow *window, QString beforeHtml, int beforeIndex, QString afterHtml, int afterIndex, const QString &text)
        : QUndoCommand(text)
        , m_window(window)
        , m_beforeHtml(std::move(beforeHtml))
        , m_beforeIndex(beforeIndex)
        , m_afterHtml(std::move(afterHtml))
        , m_afterIndex(afterIndex)
    {
    }

    void undo() override;
    void redo() override;

private:
    MainWindow *m_window;
    QString m_beforeHtml;
    int m_beforeIndex;
    QString m_afterHtml;
    int m_afterIndex;
};

void DocumentStateCommand::undo()
{
    m_window->applyDocumentHtml(m_beforeHtml, m_beforeIndex);
}

void DocumentStateCommand::redo()
{
    m_window->applyDocumentHtml(m_afterHtml, m_afterIndex);
}

QString replaceRegex(const QString &input, const QRegularExpression &expression, const QString &replacement)
{
    QString out = input;
    out.replace(expression, replacement);
    return out;
}

namespace {
QMap<QString, QString> parseStyleMap(const QString &style)
{
    QMap<QString, QString> map;
    const QStringList parts = style.split(';', Qt::SkipEmptyParts);
    for (const QString &part : parts) {
        const int colon = part.indexOf(':');
        if (colon < 0) {
            continue;
        }

        const QString key = part.left(colon).trimmed().toLower();
        const QString value = part.mid(colon + 1).trimmed();
        if (!key.isEmpty()) {
            map.insert(key, value);
        }
    }
    return map;
}

QString toStyleString(const QMap<QString, QString> &map)
{
    QStringList parts;
    for (auto it = map.constBegin(); it != map.constEnd(); ++it) {
        parts.push_back(QString("%1:%2").arg(it.key(), it.value()));
    }
    return parts.join("; ");
}

int parseBorderWidthPx(const QString &style, int fallback)
{
    const QString boxShadow = HtmlParser::styleValue(style, "box-shadow");
    const QRegularExpression shadowWidthRe(R"(0\s+0\s+0\s+(\d+)px)");
    const QRegularExpressionMatch shadowWidthMatch = shadowWidthRe.match(boxShadow);
    if (shadowWidthMatch.hasMatch()) {
        return shadowWidthMatch.captured(1).toInt();
    }

    const int explicitWidth = HtmlParser::stylePxValue(style, "border-width", -1);
    if (explicitWidth >= 0) {
        return explicitWidth;
    }

    const QString border = HtmlParser::styleValue(style, "border");
    const QRegularExpression pxRe(R"((\d+)px)");
    const QRegularExpressionMatch match = pxRe.match(border);
    return match.hasMatch() ? match.captured(1).toInt() : fallback;
}

QString parseBorderColorValue(const QString &style, const QString &fallback)
{
    const QString boxShadow = HtmlParser::styleValue(style, "box-shadow");
    const QRegularExpression shadowColorRe(R"((#[0-9a-fA-F]{3,6}|rgba?\([^\)]+\)|[a-zA-Z]+)\s*$)");
    const QRegularExpressionMatch shadowColorMatch = shadowColorRe.match(boxShadow);
    if (shadowColorMatch.hasMatch()) {
        return shadowColorMatch.captured(1);
    }

    const QString explicitColor = HtmlParser::styleValue(style, "border-color");
    if (!explicitColor.isEmpty()) {
        return explicitColor;
    }

    const QString border = HtmlParser::styleValue(style, "border");
    const QRegularExpression colorRe(R"((#[0-9a-fA-F]{3,6}|rgba?\([^\)]+\)|[a-zA-Z]+)\s*$)");
    const QRegularExpressionMatch match = colorRe.match(border);
    return match.hasMatch() ? match.captured(1) : fallback;
}

int alignedCoordinate(const QString &mode, int containerSize, int objectSize, int margin, int current)
{
    if (mode == "left" || mode == "top") {
        return qMax(0, margin);
    }
    if (mode == "center") {
        return qMax(0, ((containerSize - objectSize) / 2) + margin);
    }
    if (mode == "right" || mode == "bottom") {
        return qMax(0, containerSize - objectSize - margin);
    }
    return current;
}
}

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindowUi)
{
    ui->setupUi(this);

    // Layout: [palette | canvas] over code (left); property panel full height (right)
    ui->workAreaSplitter->setStretchFactor(0, 0);
    ui->workAreaSplitter->setStretchFactor(1, 1);
    ui->editorSplitter->setStretchFactor(0, 1);
    ui->editorSplitter->setStretchFactor(1, 0);
    ui->mainSplitter->setStretchFactor(0, 1);
    ui->mainSplitter->setStretchFactor(1, 0);

    // Undo/Redo are created dynamically from QUndoStack
    m_undoStack = new QUndoStack(this);
    QAction *undoAction = m_undoStack->createUndoAction(this, "&Undo");
    undoAction->setShortcut(QKeySequence::Undo);
    QAction *redoAction = m_undoStack->createRedoAction(this, "&Redo");
    redoAction->setShortcut(QKeySequence::Redo);
    ui->menuEdit->insertAction(ui->actionCopy, undoAction);
    ui->menuEdit->insertAction(ui->actionCopy, redoAction);
    ui->menuEdit->insertSeparator(ui->actionCopy);

    // Close/Exit wired here (lambdas)
    connect(ui->actionClose, &QAction::triggered, this, &MainWindow::onCloseFile);
    connect(ui->actionExit, &QAction::triggered, this, &QWidget::close);

    loadSettings();

    connect(ui->actionNew, &QAction::triggered, this, &MainWindow::onNewFile);
    connect(ui->actionOpen, &QAction::triggered, this, &MainWindow::onOpenFile);
    connect(ui->actionSave, &QAction::triggered, this, &MainWindow::onSaveFile);
    connect(ui->actionDelete, &QAction::triggered, this, &MainWindow::onDeleteSelectedElement);
    connect(ui->actionCopy, &QAction::triggered, this, &MainWindow::onCopySelectedElement);
    connect(ui->actionPaste, &QAction::triggered, this, &MainWindow::onPasteElement);
    connect(ui->actionDuplicate, &QAction::triggered, this, &MainWindow::onDuplicateSelectedElement);

    connect(ui->paletteWidget, &PaletteWidget::elementRequested, this, &MainWindow::onPaletteElementRequested);
    connect(ui->canvasWidget, &CanvasWidget::elementDropped, this, &MainWindow::onCanvasElementDropped);
    connect(ui->canvasWidget, &CanvasWidget::elementSelected, this, &MainWindow::onCanvasElementSelected);
    connect(ui->canvasWidget, &CanvasWidget::elementMoved, this, &MainWindow::onCanvasElementMoved);
    connect(ui->canvasWidget, &CanvasWidget::elementResized, this, &MainWindow::onCanvasElementResized);
    connect(ui->canvasWidget, &CanvasWidget::elementGeometryChanged, this, &MainWindow::onCanvasElementGeometryChanged);

    connect(ui->codeView, &QPlainTextEdit::textChanged, this, &MainWindow::updateCanvasFromCodeView);
    connect(ui->codeView, &QPlainTextEdit::cursorPositionChanged, this, &MainWindow::onCodeCursorChanged);
    connect(ui->propertyPanel, &PropertyPanel::documentEdited, this, &MainWindow::onDocumentEdited);
    connect(ui->propertyPanel, &PropertyPanel::elementEdited, this, &MainWindow::onPropertyPanelEdited);
    connect(ui->actionToggleGrid, &QAction::toggled, this, &MainWindow::onToggleGrid);
    connect(ui->actionGridSettings, &QAction::triggered, this, &MainWindow::onConfigureGrid);
    connect(ui->actionViewerBackground, &QAction::triggered, this, &MainWindow::onConfigureViewerBackground);
    connect(ui->actionCenterPreview, &QAction::toggled, this, &MainWindow::onToggleCenterPreview);

    // Font menu
    connect(ui->actionLoadFont, &QAction::triggered, this, &MainWindow::onLoadFont);
    connect(ui->actionLoadFontDirectory, &QAction::triggered, this, &MainWindow::onLoadFontDirectory);
    connect(ui->actionFontEditor, &QAction::triggered, this, &MainWindow::onOpenFontEditor);

    m_fontActionGroup = new QActionGroup(this);
    m_fontActionGroup->setExclusive(true);
    refreshFontListMenu();
    connect(&TftFontManager::instance(), &TftFontManager::fontsChanged,
            this, &MainWindow::refreshFontListMenu);
    refreshSystemFontMenu();
    rebuildRecentFilesMenu();

    statusBar()->showMessage("Ready");
    updateWindowTitle();
    ui->actionToggleGrid->setChecked(m_gridEnabled);
    ui->actionCenterPreview->setChecked(m_centerPreviewEnabled);
    ui->canvasWidget->setGridSettings(m_gridEnabled, m_gridStep, QColor(m_gridColor));
    ui->canvasWidget->setViewerBackgroundColor(QColor(m_viewerBackgroundColor));
    ui->canvasWidget->setPreviewCentered(m_centerPreviewEnabled);

    // Initialize font manager with built-in fonts
    const QString fontsDir = QCoreApplication::applicationDirPath() + "/fonts";
    if (!QDir(fontsDir).exists()) {
        const QString srcFontsDir = QCoreApplication::applicationDirPath() + "/../../fonts";
        if (QDir(srcFontsDir).exists())
            TftFontManager::instance().loadBuiltinFonts(QDir(srcFontsDir).absolutePath());
    } else {
        TftFontManager::instance().loadBuiltinFonts(fontsDir);
    }

    onNewFile();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::loadSettings()
{
    QSettings settings;
    m_gridEnabled = settings.value("viewer/gridEnabled", true).toBool();
    m_gridStep = settings.value("viewer/gridStep", 10).toInt();
    m_gridColor = settings.value("viewer/gridColor", "#2f4f8f").toString();
    m_viewerBackgroundColor = settings.value("viewer/backgroundColor", "#ffffff").toString();
    m_centerPreviewEnabled = settings.value("viewer/centerPreview", true).toBool();
    m_activeFont = settings.value("fonts/activeFont").toString();
    m_activeSystemFont = settings.value("fonts/activeSystemFont").toString();

    const QByteArray geometry = settings.value("window/geometry").toByteArray();
    if (!geometry.isEmpty()) {
        restoreGeometry(geometry);
    } else {
        resize(1400, 900);
    }

    QList<int> mainSizes;
    for (const QVariant &value : settings.value("window/mainSplitterSizes").toList()) {
        mainSizes.push_back(value.toInt());
    }
    if (mainSizes.size() == 2) {
        ui->mainSplitter->setSizes(mainSizes);
    }

    QList<int> editorSizes;
    for (const QVariant &value : settings.value("window/editorSplitterSizes").toList()) {
        editorSizes.push_back(value.toInt());
    }
    if (editorSizes.size() != 2) {
        editorSizes.clear();
        for (const QVariant &value : settings.value("window/workspaceSplitterSizes").toList()) {
            editorSizes.push_back(value.toInt());
        }
    }
    if (editorSizes.size() == 2) {
        ui->editorSplitter->setSizes(editorSizes);
    }

    QList<int> workAreaSizes;
    for (const QVariant &value : settings.value("window/workAreaSplitterSizes").toList()) {
        workAreaSizes.push_back(value.toInt());
    }
    if (workAreaSizes.size() == 3) {
        ui->workAreaSplitter->setSizes({workAreaSizes[0], workAreaSizes[1]});
        if (mainSizes.isEmpty()) {
            ui->mainSplitter->setSizes({workAreaSizes[0] + workAreaSizes[1], workAreaSizes[2]});
        }
    } else if (workAreaSizes.size() == 2) {
        ui->workAreaSplitter->setSizes(workAreaSizes);
    } else {
        const QVariantList legacyMain = settings.value("window/mainSplitterSizes").toList();
        const QVariantList legacyCenter = settings.value("window/centerSplitterSizes").toList();
        if (legacyMain.size() == 3 && legacyCenter.size() == 2) {
            ui->workAreaSplitter->setSizes({legacyMain[0].toInt(), legacyMain[1].toInt()});
            ui->editorSplitter->setSizes({legacyCenter[0].toInt(), legacyCenter[1].toInt()});
            ui->mainSplitter->setSizes({
                legacyMain[0].toInt() + legacyMain[1].toInt(),
                legacyMain[2].toInt(),
            });
        }
    }
}

void MainWindow::saveSettings() const
{
    QSettings settings;
    settings.setValue("viewer/gridEnabled", m_gridEnabled);
    settings.setValue("viewer/gridStep", m_gridStep);
    settings.setValue("viewer/gridColor", m_gridColor);
    settings.setValue("viewer/backgroundColor", m_viewerBackgroundColor);
    settings.setValue("viewer/centerPreview", m_centerPreviewEnabled);
    settings.setValue("window/geometry", saveGeometry());
    QVariantList mainSizes;
    for (const int size : ui->mainSplitter->sizes()) {
        mainSizes.push_back(size);
    }
    QVariantList editorSizes;
    for (const int size : ui->editorSplitter->sizes()) {
        editorSizes.push_back(size);
    }
    QVariantList workAreaSizes;
    for (const int size : ui->workAreaSplitter->sizes()) {
        workAreaSizes.push_back(size);
    }
    settings.setValue("window/mainSplitterSizes", mainSizes);
    settings.setValue("window/editorSplitterSizes", editorSizes);
    settings.setValue("window/workAreaSplitterSizes", workAreaSizes);
}

void MainWindow::onNewFile()
{
    static const char kDefaultHtml[] = R"(<!DOCTYPE html>
<html lang="uk">
<head>
  <meta charset="utf-8" />
  <title>New Screen</title>
</head>
<body style="margin:0; background:#fff">
    <section data-screen="NEW" style="position:relative; width:480px; height:320px; background:#000000; box-shadow:0 0 0 1px #2455ff; overflow:visible;">
    <label style="position:absolute; left:0px; right:0px; top:8px; margin:0 auto; width:max-content; color:#ffffff; background:#000000; font-size:20px; font-weight:700; font-family:'Square721 BT', Tahoma, Geneva, sans-serif;">NEW SCREEN</label>
    <div style="position:absolute; left:0px; top:52px; width:480px; height:1px; background:#2455ff;"></div>
  </section>
</body>
</html>
)";

    m_currentFilePath.clear();
    m_copiedElementHtml.clear();
    applyDocumentHtml(QString::fromUtf8(kDefaultHtml), 0);
    m_undoStack->clear();
    m_lastSavedHtml = ui->codeView->toPlainText();
    m_isDirty = false;
    updateWindowTitle();

    statusBar()->showMessage("Created new document", 2000);
}

void MainWindow::onOpenFile()
{
    const QString path = QFileDialog::getOpenFileName(
        this,
        "Open HTML file",
        QString(),
        "HTML Files (*.html *.htm);;All Files (*.*)");

    if (path.isEmpty()) {
        return;
    }

    openFilePath(path);
}

void MainWindow::openFilePath(const QString &path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        statusBar()->showMessage("Failed to open file", 3000);
        return;
    }

    const QString html = QString::fromUtf8(file.readAll());
    m_currentFilePath = path;
    applyDocumentHtml(html, 0);
    m_undoStack->clear();
    m_lastSavedHtml = ui->codeView->toPlainText();
    m_isDirty = false;
    updateWindowTitle();

    addToRecentFiles(path);
    statusBar()->showMessage("File opened", 2000);
}

void MainWindow::onCloseFile()
{
    if (m_isDirty) {
        const QMessageBox::StandardButton answer = QMessageBox::question(
            this, "Unsaved changes",
            "The document has unsaved changes. Save before closing?",
            QMessageBox::Yes | QMessageBox::No | QMessageBox::Cancel);
        if (answer == QMessageBox::Cancel)
            return;
        if (answer == QMessageBox::Yes && !saveDocumentInteractively())
            return;
    }
    onNewFile();
}

void MainWindow::addToRecentFiles(const QString &path)
{
    QSettings settings;
    QStringList recent = settings.value("recentFiles").toStringList();
    recent.removeAll(path);
    recent.prepend(path);
    while (recent.size() > 10)
        recent.removeLast();
    settings.setValue("recentFiles", recent);
    rebuildRecentFilesMenu();
}

void MainWindow::rebuildRecentFilesMenu()
{
    ui->recentFilesMenu->clear();
    QSettings settings;
    const QStringList recent = settings.value("recentFiles").toStringList();
    if (recent.isEmpty()) {
        ui->recentFilesMenu->addAction("(no recent files)")->setEnabled(false);
        return;
    }
    for (const QString &filePath : recent) {
        const QString label = QFileInfo(filePath).fileName();
        ui->recentFilesMenu->addAction(label, this, [this, filePath]() {
            openFilePath(filePath);
        });
    }
}

void MainWindow::onSaveFile()
{
    saveDocumentInteractively();
}

bool MainWindow::saveDocumentInteractively()
{
    QString savePath = m_currentFilePath;
    if (savePath.isEmpty()) {
        savePath = QFileDialog::getSaveFileName(
            this,
            "Save HTML file",
            "screen.html",
            "HTML Files (*.html *.htm);;All Files (*.*)");
    }

    if (savePath.isEmpty()) {
        return false;
    }

    if (!saveToPath(savePath)) {
        statusBar()->showMessage("Failed to save file", 3000);
        return false;
    }

    m_currentFilePath = savePath;
    m_lastSavedHtml = ui->codeView->toPlainText();
    m_isDirty = false;
    if (m_undoStack != nullptr) {
        m_undoStack->setClean();
    }
    updateWindowTitle();
    statusBar()->showMessage("File saved", 2000);
    return true;
}

void MainWindow::onDeleteSelectedElement()
{
    if (m_selectedElementIndex < 0 || m_selectedElementIndex >= m_elements.size()) {
        return;
    }

    const HtmlElementToken token = m_elements[m_selectedElementIndex];
    QString html = ui->codeView->toPlainText();
    html.remove(token.startOffset, token.endOffset - token.startOffset);
    const QVector<HtmlElementToken> updatedElements = HtmlParser::parseElements(html);
    const int nextIndex = updatedElements.isEmpty() ? -1 : qMin(m_selectedElementIndex, updatedElements.size() - 1);
    pushDocumentChange(html, nextIndex, "Delete Element");
}

void MainWindow::onCopySelectedElement()
{
    if (tryCopyFocusedTextEdit()) {
        return;
    }

    if (m_selectedElementIndex < 0 || m_selectedElementIndex >= m_elements.size()) {
        return;
    }

    const HtmlElementToken token = m_elements[m_selectedElementIndex];
    const QString html = ui->codeView->toPlainText();
    m_copiedElementHtml = html.mid(token.startOffset, token.endOffset - token.startOffset);
    QGuiApplication::clipboard()->setText(m_copiedElementHtml);
    statusBar()->showMessage("Element copied", 1200);
}

void MainWindow::onPasteElement()
{
    if (tryPasteFocusedTextEdit()) {
        return;
    }

    if (m_copiedElementHtml.trimmed().isEmpty()) {
        return;
    }

    const QString pastedHtml = offsetElementHtml(m_copiedElementHtml, 10, 10);
    QString html = ui->codeView->toPlainText();
    html = HtmlGenerator::insertBeforeSectionEnd(html, pastedHtml);

    const QVector<HtmlElementToken> updatedElements = HtmlParser::parseElements(html);
    pushDocumentChange(html, updatedElements.size() - 1, "Paste Element");
}

void MainWindow::onDuplicateSelectedElement()
{
    onCopySelectedElement();
    onPasteElement();
}

void MainWindow::onPaletteElementRequested(const QString &elementType)
{
    onCanvasElementDropped(elementType, 20, 80);
}

void MainWindow::onCanvasElementDropped(const QString &elementType, int x, int y)
{
    QString html = ui->codeView->toPlainText();
    html = HtmlGenerator::insertBeforeSectionEnd(html, makeDefaultElementHtml(elementType, x, y));
    const QVector<HtmlElementToken> updatedElements = HtmlParser::parseElements(html);
    pushDocumentChange(html, updatedElements.size() - 1, "Add Element");
}

void MainWindow::onCanvasElementSelected(int elementIndex)
{
    selectElementByIndex(elementIndex);
}

void MainWindow::onCanvasElementMoved(int elementIndex, int x, int y)
{
    if (elementIndex < 0 || elementIndex >= m_elements.size()) {
        return;
    }

    m_selectedElementIndex = elementIndex;
    PropertyPanel::ElementData data = toPanelData(m_elements[elementIndex]);
    data.x = x;
    data.y = y;
    m_skipCanvasReload = true;
    onPropertyPanelEdited(data);
    m_skipCanvasReload = false;
}

void MainWindow::onCanvasElementResized(int elementIndex, int width, int height)
{
    if (elementIndex < 0 || elementIndex >= m_elements.size()) {
        return;
    }

    m_selectedElementIndex = elementIndex;
    PropertyPanel::ElementData data = toPanelData(m_elements[elementIndex]);
    data.width = qMax(1, width);
    data.height = qMax(1, height);
    m_skipCanvasReload = true;
    onPropertyPanelEdited(data);
    m_skipCanvasReload = false;
}

void MainWindow::onCanvasElementGeometryChanged(int elementIndex, int x, int y, int width, int height)
{
    if (elementIndex < 0 || elementIndex >= m_elements.size()) {
        return;
    }

    m_selectedElementIndex = elementIndex;
    PropertyPanel::ElementData data = toPanelData(m_elements[elementIndex]);
    data.x = qMax(0, x);
    data.y = qMax(0, y);
    data.width = qMax(1, width);
    data.height = qMax(1, height);
    m_skipCanvasReload = true;
    onPropertyPanelEdited(data);
    m_skipCanvasReload = false;
}

void MainWindow::onCodeCursorChanged()
{
    if (m_blockCursorSync) {
        return;
    }
    selectElementAtCursor();
}

bool MainWindow::tryCopyFocusedTextEdit()
{
    auto *edit = qobject_cast<QPlainTextEdit *>(QApplication::focusWidget());
    if (!edit) {
        return false;
    }

    const bool isCodeView = (edit == ui->codeView);
    const bool isPropertyText = ui->propertyPanel->isAncestorOf(edit);
    if (!isCodeView && !isPropertyText) {
        return false;
    }

    if (!edit->textCursor().hasSelection()) {
        return false;
    }

    edit->copy();
    statusBar()->showMessage("Copied to clipboard", 1200);
    return true;
}

bool MainWindow::tryPasteFocusedTextEdit()
{
    auto *edit = qobject_cast<QPlainTextEdit *>(QApplication::focusWidget());
    if (!edit || edit->isReadOnly()) {
        return false;
    }

    const bool isCodeView = (edit == ui->codeView);
    const bool isPropertyText = ui->propertyPanel->isAncestorOf(edit);
    if (!isCodeView && !isPropertyText) {
        return false;
    }

    edit->paste();
    return true;
}

void MainWindow::onDocumentEdited(const PropertyPanel::DocumentData &data)
{
    QString html = ui->codeView->toPlainText();
    html = replaceRegex(
        html,
        QRegularExpression(R"re((<body\b[^>]*style="[^"]*background:)\s*[^;"\n]+)re", QRegularExpression::CaseInsensitiveOption),
        QString("\\1%1").arg(data.backgroundColor));
    const QRegularExpression sectionStyleRe(R"re(<section\b[^>]*style="([^"]*)")re", QRegularExpression::CaseInsensitiveOption);
    const QRegularExpressionMatch sectionMatch = sectionStyleRe.match(html);
    if (sectionMatch.hasMatch()) {
        QMap<QString, QString> styleMap = parseStyleMap(sectionMatch.captured(1));
        styleMap.insert("width", QString("%1px").arg(data.width));
        styleMap.insert("height", QString("%1px").arg(data.height));
        styleMap.insert("background", data.backgroundColor);
        styleMap.insert("overflow", "visible");

        if (data.borderWidth > 0) {
            styleMap.insert("box-shadow", QString("0 0 0 %1px %2").arg(data.borderWidth).arg(data.borderColor));
            styleMap.remove("border");
            styleMap.remove("border-style");
            styleMap.remove("border-width");
            styleMap.remove("border-color");
        } else {
            styleMap.remove("box-shadow");
            styleMap.remove("border");
            styleMap.remove("border-style");
            styleMap.remove("border-width");
            styleMap.remove("border-color");
        }

        html.replace(sectionMatch.capturedStart(1), sectionMatch.capturedLength(1), toStyleString(styleMap));
    }

    pushDocumentChange(html, m_selectedElementIndex, "Edit Document");
}

void MainWindow::onPropertyPanelEdited(const PropertyPanel::ElementData &data)
{
    if (m_selectedElementIndex < 0 || m_selectedElementIndex >= m_elements.size()) {
        return;
    }

    const HtmlElementToken token = m_elements[m_selectedElementIndex];
    PropertyPanel::ElementData alignedData = data;
    applyScreenAlignment(alignedData);

    HtmlElementEdit edit;
    edit.x = alignedData.x;
    edit.y = alignedData.y;
    edit.width = alignedData.width;
    edit.height = alignedData.height;
    edit.fontSize = alignedData.fontSize;
    edit.text = alignedData.text;
    edit.fgColor = alignedData.fgColor;
    edit.bgColor = alignedData.bgColor;
    edit.textAlign = alignedData.textAlign;
    edit.verticalTextAlign = alignedData.verticalTextAlign;
    edit.borderWidth = alignedData.borderWidth;
    edit.borderColor = alignedData.borderColor;
    edit.marginTop = alignedData.marginTop;
    edit.marginBottom = alignedData.marginBottom;
    edit.marginLeft = alignedData.marginLeft;
    edit.marginRight = alignedData.marginRight;

    const QString newHtml = HtmlGenerator::updateElement(ui->codeView->toPlainText(), token, edit);
    pushDocumentChange(newHtml, m_selectedElementIndex, "Edit Element");
}

void MainWindow::updateCodeViewFromCanvas()
{
    m_blockCodeSync = true;
    ui->codeView->setPlainText(ui->canvasWidget->html());
    m_blockCodeSync = false;
}

void MainWindow::updateCanvasFromCodeView()
{
    if (m_blockCodeSync) {
        return;
    }

    if (!m_skipCanvasReload) {
        ui->canvasWidget->setActiveFontInfo(m_activeFont, m_activeSystemFont);
        ui->canvasWidget->setHtml(ui->codeView->toPlainText());
    }
    refreshEditableElements();
}

void MainWindow::applyDocumentHtml(const QString &html, int selectedIndex)
{
    m_applyingDocumentState = true;

    m_blockCodeSync = true;
    ui->codeView->setPlainText(html);
    m_blockCodeSync = false;

    updateCanvasFromCodeView();
    ui->propertyPanel->setDocumentData(currentDocumentData());

    if (m_elements.isEmpty()) {
        selectElementByIndex(-1);
    } else {
        const int safeIndex = qBound(0, selectedIndex, m_elements.size() - 1);
        selectElementByIndex(safeIndex);
    }

    m_applyingDocumentState = false;
}

void MainWindow::pushDocumentChange(const QString &html, int selectedIndex, const QString &text)
{
    if (m_applyingDocumentState || html == ui->codeView->toPlainText()) {
        return;
    }

    m_undoStack->push(new DocumentStateCommand(
        this,
        ui->codeView->toPlainText(),
        m_selectedElementIndex,
        html,
        selectedIndex,
        text));

    updateDirtyState();
}

bool MainWindow::saveToPath(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate)) {
        return false;
    }

    const QByteArray utf8 = ui->codeView->toPlainText().toUtf8();
    if (file.write(utf8) != utf8.size())
        return false;

    addToRecentFiles(filePath);
    return true;
}

void MainWindow::refreshEditableElements()
{
    m_elements = HtmlParser::parseElements(ui->codeView->toPlainText());
    ui->propertyPanel->setDocumentData(currentDocumentData());
    if (m_elements.isEmpty()) {
        m_selectedElementIndex = -1;
        ui->propertyPanel->clearElementData();
    }

    updateDirtyState();
}

void MainWindow::updateDirtyState()
{
    m_isDirty = (ui->codeView->toPlainText() != m_lastSavedHtml);
    updateWindowTitle();
}

void MainWindow::updateWindowTitle()
{
    const QString name = m_currentFilePath.isEmpty() ? "Untitled" : QFileInfo(m_currentFilePath).fileName();
    const QString dirty = m_isDirty ? " *" : "";
    setWindowTitle(QString("TFT HTML Editor - %1%2").arg(name, dirty));
}

void MainWindow::selectElementAtCursor()
{
    const QTextCursor cursor = ui->codeView->textCursor();
    const int pos = cursor.hasSelection() ? cursor.selectionStart() : cursor.position();
    for (int i = 0; i < m_elements.size(); ++i) {
        const HtmlElementToken &e = m_elements[i];
        if (pos >= e.startOffset && pos <= e.endOffset) {
            selectElementByIndex(i, false);
            return;
        }
    }
}

void MainWindow::selectElementByIndex(int index, bool moveCodeCursor)
{
    if (index < 0 || index >= m_elements.size()) {
        m_selectedElementIndex = -1;
        ui->propertyPanel->clearElementData();
        ui->canvasWidget->highlightElement(-1);
        updateCodeHighlights(-1);
        return;
    }

    const bool preserveTransientState = (index == m_selectedElementIndex);
    m_selectedElementIndex = index;
    const HtmlElementToken &token = m_elements[index];
    ui->propertyPanel->setElementData(toPanelData(token), preserveTransientState);
    ui->canvasWidget->highlightElement(index);
    updateCodeHighlights(index);

    if (!moveCodeCursor) {
        return;
    }

    m_blockCursorSync = true;
    QTextCursor cursor = ui->codeView->textCursor();
    cursor.setPosition(token.startOffset);
    ui->codeView->setTextCursor(cursor);
    ui->codeView->centerCursor();
    m_blockCursorSync = false;
}

void MainWindow::updateCodeHighlights(int index)
{
    QList<CodeView::HighlightRange> ranges;

    if (index >= 0 && index < m_elements.size()) {
        ranges.push_back({m_elements[index].startOffset, m_elements[index].endOffset, QColor(26, 115, 232, 48)});
    }

    ui->codeView->setHighlightRanges(ranges);
}

QString MainWindow::makeDefaultElementHtml(const QString &elementType, int x, int y) const
{
    const QString type = elementType.toLower().trimmed();

    if (type == "button") {
        return QString("<button style=\"position:absolute; left:%1px; top:%2px; width:200px; height:90px; border:0; background:#2455ff; color:#ffffff; font-size:20px; font-weight:700; font-family:'Square721 BT', Tahoma, Geneva, sans-serif; display:flex; align-items:center; justify-content:center;\">Button</button>")
            .arg(x)
            .arg(y);
    }
    if (type == "label") {
        return QString("<label style=\"position:absolute; left:%1px; top:%2px; width:140px; height:30px; color:#ffffff; background:#000000; font-size:20px; font-weight:700; font-family:'Square721 BT', Tahoma, Geneva, sans-serif;\">Label</label>")
            .arg(x)
            .arg(y);
    }
    if (type == "output") {
        return QString("<output style=\"position:absolute; left:%1px; top:%2px; width:90px; height:30px; color:#ffffff; background:#000000; font-size:20px; font-family:'Square721 BT', Tahoma, Geneva, sans-serif;\">0</output>")
            .arg(x)
            .arg(y);
    }
    if (type == "hline") {
        return QString("<div style=\"position:absolute; left:%1px; top:%2px; width:200px; height:1px; background:#2455ff;\"></div>")
            .arg(x)
            .arg(y);
    }
    if (type == "left_arrow") {
        return QString("<button style=\"position:absolute; left:%1px; top:%2px; width:80px; height:50px; border:0; background:#2455ff; color:#ffffff; font-size:20px; font-weight:700; font-family:'Square721 BT', Tahoma, Geneva, sans-serif;\">&#8592;</button>")
            .arg(x)
            .arg(y);
    }
    if (type == "up_arrow") {
        return QString("<button style=\"position:absolute; left:%1px; top:%2px; width:60px; height:50px; border:0; background:#2455ff; color:#ffffff; font-size:20px; font-weight:700; font-family:'Square721 BT', Tahoma, Geneva, sans-serif;\">&#8593;</button>")
            .arg(x)
            .arg(y);
    }
    if (type == "down_arrow") {
        return QString("<button style=\"position:absolute; left:%1px; top:%2px; width:60px; height:50px; border:0; background:#2455ff; color:#ffffff; font-size:20px; font-weight:700; font-family:'Square721 BT', Tahoma, Geneva, sans-serif;\">&#8595;</button>")
            .arg(x)
            .arg(y);
    }

    return QString("<div style=\"position:absolute; left:%1px; top:%2px; width:120px; height:50px; background:#2455ff;\"></div>")
        .arg(x)
        .arg(y);
}

PropertyPanel::ElementData MainWindow::toPanelData(const HtmlElementToken &token) const
{
    PropertyPanel::ElementData data;
    const auto styleInsetPx = [&token](const QString &primaryKey, const QString &legacyKey) {
        const int primaryValue = HtmlParser::stylePxValue(token.style, primaryKey, 0);
        if (primaryValue > 0) {
            return primaryValue;
        }
        return HtmlParser::stylePxValue(token.style, legacyKey, 0);
    };

    data.type = token.tag;
    data.x = HtmlParser::stylePxValue(token.style, "left", 0);
    data.y = HtmlParser::stylePxValue(token.style, "top", 0);
    data.width = HtmlParser::stylePxValue(token.style, "width", token.tag == "div" ? 100 : 80);
    data.height = HtmlParser::stylePxValue(token.style, "height", token.tag == "div" ? 1 : 30);
    data.text = token.text;
    data.fontSize = HtmlParser::stylePxValue(token.style, "font-size", 12);
    data.fgColor = HtmlParser::styleValue(token.style, "color");
    data.bgColor = HtmlParser::styleValue(token.style, "background");
    data.textAlign = HtmlParser::styleValue(token.style, "text-align");
    // Vertical text alignment from flexbox justify-content
    const QString justifyContent = HtmlParser::styleValue(token.style, "justify-content");
    if (justifyContent == "center") {
        data.verticalTextAlign = "center";
    } else if (justifyContent == "flex-end") {
        data.verticalTextAlign = "bottom";
    } else {
        data.verticalTextAlign = "top";
    }
    // Border
    const QString borderVal = HtmlParser::styleValue(token.style, "border");
    if (!borderVal.isEmpty()) {
        static const QRegularExpression borderRe(R"((\d+)\s*px\s+\w+\s+(#[0-9a-fA-F]{3,8}|rgb[^)]*\)))");
        const QRegularExpressionMatch bm = borderRe.match(borderVal);
        if (bm.hasMatch()) {
            data.borderWidth = bm.captured(1).toInt();
            data.borderColor = bm.captured(2);
        }
    }
    data.marginTop = styleInsetPx("padding-top", "margin-top");
    data.marginBottom = styleInsetPx("padding-bottom", "margin-bottom");
    data.marginLeft = styleInsetPx("padding-left", "margin-left");
    data.marginRight = styleInsetPx("padding-right", "margin-right");
    int tokenIndex = -1;
    for (int i = 0; i < m_elements.size(); ++i) {
        if (m_elements[i].startOffset == token.startOffset && m_elements[i].endOffset == token.endOffset) {
            tokenIndex = i;
            break;
        }
    }
    data.allowScreenAlignment = isTopLevelElement(tokenIndex);

    if (data.fgColor.isEmpty()) {
        data.fgColor = "#ffffff";
    }
    if (data.bgColor.isEmpty()) {
        data.bgColor = "#000000";
    }
    if (data.textAlign.isEmpty()) {
        data.textAlign = "left";
    }

    return data;
}

bool MainWindow::isTopLevelElement(int index) const
{
    if (index < 0 || index >= m_elements.size()) {
        return false;
    }

    const HtmlElementToken &token = m_elements[index];
    for (int i = 0; i < m_elements.size(); ++i) {
        if (i == index) {
            continue;
        }

        const HtmlElementToken &candidateParent = m_elements[i];
        if (candidateParent.startOffset < token.startOffset && candidateParent.endOffset > token.endOffset) {
            return false;
        }
    }

    return true;
}

void MainWindow::applyScreenAlignment(PropertyPanel::ElementData &data) const
{
    if (!data.allowScreenAlignment || m_selectedElementIndex < 0 || m_selectedElementIndex >= m_elements.size()) {
        return;
    }

    const PropertyPanel::DocumentData document = currentDocumentData();
    data.x = alignedCoordinate(
        data.horizontalScreenAlign,
        document.width,
        data.width,
        data.horizontalScreenMargin,
        data.x);
    data.y = alignedCoordinate(
        data.verticalScreenAlign,
        document.height,
        data.height,
        data.verticalScreenMargin,
        data.y);
}

PropertyPanel::DocumentData MainWindow::currentDocumentData() const
{
    PropertyPanel::DocumentData data;
    const QString html = ui->codeView->toPlainText();

    const QRegularExpression sectionStyleRe(R"re(<section\b[^>]*style="([^"]*)")re", QRegularExpression::CaseInsensitiveOption);
    const QRegularExpressionMatch sectionMatch = sectionStyleRe.match(html);
    if (sectionMatch.hasMatch()) {
        const QString style = sectionMatch.captured(1);
        data.width = HtmlParser::stylePxValue(style, "width", data.width);
        data.height = HtmlParser::stylePxValue(style, "height", data.height);
        const QString bg = HtmlParser::styleValue(style, "background");
        if (!bg.isEmpty()) {
            data.backgroundColor = bg;
        }
        data.borderWidth = parseBorderWidthPx(style, data.borderWidth);
        data.borderColor = parseBorderColorValue(style, data.borderColor);
    }

    return data;
}

QString MainWindow::offsetElementHtml(const QString &elementHtml, int dx, int dy) const
{
    QVector<HtmlElementToken> tokens = HtmlParser::parseElements(elementHtml);
    if (tokens.isEmpty()) {
        return elementHtml;
    }

    const HtmlElementToken token = tokens.first();
    HtmlElementEdit edit;
    edit.x = HtmlParser::stylePxValue(token.style, "left", 0) + dx;
    edit.y = HtmlParser::stylePxValue(token.style, "top", 0) + dy;
    edit.width = HtmlParser::stylePxValue(token.style, "width", 80);
    edit.height = HtmlParser::stylePxValue(token.style, "height", 30);
    edit.fontSize = HtmlParser::stylePxValue(token.style, "font-size", 12);
    edit.text = token.text;
    edit.fgColor = HtmlParser::styleValue(token.style, "color");
    edit.bgColor = HtmlParser::styleValue(token.style, "background");

    return HtmlGenerator::updateElement(elementHtml, token, edit);
}

void MainWindow::onToggleGrid(bool enabled)
{
    m_gridEnabled = enabled;
    ui->canvasWidget->setGridSettings(m_gridEnabled, m_gridStep, QColor(m_gridColor));
    saveSettings();
    statusBar()->showMessage(enabled ? "Grid enabled" : "Grid disabled", 1500);
}

void MainWindow::onConfigureGrid()
{
    bool ok = false;
    const int step = QInputDialog::getInt(
        this,
        "Grid Step",
        "Step (px):",
        m_gridStep,
        2,
        200,
        1,
        &ok);
    if (!ok) {
        return;
    }

    const QColor color = QColorDialog::getColor(QColor(m_gridColor), this, "Grid Color");
    if (!color.isValid()) {
        return;
    }

    m_gridStep = step;
    m_gridColor = color.name(QColor::HexRgb);
    ui->canvasWidget->setGridSettings(m_gridEnabled, m_gridStep, QColor(m_gridColor));
    saveSettings();
    statusBar()->showMessage(
        QString("Grid updated: step=%1, color=%2").arg(m_gridStep).arg(m_gridColor),
        2000);
}

void MainWindow::onConfigureViewerBackground()
{
    const QColor color = QColorDialog::getColor(QColor(m_viewerBackgroundColor), this, "Viewer Background");
    if (!color.isValid()) {
        return;
    }

    m_viewerBackgroundColor = color.name(QColor::HexRgb);
    ui->canvasWidget->setViewerBackgroundColor(color);
    saveSettings();
    statusBar()->showMessage(QString("Viewer background: %1").arg(m_viewerBackgroundColor), 2000);
}

void MainWindow::onToggleCenterPreview(bool enabled)
{
    m_centerPreviewEnabled = enabled;
    ui->canvasWidget->setPreviewCentered(enabled);
    saveSettings();
    statusBar()->showMessage(enabled ? "Preview centered" : "Preview aligned to top-left", 1500);
}

void MainWindow::onLoadFont()
{
    const QString path = QFileDialog::getOpenFileName(
        this, "Load TFT Font", QString(),
        "Assembly Font Files (*.s);;All Files (*.*)");
    if (path.isEmpty())
        return;

    if (TftFontManager::instance().loadFontFile(path)) {
        statusBar()->showMessage(QString("Font loaded: %1").arg(QFileInfo(path).fileName()), 3000);
        // Refresh canvas to re-render with new font
        updateCanvasFromCodeView();
    } else {
        statusBar()->showMessage("Failed to load font file", 3000);
    }
}

void MainWindow::onLoadFontDirectory()
{
    const QString dir = QFileDialog::getExistingDirectory(
        this, "Select Font Directory", "Z:/Graphics/Raster Fonts");
    if (dir.isEmpty())
        return;

    const QStringList files = TftFont::availableFontFiles(dir);
    int loaded = 0;
    for (const QString &path : files) {
        if (TftFontManager::instance().loadFontFile(path))
            loaded++;
    }

    statusBar()->showMessage(QString("Loaded %1 fonts from %2").arg(loaded).arg(dir), 3000);
    if (loaded > 0)
        updateCanvasFromCodeView();
}

void MainWindow::refreshFontListMenu()
{
    ui->fontListMenu->clear();
    const QStringList names = TftFontManager::instance().fontNames();
    if (names.isEmpty()) {
        ui->fontListMenu->addAction("(no fonts loaded)")->setEnabled(false);
        return;
    }
    for (const QString &name : names) {
        const TftFont *f = TftFontManager::instance().font(name);
        const QString label = f
            ? QString("%1  (size %2, height %3)").arg(name).arg(f->emHeight()).arg(f->bitmapHeight())
            : name;
        auto *action = ui->fontListMenu->addAction(label);
        action->setCheckable(true);
        action->setChecked(name == m_activeFont);
        m_fontActionGroup->addAction(action);
        connect(action, &QAction::triggered, this, [this, name]() {
            setActiveFont(name);
        });
    }
}

void MainWindow::refreshSystemFontMenu()
{
    ui->systemFontMenu->clear();
    const QStringList families = QFontDatabase::families();
    for (const QString &family : families) {
        auto *action = ui->systemFontMenu->addAction(family);
        action->setCheckable(true);
        action->setChecked(m_activeFont.isEmpty() && family == m_activeSystemFont);
        m_fontActionGroup->addAction(action);
        connect(action, &QAction::triggered, this, [this, family]() {
            setActiveSystemFont(family);
        });
    }
}

void MainWindow::setActiveFont(const QString &fontName)
{
    m_activeFont = fontName;
    m_activeSystemFont.clear();
    QSettings settings;
    settings.setValue("fonts/activeFont", m_activeFont);
    settings.setValue("fonts/activeSystemFont", QString());
    updateCanvasFromCodeView();
    statusBar()->showMessage(QString("Active font: %1").arg(fontName), 3000);
}

void MainWindow::setActiveSystemFont(const QString &family)
{
    m_activeFont.clear();
    m_activeSystemFont = family;
    QSettings settings;
    settings.setValue("fonts/activeFont", QString());
    settings.setValue("fonts/activeSystemFont", family);
    updateCanvasFromCodeView();
    statusBar()->showMessage(QString("Active system font: %1").arg(family), 3000);
}

void MainWindow::onOpenFontEditor()
{
    auto *editor = new FontEditorWindow(this);
    editor->setAttribute(Qt::WA_DeleteOnClose);
    connect(editor, &FontEditorWindow::fontModified, this, [this]() {
        updateCanvasFromCodeView();
    });
    editor->show();
}

void MainWindow::closeEvent(QCloseEvent *event)
{
    if (m_isDirty) {
        const QMessageBox::StandardButton answer = QMessageBox::question(
            this,
            "Unsaved changes",
            "The document has unsaved changes. Save before closing?",
            QMessageBox::Yes | QMessageBox::No | QMessageBox::Cancel,
            QMessageBox::Yes);

        if (answer == QMessageBox::Cancel) {
            event->ignore();
            return;
        }
        if (answer == QMessageBox::Yes && !saveDocumentInteractively()) {
            event->ignore();
            return;
        }
    }

    saveSettings();
    QMainWindow::closeEvent(event);
}
