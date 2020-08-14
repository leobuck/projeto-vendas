unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  uDMConexao, uDMVenda, RxToolEdit, RxCurrEdit, cProVenda, uEnum;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    qryListagemvendaId: TIntegerField;
    qryListagemclienteId: TIntegerField;
    qryListagemnome: TWideStringField;
    qryListagemdataVenda: TDateTimeField;
    qryListagemtotalVenda: TFloatField;
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    Label4: TLabel;
    edtDataVenda: TDateEdit;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    edtValorTotal: TCurrencyEdit;
    dbGridItensVenda: TDBGrid;
    lkpProduto: TDBLookupComboBox;
    Label1: TLabel;
    edtValorUnitario: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnAdicionarItem: TBitBtn;
    btnApagarItem: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarItemClick(Sender: TObject);
    procedure dbGridItensVendaDblClick(Sender: TObject);
  private
    { Private declarations }
    dtmVenda: TdtmVenda;
    oVenda: TVenda;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure LimparComponenteItem;
    procedure LimparCds;
    procedure CarregarRegistroSelecionado;
    function TotalizarVenda: Double;
  public
    { Public declarations }
  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}

uses uRelProVenda;

{$region 'OVERRIDE'}
function TfrmProVenda.Apagar: Boolean;
begin
  if oVenda.Selecionar(qryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then begin
    Result := oVenda.Apagar;
  end;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtVendaId.Text <> EmptyStr then
    oVenda.VendaId := StrToInt(edtVendaId.Text)
  else
    oVenda.VendaId := 0;

  oVenda.ClienteId := lkpCliente.KeyValue;
  oVenda.DataVenda := edtDataVenda.Date;
  oVenda.TotalVenda := edtValorTotal.Value;

  if (EstadoDoCadastro = ecInserir) then
    oVenda.VendaId := oVenda.Inserir(dtmVenda.cdsItensVenda)
  else if (EstadoDoCadastro = ecAlterar) then
    oVenda.Atualizar(dtmVenda.cdsItensVenda);

  frmRelProVenda := TfrmRelProVenda.Create(Self);
  frmRelProVenda.QryVendas.Close;
  frmRelProVenda.QryVendas.ParamByName('VendaId').AsInteger := oVenda.VendaId;
  frmRelProVenda.QryVendas.Open;

  frmRelProVenda.QryVendasItens.Close;
  frmRelProVenda.QryVendasItens.ParamByName('VendaId').AsInteger := oVenda.VendaId;
  frmRelProVenda.QryVendasItens.Open;

  frmRelProVenda.Relatorio.PreviewModal;
  frmRelProVenda.Release;

  Result := True;
end;
procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;

  if TDBLookupComboBox(Sender).KeyValue <> Null then begin
    edtValorUnitario.Value := dtmVenda.QryProdutos.FieldByName('valor').AsFloat;
    edtQuantidade.Value := 1;
    edtValorTotal.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
  end;

end;

{$endregion}

procedure TfrmProVenda.btnAdicionarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue = Null then begin
    MessageDlg('Produto é um campo obrigatório', mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    Abort;
  end;

  if edtValorUnitario.Value <= 0 then begin
    MessageDlg('Valor Unitário não pode ser Zero', mtInformation, [mbOK], 0);
    edtValorUnitario.SetFocus;
    Abort;
  end;

  if edtQuantidade.Value <= 0 then begin
    MessageDlg('Quantidade não pode ser Zero', mtInformation, [mbOK], 0);
    edtQuantidade.SetFocus;
    Abort;
  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then begin
    MessageDlg('Este Produto já foi selecionado', mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    Abort;
  end;

  edtValorTotal.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

  dtmVenda.cdsItensVenda.Append;
  dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString := lkpProduto.KeyValue;
  dtmVenda.cdsItensVenda.FieldByName('nomeProduto').AsString := dtmVenda.QryProdutos.FieldByName('nome').AsString;
  dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat := edtQuantidade.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat := edtValorUnitario.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat := edtTotalProduto.Value;
  dtmVenda.cdsItensVenda.Post;

  edtValorTotal.Value := TotalizarVenda;

  LimparComponenteItem;

  lkpProduto.SetFocus;
end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  lkpProduto.KeyValue    := Null;
  edtQuantidade.Value    := 0;
  edtValorUnitario.Value := 0;
  edtTotalProduto.Value  := 0;
end;

function TfrmProVenda.TotalizarProduto(valorUnitario, Quantidade: Double): Double;
begin
  Result := valorUnitario * Quantidade;
end;

procedure TfrmProVenda.LimparCds;
begin
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do
    dtmVenda.cdsItensVenda.Delete;

end;

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(qryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then begin
    edtVendaId.Text     := IntToStr(oVenda.VendaId);
    lkpCliente.KeyValue := oVenda.ClienteId;
    edtDataVenda.Date   := oVenda.DataVenda;
    edtValorTotal.Value := oVenda.TotalVenda;
  end else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;

end;

procedure TfrmProVenda.btnApagarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue = Null then begin
    MessageDlg('Selecione o Produto a ser excluído', mtInformation, [mbOK], 0);
    dbGridItensVenda.SetFocus;
    Abort;
  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then begin
    dtmVenda.cdsItensVenda.Delete;
    edtValorTotal.Value := TotalizarVenda;
    LimparComponenteItem;
  end;

end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
  LimparCds;
end;

procedure TfrmProVenda.dbGridItensVendaDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;
end;

procedure TfrmProVenda.dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGRID(Key, Shift);
end;

procedure TfrmProVenda.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVenda) then
    FreeAndNil(dtmVenda);

  if Assigned(oVenda) then
    FreeAndNil(oVenda);

end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVenda := TdtmVenda.Create(Self);

  oVenda := TVenda.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual := 'clienteId';

end;

procedure TfrmProVenda.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue    := dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString;
  edtQuantidade.Value    := dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat;
  edtValorUnitario.Value := dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat;
  edtValorTotal.Value    := dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
end;

function TfrmProVenda.TotalizarVenda: Double;
begin
  Result := 0;
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do begin
    Result := Result + dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
    dtmVenda.cdsItensVenda.Next;
  end;

end;

end.
