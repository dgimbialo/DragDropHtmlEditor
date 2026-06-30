#include "fonteditorwindow.h"
#include "ui_fonteditorwindow.h"
#include "glypheditorwidget.h"

#include <QComboBox>
#include <QFileDialog>
#include <QInputDialog>
#include <QLabel>
#include <QListWidget>
#include <QMessageBox>
#include <QPlainTextEdit>
#include <QPushButton>
#include <QSplitter>
#include <QSpinBox>
#include <QStatusBar>
#include <QTextStream>

#include "../model/tftfont.h"
#include "../model/tftfontmanager.h"

FontEditorWindow::FontEditorWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::FontEditorWindowUi)
{
    ui->setupUi(this);
    setWindowTitle("TFT Font Editor");
    resize(1100, 750);

    // Configure splitter stretch
    ui->mainSplitter->setStretchFactor(0, 0);
    ui->mainSplitter->setStretchFactor(1, 1);
    ui->mainSplitter->setStretchFactor(2, 0);
    ui->mainSplitter->setSizes({220, 560, 280});

    // Connections
    connect(ui->fontCombo, QOverload<int>::of(&QComboBox::currentIndexChanged),
            this, &FontEditorWindow::onFontSelected);
    connect(ui->glyphList, &QListWidget::currentRowChanged,
            this, [this]() { onGlyphSelected(); });
    connect(ui->glyphEditor, &GlyphEditorWidget::pixelChanged,
            this, &FontEditorWindow::onGlyphPixelChanged);
    connect(ui->glyphEditor, &GlyphEditorWidget::glyphModified,
            this, &FontEditorWindow::onGlyphEditorModified);
    connect(ui->glyphEditor, &GlyphEditorWidget::deleteRowRequested,
            this, &FontEditorWindow::onDeleteRow);
    connect(ui->glyphEditor, &GlyphEditorWidget::deleteColumnRequested,
            this, &FontEditorWindow::onDeleteColumn);
    connect(ui->zoomSpin, QOverload<int>::of(&QSpinBox::valueChanged),
            this, &FontEditorWindow::onZoomChanged);
    connect(ui->widthSpin, QOverload<int>::of(&QSpinBox::valueChanged),
            this, &FontEditorWindow::onWidthChanged);
    connect(ui->heightSpin, QOverload<int>::of(&QSpinBox::valueChanged),
            this, &FontEditorWindow::onHeightChanged);
    connect(ui->addButton, &QPushButton::clicked, this, &FontEditorWindow::onAddGlyph);
    connect(ui->deleteButton, &QPushButton::clicked, this, &FontEditorWindow::onDeleteGlyph);
    connect(ui->commentButton, &QPushButton::clicked, this, &FontEditorWindow::onToggleComment);
    connect(ui->saveButton, &QPushButton::clicked, this, &FontEditorWindow::onSaveFont);
    connect(ui->loadButton, &QPushButton::clicked, this, &FontEditorWindow::onLoadFont);
    connect(ui->clearButton, &QPushButton::clicked, this, &FontEditorWindow::onClearGlyph);
    connect(ui->invertButton, &QPushButton::clicked, this, &FontEditorWindow::onInvertGlyph);
    connect(ui->dataFormatCombo, QOverload<int>::of(&QComboBox::currentIndexChanged),
            this, [this]() { updateDataPreview(); });

    populateFontList();

    connect(&TftFontManager::instance(), &TftFontManager::fontsChanged,
            this, &FontEditorWindow::populateFontList);
}

FontEditorWindow::~FontEditorWindow()
{
    delete ui;
}

TftFont *FontEditorWindow::currentFont() const
{
    const QString name = ui->fontCombo->currentData().toString();
    if (name.isEmpty())
        return nullptr;
    return TftFontManager::instance().font(name);
}

void FontEditorWindow::populateFontList()
{
    const QString prev = ui->fontCombo->currentData().toString();
    ui->fontCombo->blockSignals(true);
    ui->fontCombo->clear();

    const QStringList names = TftFontManager::instance().fontNames();
    for (const QString &name : names) {
        const TftFont *f = TftFontManager::instance().font(name);
        const QString label = QString("%1 (%2pt, h=%3)")
                                  .arg(name)
                                  .arg(f ? f->emHeight() : 0)
                                  .arg(f ? f->bitmapHeight() : 0);
        ui->fontCombo->addItem(label, name);
    }

    // Restore selection
    const int idx = ui->fontCombo->findData(prev);
    if (idx >= 0)
        ui->fontCombo->setCurrentIndex(idx);

    ui->fontCombo->blockSignals(false);

    if (ui->fontCombo->count() > 0 && ui->fontCombo->currentIndex() >= 0)
        onFontSelected(ui->fontCombo->currentIndex());
}

