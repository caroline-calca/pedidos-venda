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

type
  TSeedProduto = record
    Descricao: string;
    Preco: Double;
  end;

const
  SEED_PRODUTOS: array[0..23] of TSeedProduto = (
    (Descricao: 'Arroz';               Preco: 24.99),
    (Descricao: 'Feijao';              Preco: 9.90),
    (Descricao: 'Cafe';                Preco: 11.90),
    (Descricao: 'Macarrao';            Preco: 3.55),
    (Descricao: 'Farinha de trigo';    Preco: 6.50),
    (Descricao: 'Ovo';                 Preco: 0.90),
    (Descricao: 'Salgadinho';          Preco: 9.90),
    (Descricao: 'Refrigerante 2l';     Preco: 7.30),
    (Descricao: 'Chocolate';           Preco: 5.40),
    (Descricao: 'Miojo';               Preco: 1.99),
    (Descricao: 'Leite';               Preco: 4.50),
    (Descricao: 'Achocolatado';        Preco: 7.80),
    (Descricao: 'Leite em po';          Preco: 10.20),
    (Descricao: 'Vassoura';            Preco: 10.70),
    (Descricao: 'Limpador multiuso';   Preco: 12.60),
    (Descricao: 'Sacos de lixo 50l';   Preco: 13.80),
    (Descricao: 'Bolacha';             Preco: 2.70),
    (Descricao: 'Iogurte';             Preco: 5.90),
    (Descricao: 'Biscoito';            Preco: 8.60),
    (Descricao: 'Oleo';                Preco: 11.50),
    (Descricao: 'Vinagre';             Preco: 3.90),
    (Descricao: 'Sal';                 Preco: 2.30),
    (Descricao: 'Acucar';              Preco: 3.20),
    (Descricao: 'Pao de forma';         Preco: 7.50)
  );

implementation

end.
