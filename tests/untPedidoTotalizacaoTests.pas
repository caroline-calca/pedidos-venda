unit untPedidoTotalizacaoTests;

interface

uses
  DUnitX.TestFramework,
  untPedidoItem;

type
  [TestFixture]
  TPedidoTotalizacaoTests = class
  public
    [Test]
    procedure DeveCalcularTotalDoItem_ComSucesso;

    [Test]
    procedure DeveFalharAoCompararTotalDoItem;

    [Test]
    procedure DeveCalcularTotalDoPedido_ComSucesso;

    [Test]
    procedure DeveFalharAoCompararTotalDoPedido;
  end;

implementation

procedure TPedidoTotalizacaoTests.DeveCalcularTotalDoItem_ComSucesso;
var
  Quantidade: Double;
  ValorUnitario: Double;
  TotalEsperado: Double;
  Item: TPedidoItem;
begin
  Quantidade := 2;
  ValorUnitario := 5.50;
  TotalEsperado := 11.00;

  Item := TPedidoItem.Criar(10, Quantidade, ValorUnitario);
  try
    Assert.AreEqual(TotalEsperado, Item.VlrTotal, 0.01,
      'Total do item deve ser quantidade x valor unitário');
  finally
    Item.Free;
  end;
end;

procedure TPedidoTotalizacaoTests.DeveFalharAoCompararTotalDoItem;
var
  Quantidade: Double;
  ValorUnitario: Double;
  TotalErrado: Double;
  Item: TPedidoItem;
begin
  Quantidade := 2;
  ValorUnitario := 5.50;
  TotalErrado := 12.00; // propositalmente errado

  Item := TPedidoItem.Criar(10, Quantidade, ValorUnitario);
  try
    Assert.AreEqual(TotalErrado, Item.VlrTotal, 0.01,
      'Teste propositalmente incorreto para demonstrar falha');
  finally
    Item.Free;
  end;
end;

procedure TPedidoTotalizacaoTests.DeveCalcularTotalDoPedido_ComSucesso;
var
  QtdItem1, QtdItem2: Double;
  VlrItem1, VlrItem2: Double;
  TotalEsperado: Double;
  Item1, Item2: TPedidoItem;
  TotalCalculado: Double;
begin
  QtdItem1 := 2;
  VlrItem1 := 10.00; // 20

  QtdItem2 := 3;
  VlrItem2 := 5.00;  // 15

  TotalEsperado := 35.00;

  Item1 := TPedidoItem.Criar(1, QtdItem1, VlrItem1);
  Item2 := TPedidoItem.Criar(2, QtdItem2, VlrItem2);
  try
    TotalCalculado := Item1.VlrTotal + Item2.VlrTotal;

    Assert.AreEqual(TotalEsperado, TotalCalculado, 0.01,
      'Total do pedido deve ser a soma dos totais dos itens');
  finally
    Item1.Free;
    Item2.Free;
  end;
end;

procedure TPedidoTotalizacaoTests.DeveFalharAoCompararTotalDoPedido;
var
  QtdItem1, QtdItem2: Double;
  VlrItem1, VlrItem2: Double;
  TotalEsperado: Double;
  Item1, Item2: TPedidoItem;
  TotalCalculado: Double;
begin
  QtdItem1 := 2;
  VlrItem1 := 10.00; // 20

  QtdItem2 := 3;
  VlrItem2 := 5.00;  // 15

  TotalEsperado := 36.00; // propositalmente errado

  Item1 := TPedidoItem.Criar(1, QtdItem1, VlrItem1);
  Item2 := TPedidoItem.Criar(2, QtdItem2, VlrItem2);
  try
    TotalCalculado := Item1.VlrTotal + Item2.VlrTotal;

    Assert.AreEqual(TotalEsperado, TotalCalculado, 0.01,
      'Total do pedido deve ser a soma dos totais dos itens');
  finally
    Item1.Free;
    Item2.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TPedidoTotalizacaoTests);

end.