void FontEditorWindow::onFontSelected(int)
{
    populateGlyphList();
}

void FontEditorWindow::populateGlyphList()
{
    ui->glyphList->blockSignals(true);
    ui->glyphList->clear();

    TftFont *f = currentFont();
    if (!f) {
        ui->glyphList->blockSignals(false);
        ui->glyphEditor->clear();
        return;
    }

    const QList<int> codes = f->charCodes();
    for (int code : codes) {
        const TftGlyph *g = f->glyph(code);
        if (!g)
            continue;

        QString label;
        if (code >= 0x20 && code <= 0x7E)
            label = QString("0x%1 '%2'  w=%3")
                        .arg(code, 2, 16, QChar('0'))
                        .arg(QChar(code))
                        .arg(g->width);
        else
            label = QString("0x%1  w=%2")
                        .arg(code, 2, 16, QChar('0'))
                        .arg(g->width);

        if (g->commented)
            label = QString("; %1 [commented]").arg(label);

        auto *item = new QListWidgetItem(label);
        item->setData(Qt::UserRole, code);
        if (g->commented) {
            item->setForeground(QColor(160, 160, 160));
            item->setBackground(QColor(245, 245, 245));
        }
        ui->glyphList->addItem(item);
    }

    ui->glyphList->blockSignals(false);

    if (ui->glyphList->count() > 0) {
        ui->glyphList->setCurrentRow(0);
        onGlyphSelected();
    } else {
        ui->glyphEditor->clear();
    }
}

void FontEditorWindow::onGlyphSelected()
{
    auto *item = ui->glyphList->currentItem();
    if (!item) {
        ui->glyphEditor->clear();
        m_currentCharCode = -1;
        return;
    }

    const int code = item->data(Qt::UserRole).toInt();
    selectGlyph(code);
}

void FontEditorWindow::selectGlyph(int charCode)
{
    m_currentCharCode = charCode;
    TftFont *f = currentFont();
    if (!f) {
        ui->glyphEditor->clear();
        return;
    }

    const TftGlyph *g = f->glyph(charCode);
    if (!g) {
        ui->glyphEditor->clear();
        return;
    }

    ui->widthSpin->blockSignals(true);
    ui->widthSpin->setValue(g->width);
    ui->widthSpin->blockSignals(false);

    ui->heightSpin->blockSignals(true);
    ui->heightSpin->setValue(f->bitmapHeight());
    ui->heightSpin->blockSignals(false);

    ui->glyphEditor->setGlyph(charCode, g->width, f->bitmapHeight(), g->bitmap);

    QString info;
    if (charCode >= 0x20 && charCode <= 0x7E)
        info = QString("Char: 0x%1 '%2'  Size: %3x%4  Bytes/row: %5")
                   .arg(charCode, 2, 16, QChar('0'))
                   .arg(QChar(charCode))
                   .arg(g->width)
                   .arg(f->bitmapHeight())
                   .arg(g->bytesPerRow());
    else
        info = QString("Char: 0x%1  Size: %2x%3  Bytes/row: %4")
                   .arg(charCode, 2, 16, QChar('0'))
                   .arg(g->width)
                   .arg(f->bitmapHeight())
                   .arg(g->bytesPerRow());

    ui->glyphInfoLabel->setText(info);
    updateGlyphPreview();
    updateDataPreview();
}

void FontEditorWindow::onGlyphPixelChanged(int charCode, int x, int y, bool on)
{
    qDebug() << "onGlyphPixelChanged" << charCode << x << y << on;
    TftFont *f = currentFont();
    if (!f)
        return;

    f->setGlyphPixel(charCode, x, y, on);
    qDebug() << "  calling updateGlyphPreview";
    updateGlyphPreview();
    qDebug() << "  done";
}

