unit registracija;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit;

type
  TformRegistracija = class(TForm)
    layoutclient: TLayout;
    Image1: TImage;
    Rectangle1: TRectangle;
    layoutImePrezime: TLayout;
    editIme: TEdit;
    Line1: TLine;
    Text1: TText;
    layoutEmail: TLayout;
    editEmail: TEdit;
    Line2: TLine;
    Text2: TText;
    layoutSifra: TLayout;
    Edit1: TEdit;
    Line3: TLine;
    Text3: TText;
    layoutAdresa: TLayout;
    Edit2: TEdit;
    Line4: TLine;
    Text4: TText;
    layoutPol: TLayout;
    Edit3: TEdit;
    Z: TText;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    layoutTelefon: TLayout;
    Edit4: TEdit;
    Line5: TLine;
    Text5: TText;
    buttonRegistracija: TButton;
    Layout1: TLayout;
    buttonNazad: TButton;
    procedure buttonNazadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formRegistracija: TformRegistracija;

implementation

uses main;

{$R *.fmx}

procedure TformRegistracija.buttonNazadClick(Sender: TObject);
begin
    formRegistracija.hide;
    formMain.Show;
end;

end.
