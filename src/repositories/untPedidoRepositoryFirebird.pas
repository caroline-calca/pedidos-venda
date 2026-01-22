unit untPedidoRepositoryFirebird;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Data.DB,

  untPedidoRepository,
  untPedido,
  untConnectionManager;

type
  TPedidoRepositoryFirebird = class(TInterfacedObject, IPedidoRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create; overload;
    constructor Create(AConnection: TFDConnection); overload;

    function ProximoNumeroPedido: Integer;
    procedure InserirCabecalho(const APedido: TPedido);
    procedure AtualizarTotalEObs(const ANumero: Integer; const ATotal: Double; const AObs: string);

    function CarregarCabecalho(const ANumero: Integer): TPedido;
    procedure ExcluirPedido(const ANumero: Integer);
  end;

implementation

constructor TPedidoRepositoryFirebird.Create;
begin
  inherited Create;
  FConnection := FConnectionManager.Connection;
end;

constructor TPedidoRepositoryFirebird.Create(AConnection: TFDConnection);
begin
  inherited Create;
  if Assigned(AConnection) then
    FConnection := AConnection
  else
    FConnection := FConnectionManager.Connection;
end;

function TPedidoRepositoryFirebird.ProximoNumeroPedido: Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT NEXT VALUE FOR GEN_PEDIDO AS NUMERO FROM RDB$DATABASE';
    Qry.Open;
    Result := Qry.FieldByName('NUMERO').AsInteger;
  finally
    Qry.Free;
  end;
end;

procedure TPedidoRepositoryFirebird.InserirCabecalho(const APedido: TPedido);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'INSERT INTO PEDIDO (NUMERO_PEDIDO, DATA_EMISSAO, CODIGO_CLIENTE, VALOR_TOTAL, OBSERVACAO) ' +
      'VALUES (:NUM, :DATA, :CLI, :TOTAL, :OBS)';

    Qry.ParamByName('NUM').AsInteger := APedido.NumeroPedido;
    Qry.ParamByName('DATA').AsDate := APedido.DataEmissao;
    Qry.ParamByName('CLI').AsInteger := APedido.CodigoCliente;
    Qry.ParamByName('TOTAL').AsFloat := APedido.ValorTotal;
    Qry.ParamByName('OBS').AsString := APedido.Observacao;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TPedidoRepositoryFirebird.AtualizarTotalEObs(const ANumero: Integer; const ATotal: Double; const AObs: string);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'UPDATE PEDIDO SET VALOR_TOTAL = :TOTAL, OBSERVACAO = :OBS ' +
      'WHERE NUMERO_PEDIDO = :NUM';

    Qry.ParamByName('TOTAL').AsFloat := ATotal;
    Qry.ParamByName('OBS').AsString := AObs;
    Qry.ParamByName('NUM').AsInteger := ANumero;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TPedidoRepositoryFirebird.CarregarCabecalho(const ANumero: Integer): TPedido;
var
  Qry: TFDQuery;
begin
  Result := nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT NUMERO_PEDIDO, DATA_EMISSAO, CODIGO_CLIENTE, VALOR_TOTAL, OBSERVACAO ' +
      'FROM PEDIDO WHERE NUMERO_PEDIDO = :NUM';

    Qry.ParamByName('NUM').AsInteger := ANumero;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      Result := TPedido.Carregar(Qry.FieldByName('NUMERO_PEDIDO').AsInteger,
                                 Qry.FieldByName('DATA_EMISSAO').AsDateTime,
                                 Qry.FieldByName('CODIGO_CLIENTE').AsInteger,
                                 Qry.FieldByName('VALOR_TOTAL').AsFloat,
                                 Qry.FieldByName('OBSERVACAO').AsString);
    end;
  finally
    Qry.Free;
  end;
end;

procedure TPedidoRepositoryFirebird.ExcluirPedido(const ANumero: Integer);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'DELETE FROM PEDIDO WHERE NUMERO_PEDIDO = :NUM';
    Qry.ParamByName('NUM').AsInteger := ANumero;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

end.
