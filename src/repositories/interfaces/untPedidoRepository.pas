unit untPedidoRepository;

interface

uses
  untPedido;

type
  IPedidoRepository = interface
    ['{7B5F6E2F-5B89-4E7B-9C22-333333333333}']

    function ProximoNumeroPedido: Integer;
    procedure InserirCabecalho(const APedido: TPedido);
    procedure AtualizarTotalEObs(const ANumero: Integer; const ATotal: Double; const AObs: string);

    function CarregarCabecalho(const ANumero: Integer): TPedido;
    procedure ExcluirPedido(const ANumero: Integer);
  end;

implementation

end.
