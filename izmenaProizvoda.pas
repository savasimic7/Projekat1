unit izmenaProizvoda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListBox, FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts;

type
  TformIzmenaProizvoda = class(TForm)
    layoutBottom: TLayout;
    buttonNazad: TButton;
    buttonIzmeni: TButton;
    layoutclient: TLayout;
    Layout1: TLayout;
    Layout2: TLayout;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Text9: TText;
    Layout3: TLayout;
    editNaziv: TEdit;
    editKolicina: TEdit;
    editBrend: TEdit;
    editCena: TEdit;
    editOpis: TEdit;
    editVelicina: TEdit;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    editPol: TEdit;
    editBoja: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formIzmenaProizvoda: TformIzmenaProizvoda;

implementation

{$R *.fmx}

end.