void FontEditorWindow::onGlyphEditorModified()
{
    qDebug() << "onGlyphEditorModified";
    // Sync editor bitmap back to font
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0)
        return;

    TftGlyph *g = f->glyphMutable(m_currentCharCode);
    if (g) {
        g->bitmap = ui->glyphEditor->bitmap();
    }

    qDebug() << "  calling updateDataPreview";
    updateDataPreview();
    qDebug() << "  emitting fontModified";
    emit fontModified();
    qDebug() << "  done";
}

void FontEditorWindow::onZoomChanged(int value)
{
    ui->glyphEditor->setCellSize(value / 100);
}

void FontEditorWindow::onWidthChanged(int value)
{
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0)
        return;

    f->setGlyphWidth(m_currentCharCode, value);

    // Reload glyph in editor
    const TftGlyph *g = f->glyph(m_currentCharCode);
    if (g)
        ui->glyphEditor->setGlyph(m_currentCharCode, g->width, f->bitmapHeight(), g->bitmap);

    updateGlyphPreview();
    updateDataPreview();
    emit fontModified();
}

void FontEditorWindow::onHeightChanged(int value)
{
    TftFont *f = currentFont();
    if (!f)
        return;

    f->setBitmapHeight(value);

    // Reload glyph in editor
    if (m_currentCharCode >= 0) {
        const TftGlyph *g = f->glyph(m_currentCharCode);
        if (g)
            ui->glyphEditor->setGlyph(m_currentCharCode, g->width, f->bitmapHeight(), g->bitmap);
    }

    updateGlyphPreview();
    updateDataPreview();
    emit fontModified();
}

void FontEditorWindow::onAddGlyph()
{
    TftFont *f = currentFont();
    if (!f)
        return;

    bool ok = false;
    const QString input = QInputDialog::getText(
        this, "Add Glyph", "Character code (hex, e.g. 41 for 'A'):",
        QLineEdit::Normal, "", &ok);
    if (!ok || input.isEmpty())
        return;

    const int code = input.toInt(&ok, 16);
    if (!ok || code < 0 || code > 0xFFFF) {
        QMessageBox::warning(this, "Invalid", "Invalid character code.");
        return;
    }

    if (f->glyph(code)) {
        QMessageBox::information(this, "Exists", "This character already exists in the font.");
        return;
    }

    bool widthOk = false;
    const int width = QInputDialog::getInt(this, "Glyph Width", "Width in pixels:", 8, 1, 128, 1, &widthOk);
    if (!widthOk)
        return;

    f->addGlyph(code, width);
    populateGlyphList();
    emit fontModified();
    statusBar()->showMessage(QString("Added glyph 0x%1").arg(code, 2, 16, QChar('0')), 2000);
}

void FontEditorWindow::onDeleteGlyph()
{
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0)
        return;

    const QMessageBox::StandardButton answer = QMessageBox::question(
        this, "Delete Glyph",
        QString("Delete glyph 0x%1?").arg(m_currentCharCode, 2, 16, QChar('0')));

    if (answer != QMessageBox::Yes)
        return;

    f->removeGlyph(m_currentCharCode);
    m_currentCharCode = -1;
    populateGlyphList();
    emit fontModified();
    statusBar()->showMessage("Glyph deleted", 2000);
}

void FontEditorWindow::onToggleComment()
{
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0)
        return;

    const TftGlyph *g = f->glyph(m_currentCharCode);
    if (!g)
        return;

    f->setGlyphCommented(m_currentCharCode, !g->commented);

    // Update the list item appearance
    auto *item = ui->glyphList->currentItem();
    if (item) {
        const bool commented = f->glyph(m_currentCharCode)->commented;
        if (commented) {
            item->setForeground(QColor(160, 160, 160));
            item->setBackground(QColor(245, 245, 245));
        } else {
            item->setForeground(QColor(0, 0, 0));
            item->setBackground(QColor(255, 255, 255));
        }

        // Update text
        QString label;
        if (m_currentCharCode >= 0x20 && m_currentCharCode <= 0x7E)
            label = QString("0x%1 '%2'  w=%3")
                        .arg(m_currentCharCode, 2, 16, QChar('0'))
                        .arg(QChar(m_currentCharCode))
                        .arg(g->width);
        else
            label = QString("0x%1  w=%2")
                        .arg(m_currentCharCode, 2, 16, QChar('0'))
                        .arg(g->width);
        if (commented)
            label = QString("; %1 [commented]").arg(label);
        item->setText(label);
    }

    updateDataPreview();
    emit fontModified();
    statusBar()->showMessage(
        f->glyph(m_currentCharCode)->commented ? "Glyph commented out" : "Glyph uncommented", 2000);
}

