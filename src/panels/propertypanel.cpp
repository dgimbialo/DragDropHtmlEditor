#include "propertypanel.h"
#include "ui_propertypanel.h"

#include <QColorDialog>
#include <QComboBox>
#include <QFormLayout>
#include <QGroupBox>
#include <QHBoxLayout>
#include <QLabel>
#include <QLineEdit>
#include <QPlainTextEdit>
#include <QPushButton>
#include <QRegularExpression>
#include <QSignalBlocker>
#include <QSpinBox>
#include <QToolButton>
#include <QTextCursor>
#include <QVBoxLayout>

#include "../model/tftfontmanager.h"
#include "../model/tftfontmetrics.h"

namespace {
QString normalizeHexColor(const QString &raw)
{
    QString color = raw.trimmed();
    if (!color.startsWith('#')) {
        color.prepend('#');
    }

    const QRegularExpression shortRe(R"(^#([0-9a-fA-F]{3})$)");
    const QRegularExpression fullRe(R"(^#([0-9a-fA-F]{6})$)");

    const QRegularExpressionMatch shortMatch = shortRe.match(color);
    if (shortMatch.hasMatch()) {
        const QString s = shortMatch.captured(1);
        return QString("#%1%1%2%2%3%3")
            .arg(s.mid(0, 1), s.mid(1, 1), s.mid(2, 1))
            .toLower();
    }

    const QRegularExpressionMatch fullMatch = fullRe.match(color);
    if (fullMatch.hasMatch()) {
        return QString("#%1").arg(fullMatch.captured(1).toLower());
    }

    return "#000000";
}

QString snapToRgb332(const QString &hexColor)
{
    const QString normalized = normalizeHexColor(hexColor);
    const int r = normalized.mid(1, 2).toInt(nullptr, 16);
    const int g = normalized.mid(3, 2).toInt(nullptr, 16);
    const int b = normalized.mid(5, 2).toInt(nullptr, 16);

    const int r3 = qBound(0, qRound((r / 255.0) * 7.0), 7);
    const int g3 = qBound(0, qRound((g / 255.0) * 7.0), 7);
    const int b2 = qBound(0, qRound((b / 255.0) * 3.0), 3);

    const int r8 = qRound((r3 / 7.0) * 255.0);
    const int g8 = qRound((g3 / 7.0) * 255.0);
    const int b8 = qRound((b2 / 3.0) * 255.0);

    return QString("#%1%2%3")
        .arg(r8, 2, 16, QChar('0'))
        .arg(g8, 2, 16, QChar('0'))
        .arg(b8, 2, 16, QChar('0'))
        .toLower();
}
}

PropertyPanel::PropertyPanel(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::PropertyPanelUi)
{
    ui->setupUi(this);

    // Populate font sizes dynamically
    const QList<int> sizes = TftFontManager::instance().availableSizes();
    for (int s : sizes)
        ui->fontSizeCombo->addItem(QString::number(s));
    if (ui->fontSizeCombo->count() == 0)
        ui->fontSizeCombo->addItems({"8", "12", "16", "20", "32"});
    connect(&TftFontManager::instance(), &TftFontManager::fontsChanged, this, [this]() {
        const QString prev = ui->fontSizeCombo->currentText();
        ui->fontSizeCombo->blockSignals(true);
        ui->fontSizeCombo->clear();
        const QList<int> sizes = TftFontManager::instance().availableSizes();
        for (int s : sizes)
            ui->fontSizeCombo->addItem(QString::number(s));
        if (ui->fontSizeCombo->count() == 0)
            ui->fontSizeCombo->addItems({"8", "12", "16", "20", "32"});
        ui->fontSizeCombo->setCurrentText(prev);
        ui->fontSizeCombo->blockSignals(false);
    });

    wireSignals();
}

PropertyPanel::~PropertyPanel()
{
    delete ui;
}

