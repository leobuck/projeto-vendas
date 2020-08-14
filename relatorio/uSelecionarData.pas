unit uSelecionarData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  RxToolEdit, System.DateUtils;

type
  TfrmSelecionarData = class(TForm)
    edtDataInicial: TDateEdit;
    Label3: TLabel;
    edtDataFinal: TDateEdit;
    Label1: TLabel;
    btnOK: TBitBtn;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecionarData: TfrmSelecionarData;

implementation

{$R *.dfm}

procedure TfrmSelecionarData.btnOKClick(Sender: TObject);
begin
   if (edtDataFinal.Date) < (edtDataInicial.Date) then begin
     MessageDlg('Data Final não pode ser maior que a Data Inicial!', mtInformation, [mbOK], 0);
     edtDataFinal.SetFocus;
     Abort;
   end;

   if (edtDataInicial.Date = 0) then begin
     MessageDlg('Data Inicial é campo obrigatório!', mtInformation, [mbOK], 0);
     edtDataInicial.SetFocus;
     Abort;
   end;

   if (edtDataFinal.Date = 0) then begin
     MessageDlg('Data Final é campo obrigatório!', mtInformation, [mbOK], 0);
     edtDataFinal.SetFocus;
     Abort;
   end;

   Close;
end;

procedure TfrmSelecionarData.FormShow(Sender: TObject);
begin
  edtDataInicial.Date := StartOfTheMonth(Date);
  edtDataFinal.Date   := EndOfTheMonth(Date);
end;

end.
