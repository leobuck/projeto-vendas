unit cCadUsuario;

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
     uFuncaoCriptografia;

type
  TUsuario = class
  private
    ConexaoDB: TZConnection;
    F_usuarioId: Integer;
    F_nome: string;
    F_senha: string;
    function getSenha: string;
    procedure setSenha(const Value: string);

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
  published
    property codigo:         Integer    read F_usuarioId      write F_usuarioId;
    property nome:           string     read F_nome           write F_nome;
    property senha:          string     read getsenha         write setsenha;
end;

implementation

{$region 'CONSTRUCTOR AND DESTRUCTOR'}
constructor TUsuario.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TUsuario.Destroy;
begin
  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TUsuario.Apagar: Boolean;
var Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 +
                'Código: ' + IntToStr(F_usuarioId) + #13 +
                'Nome: ' + F_nome,
                mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
    Result := False;
    Abort;
  end;

  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' DELETE FROM Usuarios ' +
                ' WHERE  usuarioId = :usuarioId ');
    Qry.ParamByName('usuarioId').AsInteger := F_usuarioId;
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

function TUsuario.Atualizar: Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' UPDATE Usuarios ' +
                ' SET    nome            = :nome  ' +
                '        ,senha          = :senha ' +
                ' WHERE  usuarioId = :usuarioId ');
    Qry.ParamByName('usuarioId').AsInteger := Self.F_usuarioId;
    Qry.ParamByName('nome').AsString       := Self.F_nome;
    Qry.ParamByName('senha').AsString      := Self.F_senha;
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

function TUsuario.Inserir: Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO Usuarios (nome,   ' +
                '                      senha)  ' +
                ' VALUES              (:nome,  ' +
                '                      :senha) ');
    Qry.ParamByName('nome').AsString             := Self.F_nome;
    Qry.ParamByName('senha').AsString            := Self.F_senha;

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

function TUsuario.Selecionar(id: Integer): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' SELECT usuarioId, ' +
                '        nome,      ' +
                '        senha      ' +
                ' FROM   Usuarios   ' +
                ' WHERE  usuarioId = :usuarioId ');
    Qry.ParamByName('usuarioId').AsInteger := id;
    Try
      Qry.Open;

      Self.F_usuarioId      := Qry.FieldByName('usuarioId').AsInteger;
      Self.F_nome           := Qry.FieldByName('nome').AsString;
      Self.F_senha          := Qry.FieldByName('senha').AsString;
    Except
      Result := False;
    End;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;
{$endregion}

{$region 'GET E SET'}
function TUsuario.getSenha: string;
begin
  Result := Criptografar(Self.F_senha);
end;

procedure TUsuario.setSenha(const Value: string);
begin
  Self.F_senha := Descriptografar(Value);
end;
{$endregion}

end.
