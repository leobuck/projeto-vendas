unit cCadCategoria;

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
     System.SysUtils; // lista de Units

type
  TCategoria = class // Declaração do tipo da Classe

  private
    // Variáveis Privadas somente dentro da classe
    ConexaoBD: TZConnection;
    F_categoriaId: Integer;
    F_descricao: String;
    function getCodigo: Integer;
    function getDescricao: String;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);
  public
    constructor Create(aConexao: TZConnection); // Construtor da Classe
    destructor Destroy; override; // Destroi a Classe
                                 // Usar o override por causa de sobrescrever
    // Variáveis Publicas que pode ser trabalhadas fora da classe
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
  published
    // Variáveis Publicas utilizadas para propriedades da classe
    // para fornecer informações runtime
    property codigo: Integer   read getCodigo    write setCodigo;
    property descricao: String read getDescricao write setDescricao;
  end;
implementation

{ TCategoria }

{$region 'CONSTRUCTOR AND DESTRUCTOR'}

constructor TCategoria.Create(aConexao: TZConnection);
begin
  ConexaoBD := aConexao;
end;

destructor TCategoria.Destroy;
begin
  inherited;
end;

{$endregion}

{$region 'CRUD'}

function TCategoria.Apagar: Boolean;
var Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 + // #13: Quebra linha
                'Código: ' + IntToStr(F_categoriaId) + #13 +
                'Descrição: ' + F_descricao,
                mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
    Result := False;

    Abort;
  end;

  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoBD;
    Qry.SQL.Clear;
    Qry.SQL.Add(' DELETE FROM Categorias ' +
                ' WHERE  categoriaId = :categoriaId ');
    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;
    Try
      Qry.ExecSQL;
    Except
      Result := False;
    End;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TCategoria.Atualizar: Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoBD;
    Qry.SQL.Clear;
    Qry.SQL.Add(' UPDATE Categorias ' +
                ' SET    descricao = :descricao ' +
                ' WHERE  categoriaId = :categoriaId ');
    Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;
    Qry.ParamByName('descricao').AsString := Self.F_descricao;
    Try
      Qry.ExecSQL;
    Except
      Result := False;
    End;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TCategoria.Inserir: Boolean;
var Qry: TZQuery;
begin
  //ShowMessage(Self.F_descricao);
  //ShowMessage('Gravado!');
  //Result := True;
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoBD;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO Categorias (Descricao) VALUES (:descricao)');
    Qry.ParamByName('descricao').AsString := Self.F_descricao;
    Try
      Qry.ExecSQL;
    Except
      Result := False;
    End;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoBD;
    Qry.SQL.Clear;
    Qry.SQL.Add(' SELECT categoriaId, ' +
                '        descricao ' +
                ' FROM   Categorias ' +
                ' WHERE  categoriaId = :categoriaId ');
    Qry.ParamByName('categoriaId').AsInteger := id;
    Try
      Qry.Open;

      Self.F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
      Self.F_descricao   := Qry.FieldByName('descricao').AsString;
    Except
      Result := False;
    End;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

{$endregion}

{$region 'GETS'}

function TCategoria.getCodigo: Integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := Self.F_descricao;
end;

{$endregion}

{$region 'SETS'}

procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaId := Value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
  Self.F_descricao := Value;
end;

{$endregion}

end.
