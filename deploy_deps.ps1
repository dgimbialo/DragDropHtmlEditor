# Script to copy Qt6 and Windows runtime dependencies to build folders
param(
    [string]$BuildDir = "build",
    [string]$Config = "Debug"
)

# Detect Qt installation path from qmake
$qmakePath = Get-Command qmake -ErrorAction SilentlyContinue
if (-not $qmakePath) {
    Write-Error "qmake not found! Make sure Qt6 is in PATH."
    exit 1
}

$qtBinDir = Split-Path -Parent $qmakePath.Source
$qtInstallDir = Split-Path -Parent $qtBinDir

# Determine output directory
$outputDir = Join-Path $BuildDir $Config

if (-not (Test-Path $outputDir)) {
    Write-Error "Build directory not found: $outputDir"
    exit 1
}

Write-Host "Copying dependencies to $outputDir..." -ForegroundColor Green

# Function to copy DLL with error handling
function Copy-DllSafe {
    param(
        [string]$Source,
        [string]$Destination
    )
    
    if (Test-Path $Source) {
        Copy-Item -Path $Source -Destination $Destination -Force
        Write-Host "[OK] Copied $(Split-Path -Leaf $Source)"
    } else {
        Write-Host "[WARNING] File not found: $Source" -ForegroundColor Yellow
    }
}

# Define suffix based on configuration
$suffix = if ($Config -eq "Debug") { "d" } else { "" }

# Copy Qt Core DLLs
$qtDlls = @(
    "Qt6Core${suffix}.dll",
    "Qt6Gui${suffix}.dll",
    "Qt6Widgets${suffix}.dll",
    "Qt6WebEngineCore${suffix}.dll",
    "Qt6WebEngineWidgets${suffix}.dll",
    "Qt6Qml${suffix}.dll",
    "Qt6QmlModels${suffix}.dll",
    "Qt6QmlWorkerScript${suffix}.dll",
    "Qt6WebChannel${suffix}.dll",
    "Qt6Network${suffix}.dll",
    "Qt6DBus${suffix}.dll",
    "Qt6OpenGL${suffix}.dll",
    "Qt6Concurrent${suffix}.dll",
    "Qt6PrintSupport${suffix}.dll",
    "Qt6Svg${suffix}.dll",
    "Qt6Xml${suffix}.dll"
)

# Add OpenGL software renderer and D3D compiler
$qtDlls += @(
    "opengl32sw.dll",
    "d3dcompiler_47.dll"
)

Write-Host "`nCopying Qt6 DLLs..." -ForegroundColor Cyan
foreach ($dll in $qtDlls) {
    Copy-DllSafe -Source (Join-Path -Path $qtBinDir -ChildPath $dll) -Destination (Join-Path -Path $outputDir -ChildPath $dll)
}

# Copy WebEngine resources
Write-Host "`nCopying WebEngine resources..." -ForegroundColor Cyan
$resourcesSource = Join-Path -Path $qtInstallDir -ChildPath "resources"
$resourcesDestination = Join-Path -Path $outputDir -ChildPath "resources"

if (Test-Path $resourcesSource) {
    Copy-Item -Path $resourcesSource -Destination $resourcesDestination -Recurse -Force
    Write-Host "[OK] Copied resources folder"
} else {
    Write-Host "[WARNING] Resources folder not found: $resourcesSource" -ForegroundColor Yellow
}

# Copy translations
Write-Host "`nCopying translations..." -ForegroundColor Cyan
$translationsSource = Join-Path -Path $qtInstallDir -ChildPath "translations"
$translationsDestination = Join-Path -Path $outputDir -ChildPath "translations"

if (Test-Path $translationsSource) {
    Copy-Item -Path $translationsSource -Destination $translationsDestination -Recurse -Force
    Write-Host "[OK] Copied translations folder"
} else {
    Write-Host "[WARNING] Translations folder not found: $translationsSource" -ForegroundColor Yellow
}

# Copy libexec (contains WebEngine helper processes)
Write-Host "`nCopying libexec..." -ForegroundColor Cyan
$libexecSource = Join-Path -Path $qtInstallDir -ChildPath "libexec"
$libexecDestination = Join-Path -Path $outputDir -ChildPath "libexec"

if (Test-Path $libexecSource) {
    # Copy all exe and dll files from libexec
    Copy-Item -Path $libexecSource -Destination $libexecDestination -Recurse -Force
    Write-Host "[OK] Copied libexec folder"
} else {
    Write-Host "[WARNING] libexec folder not found: $libexecSource" -ForegroundColor Yellow
}

# Create plugins/platforms directory
$platformsDir = Join-Path -Path $outputDir -ChildPath "plugins\platforms"
if (-not (Test-Path $platformsDir)) {
    New-Item -ItemType Directory -Path $platformsDir -Force > $null
    Write-Host "[OK] Created platforms directory"
}

