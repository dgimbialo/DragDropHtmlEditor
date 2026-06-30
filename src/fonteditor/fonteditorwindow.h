#pragma once

#include <QMainWindow>

namespace Ui { class FontEditorWindowUi; }

class GlyphEditorWidget;
class TftFont;

class FontEditorWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit FontEditorWindow(QWidget *parent = nullptr);
    ~FontEditorWindow();

signals:
    void fontModified();

private slots:
    void onFontSelected(int index);
    void onGlyphSelected();
    void onGlyphPixelChanged(int charCode, int x, int y, bool on);
    void onGlyphEditorModified();
    void onZoomChanged(int value);
    void onWidthChanged(int value);
    void onHeightChanged(int value);
    void onAddGlyph();
    void onDeleteGlyph();
    void onToggleComment();
    void onSaveFont();
    void onLoadFont();
    void onClearGlyph();
    void onInvertGlyph();
    void onDeleteRow(int row);
    void onDeleteColumn(int col);

private:
    void populateFontList();
    void populateGlyphList();
    void selectGlyph(int charCode);
    void updateGlyphPreview();
    void updateAsmPreview();
    void updateDataPreview();
    TftFont *currentFont() const;

    Ui::FontEditorWindowUi *ui;
    int m_currentCharCode = -1;
};