void FontEditorWindow::onSaveFont()
{
    TftFont *f = currentFont();
    if (!f)
        return;

    QString path = f->filePath();
    if (path.isEmpty()) {
        path = QFileDialog::getSaveFileName(
            this, "Save Font", f->fontName() + ".s",
            "Assembly Font Files (*.s);;All Files (*.*)");
        if (path.isEmpty())
            return;
    }

    if (f->saveToFile(path)) {
        statusBar()->showMessage(QString("Font saved: %1").arg(path), 3000);
    } else {
        QMessageBox::warning(this, "Error", "Failed to save font file.");
    }
}

void FontEditorWindow::onLoadFont()
{
    const QString path = QFileDialog::getOpenFileName(
        this, "Load TFT Font", QString(),
        "Assembly Font Files (*.s);;All Files (*.*)");
    if (path.isEmpty())
        return;

    if (TftFontManager::instance().loadFontFile(path)) {
        statusBar()->showMessage(QString("Font loaded: %1").arg(QFileInfo(path).fileName()), 3000);
        // populateFontList is called via fontsChanged signal
    } else {
        QMessageBox::warning(this, "Error", "Failed to load font file.");
    }
}

void FontEditorWindow::onClearGlyph()
{
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0)
        return;

    TftGlyph *g = f->glyphMutable(m_currentCharCode);
    if (g) {
        std::fill(g->bitmap.begin(), g->bitmap.end(), static_cast<uint8_t>(0));
        ui->glyphEditor->setGlyph(m_currentCharCode, g->width, f->bitmapHeight(), g->bitmap);
        updateGlyphPreview();
        updateDataPreview();
        emit fontModified();
    }
}

void FontEditorWindow::onInvertGlyph()
{
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0)
        return;

    TftGlyph *g = f->glyphMutable(m_currentCharCode);
    if (g) {
        for (auto &b : g->bitmap)
            b = ~b;
        ui->glyphEditor->setGlyph(m_currentCharCode, g->width, f->bitmapHeight(), g->bitmap);
        updateGlyphPreview();
        updateDataPreview();
        emit fontModified();
    }
}

void FontEditorWindow::onDeleteRow(int row)
{
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0)
        return;

    f->deleteRow(row);

    ui->heightSpin->blockSignals(true);
    ui->heightSpin->setValue(f->bitmapHeight());
    ui->heightSpin->blockSignals(false);

    const TftGlyph *g = f->glyph(m_currentCharCode);
    if (g)
        ui->glyphEditor->setGlyph(m_currentCharCode, g->width, f->bitmapHeight(), g->bitmap);

    updateGlyphPreview();
    updateDataPreview();
    emit fontModified();
    statusBar()->showMessage(QString("Row %1 deleted").arg(row + 1), 2000);
}

void FontEditorWindow::onDeleteColumn(int col)
{
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0)
        return;

    f->deleteGlyphColumn(m_currentCharCode, col);

    const TftGlyph *g = f->glyph(m_currentCharCode);
    if (g) {
        ui->widthSpin->blockSignals(true);
        ui->widthSpin->setValue(g->width);
        ui->widthSpin->blockSignals(false);
        ui->glyphEditor->setGlyph(m_currentCharCode, g->width, f->bitmapHeight(), g->bitmap);
    }

    updateGlyphPreview();
    updateDataPreview();
    emit fontModified();
    statusBar()->showMessage(QString("Column %1 deleted").arg(col + 1), 2000);
}

void FontEditorWindow::updateGlyphPreview()
{
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0) {
        ui->previewLabel->setPixmap({});
        return;
    }

    // Render the character at 2x scale with white on black
    const QImage img = f->renderGlyph(m_currentCharCode, 0xFFFFFFFF, 0xFF000000);
    if (img.isNull()) {
        ui->previewLabel->setPixmap({});
        return;
    }

    // Show at 3x zoom for preview clarity
    const QImage scaled = img.scaled(img.width() * 3, img.height() * 3, Qt::KeepAspectRatio, Qt::FastTransformation);
    ui->previewLabel->setPixmap(QPixmap::fromImage(scaled));
}

