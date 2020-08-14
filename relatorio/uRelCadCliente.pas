unit uRelCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDMConexao, RLReport, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RLFilters, RLPDFFilter;

type
  TfrmRelCadCliente = class(TForm)
    QryCliente: TZQuery;
    dsCliente: TDataSource;
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
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLBand2: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel5: TRLLabel;
    RLLabel4: TRLLabel;
    QryClienteclienteId: TIntegerField;
    QryClientenome: TWideStringField;
    QryClienteemail: TWideStringField;
    QryClientetelefone: TWideStringField;
    RLLabel6: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText4: TRLDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadCliente: TfrmRelCadCliente;

implementation

{$R *.dfm}


procedure TfrmRelCadCliente.FormCreate(Sender: TObject);
begin
  QryCliente.Open;
end;

procedure TfrmRelCadCliente.FormDestroy(Sender: TObject);
begin
  QryCliente.Close;
end;

end.
