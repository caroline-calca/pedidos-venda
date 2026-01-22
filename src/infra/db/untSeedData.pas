unit untSeedData;

interface

type
  TSeedCliente = record
    Nome: string;
    Cidade: string;
    UF: string;
  end;

const
  SEED_CLIENTES: array[0..19] of TSeedCliente = (
    (Nome: 'Miguel';   Cidade: 'Sao Paulo';       UF: 'SP'),
    (Nome: 'Helena';   Cidade: 'Rio de Janeiro';  UF: 'RJ'),
    (Nome: 'Arthur';   Cidade: 'Belo Horizonte';  UF: 'MG'),
    (Nome: 'Alice';    Cidade: 'Brasilia';        UF: 'DF'),
    (Nome: 'Benicio';  Cidade: 'Salvador';        UF: 'BA'),
    (Nome: 'Laura';    Cidade: 'Fortaleza';       UF: 'CE'),
    (Nome: 'Theo';     Cidade: 'Sao Paulo';       UF: 'SP'),
    (Nome: 'Manuela';  Cidade: 'Sao Paulo';       UF: 'SP'),
    (Nome: 'Heitor';   Cidade: 'Sao Paulo';       UF: 'SP'),
    (Nome: 'Sophia';   Cidade: 'Manaus';          UF: 'AM'),
    (Nome: 'Davi';     Cidade: 'Rio de Janeiro';  UF: 'RJ'),
    (Nome: 'Isabella'; Cidade: 'Rio de Janeiro';  UF: 'RJ'),
    (Nome: 'Bernardo'; Cidade: 'Sao Paulo';       UF: 'SP'),
    (Nome: 'Luisa';    Cidade: 'Curitiba';        UF: 'PR'),
    (Nome: 'Noah';     Cidade: 'Recife';          UF: 'PE'),
    (Nome: 'Cecilia';  Cidade: 'Goiania';         UF: 'GO'),
    (Nome: 'Gabriel';  Cidade: 'Sao Paulo';       UF: 'SP'),
    (Nome: 'Maite';    Cidade: 'Belem';           UF: 'PA'),
    (Nome: 'Samuel';   Cidade: 'Porto Alegre';    UF: 'RS'),
    (Nome: 'Eloa';     Cidade: 'Guarulhos';       UF: 'SP')
  );

implementation

end.
