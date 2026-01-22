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
  untCliente in 'domain\untCliente.pas',
  untClienteRepository in 'repositories\interfaces\untClienteRepository.pas',
  untClienteRepositoryFirebird in 'repositories\untClienteRepositoryFirebird.pas',
  untClienteService in 'services\untClienteService.pas',
  untSeedData in 'infra\db\untSeedData.pas',
  untProduto in 'domain\untProduto.pas',
  untProdutoRepository in 'repositories\interfaces\untProdutoRepository.pas',
  untProdutoRepositoryFirebird in 'repositories\untProdutoRepositoryFirebird.pas',
  untProdutoService in 'services\untProdutoService.pas',
  untPedido in 'domain\untPedido.pas',
  untPedidoItem in 'domain\untPedidoItem.pas',
  untPedidoRepository in 'repositories\interfaces\untPedidoRepository.pas',
  untPedidoItemRepository in 'repositories\interfaces\untPedidoItemRepository.pas',
  untPedidoRepositoryFirebird in 'repositories\untPedidoRepositoryFirebird.pas',
  untPedidoItemRepositoryFirebird in 'repositories\untPedidoItemRepositoryFirebird.pas',
  untPedidoService in 'services\untPedidoService.pas';

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
