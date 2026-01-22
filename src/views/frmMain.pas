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
  untProduto,
  untClienteService,
  untProdutoService,
  untClienteRepository,
  untProdutoRepository,
  untClienteRepositoryFirebird,
  untProdutoRepositoryFirebird;

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
  private
    const cVlrMask: String = '#,###,###,##0.00';

    procedure LimpaTela;
    procedure LimparCliente;
    procedure LimparProduto;

    procedure AtualizarTotal;
    function ValidoAdicionar: Boolean;

    procedure CarregarCliente;
    procedure CarregarProduto;
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
begin
  if not ValidoAdicionar then
    Exit;

  Qtd := StrToFloatDef(edtQtd.Text, 0);
  VlrUnit := StrToFloatDef(edtValor.Text, 0);

  cdsProdutos.Append;
  cdsProdutosidproduto.AsInteger   := StrToInt(edtIdProduto.Text);
  cdsProdutosdescricao.AsString    := edtDescProduto.Text;
  cdsProdutosquantidade.AsFloat    := Qtd;
  cdsProdutosvlrunitario.AsFloat   := VlrUnit;
  cdsProdutosvlrtotal.AsFloat      := Qtd * VlrUnit;
  cdsProdutos.Post;

  AtualizarTotal;
  LimparProduto;
  edtQtd.Text := '0';
  edtIdProduto.SetFocus;
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

procedure TfMain.btnConfigurarClick(Sender: TObject);
begin
  if TfConfig.Executar(mcOpcional) = mrOk then
  begin
    ShowMsg('As configurações foram alteradas.' + sLineBreak +
            'O sistema será encerrado para aplicar as mudanças.', mtInfo);

    Application.Terminate;
  end;
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
  edtQtd.Text := '0';
  edtValor.Text := '0,00';
end;

procedure TfMain.edtIdProdutoExit(Sender: TObject);
begin
  CarregarProduto;
end;

procedure TfMain.edtValorExit(Sender: TObject);
var
  vValor: String;
begin
  vValor := EmptyStr;

  if edtValor.Text <> EmptyStr then
  begin
    vValor := StringReplace(edtValor.Text, '.', EmptyStr, [rfReplaceAll]);
    vValor := StringReplace(edtValor.Text, ',', EmptyStr, [rfReplaceAll]);

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

  edtValor.Text := vValor;
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
  edtQtd.Text := '0';
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

end.
