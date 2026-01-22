unit untPedidoTotalizacaoTests;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TPedidoTotalizacaoTests = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
  end;

implementation

procedure TPedidoTotalizacaoTests.Setup;
begin
end;

procedure TPedidoTotalizacaoTests.TearDown;
begin
end;


initialization
  TDUnitX.RegisterTestFixture(TPedidoTotalizacaoTests);

end.
