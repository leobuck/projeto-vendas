program Vendas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDMConexao in 'datamodule\uDMConexao.pas' {dtmPrincipal: TDataModule},
  uTelaHeranca in 'heranca\uTelaHeranca.pas' {frmTelaHeranca},
  uCadCategoria in 'cadastro\uCadCategoria.pas' {frmCadCategoria},
  Enter in 'terceiros\Enter.pas',
  uEnum in 'heranca\uEnum.pas',
  cCadCategoria in 'classes\cCadCategoria.pas',
  uCadCliente in 'cadastro\uCadCliente.pas' {frmCadCliente},
  cCadCliente in 'classes\cCadCliente.pas',
  uCadProduto in 'cadastro\uCadProduto.pas' {frmCadProduto},
  cCadProduto in 'classes\cCadProduto.pas',
  uFrmAtualizaDB in 'datamodule\uFrmAtualizaDB.pas' {frmAtualizaDB},
  uDMVenda in 'datamodule\uDMVenda.pas' {dtmVenda: TDataModule},
  uProVenda in 'processo\uProVenda.pas' {frmProVenda},
  cProVenda in 'classes\cProVenda.pas',
  cControleEstoque in 'classes\cControleEstoque.pas',
  uRelCadClienteFicha in 'relatorio\uRelCadClienteFicha.pas' {frmRelCadClienteFicha},
  uRelProVenda in 'relatorio\uRelProVenda.pas' {frmRelProVenda},
  uRelCadCliente in 'relatorio\uRelCadCliente.pas' {frmRelCadCliente},
  uRelCategoria in 'relatorio\uRelCategoria.pas' {frmRelCategoria},
  uRelCadProduto in 'relatorio\uRelCadProduto.pas' {frmRelCadProduto},
  uSelecionarData in 'relatorio\uSelecionarData.pas' {frmSelecionarData},
  uRelCadProdutoComGrupoCategoria in 'relatorio\uRelCadProdutoComGrupoCategoria.pas' {frmRelCadProdutoComGrupoCategoria},
  uRelVendaPorData in 'relatorio\uRelVendaPorData.pas' {frmRelVendaPorData},
  uFuncaoCriptografia in 'heranca\uFuncaoCriptografia.pas',
  uCadUsuario in 'cadastro\uCadUsuario.pas' {frmCadUsuario},
  cCadUsuario in 'classes\cCadUsuario.pas',
  uLogin in 'login\uLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
