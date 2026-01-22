unit untPedidoItem;

interface

type
  TPedidoItem = class
  private
    FID: Integer;
    FNumeroPedido: Integer;
    FCodigoProduto: Integer;
    FQuantidade: Double;
    FVlrUnitario: Double;
    FVlrTotal: Double;
  public
    property ID: Integer read FID write FID;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property VlrUnitario: Double read FVlrUnitario write FVlrUnitario;
    property VlrTotal: Double read FVlrTotal write FVlrTotal;

    class function Criar(const ACodProduto: Integer; const AQtd, AVlrUnit: Double): TPedidoItem; static;
    class function Carregar(const AID, ANumeroPedido, ACodigoProduto: Integer;
                            const AQuantidade, AValorUnitario, AValorTotal: Double): TPedidoItem; static;
    procedure RecalcularTotal;
  end;

implementation

class function TPedidoItem.Criar(const ACodProduto: Integer; const AQtd, AVlrUnit: Double): TPedidoItem;
begin
  Result := TPedidoItem.Create;
  Result.CodigoProduto := ACodProduto;
  Result.Quantidade := AQtd;
  Result.VlrUnitario := AVlrUnit;
  Result.RecalcularTotal;
end;

class function TPedidoItem.Carregar(const AID, ANumeroPedido, ACodigoProduto: Integer;
                                    const AQuantidade, AValorUnitario, AValorTotal: Double): TPedidoItem;
begin
  Result := TPedidoItem.Create;
  Result.ID := AID;
  Result.NumeroPedido := ANumeroPedido;
  Result.CodigoProduto := ACodigoProduto;
  Result.Quantidade := AQuantidade;
  Result.VlrUnitario := AValorUnitario;
  Result.VlrTotal := AValorTotal;
end;

procedure TPedidoItem.RecalcularTotal;
begin
  FVlrTotal := FQuantidade * FVlrUnitario;
end;

end.
