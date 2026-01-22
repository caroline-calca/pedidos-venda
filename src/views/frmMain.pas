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
  frmConfig;

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
    procedure btnConfigurarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.btnConfigurarClick(Sender: TObject);
begin
  if TfConfig.Executar(mcOpcional) = mrOk then
  begin
    ShowMsg('As configurações foram alteradas.' + sLineBreak +
            'O sistema será encerrado para aplicar as mudanças.', mtInfo);

    Application.Terminate;
  end;
end;

end.
