object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 205
  Width = 441
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    HostName = 'localhost'
    Port = 1433
    Database = 'Vendas'
    User = 'SA'
    Password = ''
    Protocol = 'mssql'
    LibraryLocation = 'C:\Desenvolvimento\repositorio\ProjetoVendas\ntwdblib.dll'
    Left = 24
    Top = 16
  end
  object QryScriptCategorias: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID('#39'Categorias'#39') IS NULL BEGIN'
      #9'CREATE TABLE Categorias ('
      #9#9'categoriaId INT IDENTITY(1,1) NOT NULL,'
      #9#9'descricao VARCHAR(30) NULL,'
      #9#9'PRIMARY KEY(categoriaId)'
      #9')'
      'END')
    Params = <>
    Left = 184
    Top = 16
  end
  object QryScriptClientes: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID('#39'Clientes'#39') IS NULL BEGIN'
      #9'CREATE TABLE Clientes ('
      #9#9'clienteId INT IDENTITY(1,1) NOT NULL,'
      #9#9'nome VARCHAR(60) NULL,'
      #9#9'endereco VARCHAR(60) NULL,'
      #9#9'cidade VARCHAR(50) NULL,'
      #9#9'bairro VARCHAR(40) NULL,'
      #9#9'estado VARCHAR(2) NULL,'
      #9#9'cep VARCHAR(10) NULL,'
      #9#9'telefone VARCHAR(14) NULL,'
      #9#9'email VARCHAR(100) NULL,'
      #9#9'dataNascimento DATETIME NULL,'
      #9#9'PRIMARY KEY(clienteId)'
      #9')'
      'END')
    Params = <>
    Left = 280
    Top = 16
  end
  object QryScriptProdutos: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID('#39'Produtos'#39') IS NULL BEGIN'
      #9'CREATE TABLE Produtos ('
      #9#9'produtoId INT IDENTITY(1,1) NOT NULL,'
      #9#9'nome VARCHAR(60) NULL,'
      #9#9'descricao VARCHAR(255) NULL,'
      #9#9'valor DECIMAL(18,5) DEFAULT 0.00000 NULL,'
      #9#9'quantidade DECIMAL(18,5) DEFAULT 0.00000 NULL,'
      #9#9'categoriaId INT NULL,'
      #9#9'PRIMARY KEY(produtoId),'
      #9#9'CONSTRAINT FK_ProdutosCategorias'
      #9#9'FOREIGN KEY(categoriaId) REFERENCES Categorias(categoriaId)'
      #9')'
      'END')
    Params = <>
    Left = 368
    Top = 16
  end
  object QryScriptVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID('#39'Vendas'#39') IS NULL BEGIN'
      #9'CREATE TABLE Vendas ('
      #9#9'vendaId INT IDENTITY(1,1) NOT NULL,'
      #9#9'clienteId INT NOT NULL,'
      #9#9'dataVenda DATETIME DEFAULT GETDATE(),'
      #9#9'totalVenda DECIMAL(18,5) DEFAULT 0.00000,'
      #9#9'PRIMARY KEY(vendaId),'
      #9#9'CONSTRAINT FK_VendasClientes FOREIGN KEY(clienteId)'
      #9#9'REFERENCES Clientes(clienteId)'
      #9')'
      'END')
    Params = <>
    Left = 184
    Top = 72
  end
  object QryScriptItensVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID('#39'VendasItens'#39') IS NULL BEGIN'
      #9'CREATE TABLE VendasItens ('
      #9#9'vendaId INT NOT NULL,'
      #9#9'produtoId INT NOT NULL,'
      #9#9'valorUnitario DECIMAL(18,5) DEFAULT 0.00000,'
      #9#9'quantidade DECIMAL(18,5) DEFAULT 0.00000,'
      #9#9'totalProduto DECIMAL(18,5) DEFAULT 0.00000,'
      #9#9'PRIMARY KEY(vendaId, produtoId),'
      #9#9'CONSTRAINT FK_VendasItensProdutos FOREIGN KEY(produtoId)'
      #9#9'REFERENCES Produtos(produtoId)'
      #9')'
      'END')
    Params = <>
    Left = 280
    Top = 72
  end
  object QryScriptUsuarios: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID('#39'Usuarios'#39') IS NULL '
      'BEGIN'
      #9'CREATE TABLE Usuarios ('
      #9#9'usuarioId INT IDENTITY(1,1) NOT NULL,'
      #9#9'nome VARCHAR(50) NOT NULL,'
      #9#9'senha VARCHAR(40) NOT NULL'
      ''
      #9#9'PRIMARY KEY(usuarioId)'
      #9')'
      'END')
    Params = <>
    Left = 368
    Top = 72
  end
end
