#ifndef AppVersion
  #define AppVersion "0.1.0"
#endif

#ifndef SourceDir
  #error SourceDir must be defined
#endif

#ifndef WorkspaceDir
  #error WorkspaceDir must be defined
#endif

#ifndef AppIconFile
  #define AppIconFile AddBackslash(WorkspaceDir) + "resources\\windows\\app.ico"
#endif

#ifndef InstallerOutputDir
  #define InstallerOutputDir AddBackslash(WorkspaceDir) + "build\\installer"
#endif

[Setup]
AppId={{7E782B79-B0C8-4CF7-BD89-CC9348A9DE87}}
AppName=TftHtmlEditor
AppVersion={#AppVersion}
AppPublisher=Local
AppPublisherURL=https://local.invalid/
DefaultDirName={autopf}\TftHtmlEditor
DefaultGroupName=TftHtmlEditor
DisableProgramGroupPage=yes
AllowNoIcons=yes
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64
OutputDir={#InstallerOutputDir}
OutputBaseFilename=TftHtmlEditor-{#AppVersion}-setup
SetupIconFile={#AppIconFile}
UninstallDisplayIcon={app}\TftHtmlEditor.exe

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional icons:"; Flags: unchecked

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#WorkspaceDir}\html_files\*"; DestDir: "{app}\html_files"; Flags: ignoreversion recursesubdirs createallsubdirs skipifsourcedoesntexist
Source: "{#AppIconFile}"; DestDir: "{app}"; DestName: "app.ico"; Flags: ignoreversion

[Icons]
Name: "{group}\TftHtmlEditor"; Filename: "{app}\TftHtmlEditor.exe"; IconFilename: "{app}\app.ico"
Name: "{autodesktop}\TftHtmlEditor"; Filename: "{app}\TftHtmlEditor.exe"; Tasks: desktopicon; IconFilename: "{app}\app.ico"

[Run]
Filename: "{app}\TftHtmlEditor.exe"; Description: "Launch TftHtmlEditor"; Flags: nowait postinstall skipifsilent