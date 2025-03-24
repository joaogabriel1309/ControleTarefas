object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Controlador de tarefas'
  ClientHeight = 406
  ClientWidth = 798
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 14
  object StringGridPrincipal: TStringGrid
    Left = 139
    Top = 105
    Width = 657
    Height = 301
    ColCount = 3
    DrawingStyle = gdsGradient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    TabOrder = 0
    ColWidths = (
      64
      424
      139)
    RowHeights = (
      24
      24)
  end
  object GroupBoxGeral: TGroupBox
    Left = 139
    Top = 0
    Width = 656
    Height = 105
    TabOrder = 1
    object Label1: TLabel
      Left = 34
      Top = 12
      Width = 43
      Height = 14
      Caption = 'Usu'#225'rio'
    end
    object Label2: TLabel
      Left = 16
      Top = 59
      Width = 47
      Height = 14
      Caption = 'Situa'#231#227'o'
    end
    object ImageUsuario: TImage
      Left = 3
      Top = 31
      Width = 25
      Height = 25
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
        00180806000000E0773DF80000000970485973000000B1000000B101C62D498D
        0000001974455874536F667477617265007777772E696E6B73636170652E6F72
        679BEE3C1A0000020B4944415478DAD595BF4B234114C7BFB3892682C6CA6B6C
        AC35519BE3B411C99D918DA6B048E39527E1105138FF8D034511F16777360145
        63D4440376FEE00A0F542C6D0EC1CE44C87A2499FBE6879AA09B8D1A110766F7
        BD9979EFF3DECCDB5981576EE2ED00AE1E3B8418E0922FD41A72A3E780DC8194
        F308078F9F07F07A2B71A58D71E63B3545C72E49D0346C55A3F0FBFF950E483B
        8F699B907052BBE17B868C25209E8BB6CA0E25F595E33E2A16F6086C56773148
        21C0E599E2C8201DFC85903D08ADFF79D4AACBDD0A615AE7DA7AF6496C05868D
        01993D578E282598FE275DE7F910C5B44FC9CCDE8250E0A438A0BB779CEA08A3
        9F40383052CA01D266923643F432C62C7E18003CE9081A73D11F9604503D6D48
        618FD23133701801627C56E3C65A835DFF7549804E6F352C5ADA2E4680CD0810
        E5B3E6490055B52165BEA21425A0F6ADB72877C8066557D09E74C8F9659A4AB6
        617BE3A8A8F36C991E503241519AB1B97A5A1C901F51FA4393C95E5DC8BDF34A
        AE9F4368CDA717C7C3AB22AA6D50FACCCECF5FCE4211BF10B766AF0A6BDC4178
        3FCD7C59E7191727902627C22B97C6805B484CFB49478399F41F6FBCECC4226F
        D5767AB0533F032A9C082D5F1803EEB6CBD3C4D96F0475A1E0BA166166B590D9
        7355AD43D21CE13A871EE4E53F1C034879FE68AEBE0F1089082556227EB3643F
        9617700B5112414811675575941FA0D3DE3FE03F09D1C119ABD6921C00000000
        49454E44AE426082}
      OnClick = ImageUsuarioClick
    end
    object EditNomeUsuario: TEdit
      Left = 96
      Top = 32
      Width = 545
      Height = 22
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object EditCodUsuario: TEdit
      Left = 34
      Top = 32
      Width = 57
      Height = 22
      NumbersOnly = True
      TabOrder = 1
      OnExit = EditCodUsuarioExit
    end
    object ComboBoxSituacao: TComboBox
      Left = 16
      Top = 77
      Width = 105
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = 'Todas'
      Items.Strings = (
        'Todas'
        'Di'#225'ria'
        'Semana'
        'Quinzenal'
        'Mensal')
    end
    object ButtonBuscar: TButton
      Left = 566
      Top = 77
      Width = 75
      Height = 25
      Caption = 'Buscar'
      TabOrder = 3
      OnClick = ButtonBuscarClick
    end
  end
  object PanelMenu: TPanel
    Left = 0
    Top = 0
    Width = 139
    Height = 406
    Align = alLeft
    TabOrder = 2
    object Label3: TLabel
      Left = 43
      Top = 11
      Width = 45
      Height = 23
      Caption = 'Menu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object ButtonUsuario: TButton
      Left = 0
      Top = 47
      Width = 137
      Height = 25
      Caption = 'Usu'#225'rio'
      TabOrder = 0
      OnClick = ButtonUsuarioClick
    end
    object ButtonTarefa: TButton
      Left = 0
      Top = 80
      Width = 137
      Height = 25
      Caption = 'Tarefas'
      TabOrder = 1
      OnClick = ButtonTarefaClick
    end
    object ButtonSair: TButton
      Left = 0
      Top = 373
      Width = 137
      Height = 25
      Caption = 'Sair'
      TabOrder = 2
      OnClick = ButtonSairClick
    end
    object ButtonUsuarioTarefa: TButton
      Left = 0
      Top = 113
      Width = 137
      Height = 25
      Caption = 'Atribuir tarefas'
      TabOrder = 3
      OnClick = ButtonUsuarioTarefaClick
    end
  end
end
