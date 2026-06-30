# Build and run TFT HTML Editor
#
# PowerShell (from project folder):
#   .\build_and_run.ps1
#   .\build_and_run.ps1 Release
#
# CMD:
#   build_and_run.bat
#   build_and_run.bat Release

param(
    [ValidateSet('Debug', 'Release', 'RelWithDebInfo', 'MinSizeRel')]
    [string] $Config = 'Debug'
)

$ErrorActionPreference = 'Stop'
$Root = $PSScriptRoot
$BuildDir = Join-Path $Root 'build'
$Exe = Join-Path $BuildDir "$Config\TftHtmlEditor.exe"

if (-not (Get-Command cmake -ErrorAction SilentlyContinue)) {
    Write-Error 'cmake not found in PATH. Install CMake and ensure Qt6 (qmake) is available for the first configure.'
}

$cacheFile = Join-Path $BuildDir 'CMakeCache.txt'
if (-not (Test-Path $cacheFile)) {
    Write-Host "[1/3] Configuring CMake in `"$BuildDir`" ..."
    & cmake -S $Root -B $BuildDir
    if ($LASTEXITCODE -ne 0) { throw 'CMake configure failed.' }
} else {
    Write-Host '[1/3] Using existing CMake cache.'
}

Write-Host "[2/3] Building $Config ..."
& cmake --build $BuildDir --config $Config --parallel
if ($LASTEXITCODE -ne 0) { throw 'Build failed.' }

if (-not (Test-Path $Exe)) {
    throw "Executable not found: $Exe"
}

Write-Host "[3/3] Starting: $Exe`n"
& $Exe
if ($LASTEXITCODE -ne 0) {
    Write-Host "`nApplication exited with code $LASTEXITCODE."
    exit $LASTEXITCODE
}
