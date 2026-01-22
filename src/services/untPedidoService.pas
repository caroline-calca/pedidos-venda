unit untPedidoService;

interface

uses
  System.SysUtils,
  Data.DB,
  System.Generics.Collections,
  Datasnap.DBClient,

  untProduto,
  untPedido,
  untPedidoItem,
  untPedidoRepository,
  untPedidoItemRepository,
  untClienteRepository,
  untProdutoRepository;

type
  TPedidoService = class
  private
    FPedidoRepo: IPedidoRepository;
    FItemRepo: IPedidoItemRepository;
    FClienteRepo: IClienteRepository;
    FProdutoRepo: IProdutoRepository;
  public
    constructor Create(const APedidoRepo: IPedidoRepository; const AItemRepo: IPedidoItemRepository;
      const AClienteRepo: IClienteRepository; const AProdutoRepo: IProdutoRepository);

    function GravarPedido(const ANumeroPedido: Integer; const ACodCliente: Integer;
      const AObservacao: string; AItens: TDataSet;AItensDeletados: TDataSet): Integer;

    procedure CancelarPedido(const ANumero: Integer);
    procedure CarregarPedido(const ANumero: Integer; out APedido: TPedido; out AItens: TClientDataSet);
  end;

implementation

uses
  FireDAC.Comp.Client,
  untConnectionManager,
  untUtils;

constructor TPedidoService.Create(const APedidoRepo: IPedidoRepository; const AItemRepo: IPedidoItemRepository;
  const AClienteRepo: IClienteRepository; const AProdutoRepo: IProdutoRepository);
begin
  FPedidoRepo := APedidoRepo;
  FItemRepo := AItemRepo;
  FClienteRepo := AClienteRepo;
  FProdutoRepo := AProdutoRepo;
end;

function TPedidoService.GravarPedido(const ANumeroPedido: Integer; const ACodCliente: Integer;
  const AObservacao: string; AItens: TDataSet;AItensDeletados: TDataSet): Integer;
var
  Conn: TFDConnection;
  Pedido: TPedido;
  Item: TPedidoItem;
  Total: Double;
  CodProd: Integer;
  Qtd, VUnit: Double;
  ItemID: Integer;
begin
  Result := 0;

  if ACodCliente <= 0 then
    raise Exception.Create('Informe um cliente válido.');

  if (AItens = nil) or (AItens.IsEmpty) then
    raise Exception.Create('Informe ao menos um item.');

  var Cli := FClienteRepo.ObterPorCodigo(ACodCliente);
  try
    if not Assigned(Cli) then
      raise Exception.Create('Cliente não encontrado.');
  finally
    Cli.Free;
  end;

  Conn := FConnectionManager.Connection;

  Conn.StartTransaction;
  try
    if ANumeroPedido > 0 then
      Pedido := TPedido.Carregar(ANumeroPedido, Date, ACodCliente, 0, AObservacao)
    else
      Pedido := TPedido.Criar(ACodCliente, AObservacao);

    try
      if Pedido.NumeroPedido <= 0 then
        Pedido.NumeroPedido := FPedidoRepo.ProximoNumeroPedido;

      // Recalcula total e valida produtos
      Total := 0;
      AItens.DisableControls;
      try
        AItens.First;
        while not AItens.Eof do
        begin
          CodProd := AItens.FieldByName('idproduto').AsInteger;
          Qtd := AItens.FieldByName('quantidade').AsFloat;
          VUnit := AItens.FieldByName('vlrunitario').AsFloat;

          if CodProd <= 0 then
            raise Exception.Create('Item com produto inválido.');
          if Qtd <= 0 then
            raise Exception.Create('Quantidade deve ser maior que zero.');
          if VUnit < 0 then
            raise Exception.Create('Valor unitário inválido.');

          var Prod := FProdutoRepo.ObterPorCodigo(CodProd);
          try
            if not Assigned(Prod) then
              raise Exception.Create(Format('Produto %d não encontrado.', [CodProd]));
          finally
            Prod.Free;
          end;

          Total := Total + (Qtd * VUnit);
          AItens.Next;
        end;
      finally
        AItens.EnableControls;
      end;

      Pedido.ValorTotal := Total;

      // Se for novo: insere cabeçalho
      // Se for existente: atualiza total/obs
      if ANumeroPedido = 0 then
        FPedidoRepo.InserirCabecalho(Pedido)
      else
        FPedidoRepo.AtualizarTotalEObs(Pedido.NumeroPedido, Pedido.ValorTotal, Pedido.Observacao);

      // Exclui itens marcados no cdsProdDel
      if Assigned(AItensDeletados) and not AItensDeletados.IsEmpty then
      begin
        AItensDeletados.DisableControls;
        try
          AItensDeletados.First;
          while not AItensDeletados.Eof do
          begin
            ItemID := AItensDeletados.FieldByName('idpeditem').AsInteger;
            if ItemID > 0 then
              FItemRepo.ExcluirItemPorID(ItemID);

            AItensDeletados.Next;
          end;
        finally
          AItensDeletados.EnableControls;
        end;
      end;

      // Insere itens NOVOS
      AItens.DisableControls;
      try
        AItens.First;
        while not AItens.Eof do
        begin
          ItemID := AItens.FieldByName('idpeditem').AsInteger;

          if ItemID <= 0 then
          begin
            CodProd := AItens.FieldByName('idproduto').AsInteger;
            Qtd := AItens.FieldByName('quantidade').AsFloat;
            VUnit := AItens.FieldByName('vlrunitario').AsFloat;

            Item := TPedidoItem.Criar(CodProd, Qtd, VUnit);
            try
              Item.NumeroPedido := Pedido.NumeroPedido;
              FItemRepo.InserirItem(Item);
            finally
              Item.Free;
            end;
          end;

          AItens.Next;
        end;
      finally
        AItens.EnableControls;
      end;

      Conn.Commit;
      Result := Pedido.NumeroPedido;
    finally
      Pedido.Free;
    end;
  except
    Conn.Rollback;
    raise;
  end;
