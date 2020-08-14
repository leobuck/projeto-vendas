unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDMConexao, Enter, uFrmAtualizaDB;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrio1: TMenuItem;
    Cliente1: TMenuItem;
    N1: TMenuItem;
    Categoria1: TMenuItem;
    Produto1: TMenuItem;
    N2: TMenuItem;
    menuFechar: TMenuItem;
    Venda1: TMenuItem;
    Cliente2: TMenuItem;
    N3: TMenuItem;
    Produto2: TMenuItem;
    N4: TMenuItem;
    Venda2: TMenuItem;
    Categoria2: TMenuItem;
    Fichadecliente1: TMenuItem;
    ProdutoporCategoria1: TMenuItem;
    Usurio1: TMenuItem;
    N5: TMenuItem;
    procedure menuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cliente1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Venda1Click(Sender: TObject);
    procedure Categoria2Click(Sender: TObject);
    procedure Cliente2Click(Sender: TObject);
    procedure Fichadecliente1Click(Sender: TObject);
    procedure Produto2Click(Sender: TObject);
    procedure ProdutoporCategoria1Click(Sender: TObject);
    procedure Venda2Click(Sender: TObject);
    procedure Usurio1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCadCategoria, uCadCliente, uCadProduto, uProVenda, uRelCategoria,
  uRelCadCliente, uRelCadClienteFicha, uRelCadProduto,
  uRelCadProdutoComGrupoCategoria, uSelecionarData, uRelVendaPorData,
  uCadUsuario, uLogin;

procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(Self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;
end;

procedure TfrmPrincipal.Categoria2Click(Sender: TObject);
begin
  frmRelCategoria := TfrmRelCategoria.Create(Self);
  frmRelCategoria.Relatorio.PreviewModal;
  frmRelCategoria.Release;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  frmCadCliente := TfrmCadCliente.Create(Self);
  frmCadCliente.ShowModal;
  frmCadCliente.Release;
end;

procedure TfrmPrincipal.Cliente2Click(Sender: TObject);
begin
  frmRelCadCliente := TfrmRelCadCliente.Create(Self);
  frmRelCadCliente.Relatorio.PreviewModal;
  frmRelCadCliente.Release;
end;

procedure TfrmPrincipal.Fichadecliente1Click(Sender: TObject);
begin
  frmRelCadClienteFicha := TfrmRelCadClienteFicha.Create(Self);
  frmRelCadClienteFicha.Relatorio.PreviewModal;
  frmRelCadClienteFicha.Release;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
{
  // Cria conexão no formulário principal
  dtmPrincipal := TdtmPrincipal.Create(Self);
  // Self: próprio formulário
  // Ativa cursor de ampulheta
  dtmPrincipal.ConexaoDB.SQLHourGlass := True;
  dtmPrincipal.ConexaoDB.Protocol := 'mssql';
  dtmPrincipal.ConexaoDB.LibraryLocation := 'C:\Users\Leonardo\Desktop\Desenvolvimento\Delphi\ProjetoVendas\ntwdblib.dll';
  dtmPrincipal.ConexaoDB.HostName := 'DESKTOP-AU5P5B7';
  dtmPrincipal.ConexaoDB.Port := 1433;
  dtmPrincipal.ConexaoDB.User := 'SA';
  dtmPrincipal.ConexaoDB.Password := '';
  dtmPrincipal.ConexaoDB.Database := 'Vendas';
  // Ativa conexão com o banco de dados
  dtmPrincipal.ConexaoDB.Connected := True;
}

  frmAtualizaDB := TfrmAtualizaDB.Create(Self);
  frmAtualizaDB.Show;    // Coloca form na tela e continua executando o fluxo do código
  frmAtualizaDB.Refresh; // Atualiza tela

  dtmPrincipal := TdtmPrincipal.Create(Self);

  with dtmPrincipal.ConexaoDB do begin
    SQLHourGlass := False;
    Protocol := 'mssql';
    LibraryLocation := 'C:\Desenvolvimento\repositorio\ProjetoVendas\ntwdblib.dll';
    HostName := 'localhost';
    Port := 1433;
    User := 'SA';
    Password := '';
    Database := 'Vendas';
    Connected := True;
  end;

  AtualizacaoBancoDados(frmAtualizaDB);
  frmAtualizaDB.Free; // Libera da memória

  TeclaEnter := TMREnter.Create(Self);
  TeclaEnter.FocusEnabled := True;
  TeclaEnter.FocusColor := clInfoBk;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  frmLogin := TfrmLogin.Create(self);
  frmLogin.ShowModal;
  frmLogin.Release;
end;

procedure TfrmPrincipal.menuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  frmCadProduto := TfrmCadProduto.Create(Self);
  frmCadProduto.ShowModal;
  frmCadProduto.Release;
end;

procedure TfrmPrincipal.Produto2Click(Sender: TObject);
begin
  frmRelCadProduto := TfrmRelCadProduto.Create(Self);
  frmRelCadProduto.Relatorio.PreviewModal;
  frmRelCadProduto.Release;
end;

procedure TfrmPrincipal.ProdutoporCategoria1Click(Sender: TObject);
begin
  frmRelCadProdutoComGrupoCategoria := TfrmRelCadProdutoComGrupoCategoria.Create(Self);
  frmRelCadProdutoComGrupoCategoria.Relatorio.PreviewModal;
  frmRelCadProdutoComGrupoCategoria.Release;
end;

procedure TfrmPrincipal.Usurio1Click(Sender: TObject);
begin
  frmCadUsuario := TfrmCadUsuario.Create(Self);
  frmCadUsuario.ShowModal;
  frmCadUsuario.Release;
end;

procedure TfrmPrincipal.Venda1Click(Sender: TObject);
begin
  frmProVenda := TfrmProVenda.Create(Self);
  frmProVenda.ShowModal;
  frmProVenda.Release;
end;

procedure TfrmPrincipal.Venda2Click(Sender: TObject);
begin
  try
    frmSelecionarData := TfrmSelecionarData.Create(Self);
    frmSelecionarData.ShowModal;

    frmRelVendaPorData := TfrmRelVendaPorData.Create(Self);
    frmRelVendaPorData.QryVendas.Close;
    frmRelVendaPorData.QryVendas.ParamByName('DataInicio').AsDate := frmSelecionarData.edtDataInicial.Date;
    frmRelVendaPorData.QryVendas.ParamByName('DataFim').AsDate    := frmSelecionarData.edtDataFinal.Date;
    frmRelVendaPorData.QryVendas.Open;
    frmRelVendaPorData.Relatorio.PreviewModal;
  finally
    frmSelecionarData.Release;
    frmRelVendaPorData.Release;
  end;
end;

procedure TfrmPrincipal.AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
begin
  aForm.chkConexao.Checked := True;
  aForm.Refresh;
  Sleep(100);
  dtmPrincipal.QryScriptCategorias.ExecSQL;
  aForm.chkCategoria.Checked := True;
  aForm.Refresh;
  Sleep(100);
  dtmPrincipal.QryScriptProdutos.ExecSQL;
  aForm.chkProduto.Checked := True;
  aForm.Refresh;
  Sleep(100);
  dtmPrincipal.QryScriptClientes.ExecSQL;
  aForm.chkCliente.Checked := True;
  aForm.Refresh;
  Sleep(100);
  dtmPrincipal.QryScriptVendas.ExecSQL;
  aForm.chkVendas.Checked := True;
  aForm.Refresh;
  Sleep(100);
  dtmPrincipal.QryScriptItensVendas.ExecSQL;
  aForm.chkItensVenda.Checked := True;
  aForm.Refresh;
  Sleep(100);
  dtmPrincipal.QryScriptUsuarios.ExecSQL;
  aForm.chkUsuarios.Checked := True;
  aForm.Refresh;
  Sleep(100);
end;

end.
