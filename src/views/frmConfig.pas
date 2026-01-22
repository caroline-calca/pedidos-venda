unit frmConfig;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,

  untUtils,
  untConfigManager,
  untConnectionManager;

type
  TModoConfig = (mcObrigatorio, mcOpcional);

type
  TfConfig = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtDatabase: TEdit;
    edtUsername: TEdit;
    Panel4: TPanel;
    btnCancelar: TButton;
    btnSalvar: TButton;
    edtPassword: TEdit;
    Label4: TLabel;
    edtServer: TEdit;
    Label5: TLabel;
    edtPort: TEdit;
    Label6: TLabel;
    edtClientLibrary: TEdit;
    Label7: TLabel;
    odgDB: TOpenDialog;
    odgClientLibrary: TOpenDialog;
    btnDB: TBitBtn;
    btnClientLibrary: TBitBtn;
    btnTestarConexao: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDBClick(Sender: TObject);
    procedure btnClientLibraryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTestarConexaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FModo: TModoConfig;

    function DadosValidos: Boolean;
    function Salvar: Boolean;

    procedure ConfigurarParamsTeste(AParams: TStrings);
  public
    property Modo: TModoConfig read FModo write FModo;

    class function Executar(AModo: TModoConfig): TModalResult;
  end;

var
  fConfig: TfConfig;

implementation

{$R *.dfm}

class function TfConfig.Executar(AModo: TModoConfig): TModalResult;
var
  Frm: TfConfig;
begin
  Frm := TfConfig.Create(nil);
  try
    Frm.Modo := AModo;
    Result := Frm.ShowModal;
  finally
    Frm.Free;
  end;
end;

procedure TfConfig.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfConfig.btnClientLibraryClick(Sender: TObject);
begin
  if odgClientLibrary.Execute then
    edtClientLibrary.Text := odgClientLibrary.FileName;
end;

procedure TfConfig.btnDBClick(Sender: TObject);
begin
  if odgDB.Execute then
    edtDatabase.Text := odgDB.FileName;
end;

procedure TfConfig.btnSalvarClick(Sender: TObject);
begin
  if Salvar then
  begin
    ShowMsg('Configurações salvas com sucesso.', mtInfo);
    ModalResult := mrOk;
  end;
end;

procedure TfConfig.btnTestarConexaoClick(Sender: TObject);
var
  ConnTeste: TFDConnection;
begin
  if not DadosValidos then
    Exit;

  ConnTeste := TFDConnection.Create(nil);
  try
    ConnTeste.LoginPrompt := False;
    ConfigurarParamsTeste(ConnTeste.Params);

    try
      ConnTeste.Connected := True;
      ShowMsg('Conexão realizada com sucesso!', mtInfo);
    except
      on E: Exception do
        ShowMsg('Erro ao conectar: ' + E.Message, mtErr);
    end;

  finally
    ConnTeste.Free;
  end;
end;

procedure TfConfig.ConfigurarParamsTeste(AParams: TStrings);
begin
  AParams.Clear;

  AParams.Add('DriverID=FB');
  AParams.Add('User_Name=' + edtUsername.Text);
  AParams.Add('Password=' + edtPassword.Text);
  AParams.Add('Protocol=TCPIP');
  AParams.Add('CharacterSet=UTF8');

  AParams.Add('Server=' + edtServer.Text);
  AParams.Add('Port=' + edtPort.Text);
  AParams.Add('Database=' + edtDatabase.Text);

  if Trim(edtClientLibrary.Text) <> '' then
    AParams.Add('ClientLibrary=' + edtClientLibrary.Text);
end;

function TfConfig.DadosValidos: Boolean;
begin
  Result := False;

  if Trim(edtDatabase.Text) = '' then
  begin
    ShowMsg('Informe o caminho do banco de dados.', mtWarn);
    edtDatabase.SetFocus;
    Exit;
  end;

  if Trim(edtUsername.Text) = '' then
  begin
    ShowMsg('Informe o usuário do banco de dados.', mtWarn);
    edtUsername.SetFocus;
    Exit;
  end;

  if Trim(edtPassword.Text) = '' then
  begin
    ShowMsg('Informe a senha do banco de dados.', mtWarn);
    edtUsername.SetFocus;
    Exit;
  end;

  if Trim(edtServer.Text) = '' then
  begin
    ShowMsg('Informe o servidor do banco de dados.', mtWarn);
    edtServer.SetFocus;
    Exit;
  end;

  if StrToIntDef(edtPort.Text, 0) <= 0 then
  begin
    ShowMsg('Informe uma porta válida.', mtWarn);
    edtPort.SetFocus;
    Exit;
  end;

  if Trim(edtClientLibrary.Text) = '' then
  begin
    ShowMsg('Informe o caminho do Client Library (fbclient.dll).', mtWarn);
    edtClientLibrary.SetFocus;
    Exit;
  end;

  Result := True;
end;

function TfConfig.Salvar: Boolean;
var
  Config: TConfigManager;
begin
  Result := False;

  if not DadosValidos then
    Exit;

  Config := TConfigManager.Create;
  try
    Config.SetDatabase(edtDatabase.Text);
    Config.SetUsername(edtUsername.Text);
    Config.SetPassword(edtPassword.Text);
    Config.SetServer(edtServer.Text);
    Config.SetPort(StrToIntDef(edtPort.Text, 3050));
    Config.SetClientLibrary(edtClientLibrary.Text);

    Result := True;
  finally
    Config.Free;
  end;
end;

procedure TfConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrNone then
    ModalResult := mrCancel;
end;

procedure TfConfig.FormCreate(Sender: TObject);
var
  Config: TConfigManager;
begin
  Config := TConfigManager.Create;
  try
    edtDatabase.Text      := Config.Database;
    edtUsername.Text      := Config.Username;
    edtPassword.Text      := Config.Password;
    edtServer.Text        := Config.Server;
    edtPort.Text          := Config.Port.ToString;
    edtClientLibrary.Text := Config.ClientLibrary;
  finally
    Config.Free;
  end;
end;

procedure TfConfig.FormShow(Sender: TObject);
begin
  odgDB.InitialDir := ExtractFilePath(Application.ExeName);
  odgClientLibrary.InitialDir := ExtractFilePath(Application.ExeName);
end;

end.
