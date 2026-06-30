cmake_minimum_required(VERSION 3.21)

project(TftHtmlEditor VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Widgets WebEngineWidgets WebChannel)

qt_standard_project_setup()

set(APP_SOURCES
    resources/app_icons.qrc
    src/main.cpp
    src/mainwindow.cpp
    src/mainwindow.h
    src/mainwindow.ui
    src/panels/palettewidget.cpp
    src/panels/palettewidget.h
    src/panels/propertypanel.cpp
    src/panels/propertypanel.h
    src/panels/propertypanel.ui
    src/panels/codeview.cpp
    src/panels/codeview.h
    src/canvas/canvaswidget.cpp
    src/canvas/canvaswidget.h
    src/canvas/canvasbridge.cpp
    src/canvas/canvasbridge.h
    src/model/htmlparser.cpp
    src/model/htmlparser.h
    src/model/htmlgenerator.cpp
    src/model/htmlgenerator.h
    src/model/tftfontmetrics.cpp
    src/model/tftfontmetrics.h
    src/model/tftfont.cpp
    src/model/tftfont.h
    src/model/tftfontmanager.cpp
    src/model/tftfontmanager.h
    src/fonteditor/glypheditorwidget.cpp
    src/fonteditor/glypheditorwidget.h
    src/fonteditor/fonteditorwindow.cpp
    src/fonteditor/fonteditorwindow.h
    src/fonteditor/fonteditorwindow.ui
)

if (WIN32)
    list(APPEND APP_SOURCES
        resources/windows/app.rc
    )
endif()

qt_add_executable(TftHtmlEditor
    ${APP_SOURCES}
)

target_link_libraries(TftHtmlEditor
    PRIVATE
        Qt6::Widgets
        Qt6::WebEngineWidgets
        Qt6::WebChannel
)

if (WIN32)
    set_target_properties(TftHtmlEditor PROPERTIES WIN32_EXECUTABLE TRUE)
    
    # Add post-build command to run custom deploy script
    add_custom_command(TARGET TftHtmlEditor POST_BUILD
        COMMAND powershell.exe -NoProfile -ExecutionPolicy Bypass
            -File "${CMAKE_SOURCE_DIR}/run_windeployqt.ps1"
            -ExePath "$<TARGET_FILE:TftHtmlEditor>"
            -TargetDir "$<TARGET_FILE_DIR:TftHtmlEditor>"
            -Config "$<CONFIG>"
    )

    add_custom_command(TARGET TftHtmlEditor POST_BUILD
        COMMAND powershell.exe -NoProfile -ExecutionPolicy Bypass
            -File "${CMAKE_SOURCE_DIR}/build_installer.ps1"
            -Config "$<CONFIG>"
            -TargetDir "$<TARGET_FILE_DIR:TftHtmlEditor>"
            -WorkspaceDir "${CMAKE_SOURCE_DIR}"
            -Version "${PROJECT_VERSION}"
    )
endif()
