unit uFrmAtualizaDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmAtualizaDB = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    chkConexao: TCheckBox;
    chkCategoria: TCheckBox;
    chkProduto: TCheckBox;
    chkCliente: TCheckBox;
    chkVendas: TCheckBox;
    chkItensVenda: TCheckBox;
    chkUsuarios: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAtualizaDB: TfrmAtualizaDB;

implementation

{$R *.dfm}

end.