QString PropertyPanel::currentHorizontalScreenAlign() const
{
    if (ui->alignLeftButton->isChecked()) {
        return "left";
    }
    if (ui->alignCenterButton->isChecked()) {
        return "center";
    }
    if (ui->alignRightButton->isChecked()) {
        return "right";
    }
    return "none";
}

QString PropertyPanel::currentVerticalScreenAlign() const
{
    if (ui->alignTopButton->isChecked()) {
        return "top";
    }
    if (ui->alignMiddleButton->isChecked()) {
        return "center";
    }
    if (ui->alignBottomButton->isChecked()) {
        return "bottom";
    }
    return "none";
}

void PropertyPanel::setHorizontalScreenAlign(const QString &align)
{
    const QSignalBlocker leftBlocker(ui->alignLeftButton);
    const QSignalBlocker centerBlocker(ui->alignCenterButton);
    const QSignalBlocker rightBlocker(ui->alignRightButton);

    ui->alignLeftButton->setChecked(align == "left");
    ui->alignCenterButton->setChecked(align == "center");
    ui->alignRightButton->setChecked(align == "right");
}

void PropertyPanel::setVerticalScreenAlign(const QString &align)
{
    const QSignalBlocker topBlocker(ui->alignTopButton);
    const QSignalBlocker middleBlocker(ui->alignMiddleButton);
    const QSignalBlocker bottomBlocker(ui->alignBottomButton);

    ui->alignTopButton->setChecked(align == "top");
    ui->alignMiddleButton->setChecked(align == "center");
    ui->alignBottomButton->setChecked(align == "bottom");
}

void PropertyPanel::setScreenAlignmentEnabled(bool enabled)
{
    ui->alignLeftButton->setEnabled(enabled);
    ui->alignCenterButton->setEnabled(enabled);
    ui->alignRightButton->setEnabled(enabled);
    ui->alignTopButton->setEnabled(enabled);
    ui->alignMiddleButton->setEnabled(enabled);
    ui->alignBottomButton->setEnabled(enabled);
    ui->horizontalScreenMarginSpin->setEnabled(enabled);
    ui->verticalScreenMarginSpin->setEnabled(enabled);
}

