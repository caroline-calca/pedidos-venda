program PedidosVenda;

uses
  Vcl.Forms,
  frmMain in 'views\frmMain.pas' {fMain},
  untConfigManager in 'infra\config\untConfigManager.pas',
  untConnectionManager in 'infra\db\untConnectionManager.pas',
  untDatabaseBootstrap in 'infra\db\interfaces\untDatabaseBootstrap.pas',
  untDatabaseBootstrapFirebird in 'infra\firebird\untDatabaseBootstrapFirebird.pas',
  frmConfig in 'views\frmConfig.pas' {fConfig},
  untUtils in 'infra\common\untUtils.pas',
  untAppBootstrap in 'infra\common\untAppBootstrap.pas',
  untCliente in 'domain\untCliente.pas';

{$R *.res}

begin
  Application.Initialize;

  FConnectionManager := TConnectionManager.Create;

  if not InicializarSistema then
    Exit;

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;

  FConnectionManager.Free;
end.
