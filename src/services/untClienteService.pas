unit untClienteService;

interface

uses
  untCliente,
  untClienteRepository;

type
  TClienteService = class
  private
    FRepository: IClienteRepository;
  public
    constructor Create(const ARepository: IClienteRepository);

    function BuscarCliente(const ACodigo: Integer): TCliente;
  end;

implementation

{ TClienteService }

constructor TClienteService.Create(const ARepository: IClienteRepository);
begin
  FRepository := ARepository;
end;

function TClienteService.BuscarCliente(const ACodigo: Integer): TCliente;
begin
  if ACodigo <= 0 then
    Exit(nil);

  Result := FRepository.ObterPorCodigo(ACodigo);
end;

end.
