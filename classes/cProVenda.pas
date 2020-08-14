unit cProVenda;

interface

uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZAbstractDataset,
     ZDataset,
     System.SysUtils,
     Data.DB,
     Datasnap.DBClient,
     uEnum,
     cControleEstoque;

type
  TVenda = class
    private
      ConexaoDB: TZConnection;
      F_vendaId: Integer;
      F_clienteId: Integer;
      F_dataVenda: TDateTime;
      F_totalVenda: Double;
      function InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;
      function ApagaItens(cds: TClientDataSet): Boolean;
      function InNot(cds: TClientDataSet): String;
      function EsteItemExiste(vendaId, produtoId: Integer): Boolean;
      function AtualizarItem(cds: TClientDataSet): Boolean;
      procedure RetornarEstoque(sCodigo: string; Acao: TAcaoExcluirEstoque);
      procedure BaixarEstoque(produtoId: Integer; Quantidade: Double);

    public
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
      function Inserir(cds: TClientDataSet): Integer;
      function Atualizar(cds:TClientDataSet): Boolean;
      function Apagar: Boolean;
      function Selecionar(id: Integer; var cds: TClientDataSet): Boolean;

    published
      property VendaId:    Integer   read F_vendaId    write F_vendaId;
      property ClienteId:  Integer   read F_clienteId  write F_clienteId;
      property DataVenda:  TDateTime read F_dataVenda  write F_dataVenda;
      property TotalVenda: Double    read F_totalVenda write F_totalVenda;
  end;

implementation

{ TVenda }

{$region 'CONSTRUCTOR AND DESTRUCTOR'}
constructor TVenda.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TVenda.Destroy;
begin

  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TVenda.Apagar: Boolean;
var Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 +
                'Venda Nr�: ' + IntToStr(VendaId),
                mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
    Result := False;
    Abort;
  end;

  try
    Result := True;
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    // Apaga os Itens primeiro
    Qry.SQL.Clear;
    Qry.SQL.Add(' DELETE FROM VendasItens ' +
                ' WHERE  vendaId = :vendaId ');
    Qry.ParamByName('vendaId').AsInteger := VendaId;
    Try
      Qry.ExecSQL;
      // Apaga a Tabela Master
      Qry.SQL.Clear;
      Qry.SQL.Add(' DELETE FROM Vendas ' +
                  ' WHERE  vendaId = :vendaId ');
      Qry.ParamByName('vendaId').AsInteger := VendaId;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := False;
    End;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

end;

function TVenda.Atualizar(cds:TClientDataSet): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' UPDATE Vendas ' +
                ' SET    clienteId    = :clienteId ' +
                '        ,dataVenda   = :dataVenda ' +
                '        ,totalVenda  = :totalVenda ' +
                ' WHERE  vendaId      = :vendaId ');
    Qry.ParamByName('vendaId').AsInteger    := Self.F_vendaId;
    Qry.ParamByName('clienteId').AsInteger  := Self.F_clienteId;
    Qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    Qry.ParamByName('totalVenda').AsFloat   := Self.F_totalVenda;

    Try
      // Update Vendas
      Qry.ExecSQL;

      // Apagar Itens no banco de dados que foram apagados na tela
      ApagaItens(cds);

      cds.First;
      while not cds.Eof do begin
        if EsteItemExiste(Self.F_vendaId, cds.FieldByName('produtoId').AsInteger) then begin
          AtualizarItem(cds);
        end else begin
          InserirItens(cds, Self.F_vendaId);
        end;
        cds.Next;
      end;


    Except
      Result := False;
      ConexaoDB.Rollback;
    End;

    ConexaoDB.Commit;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

end;

