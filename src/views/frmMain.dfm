object fMain: TfMain
  Left = 0
  Top = 0
  Caption = '001 - Pedidos de Venda'
  ClientHeight = 571
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      585
      41)
    object Label1: TLabel
      Left = 19
      Top = 3
      Width = 202
      Height = 35
      Caption = 'Pedidos de Venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object btnCarregar: TButton
      Left = 378
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Carregar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCarregarClick
    end
    object btnCancelar: TButton
      Left = 459
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnConfigurar: TBitBtn
      Left = 540
      Top = 10
      Width = 25
      Height = 25
      Hint = 'Configura'#231#245'es'
      Anchors = [akTop, akRight]
      Caption = #9881#65039
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnConfigurarClick
    end
    object btnNovo: TButton
      Left = 297
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Novo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnNovoClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 585
    Height = 489
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 410
    DesignSize = (
      585
      489)
    object Label2: TLabel
      Left = 41
      Top = 17
      Width = 39
      Height = 15
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 34
      Top = 87
      Width = 46
      Height = 15
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 15
      Top = 122
      Width = 65
      Height = 15
      Caption = 'Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 215
      Top = 122
      Width = 73
      Height = 15
      Caption = 'Valor unit'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 15
      Top = 52
      Width = 65
      Height = 15
      Caption = 'Observa'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object btnAdicionar: TButton
      Left = 425
      Top = 118
      Width = 135
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Adicionar Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = btnAdicionarClick
    end
    object dbgProdutos: TDBGrid
      Left = 5
      Top = 160
      Width = 572
      Height = 324
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      DataSource = dsProdutos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnKeyDown = dbgProdutosKeyDown
    end
    object edtIdCliente: TEdit
      Left = 86
      Top = 14
      Width = 68
      Height = 23
      NumbersOnly = True
      TabOrder = 0
      OnExit = edtIdClienteExit
    end
    object edtIdProduto: TEdit
      Left = 86
      Top = 84
      Width = 68
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 2
      OnChange = edtIdProdutoChange
      OnExit = edtIdProdutoExit
    end
    object edtQtd: TEdit
      Left = 86
      Top = 119
      Width = 110
      Height = 23
      Alignment = taRightJustify
      MaxLength = 17
      NumbersOnly = True
      TabOrder = 3
      Text = '0,00'
      OnExit = edtQtdExit
    end
    object edtValor: TEdit
      Left = 294
      Top = 119
      Width = 110
      Height = 23
      Hint = 'Preencha apenas com n'#250'meros.'
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 17
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = '0,00'
      OnExit = edtValorExit
    end
    object edtNomeCliente: TEdit
      Left = 160
      Top = 14
      Width = 242
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Color = cl3DLight
      Enabled = False
      TabOrder = 7
    end
    object edtDescProduto: TEdit
      Left = 160
      Top = 84
      Width = 400
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Color = cl3DLight
      Enabled = False
      TabOrder = 8
    end
    object edtCidadeCliente: TEdit
      Left = 408
      Top = 14
      Width = 114
      Height = 23
      Anchors = [akTop, akRight]
      Color = cl3DLight
      Enabled = False
      TabOrder = 9
    end
    object edtUFCliente: TEdit
      Left = 528
      Top = 14
      Width = 32
      Height = 23
      Anchors = [akTop, akRight]
      Color = cl3DLight
      Enabled = False
      TabOrder = 10
    end
    object edtObservacao: TEdit
      Left = 86
      Top = 49
      Width = 474
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 255
      TabOrder = 1
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 530
    Width = 585
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 451
    DesignSize = (
      585
      41)
    object Label6: TLabel
      Left = 19
      Top = 12
      Width = 104
      Height = 19
      Caption = 'Total do Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object lblTotal: TLabel
      Left = 129
      Top = 12
      Width = 49
      Height = 19
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object btnGravar: TButton
      Left = 490
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Gravar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnGravarClick
    end
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 217
    object cdsProdutosidpeditem: TIntegerField
      FieldName = 'idpeditem'
      Visible = False
    end
    object cdsProdutosidpedgeral: TIntegerField
      FieldName = 'idpedgeral'
      Visible = False
    end
    object cdsProdutosidproduto: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'idproduto'
    end
    object cdsProdutosdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 45
      FieldName = 'descricao'
      Size = 150
    end
    object cdsProdutosquantidade: TIntegerField
      DisplayLabel = 'Qtd.'
      FieldName = 'quantidade'
    end
    object cdsProdutosvlrunitario: TFloatField
      DisplayLabel = 'Valor Unit.'
      FieldName = 'vlrunitario'
      DisplayFormat = '#,###,###,##0.00'
      EditFormat = '#,###,###,##0.00'
    end
    object cdsProdutosvlrtotal: TFloatField
      DisplayLabel = 'Total'
      FieldName = 'vlrtotal'
      DisplayFormat = '#,###,###,##0.00'
    end
  end
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 40
    Top = 217
  end
  object cdsProdDel: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 273
    object cdsProdDelidpeditem: TIntegerField
      FieldName = 'idpeditem'
    end
  end
end