end;

procedure TPedidoService.CancelarPedido(const ANumero: Integer);
var
  Conn: TFDConnection;
begin
  if ANumero <= 0 then
    Exit;

  Conn := FConnectionManager.Connection;
  Conn.StartTransaction;
  try
    // se FK estiver ON DELETE CASCADE, pode excluir só o pedido.
    // mas deixo explícito porque nem sempre o banco garante.
    FItemRepo.ExcluirItensPorPedido(ANumero);
    FPedidoRepo.ExcluirPedido(ANumero);

    Conn.Commit;
  except
    Conn.Rollback;
    raise;
  end;
end;

procedure TPedidoService.CarregarPedido(const ANumero: Integer; out APedido: TPedido; out AItens: TClientDataSet);
var
  Pedido: TPedido;
  ItensObj: TObjectList<TPedidoItem>;
  CDS: TClientDataSet;
  Item: TPedidoItem;
  Prod: TProduto;
begin
  APedido := nil;

  if ANumero <= 0 then
    raise Exception.Create('Informe um número de pedido válido.');

  Pedido := FPedidoRepo.CarregarCabecalho(ANumero);
  if not Assigned(Pedido) then
    raise Exception.Create('Pedido não encontrado.');

  ItensObj := FItemRepo.CarregarItens(ANumero);
  try
    if not (AItens is TClientDataSet) then
      raise Exception.Create('Dataset de itens precisa ser TClientDataSet.');

    CDS := TClientDataSet(AItens);

    CDS.DisableControls;
    try
      CDS.Close;
      CDS.Open;

      CDS.EmptyDataSet;

      for Item in ItensObj do
      begin
        Prod := FProdutoRepo.ObterPorCodigo(Item.CodigoProduto);
        try
          CDS.Append;
          CDS.FieldByName('idpeditem').AsInteger := Item.ID;
          CDS.FieldByName('idpedgeral').AsInteger := ANumero;
          CDS.FieldByName('idproduto').AsInteger := Item.CodigoProduto;

          if Assigned(Prod) then
            CDS.FieldByName('descricao').AsString := Prod.Descricao
          else
            CDS.FieldByName('descricao').AsString := '';

          CDS.FieldByName('quantidade').AsFloat := Item.Quantidade;
          CDS.FieldByName('vlrunitario').AsFloat := Item.VlrUnitario;
          CDS.FieldByName('vlrtotal').AsFloat := Item.VlrTotal;

          CDS.Post;
        finally
          Prod.Free;
        end;
      end;
    finally
      CDS.EnableControls;
    end;

    APedido := Pedido;
  finally
    ItensObj.Free; // TObjectList criada como OwnsObjects=True no repo (se você fez assim)
    // se o repo não usa OwnsObjects=True, me avisa que ajusto aqui
  end;
end;

end.
