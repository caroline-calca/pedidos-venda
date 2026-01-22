unit untConfigManager;

interface

uses
  System.SysUtils,
  System.IniFiles;

type
  TConfigManager = class
  private
    const
      SECTION_DATABASE = 'database';
      KEY_DATABASE     = 'database';
      KEY_USERNAME     = 'username';
      KEY_PASSWORD     = 'password';
      KEY_SERVER       = 'server';
      KEY_PORT         = 'port';
      KEY_CLIENTLIB    = 'clientlibrary';
  private
    FIni: TIniFile;
    FIniPath: string;

    procedure GarantirIniCarregado;
    function Read(const AKey: string): string;
    procedure Write(const AKey, AValue: string);
  public
    constructor Create;
    destructor Destroy; override;

    function ExisteArquivo: Boolean;
    function ConfiguracaoValida: Boolean;
    function FormatDatabase(const AIncluirServidor: Boolean = True): string;

    function Database: string;
    function Username: string;
    function Password: string;
    function Server: string;
    function Port: Integer;
    function ClientLibrary: string;

    procedure SetDatabase(const AValue: string);
    procedure SetUsername(const AValue: string);
    procedure SetPassword(const AValue: string);
    procedure SetServer(const AValue: string);
    procedure SetPort(const AValue: Integer);
    procedure SetClientLibrary(const AValue: string);
  end;

implementation

{ TConfigManager }

constructor TConfigManager.Create;
begin
  FIniPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'config.ini';

  if FileExists(FIniPath) then
    FIni := TIniFile.Create(FIniPath);
end;

destructor TConfigManager.Destroy;
begin
  FIni.Free;
  inherited;
end;

procedure TConfigManager.GarantirIniCarregado;
begin
  if not Assigned(FIni) then
    FIni := TIniFile.Create(FIniPath);
end;

function TConfigManager.ExisteArquivo: Boolean;
begin
  Result := FileExists(FIniPath);
end;

function TConfigManager.ConfiguracaoValida: Boolean;
begin
  Result := ExisteArquivo and (Database <> '') and (Username <> '') and (Server <> '');
end;

function TConfigManager.Read(const AKey: string): string;
begin
  if Assigned(FIni) then
    Result := FIni.ReadString(SECTION_DATABASE, AKey, '')
  else
    Result := '';
end;

procedure TConfigManager.Write(const AKey, AValue: string);
begin
  GarantirIniCarregado;
  FIni.WriteString(SECTION_DATABASE, AKey, AValue);
end;

function TConfigManager.Database: string;
begin
  Result := Read(KEY_DATABASE);
end;

function TConfigManager.Username: string;
begin
  Result := Read(KEY_USERNAME);
end;

function TConfigManager.Password: string;
begin
  Result := Read(KEY_PASSWORD);
end;

function TConfigManager.Server: string;
begin
  Result := Read(KEY_SERVER);
end;

function TConfigManager.Port: Integer;
begin
  Result := StrToIntDef(Read(KEY_PORT), 3050);
end;

function TConfigManager.ClientLibrary: string;
begin
  Result := Read(KEY_CLIENTLIB);
end;

procedure TConfigManager.SetDatabase(const AValue: string);
begin
  Write(KEY_DATABASE, AValue);
end;

procedure TConfigManager.SetUsername(const AValue: string);
begin
  Write(KEY_USERNAME, AValue);
end;

procedure TConfigManager.SetPassword(const AValue: string);
begin
  Write(KEY_PASSWORD, AValue);
end;

procedure TConfigManager.SetServer(const AValue: string);
begin
  Write(KEY_SERVER, AValue);
end;

procedure TConfigManager.SetPort(const AValue: Integer);
begin
  Write(KEY_PORT, AValue.ToString);
end;

procedure TConfigManager.SetClientLibrary(const AValue: string);
begin
  Write(KEY_CLIENTLIB, AValue);
end;

function TConfigManager.FormatDatabase(const AIncluirServidor: Boolean = True): string;
var
  DatabasePath: string;
begin
  DatabasePath := Database;

  DatabasePath := StringReplace(DatabasePath, '"', '', [rfReplaceAll]);
  DatabasePath := StringReplace(DatabasePath, '/', '\', [rfReplaceAll]);
  DatabasePath := ExpandFileName(DatabasePath);

  Result := DatabasePath;
end;

end.
