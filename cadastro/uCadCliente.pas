unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RxToolEdit, cCadCliente, uEnum, uDMConexao;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCEP: TMaskEdit;
    Label1: TLabel;
    edtEndereco: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtTelefone: TMaskEdit;
    Label2: TLabel;
    edtEmail: TLabeledEdit;
    edtDataNascimento: TDateEdit;
    Label3: TLabel;
    qryListagemclienteId: TIntegerField;
    qryListagemnome: TWideStringField;
    qryListagemendereco: TWideStringField;
    qryListagemcidade: TWideStringField;
    qryListagembairro: TWideStringField;
    qryListagemestado: TWideStringField;
    qryListagemcep: TWideStringField;
    qryListagemtelefone: TWideStringField;
    qryListagememail: TWideStringField;
    qryListagemdataNascimento: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    oCliente: TCliente;
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

{ TfrmCadCliente }

{$region 'OVERRIDE'}
function TfrmCadCliente.Apagar: Boolean;
begin
  if oCliente.Selecionar(qryListagem.FieldByName('clienteId').AsInteger) then begin
    Result := oCliente.Apagar;
  end;
end;

function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtClienteId.Text <> EmptyStr then
    oCliente.codigo := StrToInt(edtClienteId.Text)
  else
    oCliente.codigo := 0;

  oCliente.nome           := edtNome.Text;
  oCliente.cep            := edtCEP.Text;
  oCliente.endereco       := edtEndereco.Text;
  oCliente.bairro         := edtBairro.Text;
  oCliente.cidade         := edtCidade.Text;
  oCliente.telefone       := edtTelefone.Text;
  oCliente.email          := edtEmail.Text;
  oCliente.dataNascimento := edtDataNascimento.Date;

  if (EstadoDoCadastro = ecInserir) then
    Result := oCliente.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oCliente.Atualizar;
end;
{$endregion}

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin

  if oCliente.Selecionar(qryListagem.FieldByName('clienteId').AsInteger) then begin
    edtClienteId.Text      := IntToStr(oCliente.codigo);
    edtNome.Text           := oCliente.nome;
    edtCEP.Text            := oCliente.cep;
    edtEndereco.Text       := oCliente.endereco;
    edtBairro.Text         := oCliente.bairro;
    edtCidade.Text         := oCliente.cidade;
    edtTelefone.Text       := oCliente.telefone;
    edtEmail.Text          := oCliente.email;
    edtDataNascimento.Date := oCliente.dataNascimento;
  end else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataNascimento.Date := Date;
  edtNome.SetFocus;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCliente) then
    FreeAndNil(oCliente);
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  oCliente := TCliente.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual := 'nome';
end;

end.
