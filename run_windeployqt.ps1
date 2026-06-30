# Script to run windeployqt with proper configuration detection
param(
    [string]$ExePath = "",
    [string]$TargetDir = "",
    [string]$Config = "Release"
)

if (-not (Test-Path $ExePath)) {
    Write-Error "Executable not found: $ExePath"
    exit 1
}

# Find windeployqt
$qmakePath = Get-Command qmake -ErrorAction SilentlyContinue
if (-not $qmakePath) {
    Write-Error "qmake not found! Make sure Qt6 is in PATH."
    exit 1
}

$qtBinDir = Split-Path -Parent $qmakePath.Source
$windeployqt = Join-Path -Path $qtBinDir -ChildPath "windeployqt.exe"

if (-not (Test-Path $windeployqt)) {
    Write-Error "windeployqt not found at: $windeployqt"
    exit 1
}

Write-Host "Running windeployqt..." -ForegroundColor Green
Write-Host "Configuration: $Config" -ForegroundColor Cyan
Write-Host "Executable: $ExePath" -ForegroundColor Cyan
Write-Host "Target Dir: $TargetDir" -ForegroundColor Cyan

function Copy-RuntimeDll {
    param(
        [string]$DllName,
        [string]$DestinationDir
    )

    $candidates = @()

    if ($env:VCINSTALLDIR) {
        $candidates += (Join-Path $env:VCINSTALLDIR "bin\HostX64\x64\$DllName")
        $candidates += (Join-Path $env:VCINSTALLDIR "redist\MSVC\x64\Microsoft.VC143.CRT\$DllName")
        $candidates += (Join-Path $env:VCINSTALLDIR "redist\MSVC\x64\Microsoft.VC142.CRT\$DllName")
    }

    if ($env:WINDIR) {
        $candidates += (Join-Path $env:WINDIR "System32\$DllName")
    }

    foreach ($candidate in $candidates) {
        if (Test-Path $candidate) {
            Copy-Item -Path $candidate -Destination (Join-Path $DestinationDir $DllName) -Force
            Write-Host "[OK] Copied runtime $DllName" -ForegroundColor Green
            return $true
        }
    }

    Write-Host "[WARNING] Runtime DLL not found: $DllName" -ForegroundColor Yellow
    return $false
}

function Copy-QtDll {
    param(
        [string]$DllName,
        [string]$DestinationDir
    )

    $source = Join-Path $qtBinDir $DllName
    if (Test-Path $source) {
        Copy-Item -Path $source -Destination (Join-Path $DestinationDir $DllName) -Force
        Write-Host "[OK] Copied Qt DLL $DllName" -ForegroundColor Green
        return $true
    }

    Write-Host "[WARNING] Qt DLL not found: $DllName" -ForegroundColor Yellow
    return $false
}

# Determine --debug or --release flag based on configuration
$debugFlag = if ($Config -eq "Debug") { "--debug" } else { "--release" }

# Run windeployqt
& $windeployqt $debugFlag "$ExePath" --dir "$TargetDir" --verbose 2

if ($LASTEXITCODE -eq 0) {
    $qtSuffix = if ($Config -eq "Debug") { "d" } else { "" }
    $requiredQtDlls = @(
        "Qt6Core${qtSuffix}.dll",
        "Qt6Gui${qtSuffix}.dll",
        "Qt6Widgets${qtSuffix}.dll",
        "Qt6Network${qtSuffix}.dll",
        "Qt6Qml${qtSuffix}.dll",
        "Qt6QmlModels${qtSuffix}.dll",
        "Qt6QmlWorkerScript${qtSuffix}.dll",
        "Qt6Quick${qtSuffix}.dll",
        "Qt6QuickWidgets${qtSuffix}.dll",
        "Qt6OpenGL${qtSuffix}.dll",
        "Qt6PrintSupport${qtSuffix}.dll",
        "Qt6Positioning${qtSuffix}.dll",
        "Qt6SerialPort${qtSuffix}.dll",
        "Qt6Svg${qtSuffix}.dll",
        "Qt6Pdf${qtSuffix}.dll",
        "Qt6DBus${qtSuffix}.dll",
        "Qt6WebChannel${qtSuffix}.dll",
        "Qt6WebEngineCore${qtSuffix}.dll",
        "Qt6WebEngineWidgets${qtSuffix}.dll",
        "Qt6Concurrent${qtSuffix}.dll",
        "Qt6Bluetooth${qtSuffix}.dll",
        "Qt6Xml${qtSuffix}.dll",
        "opengl32sw.dll",
        "d3dcompiler_47.dll"
    )

    Write-Host "`nCopying required Qt DLLs..." -ForegroundColor Cyan
    foreach ($dll in $requiredQtDlls) {
        Copy-QtDll -DllName $dll -DestinationDir $TargetDir > $null
    }

    $qtConfPath = Join-Path $TargetDir "qt.conf"
    Set-Content -Path $qtConfPath -Value "[Paths]`nPrefix = ." -Encoding ASCII
    Write-Host "[OK] Wrote qt.conf" -ForegroundColor Green

    $runtimeSuffix = if ($Config -eq "Debug") { "d" } else { "" }
    $runtimeDlls = @(
        "concrt140${runtimeSuffix}.dll",
        "vcruntime140${runtimeSuffix}.dll",
        "vcruntime140_1${runtimeSuffix}.dll",
        "msvcp140${runtimeSuffix}.dll",
        "msvcp140_1${runtimeSuffix}.dll",
        "msvcp140_2${runtimeSuffix}.dll",
        "msvcp140_atomic_wait${runtimeSuffix}.dll",
        "vccorlib140${runtimeSuffix}.dll"
    )

    Write-Host "`nCopying MSVC runtime DLLs..." -ForegroundColor Cyan
    foreach ($dll in $runtimeDlls) {
        Copy-RuntimeDll -DllName $dll -DestinationDir $TargetDir > $null
    }

    Write-Host "`n[OK] windeployqt completed successfully" -ForegroundColor Green
} else {
    Write-Host "`n[ERROR] windeployqt failed with code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}
