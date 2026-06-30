@echo off
setlocal EnableExtensions

rem Build and run TFT HTML Editor
rem
rem CMD (from project folder):
rem   build_and_run.bat
rem   build_and_run.bat Release
rem
rem PowerShell requires .\ prefix:
rem   .\build_and_run.bat Release
rem   .\build_and_run.ps1 Release

set "ROOT=%~dp0"
cd /d "%ROOT%"

set "CONFIG=Debug"
if not "%~1"=="" set "CONFIG=%~1"

set "BUILD_DIR=%ROOT%build"
set "EXE=%BUILD_DIR%\%CONFIG%\TftHtmlEditor.exe"

where cmake >nul 2>&1
if errorlevel 1 (
    echo [ERROR] cmake not found in PATH.
    echo Install CMake and ensure Qt6 ^(qmake^) is available for the first configure.
    pause
    exit /b 1
)

if not exist "%BUILD_DIR%\CMakeCache.txt" (
    echo [1/3] Configuring CMake in "%BUILD_DIR%" ...
    cmake -S "%ROOT%." -B "%BUILD_DIR%"
    if errorlevel 1 (
        echo [ERROR] CMake configure failed.
        pause
        exit /b 1
    )
) else (
    echo [1/3] Using existing CMake cache.
)

echo [2/3] Building %CONFIG% ...
cmake --build "%BUILD_DIR%" --config %CONFIG% --parallel
if errorlevel 1 (
    echo [ERROR] Build failed.
    pause
    exit /b 1
)

if not exist "%EXE%" (
    echo [ERROR] Executable not found: %EXE%
    pause
    exit /b 1
)

echo [3/3] Starting: %EXE%
echo.
"%EXE%"
set "EXIT_CODE=%ERRORLEVEL%"
if not "%EXIT_CODE%"=="0" (
    echo.
    echo Application exited with code %EXIT_CODE%.
    pause
    exit /b %EXIT_CODE%
)

endlocal
