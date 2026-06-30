# Drag & Drop HTML Editor

A desktop **WYSIWYG editor for designing screens for embedded TFT touch displays**. You drag UI elements onto a live canvas and the matching HTML is generated and kept in sync in a code view, so the layout you see on screen is exactly what the device renders. A built-in **TFT bitmap font editor** lets you draw glyphs and export them as C arrays or assembly, ready to embed in firmware.

![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Language](https://img.shields.io/badge/language-C%2B%2B17-blue)
![UI](https://img.shields.io/badge/UI-Qt6-green)
![Build](https://img.shields.io/badge/build-CMake-success)
![License](https://img.shields.io/badge/license-MIT-green)

---

## Screenshots

**Screen designer** - drag-and-drop canvas, live HTML code view and a property panel:

![Screen designer](docs/screenshots/editor-screen-design.png)

**Keypad screen and font menu:**

![Keypad and fonts](docs/screenshots/editor-keypad-and-fonts.png)

**TFT font editor** - draw a glyph on a zoomable pixel grid and export it as assembly (`.s`):

![Font editor - assembly export](docs/screenshots/font-editor-assembly.png)

**...or as a C array (`uint8_t`):**

![Font editor - C array export](docs/screenshots/font-editor-carray.png)

---

## Features

- **Drag-and-drop canvas** - place buttons, labels, images and lines, then move and resize them with handles on a grid
- **Two-way sync** - the visual canvas and the live HTML code view update each other in real time
- **Property panel** - edit position, size, colors, border, text and font of the selected element, plus document and canvas settings
- **Element management** - select, move, resize, copy / paste, duplicate and delete
- **Grid** - configurable grid with snap-to-grid for precise alignment
- **TFT bitmap font editor** - draw glyphs on a zoomable pixel grid, set per-glyph width and height, with a live preview
- **Font export** - export glyphs as a C array (`uint8_t`) or assembly (`.s`), ready to embed in firmware
- **Font management** - load fonts from a file or a directory, or use system fonts

---

## Tech Stack

| Component | Technology |
|---|---|
| Language | C++17 |
| UI | Qt6 Widgets |
| Canvas | Qt WebEngine (Chromium) with a QWebChannel C++/JS bridge |
| Output | HTML screens and bitmap fonts (C array / assembly) |
| Build | CMake, windeployqt |
| Installer | PowerShell (`build_installer.ps1`) |
| Target OS | Windows |

---

## Building

### Prerequisites

- **Qt 6** with the **Widgets**, **WebEngineWidgets** and **WebChannel** components
- **CMake 3.20+** and an MSVC toolchain (Visual Studio 2022)

### Steps

The simplest path is the helper scripts:

```bash
build_and_run.bat        # configure, build and run
build_installer.ps1      # build a Windows installer
```

Or configure manually with the bundled CMake preset and build:

```bash
cmake --preset Qt
cmake --build build
```

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
