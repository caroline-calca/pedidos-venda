unit untCliente;

interface

type
  TCliente = class
  private
    FCodigo: Integer;
    FNome: string;
    FCidade: string;
    FUF: string;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Cidade: string read FCidade write FCidade;
    property UF: string read FUF write FUF;

    class function Criar(const ACodigo: Integer; const ANome, ACidade, AUF: string): TCliente; static;
  end;

implementation

class function TCliente.Criar(const ACodigo: Integer; const ANome, ACidade, AUF: string): TCliente;
begin
  Result := TCliente.Create;
  Result.Codigo := ACodigo;
  Result.Nome := ANome;
  Result.Cidade := ACidade;
  Result.UF := AUF;
end;

end.