void PropertyPanel::wireSignals()
{
    auto emitDocumentState = [this]() {
        if (m_blockSignals) {
            return;
        }

        DocumentData data;
        data.width = ui->canvasWidthSpin->value();
        data.height = ui->canvasHeightSpin->value();
        data.backgroundColor = snapToRgb332(ui->documentBgColorEdit->text());
        data.borderColor = snapToRgb332(ui->documentBorderColorEdit->text());
        data.borderWidth = ui->documentBorderWidthSpin->value();
        emit documentEdited(data);
    };

    auto emitCurrentState = [this]() {
        if (m_blockSignals) {
            return;
        }

        ElementData data;
        data.type = ui->typeEdit->text();
        data.x = ui->xSpin->value();
        data.y = ui->ySpin->value();
        data.width = ui->wSpin->value();
        data.height = ui->hSpin->value();
        data.text = ui->textEdit->toPlainText();
        data.fontSize = ui->fontSizeCombo->currentText().toInt();
        data.fgColor = snapToRgb332(ui->fgColorEdit->text());
        data.bgColor = snapToRgb332(ui->bgColorEdit->text());
        data.textAlign = ui->textAlignCombo->currentText();
        data.verticalTextAlign = ui->verticalTextAlignCombo->currentText();
        data.horizontalScreenAlign = currentHorizontalScreenAlign();
        data.verticalScreenAlign = currentVerticalScreenAlign();
        data.horizontalScreenMargin = ui->horizontalScreenMarginSpin->value();
        data.verticalScreenMargin = ui->verticalScreenMarginSpin->value();
        data.allowScreenAlignment = ui->alignLeftButton->isEnabled();
        data.marginTop = ui->marginTopSpin->value();
        data.marginBottom = ui->marginBottomSpin->value();
        data.marginLeft = ui->marginLeftSpin->value();
        data.marginRight = ui->marginRightSpin->value();
        data.borderWidth = ui->borderWidthSpin->value();
        data.borderColor = snapToRgb332(ui->borderColorEdit->text());
        emit elementEdited(data);
    };

    // Color picker helper
    auto connectColorPicker = [this](QPushButton *btn, QLineEdit *edit, auto emitFn) {
        connect(btn, &QPushButton::clicked, this, [this, edit, emitFn]() {
            const QColor initial(normalizeHexColor(edit->text()));
            const QColor color = QColorDialog::getColor(initial, this, "Pick Color");
            if (color.isValid()) {
                edit->setText(snapToRgb332(color.name(QColor::HexRgb)));
                emitFn();
            }
        });
    };

    // Color swatch update helper
    auto updateColorSwatch = [](QPushButton *btn, const QString &hex) {
        const QString color = hex.startsWith('#') ? hex : ("#" + hex);
        btn->setStyleSheet(QString("background-color: %1; border: 1px solid #888;").arg(color));
    };

    auto connectColorSwatchUpdate = [updateColorSwatch](QLineEdit *edit, QPushButton *btn) {
        QObject::connect(edit, &QLineEdit::textChanged, [btn, updateColorSwatch](const QString &text) {
            const QString norm = text.trimmed().startsWith('#') ? text.trimmed() : ("#" + text.trimmed());
            if (QColor(norm).isValid())
                updateColorSwatch(btn, norm);
        });
    };

    // Document signals
    connect(ui->canvasWidthSpin, &QSpinBox::valueChanged, this, [emitDocumentState](int) { emitDocumentState(); });
    connect(ui->canvasHeightSpin, &QSpinBox::valueChanged, this, [emitDocumentState](int) { emitDocumentState(); });
    connect(ui->documentBgColorEdit, &QLineEdit::editingFinished, this, [this, emitDocumentState]() {
        ui->documentBgColorEdit->setText(snapToRgb332(ui->documentBgColorEdit->text()));
        emitDocumentState();
    });
    connect(ui->documentBorderColorEdit, &QLineEdit::editingFinished, this, [this, emitDocumentState]() {
        ui->documentBorderColorEdit->setText(snapToRgb332(ui->documentBorderColorEdit->text()));
        emitDocumentState();
    });
    connect(ui->documentBorderWidthSpin, &QSpinBox::valueChanged, this, [emitDocumentState](int) { emitDocumentState(); });

    connectColorPicker(ui->documentBgColorBtn, ui->documentBgColorEdit, emitDocumentState);
    connectColorPicker(ui->documentBorderColorBtn, ui->documentBorderColorEdit, emitDocumentState);
    connectColorSwatchUpdate(ui->documentBgColorEdit, ui->documentBgColorBtn);
    connectColorSwatchUpdate(ui->documentBorderColorEdit, ui->documentBorderColorBtn);

    // Element signals
    connect(ui->xSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->ySpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->wSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->hSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->bgColorEdit, &QLineEdit::editingFinished, this, [this, emitCurrentState]() {
        ui->bgColorEdit->setText(snapToRgb332(ui->bgColorEdit->text()));
        emitCurrentState();
    });
    connect(ui->borderWidthSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->borderColorEdit, &QLineEdit::editingFinished, this, [this, emitCurrentState]() {
        ui->borderColorEdit->setText(snapToRgb332(ui->borderColorEdit->text()));
        emitCurrentState();
    });

    connectColorPicker(ui->bgColorBtn, ui->bgColorEdit, emitCurrentState);
    connectColorPicker(ui->borderColorBtn, ui->borderColorEdit, emitCurrentState);
    connectColorSwatchUpdate(ui->bgColorEdit, ui->bgColorBtn);
    connectColorSwatchUpdate(ui->borderColorEdit, ui->borderColorBtn);

    // Text signals
    connect(ui->textEdit, &QPlainTextEdit::textChanged, this, [emitCurrentState, this]() { emitCurrentState(); updateTextWidthLabel(); });
    connect(ui->fontSizeCombo, &QComboBox::currentTextChanged, this, [emitCurrentState, this](const QString &) { emitCurrentState(); updateTextWidthLabel(); });
    connect(ui->fgColorEdit, &QLineEdit::editingFinished, this, [this, emitCurrentState]() {
        ui->fgColorEdit->setText(snapToRgb332(ui->fgColorEdit->text()));
        emitCurrentState();
    });
    connect(ui->textAlignCombo, &QComboBox::currentTextChanged, this, [emitCurrentState](const QString &) { emitCurrentState(); });
    connect(ui->verticalTextAlignCombo, &QComboBox::currentTextChanged, this, [emitCurrentState](const QString &) { emitCurrentState(); });

    connectColorPicker(ui->fgColorBtn, ui->fgColorEdit, emitCurrentState);
    connectColorSwatchUpdate(ui->fgColorEdit, ui->fgColorBtn);

    // Screen alignment
    const auto wireAlignButton = [this, emitCurrentState](QToolButton *button, const QList<QToolButton *> &group) {
        connect(button, &QToolButton::clicked, this, [this, button, group, emitCurrentState](bool checked) {
            if (m_blockSignals) {
                return;
            }

            for (QToolButton *other : group) {
                if (other == button) {
                    continue;
                }

                const QSignalBlocker blocker(other);
                other->setChecked(false);
            }

            if (!checked) {
                const QSignalBlocker blocker(button);
                button->setChecked(false);
            }

            emitCurrentState();
        });
    };

    wireAlignButton(ui->alignLeftButton, {ui->alignLeftButton, ui->alignCenterButton, ui->alignRightButton});
    wireAlignButton(ui->alignCenterButton, {ui->alignLeftButton, ui->alignCenterButton, ui->alignRightButton});
    wireAlignButton(ui->alignRightButton, {ui->alignLeftButton, ui->alignCenterButton, ui->alignRightButton});
    wireAlignButton(ui->alignTopButton, {ui->alignTopButton, ui->alignMiddleButton, ui->alignBottomButton});
    wireAlignButton(ui->alignMiddleButton, {ui->alignTopButton, ui->alignMiddleButton, ui->alignBottomButton});
    wireAlignButton(ui->alignBottomButton, {ui->alignTopButton, ui->alignMiddleButton, ui->alignBottomButton});

    connect(ui->horizontalScreenMarginSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->verticalScreenMarginSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->marginTopSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->marginBottomSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->marginLeftSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
    connect(ui->marginRightSpin, &QSpinBox::valueChanged, this, [emitCurrentState](int) { emitCurrentState(); });
}

void PropertyPanel::setDocumentData(const PropertyPanel::DocumentData &data)
{
    m_blockSignals = true;

    ui->canvasWidthSpin->setValue(data.width);
    ui->canvasHeightSpin->setValue(data.height);
    ui->documentBgColorEdit->setText(snapToRgb332(data.backgroundColor));
    ui->documentBorderColorEdit->setText(snapToRgb332(data.borderColor));
    ui->documentBorderWidthSpin->setValue(data.borderWidth);

    m_blockSignals = false;
}

void PropertyPanel::setElementData(const PropertyPanel::ElementData &data, bool preserveTransientState)
{
    m_blockSignals = true;

    ui->typeEdit->setText(data.type);
    ui->xSpin->setValue(data.x);
    ui->ySpin->setValue(data.y);
    ui->wSpin->setValue(data.width);
    ui->hSpin->setValue(data.height);

    const bool preserveTextCursor = ui->textEdit->hasFocus();
    const QTextCursor textCursor = ui->textEdit->textCursor();
    if (ui->textEdit->toPlainText() != data.text) {
        ui->textEdit->setPlainText(data.text);
        if (preserveTextCursor) {
            QTextCursor restoredCursor = ui->textEdit->textCursor();
            restoredCursor.setPosition(qBound(0, textCursor.position(), ui->textEdit->toPlainText().size()));
            if (textCursor.hasSelection()) {
                restoredCursor.setPosition(qBound(0, textCursor.anchor(), ui->textEdit->toPlainText().size()), QTextCursor::KeepAnchor);
            }
            ui->textEdit->setTextCursor(restoredCursor);
        }
    }

    const QString fontSize = QString::number(data.fontSize);
    const int fontIndex = ui->fontSizeCombo->findText(fontSize);
    if (fontIndex >= 0) {
        ui->fontSizeCombo->setCurrentIndex(fontIndex);
    }
    ui->fgColorEdit->setText(snapToRgb332(data.fgColor));
    ui->bgColorEdit->setText(snapToRgb332(data.bgColor));

    const int alignIndex = ui->textAlignCombo->findText(data.textAlign);
    if (alignIndex >= 0) {
        ui->textAlignCombo->setCurrentIndex(alignIndex);
    }

    const int vAlignIndex = ui->verticalTextAlignCombo->findText(data.verticalTextAlign);
    if (vAlignIndex >= 0) {
        ui->verticalTextAlignCombo->setCurrentIndex(vAlignIndex);
    }

    ui->borderWidthSpin->setValue(data.borderWidth);
    ui->borderColorEdit->setText(snapToRgb332(data.borderColor));

    setScreenAlignmentEnabled(data.allowScreenAlignment);

    if (!preserveTransientState) {
        const QSignalBlocker horizontalMarginBlocker(ui->horizontalScreenMarginSpin);
        const QSignalBlocker verticalMarginBlocker(ui->verticalScreenMarginSpin);

        setHorizontalScreenAlign(data.horizontalScreenAlign);
        setVerticalScreenAlign(data.verticalScreenAlign);

        ui->horizontalScreenMarginSpin->setValue(data.horizontalScreenMargin);
        ui->verticalScreenMarginSpin->setValue(data.verticalScreenMargin);
    }

    ui->marginTopSpin->setValue(data.marginTop);
    ui->marginBottomSpin->setValue(data.marginBottom);
    ui->marginLeftSpin->setValue(data.marginLeft);
    ui->marginRightSpin->setValue(data.marginRight);

    updateTextWidthLabel();

    m_blockSignals = false;
}

void PropertyPanel::clearElementData()
{
    m_blockSignals = true;

    ui->typeEdit->setText("none");
    ui->xSpin->setValue(0);
    ui->ySpin->setValue(0);
    ui->wSpin->setValue(1);
    ui->hSpin->setValue(1);
    ui->textEdit->clear();
    ui->fontSizeCombo->setCurrentText("12");
    ui->fgColorEdit->setText("#ffffff");
    ui->bgColorEdit->setText("#000000");
    ui->textAlignCombo->setCurrentText("left");
    ui->verticalTextAlignCombo->setCurrentText("top");
    ui->borderWidthSpin->setValue(0);
    ui->borderColorEdit->setText("#ffffff");
    setHorizontalScreenAlign("none");
    setVerticalScreenAlign("none");
    ui->horizontalScreenMarginSpin->setValue(0);
    ui->verticalScreenMarginSpin->setValue(0);
    setScreenAlignmentEnabled(false);
    ui->marginTopSpin->setValue(0);
    ui->marginBottomSpin->setValue(0);
    ui->marginLeftSpin->setValue(0);
    ui->marginRightSpin->setValue(0);
    ui->textWidthLabel->setText("0 px");

    m_blockSignals = false;
}

void PropertyPanel::updateTextWidthLabel()
{
    const int fontSize = ui->fontSizeCombo->currentText().toInt();
    const QString text = ui->textEdit->toPlainText();
    if (text.isEmpty()) {
        ui->textWidthLabel->setText("0 px");
        return;
    }
    const QStringList lines = text.split('\n');
    int maxWidth = 0;
    for (const QString &line : lines) {
        maxWidth = qMax(maxWidth, TftFontMetrics::textWidthPx(fontSize, line));
    }
    ui->textWidthLabel->setText(QString("%1 px").arg(maxWidth));
}
