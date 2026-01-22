unit untPedidoItemRepositoryFirebird;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Data.DB,

  untPedidoItemRepository,
  untPedidoItem,
  untConnectionManager;

type
  TPedidoItemRepositoryFirebird = class(TInterfacedObject, IPedidoItemRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create; overload;
    constructor Create(AConnection: TFDConnection); overload;

    procedure InserirItem(const AItem: TPedidoItem);

    function CarregarItens(const ANumeroPedido: Integer): TObjectList<TPedidoItem>;
    procedure ExcluirItensPorPedido(const ANumeroPedido: Integer);
    procedure ExcluirItemPorID(const AID: Integer);
  end;

implementation

constructor TPedidoItemRepositoryFirebird.Create;
begin
  inherited Create;
  FConnection := FConnectionManager.Connection;
end;

constructor TPedidoItemRepositoryFirebird.Create(AConnection: TFDConnection);
begin
  inherited Create;
  if Assigned(AConnection) then
    FConnection := AConnection
  else
    FConnection := FConnectionManager.Connection;
end;

procedure TPedidoItemRepositoryFirebird.InserirItem(const AItem: TPedidoItem);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'INSERT INTO PEDIDO_ITEM (NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VLR_UNITARIO, VLR_TOTAL) ' +
      'VALUES (:NUM, :PROD, :QTD, :VUNIT, :VTOT)';

    Qry.ParamByName('NUM').AsInteger := AItem.NumeroPedido;
    Qry.ParamByName('PROD').AsInteger := AItem.CodigoProduto;
    Qry.ParamByName('QTD').AsFloat := AItem.Quantidade;
    Qry.ParamByName('VUNIT').AsFloat := AItem.VlrUnitario;
    Qry.ParamByName('VTOT').AsFloat := AItem.VlrTotal;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TPedidoItemRepositoryFirebird.CarregarItens(const ANumeroPedido: Integer): TObjectList<TPedidoItem>;
var
  Qry: TFDQuery;
  Lista: TObjectList<TPedidoItem>;
begin
  Lista := TObjectList<TPedidoItem>.Create(True);
  try
    Qry := TFDQuery.Create(nil);
    try
      Qry.Connection := FConnection;
      Qry.SQL.Text :=
        'SELECT ID, NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VLR_UNITARIO, VLR_TOTAL ' +
        'FROM PEDIDO_ITEM WHERE NUMERO_PEDIDO = :NUM ' +
        'ORDER BY ID';

      Qry.ParamByName('NUM').AsInteger := ANumeroPedido;
      Qry.Open;

      while not Qry.Eof do
      begin
        Lista.Add(
          TPedidoItem.Carregar(Qry.FieldByName('ID').AsInteger,
                               Qry.FieldByName('NUMERO_PEDIDO').AsInteger,
                               Qry.FieldByName('CODIGO_PRODUTO').AsInteger,
                               Qry.FieldByName('QUANTIDADE').AsFloat,
                               Qry.FieldByName('VLR_UNITARIO').AsFloat,
                               Qry.FieldByName('VLR_TOTAL').AsFloat));
        Qry.Next;
      end;
    finally
      Qry.Free;
    end;

    Result := Lista;
    Lista := nil;
  finally
    Lista.Free;
  end;
end;

procedure TPedidoItemRepositoryFirebird.ExcluirItensPorPedido(const ANumeroPedido: Integer);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'DELETE FROM PEDIDO_ITEM WHERE NUMERO_PEDIDO = :NUM';
    Qry.ParamByName('NUM').AsInteger := ANumeroPedido;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TPedidoItemRepositoryFirebird.ExcluirItemPorID(const AID: Integer);
var
  Qry: TFDQuery;
begin
  if AID <= 0 then
    Exit;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'DELETE FROM PEDIDO_ITEM WHERE ID = :ID';
    Qry.ParamByName('ID').AsInteger := AID;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

end.
