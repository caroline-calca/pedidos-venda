object fMain: TfMain
  Left = 0
  Top = 0
  Caption = '001 - Pedidos de Venda'
  ClientHeight = 492
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 580
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 584
    DesignSize = (
      580
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
      Left = 323
      Top = 10
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Carregar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 367
    end
    object btnCancelar: TButton
      Left = 429
      Top = 10
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancelar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 473
    end
    object btnConfigurar: TBitBtn
      Left = 535
      Top = 10
      Width = 25
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #9881#65039
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ModalResult = 12
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 580
    Height = 410
    Align = alClient
    TabOrder = 1
    ExplicitTop = 12
    ExplicitWidth = 584
    ExplicitHeight = 429
    DesignSize = (
      580
      410)
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
      Top = 53
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
      Top = 88
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
      Top = 88
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
    object btnAdicionar: TButton
      Left = 425
      Top = 83
      Width = 135
      Height = 25
      Caption = 'Adicionar Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object dbgProdutos: TDBGrid
      Left = 5
      Top = 120
      Width = 567
      Height = 285
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      DataSource = dsProdutos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
    object edtIdCliente: TEdit
      Left = 86
      Top = 14
      Width = 68
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 0
    end
    object edtIdProduto: TEdit
      Left = 86
      Top = 50
      Width = 68
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 1
    end
    object edtQtd: TEdit
      Left = 86
      Top = 85
      Width = 110
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 2
      Text = '0'
    end
    object edtValor: TEdit
      Left = 294
      Top = 85
      Width = 110
      Height = 23
      Hint = 'Preencha apenas com n'#250'meros.'
      Alignment = taRightJustify
      MaxLength = 12
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '0,00'
    end
    object edtNomeCliente: TEdit
      Left = 160
      Top = 14
      Width = 400
      Height = 23
      Color = cl3DLight
      Enabled = False
      TabOrder = 6
    end
    object edtDescProduto: TEdit
      Left = 160
      Top = 50
      Width = 400
      Height = 23
      Color = cl3DLight
      Enabled = False
      TabOrder = 7
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 451
    Width = 580
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 400
    ExplicitWidth = 584
    DesignSize = (
      580
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
      Left = 460
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Gravar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 464
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
      DisplayLabel = 'Id'
      FieldName = 'idproduto'
      Visible = False
    end
    object cdsProdutosdescricao: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 55
      FieldName = 'descricao'
      Size = 150
    end
    object cdsProdutosquantidade: TIntegerField
      DisplayLabel = 'Quantidade'
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
