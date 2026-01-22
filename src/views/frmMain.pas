unit frmMain;

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
  Data.DB,
  Datasnap.DBClient,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.Buttons,

  untUtils,
  untConnectionManager,
  frmConfig,

  untCliente,
  untClienteService,
  untClienteRepository,
  untClienteRepositoryFirebird,

  untProduto,
  untProdutoService,
  untProdutoRepository,
  untProdutoRepositoryFirebird,

  untPedido,
  untPedidoRepository,
  untPedidoRepositoryFirebird,
  untPedidoService,

  untPedidoItem,
  untPedidoItemRepository,
  untPedidoItemRepositoryFirebird;

type
  TfMain = class(TForm)
    Panel1: TPanel;
    btnCarregar: TButton;
    btnCancelar: TButton;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnAdicionar: TButton;
    dbgProdutos: TDBGrid;
    edtIdCliente: TEdit;
    edtIdProduto: TEdit;
    edtQtd: TEdit;
    edtValor: TEdit;
    edtNomeCliente: TEdit;
    edtDescProduto: TEdit;
    Panel4: TPanel;
    Label6: TLabel;
    lblTotal: TLabel;
    btnGravar: TButton;
    cdsProdutos: TClientDataSet;
    cdsProdutosidpeditem: TIntegerField;
    cdsProdutosidpedgeral: TIntegerField;
    cdsProdutosidproduto: TIntegerField;
    cdsProdutosdescricao: TStringField;
    cdsProdutosquantidade: TIntegerField;
    cdsProdutosvlrunitario: TFloatField;
    cdsProdutosvlrtotal: TFloatField;
    dsProdutos: TDataSource;
    cdsProdDel: TClientDataSet;
    cdsProdDelidpeditem: TIntegerField;
    btnConfigurar: TBitBtn;
    Label1: TLabel;
    edtCidadeCliente: TEdit;
    edtUFCliente: TEdit;
    Label7: TLabel;
    edtObservacao: TEdit;
    procedure btnConfigurarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtIdProdutoChange(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure edtIdClienteExit(Sender: TObject);
    procedure edtIdProdutoExit(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtQtdExit(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    const cVlrMask: String = '#,###,###,##0.00';

    procedure LimpaTela;
    procedure LimparCliente;
    procedure LimparProduto;

    procedure AtualizarTotal;
    procedure AdicionarMascaraValores(Sender: TEdit);
    function ValidoAdicionar: Boolean;
    function NumeroPedidoAtual: Integer;

    procedure CarregarCliente;
    procedure CarregarProduto;

    function CriarPedidoService: TPedidoService;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.btnAdicionarClick(Sender: TObject);
var
  Qtd: Double;
  VlrUnit: Double;
  NumPed: Integer;
begin
  if not ValidoAdicionar then
    Exit;

  NumPed := NumeroPedidoAtual;
  Qtd := StrToFloatDef(edtQtd.Text, 0);
  VlrUnit := StrToFloatDef(edtValor.Text, 0);

  cdsProdutos.Append;
  cdsProdutosidpeditem.AsInteger   := 0;
  cdsProdutosidpedgeral.AsInteger  := NumPed;
  cdsProdutosidproduto.AsInteger   := StrToInt(edtIdProduto.Text);
  cdsProdutosdescricao.AsString    := edtDescProduto.Text;
  cdsProdutosquantidade.AsFloat    := Qtd;
  cdsProdutosvlrunitario.AsFloat   := VlrUnit;
  cdsProdutosvlrtotal.AsFloat      := Qtd * VlrUnit;
  cdsProdutos.Post;

  AtualizarTotal;
  LimparProduto;
  edtQtd.Text := '0,00';
  edtIdProduto.SetFocus;
end;

function TfMain.NumeroPedidoAtual: Integer;
begin
  Result := 0;

  if not cdsProdutos.IsEmpty then
    Result := cdsProdutosidpedgeral.AsInteger;
end;

function TfMain.ValidoAdicionar: Boolean;
begin
  Result := False;

  if Trim(edtNomeCliente.Text) = '' then
  begin
    ShowMsg('Selecione um cliente antes de adicionar produtos.', mtWarn);
    edtIdCliente.SetFocus;
    Exit;
  end;

  if Trim(edtDescProduto.Text) = '' then
  begin
    ShowMsg('Selecione um produto.', mtWarn);
    edtIdProduto.SetFocus;
    Exit;
  end;

  if StrToFloatDef(edtQtd.Text, 0) <= 0 then
  begin
    ShowMsg('Quantidade inválida.', mtWarn);
    edtQtd.SetFocus;
    Exit;
  end;

  if StrToFloatDef(edtValor.Text, 0) <= 0 then
  begin
    ShowMsg('Valor unitário inválido.', mtWarn);
    edtValor.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TfMain.btnCancelarClick(Sender: TObject);
var
  Service: TPedidoService;
  Num: Integer;
begin
  try
    if (ShowMsg('Deseja cancelar o pedido atual?', mtQuest) <> mrYes) then
      Exit;

    Num := NumeroPedidoAtual;

    if Num > 0 then
    begin
      Service := CriarPedidoService;
      try
        Service.CancelarPedido(Num);
      finally
        Service.Free;
      end;
    end;

    LimpaTela;
    edtIdCliente.SetFocus;

    ShowMsg('Pedido cancelado com sucesso.', mtInfo);
  except
    on E: Exception do
      ShowMsg('Erro ao cancelar pedido: ' + E.Message, mtErr);
  end;
end;

procedure TfMain.btnCarregarClick(Sender: TObject);
var
  Num: Integer;
  Service: TPedidoService;
  Pedido: TPedido;
begin
  LimpaTela;

  Num := StrToIntDef(InputBox('Carregar Pedido', 'Informe o número do pedido:', ''), 0);
  if Num <= 0 then
    Exit;

  Service := CriarPedidoService;
  try
    Pedido := nil;
    try
      Service.CarregarPedido(Num, Pedido, cdsProdutos);

      edtIdCliente.Text := Pedido.CodigoCliente.ToString;
      CarregarCliente;

      edtObservacao.Text := Pedido.Observacao;

      AtualizarTotal;

      ShowMsg(Format('Pedido %d carregado.', [Num]), mtInfo);
    finally
      Pedido.Free;
    end;
  finally
    Service.Free;
  end;
end;

procedure TfMain.btnConfigurarClick(Sender: TObject);
begin
  if TfConfig.Executar(mcOpcional) = mrOk then
  begin
    ShowMsg('As configurações foram alteradas.' + sLineBreak +
            'O sistema será encerrado para aplicar as mudanças.', mtInfo);

    Application.Terminate;
  end;
end;

procedure TfMain.btnGravarClick(Sender: TObject);
var
  Service: TPedidoService;
  NumPedido: Integer;
begin
  try
    Service := CriarPedidoService;
    try
      NumPedido := Service.GravarPedido(NumeroPedidoAtual,
                                        StrToIntDef(edtIdCliente.Text, 0),
                                        edtObservacao.Text,
                                        cdsProdutos,
                                        cdsProdDel);

      ShowMsg('Pedido gravado com sucesso! Nº ' + NumPedido.ToString, mtInfo);

      LimpaTela;
    finally
      Service.Free;
    end;
  except
    on E: Exception do
      ShowMsg('Erro ao gravar pedido: ' + E.Message, mtErr);
  end;

  edtIdCliente.SetFocus;
end;

procedure TfMain.dbgProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_up then
    dbgProdutos.Datasource.Dataset.Prior;

  if Key = vk_down then
    dbgProdutos.Datasource.Dataset.Next;

  if (cdsProdutos.FieldByName('idproduto').AsInteger > 0) then
  begin
    if Key = vk_delete then
    begin
      if ShowMsg('Deseja excluir o item do pedido?', mtQuest) = mrYes then
      begin
        // adiciona em outro dataset, para excluir apenas ao gravar, na transação
        if (cdsProdutos.FieldByName('idpeditem').AsInteger > 0) then
        begin
          cdsProdDel.Append;
          cdsProdDel.FieldByName('idpeditem').AsInteger := cdsProdutos.FieldByName('idpeditem').AsInteger;
          cdsProdDel.Post;
        end;

        cdsProdutos.Delete;
      end;
    end;

    if Key = vk_return then
    begin
      dbgProdutos.Options := dbgProdutos.Options + [dgEditing];
      cdsProdutos.Edit;
    end;
  end;
end;

procedure TfMain.edtIdClienteExit(Sender: TObject);
begin
  CarregarCliente;
end;

procedure TfMain.edtIdProdutoChange(Sender: TObject);
begin
  edtDescProduto.Text := EmptyStr;
  edtQtd.Text := '0,00';
  edtValor.Text := '0,00';
end;

procedure TfMain.edtIdProdutoExit(Sender: TObject);
begin
  CarregarProduto;
end;

procedure TfMain.edtQtdExit(Sender: TObject);
begin
  AdicionarMascaraValores(edtQtd);
end;

procedure TfMain.AdicionarMascaraValores(Sender: TEdit);
var
  vValor: String;
begin
  vValor := EmptyStr;

  if Sender.Text <> EmptyStr then
  begin
    vValor := StringReplace(Sender.Text, '.', EmptyStr, [rfReplaceAll]);
    vValor := StringReplace(Sender.Text, ',', EmptyStr, [rfReplaceAll]);

    if (Length(vValor) = 1) then
      vValor := '0,0' + vValor
    else if (Length(vValor) = 2) then
      vValor := '0,' + vValor
    else
      vValor := Copy(vValor, 1, Length(vValor)-2) + ',' + Copy(vValor, Length(vValor)-1, 2);

    vValor := FormatFloat(cVlrMask, StrToFloat(vValor));
  end
  else
    vValor := '0,00';

  Sender.Text := vValor;
end;

procedure TfMain.edtValorExit(Sender: TObject);
begin
  AdicionarMascaraValores(edtValor);
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  cdsProdutos.CreateDataSet;
  cdsProdDel.CreateDataSet;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  edtIdCliente.SetFocus;
end;

procedure TfMain.LimpaTela;
begin
  edtIdCliente.Text := EmptyStr;
  LimparCliente;
  edtIdProduto.Text := EmptyStr;
  LimparProduto;
  edtQtd.Text := '0,00';
  edtObservacao.Text := EmptyStr;

  cdsProdutos.EmptyDataSet;
  cdsProdDel.EmptyDataSet;
end;

procedure TfMain.LimparCliente;
begin
  edtNomeCliente.Clear;
  edtCidadeCliente.Clear;
  edtUFCliente.Clear;
end;

procedure TfMain.LimparProduto;
begin
  edtDescProduto.Clear;
  edtValor.Text := '0,00';
end;

procedure TfMain.CarregarCliente;
var
  Cod: Integer;
  Repo: IClienteRepository;
  Service: TClienteService;
  Cli: TCliente;
begin
  LimparCliente;

  Cod := StrToIntDef(Trim(edtIdCliente.Text), 0);
  if Cod <= 0 then
    Exit;

  Repo := TClienteRepositoryFirebird.Create(FConnectionManager.Connection);

  Service := TClienteService.Create(Repo);
  try
    Cli := Service.BuscarCliente(Cod);
    try
      if not Assigned(Cli) then
      begin
        ShowMsg('Cliente não encontrado.', mtWarn);
        edtIdCliente.SetFocus;
        Exit;
      end;

      edtNomeCliente.Text := Cli.Nome;
      edtCidadeCliente.Text := Cli.Cidade;
      edtUFCliente.Text := Cli.UF;
    finally
      Cli.Free;
    end;
  finally
    Service.Free;
  end;
end;

procedure TfMain.CarregarProduto;
var
  Cod: Integer;
  Repo: IProdutoRepository;
  Service: TProdutoService;
  Prod: TProduto;
begin
  LimparProduto;

  Cod := StrToIntDef(Trim(edtIdProduto.Text), 0);
  if Cod <= 0 then
    Exit;

  Repo := TProdutoRepositoryFirebird.Create(FConnectionManager.Connection);

  Service := TProdutoService.Create(Repo);
  try
    Prod := Service.BuscarProduto(Cod);
    try
      if not Assigned(Prod) then
      begin
        ShowMsg('Produto não encontrado.', mtWarn);
        edtIdProduto.SetFocus;
        Exit;
      end;

      edtDescProduto.Text := Prod.Descricao;
      edtValor.Text := FormatFloat(cVlrMask, Prod.PrecoVenda);
    finally
      Prod.Free;
    end;
  finally
    Service.Free;
  end;
end;

procedure TfMain.AtualizarTotal;
var
  Total: Double;
begin
  Total := 0;

  cdsProdutos.DisableControls;
  try
    cdsProdutos.First;
    while not cdsProdutos.Eof do
    begin
      Total := Total + cdsProdutosvlrtotal.AsFloat;
      cdsProdutos.Next;
    end;
  finally
    cdsProdutos.EnableControls;
  end;

  lblTotal.Caption := FormatFloat('R$ ' + cVlrMask, Total);
end;

function TfMain.CriarPedidoService: TPedidoService;
var
  PedRepo: IPedidoRepository;
  ItemRepo: IPedidoItemRepository;
  CliRepo: IClienteRepository;
  ProdRepo: IProdutoRepository;
begin
  PedRepo  := TPedidoRepositoryFirebird.Create(FConnectionManager.Connection);
  ItemRepo := TPedidoItemRepositoryFirebird.Create(FConnectionManager.Connection);
  CliRepo  := TClienteRepositoryFirebird.Create(FConnectionManager.Connection);
  ProdRepo := TProdutoRepositoryFirebird.Create(FConnectionManager.Connection);

  Result := TPedidoService.Create(PedRepo, ItemRepo, CliRepo, ProdRepo);
end;

end.
