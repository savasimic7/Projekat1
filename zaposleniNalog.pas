unit zaposleniNalog;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TformZaposleniNalog = class(TForm)
    layoutclient: TLayout;
    Image1: TImage;
    Rectangle1: TRectangle;
    Image2: TImage;
    textTelefon: TText;
    TextAdresa: TText;
    textImePrezime: TText;
    textPol: TText;
    Textsifra: TText;
    textEmail: TText;
    S: TLayout;
    buttonNazad: TButton;
    Layout2: TLayout;
    buttonOdjava: TButton;
    procedure buttonOdjavaClick(Sender: TObject);
    procedure buttonNazadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formZaposleniNalog: TformZaposleniNalog;

implementation

uses main, adminMain;

{$R *.fmx}

procedure TformZaposleniNalog.buttonNazadClick(Sender: TObject);
begin
    formZaposleniNalog.hide;
    formAdminMain.show;
end;

procedure TformZaposleniNalog.buttonOdjavaClick(Sender: TObject);
begin
    formZaposleniNalog.hide;
    formMain.show;
end;

end.
