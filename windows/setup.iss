; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Pywebdriver"
#define MyAppVersion "3.0.21"
#define MyAppPublisher "Akretion"
#define MyAppURL "https://github.com/pywebdriver/pywebdriver"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{7D8EF2D9-C39E-41B6-8DA3-698671538479}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputBaseFilename=pywebdriver_win64_installer
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Dirs]
Name: "{app}"; Permissions: users-modify;

[Files]
Source: "dist\pywebdriver\*"; DestDir: "{app}"; Permissions: users-modify; Flags: recursesubdirs ignoreversion overwritereadonly ;

[INI]
Filename: "{app}\config\config.ini"; Section: "flask"; Key: "sslcert"; String: "localhost+2.pem"
Filename: "{app}\config\config.ini"; Section: "flask"; Key: "sslkey"; String: "localhost+2-key.pem"

[UninstallRun]
Filename: {app}\uninstall.bat; Flags: runhidden shellexec waituntilterminated runascurrentuser;

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  ErrorCode: Integer;
begin
  if CurStep = ssPostInstall then
  begin
    ShellExecAsOriginalUser('', ExpandConstant('{app}\generate_certificate.bat'), '', '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
    ShellExec('', ExpandConstant('{app}\install.bat'), '', '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
  end;
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  ResultCode: integer;
begin
  Exec(ExpandConstant('{app}\uninstall.bat'), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
end;