# Copy platform plugin
Write-Host "`nCopying platform plugins..." -ForegroundColor Cyan
$platformDll = if ($Config -eq "Debug") { "qwindowsd.dll" } else { "qwindows.dll" }
$platformSource = Join-Path -Path $qtInstallDir -ChildPath "plugins\platforms" | Join-Path -ChildPath $platformDll
Copy-DllSafe -Source $platformSource -Destination (Join-Path -Path $platformsDir -ChildPath $platformDll)

# Copy ImageFormat plugins if available
$imageFormatsDir = Join-Path -Path $outputDir -ChildPath "plugins\imageformats"
$imageFormatsSourceDir = Join-Path -Path $qtInstallDir -ChildPath "plugins\imageformats"
if (Test-Path $imageFormatsSourceDir) {
    if (-not (Test-Path $imageFormatsDir)) {
        New-Item -ItemType Directory -Path $imageFormatsDir -Force > $null
    }
    Copy-Item -Path "$imageFormatsSourceDir\*.dll" -Destination $imageFormatsDir -Force
    Write-Host "[OK] Copied imageformats plugins"
}

# Copy platform input context plugins
$platInputDir = Join-Path -Path $qtInstallDir -ChildPath "plugins\platforminputcontexts"
if (Test-Path $platInputDir) {
    $platInputDestDir = Join-Path -Path $outputDir -ChildPath "plugins\platforminputcontexts"
    if (-not (Test-Path $platInputDestDir)) {
        New-Item -ItemType Directory -Path $platInputDestDir -Force > $null
    }
    Copy-Item -Path "$platInputDir\*.dll" -Destination $platInputDestDir -Force
    Write-Host "[OK] Copied platforminputcontexts plugins"
}

# Copy styles plugins
$stylesDir = Join-Path -Path $qtInstallDir -ChildPath "plugins\styles"
if (Test-Path $stylesDir) {
    $stylesDestDir = Join-Path -Path $outputDir -ChildPath "plugins\styles"
    if (-not (Test-Path $stylesDestDir)) {
        New-Item -ItemType Directory -Path $stylesDestDir -Force > $null
    }
    Copy-Item -Path "$stylesDir\*.dll" -Destination $stylesDestDir -Force
    Write-Host "[OK] Copied styles plugins"
}

# Copy renderplugins
$renderPluginsDir = Join-Path -Path $qtInstallDir -ChildPath "plugins\renderplugins"
if (Test-Path $renderPluginsDir) {
    $renderPluginsDestDir = Join-Path -Path $outputDir -ChildPath "plugins\renderplugins"
    if (-not (Test-Path $renderPluginsDestDir)) {
        New-Item -ItemType Directory -Path $renderPluginsDestDir -Force > $null
    }
    Copy-Item -Path "$renderPluginsDir\*.dll" -Destination $renderPluginsDestDir -Force
    Write-Host "[OK] Copied renderplugins"
}

# Copy TLS plugins (needed for HTTPS)
$tlsDir = Join-Path -Path $qtInstallDir -ChildPath "plugins\tls"
if (Test-Path $tlsDir) {
    $tlsDestDir = Join-Path -Path $outputDir -ChildPath "plugins\tls"
    if (-not (Test-Path $tlsDestDir)) {
        New-Item -ItemType Directory -Path $tlsDestDir -Force > $null
    }
    Copy-Item -Path "$tlsDir\*.dll" -Destination $tlsDestDir -Force
    Write-Host "[OK] Copied TLS plugins"
}

# Copy MSVC runtime DLLs
Write-Host "`nCopying MSVC runtime DLLs..." -ForegroundColor Cyan
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

foreach ($dll in $runtimeDlls) {
    $found = $false
    
    # Try VCINSTALLDIR
    if ($env:VCINSTALLDIR) {
        $source = Join-Path -Path $env:VCINSTALLDIR -ChildPath "bin\HostX64\x64" | Join-Path -ChildPath $dll
        if (Test-Path $source) {
            Copy-Item -Path $source -Destination (Join-Path -Path $outputDir -ChildPath $dll) -Force
            Write-Host "[OK] Copied $dll"
            $found = $true
            continue
        }
    }
    
    # Try system32
    $windir = $env:WINDIR
    if ($windir) {
        $sys32Source = Join-Path -Path $windir -ChildPath "System32" | Join-Path -ChildPath $dll
        if (Test-Path $sys32Source) {
            Copy-Item -Path $sys32Source -Destination (Join-Path -Path $outputDir -ChildPath $dll) -Force
            Write-Host "[OK] Copied $dll from System32"
            $found = $true
            continue
        }
    }
    
    if (-not $found) {
        Write-Host "[WARNING] Runtime DLL not found: $dll" -ForegroundColor Yellow
    }
}

Write-Host "`n[COMPLETED] Dependencies copy finished!" -ForegroundColor Green
