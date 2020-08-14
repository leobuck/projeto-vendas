unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, uDMConexao,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uEnum, RxToolEdit, RxCurrEdit;

type
  TfrmTelaHeranca = class(TForm)
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    pgcPrincipal: TPageControl;
    tabListagem: TTabSheet;
    pnlListagemTopo: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    tabManutencao: TTabSheet;
    grdListagem: TDBGrid;
    qryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
              btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
              pgcPrincipal: TPageControl; Flag: Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(Campo: String; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitaEditPK;
    procedure LimparEdits;
  public
    { Public declarations }
    EstadoDoCadastro: TEstadoDoCadastro;
    IndiceAtual: String;
    function Apagar: Boolean; virtual;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; virtual;
    procedure BloqueiaCTRL_DEL_DBGRID(var Key: Word; Shift: TShiftState);
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

{$region 'OBSERVAÇÕES'}
  // TAG: 1 - Chave Primária (PK)
  // TAG: 2 - Campos Obrigatórios
{$endregion}

{$region 'FUNÇÕES E PROCEDURES'}
// Procedimentos de Controle de Tela
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
          btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
          pgcPrincipal: TPageControl; Flag: Boolean);
begin
  btnNovo.Enabled                  := Flag;
  btnApagar.Enabled                := Flag;
  btnAlterar.Enabled               := Flag;
  Navegador.Enabled                := Flag;
  pgcPrincipal.Pages[0].TabVisible := Flag;
  btnCancelar.Enabled              := not (Flag);
  btnGravar.Enabled                := not (Flag);
end;

procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl;
          Indice: Integer);
begin
  if (pgcPrincipal.Pages[Indice].TabVisible) then
    pgcPrincipal.TabIndex := Indice;

end;

function TfrmTelaHeranca.RetornarCampoTraduzido(Campo: String): String;
var i: Integer;
begin
  for i := 0 to qryListagem.Fields.Count - 1 do begin
    if LowerCase(qryListagem.Fields[i].FieldName) = LowerCase(Campo) then begin
      Result := qryListagem.Fields[i].DisplayLabel;
      break;
    end;
  end;

end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo: String; aLabel: TLabel);
begin
  aLabel.Caption := RetornarCampoTraduzido(Campo);
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio: Boolean;
var i: Integer;
begin
  Result := False;
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 2) and
         (TLabeledEdit(Components[i]).Text = EmptyStr) then begin
           MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption +
            ' é um campo obrigatório', mtInformation, [mbOK], 0);
           TLabeledEdit(Components[i]).SetFocus;
           Result := True;
           Break;
         end;
    end;

  end;

end;

procedure TfrmTelaHeranca.DesabilitaEditPK;
var i: Integer;
begin
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 1) then begin
        TLabeledEdit(Components[i]).Enabled := False;
        Break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var i: Integer;
begin
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TLabeledEdit) then
      TLabeledEdit(Components[i]).Text := EmptyStr
    else if (Components[i] is TEdit) then
      TEdit(Components[i]).Text := ''
    else if (Components[i] is TMemo) then
      TMemo(Components[i]).Text := ''
    else if (Components[i] is TDBLookupComboBox) then
      TDBLookupComboBox(Components[i]).KeyValue := Null
    else if (Components[i] is TCurrencyEdit) then
      TCurrencyEdit(Components[i]).Value := 0
    else if (Components[i] is TDateEdit) then
      TDateEdit(Components[i]).Date := 0
    else if (Components[i] is TMaskEdit) then
      TMaskEdit(Components[i]).Text := '';
  end;
end;

{$endregion}

{$region 'MÉTODOS VIRTUAIS'}
function TfrmTelaHeranca.Apagar: Boolean;
begin
  ShowMessage('DELETADO');
  Result := True;
end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if (EstadoDoCadastro = ecInserir) then
    ShowMessage('Inserir')
  else if (EstadoDoCadastro = ecAlterar) then
    ShowMessage('Alterado');
  Result := True;
end;

{$endregion}

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
    btnNavigator, pgcPrincipal, False);
  EstadoDoCadastro := ecInserir;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
    btnNavigator, pgcPrincipal, False);
  EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  Try
    if (Apagar) then begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
        btnNavigator, pgcPrincipal, True );
      ControlarIndiceTab(pgcPrincipal, 0);
      LimparEdits;
      qryListagem.Refresh;
    end else begin
      MessageDlg('Erro na exclusão!', mtError, [mbOK], 0);
    end;
  Finally
    EstadoDoCadastro := ecNenhum;
  End;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
    btnNavigator, pgcPrincipal, True);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if (ExisteCampoObrigatorio) then
    Abort;

  try
    if Gravar(EstadoDoCadastro) then begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
        btnNavigator, pgcPrincipal, True);
      ControlarIndiceTab(pgcPrincipal, 0);
      EstadoDoCadastro := ecNenhum;
      LimparEdits;
      qryListagem.Refresh;
    end else begin
      MessageDlg('Erro na gravação!', mtError, [mbOK], 0);
    end;
  finally

  end;
end;

procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryListagem.Close;
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  qryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet := qryListagem;
  grdListagem.DataSource := dtsListagem;
  grdListagem.Options := [dgTitles,dgIndicator,dgColumnResize,
    dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,
    dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  if (qryListagem.SQL.Text <> EmptyStr) then begin
    qryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    qryListagem.Open;
  end;

  ControlarIndiceTab(pgcPrincipal, 0);
  DesabilitaEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
    btnNavigator, pgcPrincipal, True);
end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  BloqueiaCTRL_DEL_DBGRID(Key, Shift);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  qryListagem.IndexFieldNames := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
  qryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
  //qryListagem.Locate(IndiceAtual, mskPesquisar.Text, [loPartialKey]);
end;

procedure TfrmTelaHeranca.BloqueiaCTRL_DEL_DBGRID(var Key: Word; Shift: TShiftState);
begin
  // Bloqueia o CTRL + DEL
  if (Shift = [ssCtrl]) and (Key = 46) then
    Key := 0;

end;

end.
