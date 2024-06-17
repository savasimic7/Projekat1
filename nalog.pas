unit nalog;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TformNalog = class(TForm)
    layoutclient: TLayout;
    Image1: TImage;
    Rectangle1: TRectangle;
    S: TLayout;
    buttonNazad: TButton;
    Layout2: TLayout;
    Image2: TImage;
    textTelefon: TText;
    TextAdresa: TText;
    textImePrezime: TText;
    textPol: TText;
    Textsifra: TText;
    textEmail: TText;
    buttonOdjava: TButton;
    buttonNarudzbine: TButton;
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonOdjavaClick(Sender: TObject);
    procedure buttonNarudzbineClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formNalog: TformNalog;

implementation

uses registeredMain, main, narudzbine;

{$R *.fmx}

procedure TformNalog.buttonNarudzbineClick(Sender: TObject);
begin
    formNalog.hide;
    formNarudzbine.show;
end;

procedure TformNalog.buttonNazadClick(Sender: TObject);
begin
    formNalog.hide;
    formRegMain.show;
end;

procedure TformNalog.buttonOdjavaClick(Sender: TObject);
begin
    formNalog.hide;
    formMain.show;
end;

end.
