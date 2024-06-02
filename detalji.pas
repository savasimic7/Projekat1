unit detalji;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TformDetalji = class(TForm)
    layoutBottom: TLayout;
    buttonnazad: TButton;
    layoutclient: TLayout;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    layoutNavBar: TLayout;
    buttonMuskarci: TButton;
    buttonBrendovi: TButton;
    buttonZene: TButton;
    Line1: TLine;
    Layout1: TLayout;
    Layout2: TLayout;
    Text2: TText;
    TextOpis: TText;
    radioButtonS: TRadioButton;
    radioButtonXL: TRadioButton;
    radioButtonL: TRadioButton;
    RadioButtonM: TRadioButton;
    Layout3: TLayout;
    buttonDodajUKorpu: TButton;
    textKolicina: TText;
    textNaziv: TText;
    Layout4: TLayout;
    textCenaP: TText;
    buttonPovecajKolicinu: TButton;  // Dugme za povećanje količine
    buttonSmanjiKolicinu: TButton;
    Image1: TImage;   // Dugme za smanjenje količine
    procedure buttonnazadClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure buttonPovecajKolicinuClick(Sender: TObject);
    procedure buttonSmanjiKolicinuClick(Sender: TObject);
    procedure buttonDodajUKorpuClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    procedure AžurirajKolicinu(Korak: Integer);
    function DohvatiOdabranuVelicinu: string; // Nova funkcija za odabranu veličinu
  public
    { Public declarations }
  end;

var
  formDetalji: TformDetalji;

implementation

uses muskaOprema, nalog, korpa;

{$R *.fmx}

// Procedura za dodavanje proizvoda u korpu
procedure TformDetalji.buttonDodajUKorpuClick(Sender: TObject);
var
  NoviProizvod: TProizvod;
  CenaTekst, Velicina: string;
begin
  // Ukloni valutu iz cene i konvertuj u float
  CenaTekst := StringReplace(textCenaP.Text, ' RSD', '', [rfReplaceAll]);
  CenaTekst := StringReplace(CenaTekst, '.', '', [rfReplaceAll]);  // Ukloni tačku za hiljade
  CenaTekst := StringReplace(CenaTekst, ',', '.', [rfReplaceAll]);
  CenaTekst := StringReplace(CenaTekst, 'Cena: ', '', [rfReplaceAll]); // Zarez zameni tačkom za decimalne brojeve

  // Postavi podatke o proizvodu
  NoviProizvod.Naziv := textNaziv.Text;
  NoviProizvod.Kolicina := StrToInt(textKolicina.Text);  // Konvertuj količinu u broj
  NoviProizvod.Cena := StrToFloat(CenaTekst);            // Konvertuj cenu u float
  Velicina := DohvatiOdabranuVelicinu;                   // Dohvati veličinu
  NoviProizvod.Velicina := Velicina;                     // Dodaj veličinu proizvodu

  // Proveri da li je veličina odabrana
  if Velicina = '' then
  begin
    ShowMessage('Molimo izaberite veličinu!');
    Exit;
  end;

  // Dodaj proizvod u korpu
  formKorpa.DodajUkorpu(NoviProizvod);
  ShowMessage('Proizvod je dodan u korpu sa veličinom: ' + Velicina);
  formDetalji.hide;
  formKorpa.show;
end;

// Funkcija za dohvatanje odabrane veličine
function TformDetalji.DohvatiOdabranuVelicinu: string;
begin
  if radioButtonS.IsChecked then
    Result := 'S'
  else if RadioButtonM.IsChecked then
    Result := 'M'
  else if radioButtonL.IsChecked then
    Result := 'L'
  else if radioButtonXL.IsChecked then
    Result := 'XL'
  else
    ShowMessage('Molimo izaberite  velicinu!')  // Ako nijedna veličina nije odabrana
end;

procedure TformDetalji.buttonnazadClick(Sender: TObject);
begin
  formDetalji.Hide;
  formMuskaOprema.Show;
end;

procedure TformDetalji.Image1Click(Sender: TObject);
begin
    formDetalji.hide;
    formKorpa.show;
end;

procedure TformDetalji.Image3Click(Sender: TObject);
begin
  formDetalji.Hide;
  formNalog.show;
end;

// Funkcija za povećanje količine
procedure TformDetalji.buttonPovecajKolicinuClick(Sender: TObject);
begin
  AžurirajKolicinu(1);  // Povećaj količinu za 1
end;

// Funkcija za smanjenje količine
procedure TformDetalji.buttonSmanjiKolicinuClick(Sender: TObject);
begin
  AžurirajKolicinu(-1);  // Smanji količinu za 1
end;

// Funkcija za ažuriranje količine
procedure TformDetalji.AžurirajKolicinu(Korak: Integer);
var
  Kolicina: Integer;
begin
  if textKolicina.Text = '' then
    Kolicina := 0  // Postavi na 0 ako je polje prazno
  else
    Kolicina := StrToInt(textKolicina.Text);  // Pretvori tekst u broj

  // Ažuriraj količinu
  Kolicina := Kolicina + Korak;
  if Kolicina < 0 then
    Kolicina := 0;

  textKolicina.Text := IntToStr(Kolicina);  // Ažuriraj tekstualno polje
end;


end.

