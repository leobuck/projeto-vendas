inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de Produto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlRodape: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 319
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoCategoria'
            Width = 196
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 736
      ExplicitHeight = 388
      object Label1: TLabel
        Left = 7
        Top = 101
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label2: TLabel
        Left = 7
        Top = 222
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object Label3: TLabel
        Left = 162
        Top = 222
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label4: TLabel
        Left = 333
        Top = 53
        Width = 47
        Height = 13
        Caption = 'Categoria'
      end
      object edtProdutoId: TLabeledEdit
        Tag = 1
        Left = 7
        Top = 26
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 7
        Top = 72
        Width = 320
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtValor: TCurrencyEdit
        Left = 7
        Top = 241
        Width = 121
        Height = 21
        TabOrder = 4
      end
      object edtQuantidade: TCurrencyEdit
        Left = 162
        Top = 241
        Width = 121
        Height = 21
        DisplayFormat = '0.00;-0.00'
        TabOrder = 5
      end
      object lkpCategoria: TDBLookupComboBox
        Left = 333
        Top = 72
        Width = 308
        Height = 21
        KeyField = 'categoriaId'
        ListField = 'descricao'
        ListSource = dtsCategoria
        TabOrder = 2
      end
      object edtDescricao: TMemo
        Left = 7
        Top = 120
        Width = 634
        Height = 89
        Lines.Strings = (
          'edtDescricao')
        MaxLength = 255
        TabOrder = 3
      end
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'SELECT P.produtoId,'
      '       P.nome,'
      '       P.descricao,'
      '       P.valor,'
      '       P.quantidade,'
      '       P.categoriaId,'
      '       C.descricao AS DescricaoCategoria'
      'FROM   Produtos AS P'
      'LEFT JOIN Categorias AS C ON C.categoriaId = P.categoriaId')
    object qryListagemprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object qryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 255
    end
    object qryListagemvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object qryListagemquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object qryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo Categoria'
      FieldName = 'categoriaId'
    end
    object qryListagemDescricaoCategoria: TWideStringField
      DisplayLabel = 'Descri'#231#227'o Categoria'
      FieldName = 'DescricaoCategoria'
      Size = 30
    end
  end
  object qryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT categoriaId,'
      '       descricao'
      'FROM   Categorias')
    Params = <>
    Left = 688
    Top = 240
    object qryCategoriacategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object qryCategoriadescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  object dtsCategoria: TDataSource
    DataSet = qryCategoria
    Left = 688
    Top = 288
  end
end
