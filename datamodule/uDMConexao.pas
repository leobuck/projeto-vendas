unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, ZAbstractConnection, ZConnection, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TdtmPrincipal = class(TDataModule)
    ConexaoDB: TZConnection;
    QryScriptCategorias: TZQuery;
    QryScriptClientes: TZQuery;
    QryScriptProdutos: TZQuery;
    QryScriptVendas: TZQuery;
    QryScriptItensVendas: TZQuery;
    QryScriptUsuarios: TZQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
