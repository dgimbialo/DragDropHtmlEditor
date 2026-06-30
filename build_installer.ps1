param(
    [string]$Config = "Release",
    [string]$TargetDir = "",
    [string]$WorkspaceDir = "",
    [string]$Version = "0.1.0"
)

if ($Config -ne "Release") {
    Write-Host "Skipping installer build for configuration: $Config" -ForegroundColor DarkGray
    exit 0
}

if (-not $WorkspaceDir) {
    $WorkspaceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
}

$WorkspaceDir = (Resolve-Path $WorkspaceDir).Path

if (-not $TargetDir) {
    $TargetDir = Join-Path $WorkspaceDir "build\Release"
}

$TargetDir = (Resolve-Path $TargetDir).Path

if (-not (Test-Path $TargetDir)) {
    Write-Error "Release output directory not found: $TargetDir"
    exit 1
}

$exePath = Join-Path $TargetDir "TftHtmlEditor.exe"
if (-not (Test-Path $exePath)) {
    Write-Error "Release executable not found: $exePath"
    exit 1
}

$issPath = Join-Path $WorkspaceDir "installer\TftHtmlEditor.iss"
if (-not (Test-Path $issPath)) {
    Write-Error "Inno Setup script not found: $issPath"
    exit 1
}

$iconPath = Join-Path $WorkspaceDir "resources\windows\app.ico"
if (-not (Test-Path $iconPath)) {
    Write-Error "Installer icon not found: $iconPath"
    exit 1
}

$iconPath = (Resolve-Path $iconPath).Path

$isccCandidates = @(
    (Get-Command ISCC.exe -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue),
    "C:\Program Files (x86)\Inno Setup 6\ISCC.exe",
    "C:\Program Files\Inno Setup 6\ISCC.exe"
) | Where-Object { $_ -and (Test-Path $_) }

if (-not $isccCandidates -or $isccCandidates.Count -eq 0) {
    Write-Error "ISCC.exe not found. Install Inno Setup 6 or add ISCC.exe to PATH."
    exit 1
}

$isccPath = @($isccCandidates) | Select-Object -First 1
$outputDir = Join-Path $WorkspaceDir "build\installer"
New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
$outputDir = (Resolve-Path $outputDir).Path

Write-Host "Building installer with Inno Setup..." -ForegroundColor Green
Write-Host "ISCC: $isccPath" -ForegroundColor Cyan
Write-Host "SourceDir: $TargetDir" -ForegroundColor Cyan
Write-Host "OutputDir: $outputDir" -ForegroundColor Cyan

$isccArgs = @(
    "/DAppVersion=$Version",
    "/DSourceDir=$TargetDir",
    "/DWorkspaceDir=$WorkspaceDir",
    "/DInstallerOutputDir=$outputDir",
    "/DAppIconFile=$iconPath",
    $issPath
)

& $isccPath @isccArgs

if ($LASTEXITCODE -ne 0) {
    Write-Error "Installer build failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "[OK] Installer created in $outputDir" -ForegroundColor Green