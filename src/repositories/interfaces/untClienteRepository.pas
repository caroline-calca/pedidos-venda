unit untClienteRepository;

interface

uses
  untCliente;

type
  IClienteRepository = interface
    ['{A2E3F7B0-9C1E-4A65-9B2F-111111111111}']

    procedure Inserir(const ACliente: TCliente);
    function ObterPorCodigo(const ACodigo: Integer): TCliente;
  end;

implementation

end.
