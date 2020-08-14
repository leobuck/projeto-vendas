IF OBJECT_ID('Categorias') IS NULL BEGIN
	CREATE TABLE Categorias (
		categoriaId INT IDENTITY(1,1) NOT NULL,
		descricao VARCHAR(30) NULL,
		PRIMARY KEY(categoriaId)
	)
END

IF OBJECT_ID('Clientes') IS NULL BEGIN
	CREATE TABLE Clientes (
		clienteId INT IDENTITY(1,1) NOT NULL,
		nome VARCHAR(60) NULL,
		endereco VARCHAR(60) NULL,
		cidade VARCHAR(50) NULL,
		bairro VARCHAR(40) NULL,
		estado VARCHAR(2) NULL,
		cep VARCHAR(10) NULL,
		telefone VARCHAR(14) NULL,
		email VARCHAR(100) NULL,
		dataNascimento DATETIME NULL,
		PRIMARY KEY(clienteId)
	)
END

IF OBJECT_ID('Produtos') IS NULL BEGIN
	CREATE TABLE Produtos (
		produtoId INT IDENTITY(1,1) NOT NULL,
		nome VARCHAR(60) NULL,
		descricao VARCHAR(255) NULL,
		valor DECIMAL(18,5) DEFAULT 0.00000 NULL,
		quantidade DECIMAL(18,5) DEFAULT 0.00000 NULL,
		categoriaId INT NULL,
		PRIMARY KEY(produtoId),
		CONSTRAINT FK_ProdutosCategorias
		FOREIGN KEY(categoriaId) REFERENCES Categorias(categoriaId)
	)
END

IF OBJECT_ID('Vendas') IS NULL BEGIN
	CREATE TABLE Vendas (
		vendaId INT IDENTITY(1,1) NOT NULL,
		clienteId INT NOT NULL,
		dataVenda DATETIME DEFAULT GETDATE(),
		totalVenda DECIMAL(18,5) DEFAULT 0.00000,
		PRIMARY KEY(vendaId),
		CONSTRAINT FK_VendasClientes FOREIGN KEY(clienteId)
		REFERENCES Clientes(clienteId)
	)
END

IF OBJECT_ID('VendasItens') IS NULL BEGIN
	CREATE TABLE VendasItens (
		vendaId INT NOT NULL,
		produtoId INT NOT NULL,
		valorUnitario DECIMAL(18,5) DEFAULT 0.00000,
		quantidade DECIMAL(18,5) DEFAULT 0.00000,
		totalProduto DECIMAL(18,5) DEFAULT 0.00000,
		PRIMARY KEY(vendaId, produtoId),
		CONSTRAINT FK_VendasItensProdutos FOREIGN KEY(produtoId)
		REFERENCES Produtos(produtoId)
	)
END