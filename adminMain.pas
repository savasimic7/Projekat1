unit adminMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TformAdminMain = class(TForm)
    layoutBottom: TLayout;
    layoutclient: TLayout;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    buttonNarudzbine: TButton;
    buttonStanjeProizvoda: TButton;
    buttonReklamacije: TButton;
    procedure Image3Click(Sender: TObject);
    procedure buttonStanjeProizvodaClick(Sender: TObject);
    procedure buttonNarudzbineClick(Sender: TObject);
    procedure buttonReklamacijeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAdminMain: TformAdminMain;

implementation

uses nalog, zaposleniNalog, stanjeProizvoda, narudzbineAdmin, adminReklamacije;

{$R *.fmx}

procedure TformAdminMain.buttonNarudzbineClick(Sender: TObject);
begin
    formAdminMain.hide;
    formNarudzbineAdmin.show;
end;

procedure TformAdminMain.buttonReklamacijeClick(Sender: TObject);
begin
    formAdminMain.hide;
    formAdminReklamacije.show;
end;

procedure TformAdminMain.buttonStanjeProizvodaClick(Sender: TObject);
begin
    formAdminMain.hide;
    formStanjeProizvoda.show;
end;

procedure TformAdminMain.Image3Click(Sender: TObject);
begin
    formAdminMain.hide;
    formZaposleniNalog.show;
end;

end.
