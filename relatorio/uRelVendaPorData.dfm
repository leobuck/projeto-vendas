object frmRelVendaPorData: TfrmRelVendaPorData
  Left = 0
  Top = 0
  Caption = 'frmRelVendaPorData'
  ClientHeight = 518
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dsVenda
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
        Width = 303
        Height = 24
        Caption = 'Listagem de Vendas por Data'
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
      Top = 405
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
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 113
      Width = 718
      Height = 208
      DataFields = 'dataVenda'
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 33
        BandType = btHeader
        Color = 12369084
        ParentColor = False
        Transparent = False
        object RLLabel8: TRLLabel
          Left = 4
          Top = 3
          Width = 43
          Height = 16
          Caption = 'DATA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText5: TRLDBText
          Left = 53
          Top = 3
          Width = 66
          Height = 16
          DataField = 'dataVenda'
          DataSource = dsVenda
          Text = ''
        end
      end
      object RLBand2: TRLBand
        Left = 0
        Top = 33
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
            Left = 75
            Top = 1
            Width = 110
            Height = 16
            Caption = 'Nome do Cliente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLLabel7: TRLLabel
            Left = 610
            Top = 1
            Width = 103
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor da Venda'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 53
        Width = 718
        Height = 29
        object RLDBText1: TRLDBText
          Left = 3
          Top = 6
          Width = 54
          Height = 16
          DataField = 'ClienteId'
          DataSource = dsVenda
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 76
          Top = 6
          Width = 38
          Height = 16
          DataField = 'Nome'
          DataSource = dsVenda
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 647
          Top = 6
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dsVenda
          Text = ''
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 82
        Width = 718
        Height = 39
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 611
          Top = 12
          Width = 105
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dsVenda
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 448
          Top = 3
          Width = 267
          Height = 9
          DrawKind = dkLine
        end
        object RLLabel10: TRLLabel
          Left = 448
          Top = 12
          Width = 159
          Height = 16
          Caption = 'Total de Venda por Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 321
      Width = 718
      Height = 84
      BandType = btSummary
      object RLDBResult2: TRLDBResult
        Left = 613
        Top = 20
        Width = 105
        Height = 16
        Alignment = taRightJustify
        DataField = 'totalVenda'
        DataSource = dsVenda
        Info = riSum
        Text = ''
      end
      object RLDraw4: TRLDraw
        Left = 451
        Top = 11
        Width = 267
        Height = 9
        DrawKind = dkLine
      end
      object RLLabel5: TRLLabel
        Left = 533
        Top = 20
        Width = 75
        Height = 16
        Caption = 'Total Geral'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object QryVendas: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT Vendas.VendaId,'
      '             Vendas.ClienteId,'
      '             Clientes.Nome,'
      '             Vendas.dataVenda,'
      '             Vendas.totalVenda'
      'FROM   Vendas'
      'INNER JOIN Clientes ON Clientes.ClienteId = Vendas.ClienteId'
      'WHERE Vendas.dataVenda BETWEEN :DataInicio AND :DataFim'
      'ORDER BY Vendas.dataVenda, Vendas.ClienteId')
    Params = <
      item
        DataType = ftDate
        Name = 'DataInicio'
        ParamType = ptInput
        Value = '01/10/2019'
      end
      item
        DataType = ftDate
        Name = 'DataFim'
        ParamType = ptInput
        Value = '31/10/2019'
      end>
    Left = 536
    Top = 360
    ParamData = <
      item
        DataType = ftDate
        Name = 'DataInicio'
        ParamType = ptInput
        Value = '01/10/2019'
      end
      item
        DataType = ftDate
        Name = 'DataFim'
        ParamType = ptInput
        Value = '31/10/2019'
      end>
    object QryVendasVendaId: TIntegerField
      FieldName = 'VendaId'
      ReadOnly = True
    end
    object QryVendasClienteId: TIntegerField
      FieldName = 'ClienteId'
      Required = True
    end
    object QryVendasNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
    object QryVendasdataVenda: TDateTimeField
      FieldName = 'dataVenda'
    end
    object QryVendastotalVenda: TFloatField
      FieldName = 'totalVenda'
    end
  end
  object dsVenda: TDataSource
    DataSet = QryVendas
    Left = 576
    Top = 362
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 672
    Top = 368
  end
end
