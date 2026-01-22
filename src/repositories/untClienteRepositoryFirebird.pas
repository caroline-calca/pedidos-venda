unit untClienteRepositoryFirebird;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,

  untClienteRepository,
  untCliente,
  untConnectionManager;

type
  TClienteRepositoryFirebird = class(TInterfacedObject, IClienteRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create;

    procedure Inserir(const ACliente: TCliente);
    function ObterPorCodigo(const ACodigo: Integer): TCliente;
  end;

implementation

{ TClienteRepositoryFirebird }

constructor TClienteRepositoryFirebird.Create;
begin
  FConnection := FConnectionManager.Connection;
end;

procedure TClienteRepositoryFirebird.Inserir(const ACliente: TCliente);
var
  Qry: TFDQuery;
begin
  if not Assigned(ACliente) then
    Exit;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'INSERT INTO CLIENTE (CODIGO, NOME, CIDADE, UF) ' +
      'VALUES (:CODIGO, :NOME, :CIDADE, :UF)';

    Qry.ParamByName('CODIGO').AsInteger := ACliente.Codigo;
    Qry.ParamByName('NOME').AsString   := ACliente.Nome;
    Qry.ParamByName('CIDADE').AsString := ACliente.Cidade;
    Qry.ParamByName('UF').AsString     := ACliente.UF;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TClienteRepositoryFirebird.ObterPorCodigo(const ACodigo: Integer): TCliente;
var
  Qry: TFDQuery;
begin
  Result := nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT CODIGO, NOME, CIDADE, UF ' +
      'FROM CLIENTE ' +
      'WHERE CODIGO = :CODIGO';

    Qry.ParamByName('CODIGO').AsInteger := ACodigo;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      Result := TCliente.Create;
      Result.Codigo := Qry.FieldByName('CODIGO').AsInteger;
      Result.Nome   := Qry.FieldByName('NOME').AsString;
      Result.Cidade := Qry.FieldByName('CIDADE').AsString;
      Result.UF     := Qry.FieldByName('UF').AsString;
    end;
  finally
    Qry.Free;
  end;
end;

end.
