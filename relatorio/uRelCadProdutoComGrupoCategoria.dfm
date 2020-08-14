object frmRelCadProdutoComGrupoCategoria: TfrmRelCadProdutoComGrupoCategoria
  Left = 0
  Top = 0
  Caption = 'frmRelCadProdutoComGrupoCategoria'
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
    DataSource = dsProdutos
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
        Width = 372
        Height = 24
        Caption = 'Listagem de Produtos por Categoria'
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
      Top = 321
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
      DataFields = 'CategoriaId'
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
          Width = 84
          Height = 16
          Caption = 'CATEGORIA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText5: TRLDBText
          Left = 91
          Top = 3
          Width = 25
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'CategoriaId'
          DataSource = dsProdutos
          Text = ''
        end
        object RLDBText6: TRLDBText
          Left = 132
          Top = 3
          Width = 117
          Height = 16
          DataField = 'DescricaoCategoria'
          DataSource = dsProdutos
          Text = ''
        end
        object RLLabel9: TRLLabel
          Left = 120
          Top = 3
          Width = 8
          Height = 16
          Alignment = taCenter
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Layout = tlCenter
          ParentFont = False
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
            Width = 115
            Height = 16
            Caption = 'Nome do Produto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLLabel7: TRLLabel
            Left = 675
            Top = 1
            Width = 38
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object RLLabel5: TRLLabel
          Left = 476
          Top = 1
          Width = 152
          Height = 16
          Caption = 'Quantidade de Estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
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
          Width = 57
          Height = 16
          DataField = 'produtoId'
          DataSource = dsProdutos
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 76
          Top = 6
          Width = 38
          Height = 16
          DataField = 'Nome'
          DataSource = dsProdutos
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 558
          Top = 6
          Width = 70
          Height = 16
          Alignment = taRightJustify
          DataField = 'Quantidade'
          DataSource = dsProdutos
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 679
          Top = 6
          Width = 34
          Height = 16
          Alignment = taRightJustify
          DataField = 'Valor'
          DataSource = dsProdutos
          Text = ''
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 82
        Width = 718
        Height = 55
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 607
          Top = 12
          Width = 109
          Height = 16
          Alignment = taRightJustify
          DataField = 'Quantidade'
          DataSource = dsProdutos
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 360
          Top = 3
          Width = 358
          Height = 9
          DrawKind = dkLine
        end
        object RLLabel10: TRLLabel
          Left = 360
          Top = 12
          Width = 243
          Height = 16
          Caption = 'Quantidade de Estoque por Categoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel11: TRLLabel
          Left = 411
          Top = 34
          Width = 192
          Height = 16
          Caption = 'M'#233'dia do Valor por Categoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBResult2: TRLDBResult
          Left = 607
          Top = 34
          Width = 109
          Height = 16
          Alignment = taRightJustify
          DataField = 'Valor'
          DataSource = dsProdutos
          Info = riAverage
          Text = ''
        end
      end
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT Produtos.produtoId,'
      '             Produtos.Nome,'
      '             Produtos.Descricao,'
      '             Produtos.Valor,'
      '             Produtos.Quantidade,'
      '             Produtos.CategoriaId,'
      '             Categorias.Descricao AS DescricaoCategoria'
      'FROM   Produtos'
      
        'LEFT JOIN Categorias ON Categorias.CategoriaId = Produtos.Catego' +
        'riaId'
      'ORDER BY Produtos.CategoriaId, Produtos.ProdutoId')
    Params = <>
    Left = 648
    Top = 312
    object QryProdutosprodutoId: TIntegerField
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryProdutosNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
    object QryProdutosValor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '#0.00'
    end
    object QryProdutosQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = '#0.00'
    end
    object QryProdutosDescricao: TWideStringField
      FieldName = 'Descricao'
      Size = 255
    end
    object QryProdutosCategoriaId: TIntegerField
      FieldName = 'CategoriaId'
    end
    object QryProdutosDescricaoCategoria: TWideStringField
      FieldName = 'DescricaoCategoria'
      Size = 30
    end
  end
  object dsProdutos: TDataSource
    DataSet = QryProdutos
    Left = 704
    Top = 312
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
