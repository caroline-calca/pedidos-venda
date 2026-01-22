unit untPedido;

interface

uses
  System.SysUtils;

type
  TPedido = class
  private
    FNumeroPedido: Integer;
    FDataEmissao: TDateTime;
    FCodigoCliente: Integer;
    FValorTotal: Double;
    FObservacao: string;
  public
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property Observacao: string read FObservacao write FObservacao;

    class function Criar(const ACodCliente: Integer; const AObs: string = ''): TPedido; static;
    class function Carregar(const ANumero: Integer; const AData: TDateTime;
                            const ACodCliente: Integer; const ATotal: Double; const AObs: string): TPedido; static;
  end;

implementation

class function TPedido.Criar(const ACodCliente: Integer; const AObs: string): TPedido;
begin
  Result := TPedido.Create;
  Result.DataEmissao := Date;
  Result.CodigoCliente := ACodCliente;
  Result.Observacao := AObs;
  Result.ValorTotal := 0;
end;

class function TPedido.Carregar(const ANumero: Integer; const AData: TDateTime;
  const ACodCliente: Integer; const ATotal: Double; const AObs: string): TPedido;
begin
  Result := TPedido.Create;
  Result.NumeroPedido := ANumero;
  Result.DataEmissao := AData;
  Result.CodigoCliente := ACodCliente;
  Result.ValorTotal := ATotal;
  Result.Observacao := AObs;
end;

end.
