#pragma once

#include <QWidget>

#include <QString>

namespace Ui { class PropertyPanelUi; }

class QFormLayout;
class QGroupBox;
class QLabel;
class QLineEdit;
class QSpinBox;
class QComboBox;
class QPlainTextEdit;
class QToolButton;
class QPushButton;

class PropertyPanel : public QWidget
{
    Q_OBJECT

public:
    struct DocumentData {
        int width = 480;
        int height = 320;
        QString backgroundColor = "#000000";
        QString borderColor = "#2455ff";
        int borderWidth = 1;
    };

    struct ElementData {
        QString type;
        int x = 0;
        int y = 0;
        int width = 1;
        int height = 1;
        QString text;
        int fontSize = 12;
        QString fgColor = "#ffffff";
        QString bgColor = "#000000";
        QString textAlign = "left";
        QString verticalTextAlign = "top";
        int marginTop = 0;
        int marginBottom = 0;
        int marginLeft = 0;
        int marginRight = 0;
        bool allowScreenAlignment = true;
        QString horizontalScreenAlign = "none";
        QString verticalScreenAlign = "none";
        int horizontalScreenMargin = 0;
        int verticalScreenMargin = 0;
        int borderWidth = 0;
        QString borderColor = "#ffffff";
    };

    explicit PropertyPanel(QWidget *parent = nullptr);
    ~PropertyPanel();
    void setDocumentData(const DocumentData &data);
    void setElementData(const ElementData &data, bool preserveTransientState = false);
    void clearElementData();

private:
    void wireSignals();
    QString currentHorizontalScreenAlign() const;
    QString currentVerticalScreenAlign() const;
    void setHorizontalScreenAlign(const QString &align);
    void setVerticalScreenAlign(const QString &align);
    void setScreenAlignmentEnabled(bool enabled);
    void updateTextWidthLabel();

signals:
    void documentEdited(const PropertyPanel::DocumentData &data);
    void elementEdited(const PropertyPanel::ElementData &data);

private:
    Ui::PropertyPanelUi *ui;
    bool m_blockSignals = false;
};
