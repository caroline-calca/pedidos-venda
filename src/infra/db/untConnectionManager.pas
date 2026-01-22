unit untConnectionManager;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.DApt,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys.IBWrapper,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.Intf,
  FireDAC.DatS,
  FireDAC.Comp.DataSet,

  untConfigManager;

type
  TConnectionManager = class
  private
    FConnection: TFDConnection;
  public
    constructor Create;
    destructor Destroy; override;

    function Conectar: Boolean;
    function Conectado: Boolean;

    function Connection: TFDConnection;
    function TestarConexao: Boolean;

    procedure ConfigurarParametros(AParams: TStrings; const ACreateDatabase: Boolean = False);
  end;

var
  FConnectionManager: TConnectionManager;

implementation

{ TConnectionManager }

constructor TConnectionManager.Create;
begin
  FConnection := TFDConnection.Create(nil);
  FConnection.LoginPrompt := False;
end;

destructor TConnectionManager.Destroy;
begin
  FConnection.Free;
  inherited;
end;

procedure TConnectionManager.ConfigurarParametros(AParams: TStrings; const ACreateDatabase: Boolean = False);
var
  Config: TConfigManager;
begin
  Config := TConfigManager.Create;
  try
    AParams.Clear;

    AParams.Add('DriverID=FB');
    AParams.Add('User_Name=' + Config.Username);
    AParams.Add('Password=' + Config.Password);

    if Config.Server <> '' then
    begin
      AParams.Add('Server=' + Config.Server);
      AParams.Add('Port=' + Config.Port.ToString);
      AParams.Add('Protocol=TCPIP');
    end;

    AParams.Add('CharacterSet=UTF8');

    AParams.Add('Database=' + Config.FormatDatabase);

    if ACreateDatabase then
      AParams.Add('CreateDatabase=Yes');

    if Config.ClientLibrary <> '' then
      AParams.Add('ClientLibrary=' + Config.ClientLibrary);

  finally
    Config.Free;
  end;
end;

function TConnectionManager.Conectar: Boolean;
begin
  Result := False;

  ConfigurarParametros(FConnection.Params);

  try
    FConnection.Connected := True;
    Result := True;
  except
    raise;
  end;
end;

function TConnectionManager.Conectado: Boolean;
begin
  Result := Assigned(FConnection) and FConnection.Connected;
end;

function TConnectionManager.Connection: TFDConnection;
begin
  Result := FConnection;
end;

function TConnectionManager.TestarConexao: Boolean;
var
  Qry: TFDQuery;
begin
  Result := False;

  if not Conectar then
    raise Exception.Create('Não foi possível conectar ao banco de dados.');

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;

    // select simples para validar a conexão
    Qry.SQL.Text := 'SELECT COUNT(*) AS TOTAL FROM CLIENTE';
    Qry.Open;

    Result := True;
  finally
    Qry.Free;
  end;
end;

end.