function TVenda.AtualizarItem(cds: TClientDataSet): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    RetornarEstoque(cds.FieldByName('produtoId').AsString, aeeAlterar);
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' UPDATE VendasItens ' +
                '    SET ValorUnitario = :ValorUnitario ' +
                '          ,Quantidade = :Quantidade ' +
                '          ,TotalProduto = :TotalProduto ' +
                ' WHERE vendaId = :vendaId AND produtoId = :produtoId ');
    Qry.ParamByName('vendaId').AsInteger     := Self.F_VendaId;
    Qry.ParamByName('produtoId').AsInteger   := cds.FieldByName('produtoId').AsInteger;
    Qry.ParamByName('ValorUnitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('Quantidade').AsFloat    := cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('TotalProduto').AsFloat  := cds.FieldByName('valorTotalProduto').AsFloat;

    try
      Qry.ExecSQL;
      BaixarEstoque(cds.FieldByName('produtoId').AsInteger, cds.FieldByName('quantidade').AsFloat);
    finally
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.EsteItemExiste(vendaId: Integer; produtoId: Integer): Boolean;
var Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' SELECT COUNT(vendaId) AS Qtde ' +
                '   FROM VendasItens ' +
                '  WHERE vendaId = :vendaId and produtoId = :produtoId ');
    Qry.ParamByName('vendaId').AsInteger   := vendaId;
    Qry.ParamByName('produtoId').AsInteger := produtoId;
    try
      Qry.Open;

      if Qry.FieldByName('Qtde').AsInteger > 0 then
        Result := True
      else
        Result := False;

    except
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.ApagaItens(cds: TClientDataSet): Boolean;
var Qry: TZQuery;
    sCodNoCds: string;
begin
  try
    Result := True;
    // Pega os c�digos que estam no cliente para selecionar o In Not no BD
    sCodNoCds := InNot(cds);
    // Retorna ao estoque
    RetornarEstoque(sCodNoCds, aeeApagar);

    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' DELETE ' +
                '   FROM VendasItens ' +
                '  WHERE VendaId = :VendaId ' +
                '    AND produtoId NOT IN (' + sCodNoCds + ') ');
    Qry.ParamByName('VendaId').AsInteger := Self.F_vendaId;

    try
      Qry.ExecSQL;
    except
      Result := False;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.InNot(cds: TClientDataSet): String;
var sInNot: String;
begin
  sInNot := EmptyStr;
  cds.First;
  while not cds.Eof do begin
    if sInNot = EmptyStr then
      sInNot := cds.FieldByName('produtoId').AsString
    else
      sInNot := sInNot + ', ' + cds.FieldByName('produtoId').AsString;

    cds.Next;
  end;
  Result := sInNot;
end;

function TVenda.Inserir(cds: TClientDataSet): Integer;
var Qry: TZQuery;
    IdVendaGerado: Integer;
begin
  try
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    // Faz a inclus�o no Banco de Dados
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO Vendas (clienteId, ' +
                '                    dataVenda, ' +
                '                    totalVenda) ' +
                ' VALUES            (:clienteId, ' +
                '                    :dataVenda, ' +
                '                    :totalVenda) ');
    Qry.ParamByName('clienteId').AsInteger     := Self.F_clienteId;
    Qry.ParamByName('dataVenda').AsDateTime    := Self.F_dataVenda;
    Qry.ParamByName('totalVenda').AsFloat      := Self.F_totalVenda;

    Try
      Qry.ExecSQL;
      // Recupera o ID gerado no Insert
      Qry.SQL.Clear;
      Qry.SQL.Add(' SELECT SCOPE_IDENTITY() AS ID ');
      Qry.Open;

      // ID da tabela Master (Venda)
      IdVendaGerado := Qry.FieldByName('ID').AsInteger;

      {$region 'GRAVAR NA TABELA VENDASITENS'}
      cds.First;
      while not cds.Eof do begin
        InserirItens(cds, IdVendaGerado);
        cds.Next;
      end;
      {$endregion}

      ConexaoDB.Commit;
      Result := IdVendaGerado;
    Except
      ConexaoDB.Rollback;
      Result := -1;
    End;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

end;

