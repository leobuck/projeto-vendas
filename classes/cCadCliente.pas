unit cCadCliente;

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
     System.SysUtils;

type
  TCliente = class
  private
    ConexaoDB: TZConnection;
    F_clienteId: Integer;
    F_nome: string;
    F_endereco: string;
    F_cidade: string;
    F_bairro: string;
    F_estado: string;
    F_cep: string;
    F_telefone: string;
    F_email: string;
    F_dataNascimento: TDateTime;
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
  published
    property codigo:         Integer    read F_clienteId      write F_clienteId;
    property nome:           string     read F_nome           write F_nome;
    property endereco:       string     read F_endereco       write F_endereco;
    property cidade:         string     read F_cidade         write F_cidade;
    property bairro:         string     read F_bairro         write F_bairro;
    property estado:         string     read F_estado         write F_estado;
    property cep:            string     read F_cep            write F_cep;
    property telefone:       string     read F_telefone       write F_telefone;
    property email:          string     read F_email          write F_email;
    property dataNascimento: TDateTime  read F_dataNascimento write F_dataNascimento;
end;

implementation

{$region 'CONSTRUCTOR AND DESTRUCTOR'}
constructor TCliente.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TCliente.Destroy;
begin
  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TCliente.Apagar: Boolean;
var Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 +
                'C�digo: ' + IntToStr(F_clienteId) + #13 +
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
    Qry.SQL.Add(' DELETE FROM Clientes ' +
                ' WHERE  clienteId = :clienteId ');
    Qry.ParamByName('clienteId').AsInteger := F_clienteId;
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

function TCliente.Atualizar: Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' UPDATE Clientes ' +
                ' SET    nome            = :nome ' +
                '        ,endereco       = :endereco ' +
                '        ,cidade         = :cidade ' +
                '        ,bairro         = :bairro ' +
                '        ,estado         = :estado ' +
                '        ,cep            = :cep ' +
                '        ,telefone       = :telefone ' +
                '        ,email          = :email ' +
                '        ,dataNascimento = :dataNascimento ' +
                ' WHERE  clienteId = :clienteId ');
    Qry.ParamByName('clienteId').AsInteger := Self.F_clienteId;
    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('endereco').AsString := Self.F_endereco;
    Qry.ParamByName('cidade').AsString := Self.F_cidade;
    Qry.ParamByName('bairro').AsString := Self.F_bairro;
    Qry.ParamByName('estado').AsString := Self.F_estado;
    Qry.ParamByName('cep').AsString := Self.F_cep;
    Qry.ParamByName('telefone').AsString := Self.F_telefone;
    Qry.ParamByName('email').AsString := Self.F_email;
    Qry.ParamByName('dataNascimento').AsDateTime := Self.F_dataNascimento;
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

function TCliente.Inserir: Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO Clientes (nome, ' +
                '                      endereco, ' +
                '                      cidade, ' +
                '                      bairro, ' +
                '                      estado, ' +
                '                      cep, ' +
                '                      telefone, ' +
                '                      email, ' +
                '                      dataNascimento) ' +
                ' VALUES               (:nome, ' +
                '                       :endereco, ' +
                '                       :cidade, ' +
                '                       :bairro, ' +
                '                       :estado, ' +
                '                       :cep, ' +
                '                       :telefone, ' +
                '                       :email, ' +
                '                       :dataNascimento) ');
    Qry.ParamByName('nome').AsString             := Self.F_nome;
    Qry.ParamByName('endereco').AsString         := Self.F_endereco;
    Qry.ParamByName('cidade').AsString           := Self.F_cidade;
    Qry.ParamByName('bairro').AsString           := Self.F_bairro;
    Qry.ParamByName('estado').AsString           := Self.F_estado;
    Qry.ParamByName('cep').AsString              := Self.F_cep;
    Qry.ParamByName('telefone').AsString         := Self.F_telefone;
    Qry.ParamByName('email').AsString            := Self.F_email;
    Qry.ParamByName('dataNascimento').AsDateTime := Self.F_dataNascimento;
    
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

function TCliente.Selecionar(id: Integer): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' SELECT clienteId, ' +
                '        nome, ' +
                '        endereco, ' +
                '        cidade, ' +
                '        bairro, ' +
                '        estado, ' +
                '        cep, ' +
                '        telefone, ' +
                '        email, ' +
                '        dataNascimento ' +
                ' FROM   Clientes ' +
                ' WHERE  clienteId = :clienteId ');
    Qry.ParamByName('clienteId').AsInteger := id;
    Try
      Qry.Open;

      Self.F_clienteId      := Qry.FieldByName('clienteId').AsInteger;
      Self.F_nome           := Qry.FieldByName('nome').AsString;
      Self.F_endereco       := Qry.FieldByName('endereco').AsString;
      Self.F_cidade         := Qry.FieldByName('cidade').AsString;
      Self.F_bairro         := Qry.FieldByName('bairro').AsString;
      Self.F_estado         := Qry.FieldByName('estado').AsString;
      Self.F_cep            := Qry.FieldByName('cep').AsString;
      Self.F_telefone       := Qry.FieldByName('telefone').AsString;
      Self.F_email          := Qry.FieldByName('email').AsString;      
      Self.F_dataNascimento := Qry.FieldByName('dataNascimento').AsDateTime;
    Except
      Result := False;
    End;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;
{$endregion}


end.
