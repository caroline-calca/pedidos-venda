unit untPedidoItemRepository;

interface

uses
  System.Generics.Collections,
  untPedidoItem;

type
  IPedidoItemRepository = interface
    ['{3F1D7C5A-75E3-4A6E-8D2B-444444444444}']

    procedure InserirItem(const AItem: TPedidoItem);

    function CarregarItens(const ANumeroPedido: Integer): TObjectList<TPedidoItem>;
    procedure ExcluirItensPorPedido(const ANumeroPedido: Integer);
    procedure ExcluirItemPorID(const AID: Integer);
    procedure AtualizarItem(const AItem: TPedidoItem);
  end;

implementation

end.
