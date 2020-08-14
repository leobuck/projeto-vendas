object frmRelCadCliente: TfrmRelCadCliente
  Left = 0
  Top = 0
  Caption = 'frmRelCadCliente'
  ClientHeight = 518
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dsCliente
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 75
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 0
        Top = 24
        Width = 205
        Height = 24
        Caption = 'Listagem de Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 48
        Width = 718
        Height = 27
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
    end
    object Rodape: TRLBand
      Left = 38
      Top = 158
      Width = 718
      Height = 48
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 27
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 3
        Top = 24
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 650
        Top = 24
        Width = 25
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 690
        Top = 24
        Width = 25
        Height = 16
        Info = itLastPageNumber
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 678
        Top = 24
        Width = 10
        Height = 16
        Alignment = taCenter
        Caption = '/'
      end
      object RLLabel3: TRLLabel
        Left = 600
        Top = 24
        Width = 48
        Height = 16
        Caption = 'P'#225'gina:'
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 133
      Width = 718
      Height = 25
      object RLDBText1: TRLDBText
        Left = 3
        Top = 6
        Width = 52
        Height = 16
        DataField = 'clienteId'
        DataSource = dsCliente
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 76
        Top = 6
        Width = 36
        Height = 16
        DataField = 'nome'
        DataSource = dsCliente
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 304
        Top = 6
        Width = 44
        Height = 16
        DataField = 'email'
        DataSource = dsCliente
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 655
        Top = 6
        Width = 60
        Height = 16
        Alignment = taRightJustify
        DataField = 'telefone'
        DataSource = dsCliente
        Text = ''
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 113
      Width = 718
      Height = 20
      BandType = btColumnHeader
      object RLPanel1: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 20
        Align = faClient
        Color = clInfoBk
        ParentColor = False
        Transparent = False
        object RLLabel4: TRLLabel
          Left = 2
          Top = 1
          Width = 49
          Height = 16
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel6: TRLLabel
          Left = 304
          Top = 1
          Width = 44
          Height = 16
          Caption = 'E-mail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel7: TRLLabel
          Left = 655
          Top = 1
          Width = 60
          Height = 16
          Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLLabel5: TRLLabel
        Left = 76
        Top = 1
        Width = 41
        Height = 16
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT Clientes.clienteId,'
      '       Clientes.nome,'
      '       Clientes.email,'
      '       Clientes.telefone'
      'FROM   Clientes'
      'ORDER BY Clientes.nome')
    Params = <>
    Left = 592
    Top = 8
    object QryClienteclienteId: TIntegerField
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object QryClientenome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryClienteemail: TWideStringField
      FieldName = 'email'
      Size = 100
    end
    object QryClientetelefone: TWideStringField
      FieldName = 'telefone'
      Size = 14
    end
  end
  object dsCliente: TDataSource
    DataSet = QryCliente
    Left = 664
    Top = 8
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 712
    Top = 64
  end
end
