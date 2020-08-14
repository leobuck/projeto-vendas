object dtmVenda: TdtmVenda
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 192
  Width = 274
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT clienteId,'
      '       nome'
      'FROM   Clientes')
    Params = <>
    Left = 40
    Top = 24
    object QryClienteclienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object QryClientenome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT produtoId,'
      '       nome,'
      #9'valor,'
      #9'quantidade'
      'FROM   Produtos')
    Params = <>
    Left = 120
    Top = 25
    object QryProdutosprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryProdutosnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryProdutosvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object QryProdutosquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 25
    object cdsItensVendaprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
    end
    object cdsItensVendanomeProduto: TStringField
      DisplayLabel = 'Nome Produto'
      FieldName = 'nomeProduto'
      Size = 60
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsItensVendavalorUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'valorUnitario'
    end
    object cdsItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'Total Produto'
      FieldName = 'valorTotalProduto'
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 40
    Top = 104
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
    Left = 122
    Top = 104
  end
  object dtsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 208
    Top = 104
  end
end