function TVenda.InserirItens(cds: TClientDataSet; IdVenda: Integer):Boolean;
var Qry: TZQuery;
begin
   try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO VendasItens ( vendaId, produtoId,  valorUnitario,  quantidade,  totalProduto ) ' +
                '                 VALUES (:vendaId, :produtoId, :valorUnitario, :quantidade, :totalProduto) ');
    Qry.ParamByName('vendaId').AsInteger     := IdVenda;
    Qry.ParamByName('produtoId').AsInteger   := cds.FieldByName('produtoId').AsInteger;
    Qry.ParamByName('valorUnitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('quantidade').AsFloat    := cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('totalProduto').AsFloat  := cds.FieldByName('valorTotalProduto').AsFloat;

    try
      Qry.ExecSQL;
      BaixarEstoque(cds.FieldByName('produtoId').AsInteger, cds.FieldByName('quantidade').AsFloat);
    Except
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.Selecionar(id: Integer; var cds: TClientDataSet): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' SELECT  vendaId ' +
                '        ,clienteId ' +
                '        ,dataVenda ' +
                '        ,totalVenda ' +
                ' FROM   Vendas ' +
                ' WHERE  vendaId = :vendaId ');
    Qry.ParamByName('vendaId').AsInteger := id;
    Try
      Qry.Open;

      Self.F_vendaId    := Qry.FieldByName('vendaId').AsInteger;
      Self.F_clienteId  := Qry.FieldByName('clienteId').AsInteger;
      Self.F_dataVenda  := Qry.FieldByName('dataVenda').AsDateTime;
      Self.F_totalVenda := Qry.FieldByName('totalVenda').AsFloat;

      {$region 'SELECIONAR NA TABELA VENDASITENS'}
      // Apaga o ClientDataSet caso esteja com registro
      cds.First;
      while not cds.Eof do begin
        cds.Delete;
      end;

      // Seleciona os Itens do banco de dados com a propriedade F_VendaId
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add(' SELECT VendasItens.produtoId,								        	            ' +
                  '        Produtos.nome,											                        ' +
                  ' 	     VendasItens.valorUnitario,								                  ' +
                  ' 	     VendasItens.quantidade,									                  ' +
                  ' 	     VendasItens.totalProduto									                  ' +
                  ' FROM   VendasItens 											                          ' +
                  ' INNER JOIN Produtos ON Produtos.produtoId = VendasItens.produtoId ' +
                  ' WHERE VendasItens.vendaId = :vendaId                              ' );
      Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;
      Qry.Open;

      // L� da Query e coloca no ClientDataSet
      Qry.First;
      while not Qry.Eof do begin
        cds.Append;
        cds.FieldByName('produtoId').AsInteger       := Qry.FieldByName('produtoId').AsInteger;
        cds.FieldByName('nomeProduto').AsString      := Qry.FieldByName('nome').AsString;
        cds.FieldByName('valorUnitario').AsFloat     := Qry.FieldByName('valorUnitario').AsFloat;
        cds.FieldByName('quantidade').AsFloat        := Qry.FieldByName('quantidade').AsFloat;
        cds.FieldByName('valorTotalProduto').AsFloat := Qry.FieldByName('totalProduto').AsFloat;
        cds.Post;
        Qry.Next;
      end;
      cds.First;

      {$endregion}
    Except
      Result := False;
    End;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

end;
{$endregion}

{$region 'Controle de Estoque'}

// Utilizar no Update e Delete
procedure TVenda.RetornarEstoque(sCodigo: string; Acao: TAcaoExcluirEstoque);
var Qry: TZQuery;
    oControleEstoque: TControleEstoque;
begin
  Qry := TZQuery.Create(nil);
  Qry.Connection := ConexaoDB;
  Qry.SQL.Clear;
  Qry.SQL.Add(' SELECT produtoId, quantidade ' +
              '   FROM VendasItens ' +
              '  WHERE VendaId = :vendaId ' );
  if Acao = aeeApagar then
    Qry.SQL.Add(' AND produtoId NOT IN (' + sCodigo + ') ')
  else
    Qry.SQL.Add(' AND produtoId = (' + sCodigo + ') ');

  Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;

  try
    oControleEstoque := TControleEstoque.Create(ConexaoDB);
    Qry.Open;
    Qry.First;
    while not Qry.Eof do begin
      oControleEstoque.ProdutoId  := Qry.FieldByName('produtoId').AsInteger;
      oControleEstoque.Quantidade := Qry.FieldByName('quantidade').AsFloat;
      oControleEstoque.RetornarEstoque;
      Qry.Next;
    end;
  finally
    if Assigned(oControleEstoque) then
      FreeAndNil(oControleEstoque);
  end;
end;

// Utilizar no Insert
procedure TVenda.BaixarEstoque(produtoId: Integer; Quantidade: Double);
var oControleEstoque: TControleEstoque;
begin
  try
    oControleEstoque := TControleEstoque.Create(ConexaoDB);
    oControleEstoque.ProdutoId  := produtoId;
    oControleEstoque.Quantidade := Quantidade;
    oControleEstoque.BaixarEstoque;
  finally
    if Assigned(oControleEstoque) then
      FreeAndNil(oControleEstoque);
  end;
end;

{$endregion}

end.
