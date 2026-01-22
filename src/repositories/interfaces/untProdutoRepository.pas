unit untProdutoRepository;

interface

uses
  untProduto;

type
  IProdutoRepository = interface
    ['{C8A56B9A-7C83-4B8C-9A45-222222222222}']

    procedure Inserir(const AProduto: TProduto);
    function ObterPorCodigo(const ACodigo: Integer): TProduto;
  end;

implementation

end.
