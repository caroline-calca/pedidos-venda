unit untProdutoService;

interface

uses
  untProduto,
  untProdutoRepository;

type
  TProdutoService = class
  private
    FRepository: IProdutoRepository;
  public
    constructor Create(const ARepository: IProdutoRepository);

    function BuscarProduto(const ACodigo: Integer): TProduto;
  end;

implementation

constructor TProdutoService.Create(const ARepository: IProdutoRepository);
begin
  FRepository := ARepository;
end;

function TProdutoService.BuscarProduto(const ACodigo: Integer): TProduto;
begin
  if ACodigo <= 0 then
    Exit(nil);

  Result := FRepository.ObterPorCodigo(ACodigo);
end;

end.
