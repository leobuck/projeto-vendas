unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  cCadCategoria, uDMConexao, uEnum;

type
  TfrmCadCategoria = class(TfrmTelaHeranca)
    qryListagemcategoriaId: TIntegerField;
    qryListagemdescricao: TWideStringField;
    edtCategoriaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    oCategoria : TCategoria; // Declara��o do objeto
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

{$region 'OVERRIDE'}

function TfrmCadCategoria.Apagar: Boolean;
begin
  if oCategoria.Selecionar(qryListagem.FieldByName('categoriaId').AsInteger) then begin
    Result := oCategoria.Apagar;
  end;
end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtCategoriaId.Text <> EmptyStr then
    oCategoria.codigo := StrToInt(edtCategoriaId.Text)
  else
    oCategoria.codigo := 0;

  oCategoria.descricao := edtDescricao.Text;

  if (EstadoDoCadastro = ecInserir) then
    Result := oCategoria.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oCategoria.Atualizar;

end;

{$endregion}

procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
  if oCategoria.Selecionar(qryListagem.FieldByName('categoriaId').AsInteger) then begin
    edtCategoriaId.Text := IntToStr(oCategoria.codigo);
    edtDescricao.Text := oCategoria.descricao;
  end else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;

end;

procedure TfrmCadCategoria.btnGravarClick(Sender: TObject);
begin
  //oCategoria.codigo := 100;
  //oCategoria.descricao := 'Teste';
  //ShowMessage(oCategoria.descricao);

  inherited;
end;

procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCategoria) then  // Verifica se objeto est� instanciado na mem�ria
    FreeAndNil(oCategoria); // Limpa objeto da mem�ria

end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  oCategoria := TCategoria.Create(dtmPrincipal.ConexaoDB); // Instancia do objeto
  IndiceAtual := 'descricao';
end;

end.
