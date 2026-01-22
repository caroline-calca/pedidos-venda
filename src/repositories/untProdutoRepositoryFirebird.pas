unit untProdutoRepositoryFirebird;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  untProdutoRepository,
  untProduto,
  untConnectionManager;

type
  TProdutoRepositoryFirebird = class(TInterfacedObject, IProdutoRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create; overload;
    constructor Create(AConnection: TFDConnection); overload;

    procedure Inserir(const AProduto: TProduto);
    function ObterPorCodigo(const ACodigo: Integer): TProduto;
  end;

implementation

{ TProdutoRepositoryFirebird }

constructor TProdutoRepositoryFirebird.Create;
begin
  inherited Create;
  FConnection := FConnectionManager.Connection;
end;

constructor TProdutoRepositoryFirebird.Create(AConnection: TFDConnection);
begin
  inherited Create;
  if Assigned(AConnection) then
    FConnection := AConnection
  else
    FConnection := FConnectionManager.Connection;
end;

procedure TProdutoRepositoryFirebird.Inserir(const AProduto: TProduto);
var
  Qry: TFDQuery;
begin
  if not Assigned(AProduto) then
    Exit;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'INSERT INTO PRODUTO (CODIGO, DESCRICAO, PRECO_VENDA) ' +
      'VALUES (:CODIGO, :DESCRICAO, :PRECO_VENDA)';

    Qry.ParamByName('CODIGO').AsInteger := AProduto.Codigo;
    Qry.ParamByName('DESCRICAO').AsString := AProduto.Descricao;
    Qry.ParamByName('PRECO_VENDA').AsFloat := AProduto.PrecoVenda;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TProdutoRepositoryFirebird.ObterPorCodigo(const ACodigo: Integer): TProduto;
var
  Qry: TFDQuery;
begin
  Result := nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT CODIGO, DESCRICAO, PRECO_VENDA ' +
      'FROM PRODUTO ' +
      'WHERE CODIGO = :CODIGO';

    Qry.ParamByName('CODIGO').AsInteger := ACodigo;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      Result := TProduto.Create;
      Result.Codigo := Qry.FieldByName('CODIGO').AsInteger;
      Result.Descricao := Qry.FieldByName('DESCRICAO').AsString;
      Result.PrecoVenda := Qry.FieldByName('PRECO_VENDA').AsFloat;
    end;
  finally
    Qry.Free;
  end;
end;

end.
