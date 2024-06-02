unit kontakt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TformKontakt = class(TForm)
    layoutclient: TLayout;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    Line1: TLine;
    Text2: TText;
    Image1: TImage;
    Text3: TText;
    Text4: TText;
    Layout1: TLayout;
    Text5: TText;
    buttonKontakt: TButton;
    buttonNazad: TButton;
    procedure Image3Click(Sender: TObject);
    procedure buttonNazadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formKontakt: TformKontakt;

implementation

uses nalog, registeredMain;

{$R *.fmx}

procedure TformKontakt.buttonNazadClick(Sender: TObject);
begin
    formKontakt.hide;
    formRegMain.show;
end;

procedure TformKontakt.Image3Click(Sender: TObject);
begin
    formKontakt.hide;
    formNalog.show;
end;

end.
