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
    procedure buttonNazadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formNalog: TformNalog;

implementation

uses registeredMain;

{$R *.fmx}

procedure TformNalog.buttonNazadClick(Sender: TObject);
begin
    formNalog.hide;
    formRegMain.show;
end;

end.
