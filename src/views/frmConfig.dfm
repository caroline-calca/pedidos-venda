object fConfig: TfConfig
  Left = 0
  Top = 0
  Caption = '000 - Configura'#231#245'es'
  ClientHeight = 257
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 548
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 19
      Top = 3
      Width = 161
      Height = 35
      Caption = 'Configura'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 548
    Height = 175
    Align = alClient
    TabOrder = 1
    DesignSize = (
      548
      175)
    object Label2: TLabel
      Left = 37
      Top = 17
      Width = 51
      Height = 15
      Caption = 'Database:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 33
      Top = 53
      Width = 55
      Height = 15
      Caption = 'Username:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 291
      Top = 53
      Width = 53
      Height = 15
      Caption = 'Password:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 53
      Top = 93
      Width = 35
      Height = 15
      Caption = 'Server:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 319
      Top = 93
      Width = 25
      Height = 15
      Caption = 'Port:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 20
      Top = 133
      Width = 68
      Height = 15
      Caption = 'ClientLibrary:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object edtDatabase: TEdit
      Left = 94
      Top = 14
      Width = 396
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object edtUsername: TEdit
      Left = 94
      Top = 50
      Width = 171
      Height = 23
      TabOrder = 2
    end
    object edtPassword: TEdit
      Left = 350
      Top = 50
      Width = 171
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object edtServer: TEdit
      Left = 94
      Top = 90
      Width = 171
      Height = 23
      TabOrder = 4
    end
    object edtPort: TEdit
      Left = 350
      Top = 90
      Width = 171
      Height = 23
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      TabOrder = 5
    end
    object edtClientLibrary: TEdit
      Left = 94
      Top = 130
      Width = 396
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
    end
    object btnDB: TBitBtn
      Left = 496
      Top = 12
      Width = 25
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #55357#56514
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = btnDBClick
    end
    object btnClientLibrary: TBitBtn
      Left = 496
      Top = 128
      Width = 25
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #55357#56514
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = btnClientLibraryClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 216
    Width = 548
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      548
      41)
    object btnCancelar: TButton
      Left = 334
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCancelarClick
    end
    object btnSalvar: TButton
      Left = 440
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Salvar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnSalvarClick
    end
    object btnTestarConexao: TBitBtn
      Left = 303
      Top = 8
      Width = 25
      Height = 25
      Hint = 'Testar conex'#227'o'
      Anchors = [akTop, akRight]
      Caption = #55357#57052
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnTestarConexaoClick
    end
  end
  object odgDB: TOpenDialog
    Filter = 'Firebird Database (*.fdb)|*.fdb'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 448
    Top = 33
  end
  object odgClientLibrary: TOpenDialog
    Filter = 'Firebird Client (fbclient.dll)|fbclient.dll'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 440
    Top = 168
  end
end
