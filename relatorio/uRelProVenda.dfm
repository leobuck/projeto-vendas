object frmRelProVenda: TfrmRelProVenda
  Left = 0
  Top = 0
  Caption = 'frmRelProVenda'
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
        Width = 77
        Height = 24
        Caption = 'VENDA'
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
      Top = 372
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
      DataFields = 'VendaId'
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 27
        BandType = btHeader
        Color = 12369084
        ParentColor = False
        Transparent = False
        object RLLabel8: TRLLabel
          Left = 4
          Top = 3
          Width = 52
          Height = 16
          Caption = 'VENDA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText5: TRLDBText
          Left = 62
          Top = 3
          Width = 51
          Height = 16
          DataField = 'VendaId'
          DataSource = dsVenda
          Text = ''
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 27
        Width = 718
        Height = 26
        object RLDBText1: TRLDBText
          Left = 51
          Top = 3
          Width = 58
          Height = 16
          Alignment = taRightJustify
          DataField = 'ClienteId'
          DataSource = dsVenda
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 125
          Top = 3
          Width = 62
          Height = 16
          DataField = 'Nome'
          DataSource = dsVenda
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 647
          Top = 3
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'dataVenda'
          DataSource = dsVenda
          Text = ''
        end
        object RLLabel6: TRLLabel
          Left = 0
          Top = 3
          Width = 49
          Height = 16
          Caption = 'Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel9: TRLLabel
          Left = 112
          Top = 3
          Width = 9
          Height = 16
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel7: TRLLabel
          Left = 546
          Top = 3
          Width = 98
          Height = 16
          Alignment = taRightJustify
          Caption = 'Data da Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLSubDetail1: TRLSubDetail
        Left = 0
        Top = 53
        Width = 718
        Height = 64
        DataSource = dsVendasItens
        object RLBand2: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 20
          BandType = btHeader
          Color = clInfoBk
          ParentColor = False
          Transparent = False
          object RLLabel10: TRLLabel
            Left = 2
            Top = 0
            Width = 77
            Height = 16
            Caption = 'PRODUTOS'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel11: TRLLabel
            Left = 452
            Top = 0
            Width = 78
            Height = 16
            Alignment = taRightJustify
            Caption = 'Quantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel12: TRLLabel
            Left = 537
            Top = 0
            Width = 92
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor Unit'#225'rio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel13: TRLLabel
            Left = 639
            Top = 0
            Width = 74
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLBand4: TRLBand
          Left = 0
          Top = 20
          Width = 718
          Height = 24
          object RLDBText3: TRLDBText
            Left = 0
            Top = 1
            Width = 59
            Height = 16
            Alignment = taRightJustify
            DataField = 'ProdutoId'
            DataSource = dsVendasItens
            Text = ''
          end
          object RLLabel4: TRLLabel
            Left = 62
            Top = 1
            Width = 9
            Height = 16
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLDBText6: TRLDBText
            Left = 75
            Top = 1
            Width = 38
            Height = 16
            DataField = 'Nome'
            DataSource = dsVendasItens
            Text = ''
          end
          object RLDBText7: TRLDBText
            Left = 460
            Top = 1
            Width = 70
            Height = 16
            Alignment = taRightJustify
            DataField = 'Quantidade'
            DataSource = dsVendasItens
            Text = ''
          end
          object RLDBText8: TRLDBText
            Left = 636
            Top = 1
            Width = 77
            Height = 16
            Alignment = taRightJustify
            DataField = 'TotalProduto'
            DataSource = dsVendasItens
            Text = ''
          end
          object RLDBText9: TRLDBText
            Left = 551
            Top = 1
            Width = 78
            Height = 16
            Alignment = taRightJustify
            DataField = 'ValorUnitario'
            DataSource = dsVendasItens
            Text = ''
          end
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 321
      Width = 718
      Height = 51
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
        Left = 509
        Top = 20
        Width = 101
        Height = 16
        Caption = 'Total da Venda'
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
    Active = True
    SQL.Strings = (
      'SELECT Vendas.VendaId,'
      '             Vendas.ClienteId,'
      '             Clientes.Nome,'
      '             Vendas.dataVenda,'
      '             Vendas.totalVenda'
      'FROM   Vendas'
      'INNER JOIN Clientes ON Clientes.ClienteId = Vendas.ClienteId'
      'WHERE Vendas.vendaId = :vendaId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = '1'
      end>
    Left = 536
    Top = 360
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = '1'
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
      DisplayFormat = 'dd/mm/yyyy'
    end
    object QryVendastotalVenda: TFloatField
      FieldName = 'totalVenda'
      DisplayFormat = '#0.00'
    end
  end
  object dsVenda: TDataSource
    DataSet = QryVendas
    Left = 576
    Top = 360
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 672
    Top = 368
  end
  object QryVendasItens: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT VendasItens.VendaId,'
      '             VendasItens.ProdutoId,'
      '             Produtos.Nome,'
      '             VendasItens.Quantidade,'
      '             VendasItens.ValorUnitario,'
      '             VendasItens.TotalProduto'
      'FROM   VendasItens'
      
        'INNER JOIN Produtos ON Produtos.ProdutoId = VendasItens.ProdutoI' +
        'd'
      'WHERE VendasItens.vendaId = :vendaId'
      'ORDER BY VendasItens.ProdutoId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = '1'
      end>
    Left = 536
    Top = 408
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = '1'
      end>
    object QryVendasItensVendaId: TIntegerField
      FieldName = 'VendaId'
      Required = True
    end
    object QryVendasItensProdutoId: TIntegerField
      FieldName = 'ProdutoId'
      Required = True
    end
    object QryVendasItensNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
    object QryVendasItensQuantidade: TFloatField
      FieldName = 'Quantidade'
      Required = True
    end
    object QryVendasItensValorUnitario: TFloatField
      FieldName = 'ValorUnitario'
      Required = True
    end
    object QryVendasItensTotalProduto: TFloatField
      FieldName = 'TotalProduto'
      Required = True
    end
  end
  object dsVendasItens: TDataSource
    DataSet = QryVendasItens
    Left = 576
    Top = 408
  end
end
