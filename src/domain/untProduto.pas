unit untProduto;

interface

type
  TProduto = class
  private
    FCodigo: Integer;
    FDescricao: string;
    FPrecoVenda: Double;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;

    class function Criar(const ACodigo: Integer; const ADescricao: string; const APrecoVenda: Double): TProduto; static;
  end;

implementation

class function TProduto.Criar(const ACodigo: Integer; const ADescricao: string; const APrecoVenda: Double): TProduto;
begin
  Result := TProduto.Create;
  Result.Codigo := ACodigo;
  Result.Descricao := ADescricao;
  Result.PrecoVenda := APrecoVenda;
end;

end.
