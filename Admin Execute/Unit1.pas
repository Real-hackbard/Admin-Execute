unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R 'admin.res'}
{$WARNINGS OFF}
{$WARN SYMBOL_PLATFORM OFF}

{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 22}
    {$DEFINE STRING_IS_UNICODESTRING}
  {$IFEND}
{$ENDIF}

{$R-}            // Disable range checking
{$F-}            // Force Far Calls
{$I-}            // I/O Error off
{$B-}            // Complete Boolean Evaluation Off
{$Q-}            // Overflow Checking Off

function GetAdminSid: PSID;
const
  // known SIDs ... (WinNT.h)
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  // known RIDs ... (WinNT.h)
  SECURITY_BUILTIN_DOMAIN_RID: DWORD = $00000020;
  DOMAIN_ALIAS_RID_ADMINS: DWORD = $00000220;
begin
  Result := nil;
  AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
    SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,
    0, 0, 0, 0, 0, 0, Result);
end;

function IsAdmin: LongBool;
var
  TokenHandle: THandle;
  ReturnLength: DWORD;
  TokenInformation: PTokenGroups;
  AdminSid: PSID;
  Loop: Integer;
begin
  Result := False;
  TokenHandle := 0;
  if OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, TokenHandle) then
  try
    ReturnLength := 0;
    GetTokenInformation(TokenHandle, TokenGroups, nil, 0, ReturnLength);
    TokenInformation := GetMemory(ReturnLength);
    if Assigned(TokenInformation) then
    try
      if GetTokenInformation(TokenHandle, TokenGroups, TokenInformation,
        ReturnLength, ReturnLength) then
      begin
        AdminSid := GetAdminSid;
        for Loop := 0 to TokenInformation^.GroupCount - 1 do
        begin
          if EqualSid(TokenInformation^.Groups[Loop].Sid, AdminSid) then
          begin
            Result := True;
            Break;
          end;
        end;
        FreeSid(AdminSid);
      end;
    finally
      FreeMemory(TokenInformation);
    end;
  finally
    CloseHandle(TokenHandle);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if IsAdmin then
    Label4.Caption := 'administrator'
  else
    Label4.Caption := 'no administrator';
end;

end.
