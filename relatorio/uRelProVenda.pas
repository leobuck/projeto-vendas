unit uRelProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDMConexao, RLReport, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RLFilters, RLPDFFilter;

type
  TfrmRelProVenda = class(TForm)
    QryVendas: TZQuery;
    dsVenda: TDataSource;
    Relatorio: TRLReport;
    Cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    RLPDFFilter1: TRLPDFFilter;
    Rodape: TRLBand;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    BandaDoGrupo: TRLGroup;
    RLBand3: TRLBand;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel8: TRLLabel;
    RLDBText5: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult2: TRLDBResult;
    RLDraw4: TRLDraw;
    RLLabel5: TRLLabel;
    QryVendasItens: TZQuery;
    dsVendasItens: TDataSource;
    QryVendasVendaId: TIntegerField;
    QryVendasClienteId: TIntegerField;
    QryVendasNome: TWideStringField;
    QryVendasdataVenda: TDateTimeField;
    QryVendastotalVenda: TFloatField;
    QryVendasItensVendaId: TIntegerField;
    QryVendasItensProdutoId: TIntegerField;
    QryVendasItensNome: TWideStringField;
    QryVendasItensQuantidade: TFloatField;
    QryVendasItensValorUnitario: TFloatField;
    QryVendasItensTotalProduto: TFloatField;
    RLLabel6: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel7: TRLLabel;
    RLSubDetail1: TRLSubDetail;
    RLBand2: TRLBand;
    RLBand4: TRLBand;
    RLDBText3: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelProVenda: TfrmRelProVenda;

implementation

{$R *.dfm}


procedure TfrmRelProVenda.FormDestroy(Sender: TObject);
begin
  QryVendas.Close;
  QryVendasItens.Close;
end;

end.
