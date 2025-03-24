object TfrmPesquisaUsuario: TTfrmPesquisaUsuario
  Left = 449
  Top = 212
  BorderStyle = bsToolWindow
  Caption = 'Pesquisa us'#250'ario'
  ClientHeight = 344
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = []
  Position = poDesigned
  OnShow = FormShow
  TextHeight = 14
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 469
    Height = 81
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 624
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 50
      Height = 14
      Caption = 'Pesquisa'
    end
    object EditPesquisa: TEdit
      Left = 16
      Top = 32
      Width = 353
      Height = 22
      TabOrder = 0
    end
    object ButtonPesquisa: TButton
      Left = 381
      Top = 31
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = ButtonPesquisaClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 81
    Width = 469
    Height = 257
    Align = alTop
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Calibri'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Title.Caption = 'Nome'
        Width = 346
        Visible = True
      end>
  end
  object FDQuery: TFDQuery
    Connection = Tconexao.FDConnection
    Left = 320
    Top = 208
  end
  object DataSource1: TDataSource
    DataSet = FDQuery
    Left = 272
    Top = 144
  end
end