void FontEditorWindow::updateAsmPreview()
{
    TftFont *f = currentFont();
    if (!f || m_currentCharCode < 0) {
        ui->asmPreview->clear();
        return;
    }

    const TftGlyph *g = f->glyph(m_currentCharCode);
    if (!g) {
        ui->asmPreview->clear();
        return;
    }

    // Build ASM snippet for this single glyph
    const int bpr = g->bytesPerRow();
    QString asm_text;
    QTextStream s(&asm_text);

    QString charLabel;
    if (m_currentCharCode >= 0x20 && m_currentCharCode <= 0x7E)
        charLabel = QString("'%1'").arg(QChar(m_currentCharCode));
    else
        charLabel = QString("0x%1").arg(m_currentCharCode, 2, 16, QChar('0'));

    s << "; Character 0x" << QString::number(m_currentCharCode, 16) << " " << charLabel << "\n";
    s << "; Width: " << g->width << "  Height: " << f->bitmapHeight()
      << "  Bytes/row: " << bpr << "\n\n";

    const QString prefix = g->commented ? ";\t" : "\t";

    for (int row = 0; row < f->bitmapHeight(); ++row) {
        s << prefix << ".pbyte\t";
        for (int b = 0; b < bpr; ++b) {
            const int idx = row * bpr + b;
            uint8_t val = (idx < g->bitmap.size()) ? g->bitmap[idx] : 0;
            s << "0x" << QString::number(val, 16).toUpper().rightJustified(2, '0');
            if (b + 1 < bpr)
                s << ",";
        }

        s << "\t\t; |";
        for (int x = 0; x < g->width; ++x)
            s << (g->pixelAt(x, row, f->bitmapHeight()) ? '#' : ' ');
        s << "|\n";
    }

    ui->asmPreview->setPlainText(asm_text);
}

void FontEditorWindow::updateDataPreview()
{
    const int fmt = ui->dataFormatCombo ? ui->dataFormatCombo->currentIndex() : 0;

    if (fmt == 1) {
        // C Array format
        ui->dataGroup->setTitle("C Array Preview");

        TftFont *f = currentFont();
        if (!f || m_currentCharCode < 0) {
            ui->asmPreview->clear();
            return;
        }

        const TftGlyph *g = f->glyph(m_currentCharCode);
        if (!g) {
            ui->asmPreview->clear();
            return;
        }

        const int bpr = g->bytesPerRow();
        QString text;
        QTextStream s(&text);

        QString charLabel;
        if (m_currentCharCode >= 0x20 && m_currentCharCode <= 0x7E)
            charLabel = QString("'%1'").arg(QChar(m_currentCharCode));
        else
            charLabel = QString("0x%1").arg(m_currentCharCode, 2, 16, QChar('0'));

        s << "// Character 0x" << QString::number(m_currentCharCode, 16) << " " << charLabel << "\n";
        s << "// Width: " << g->width << "  Height: " << f->bitmapHeight()
          << "  Bytes/row: " << bpr << "\n";
        s << "const uint8_t glyph_0x" << QString::number(m_currentCharCode, 16)
          << "[] = {\n";

        for (int row = 0; row < f->bitmapHeight(); ++row) {
            s << "    ";
            for (int b = 0; b < bpr; ++b) {
                const int idx = row * bpr + b;
                uint8_t val = (idx < g->bitmap.size()) ? g->bitmap[idx] : 0;
                s << "0x" << QString::number(val, 16).toUpper().rightJustified(2, '0');
                if (row + 1 < f->bitmapHeight() || b + 1 < bpr)
                    s << ",";
                if (b + 1 < bpr)
                    s << " ";
            }

            s << "  // |";
            for (int x = 0; x < g->width; ++x)
                s << (g->pixelAt(x, row, f->bitmapHeight()) ? '#' : ' ');
            s << "|\n";
        }

        s << "};\n";
        ui->asmPreview->setPlainText(text);
    } else {
        // Assembly format
        ui->dataGroup->setTitle("Assembly (.s) Preview");
        updateAsmPreview();
    }
}
