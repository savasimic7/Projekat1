unit nabavka;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Math.Vectors, FMX.Edit, FMX.Controls3D, FMX.Layers3D;

type
  TformNabavka = class(TForm)
    layoutBottom: TLayout;
    buttonNazad: TButton;
    layoutclient: TLayout;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    buttonDodaj: TButton;
    Layout1: TLayout;
    radioAksesoari: TRadioButton;
    radioSorcevi: TRadioButton;
    radioPatike: TRadioButton;
    radioPantalone: TRadioButton;
    radioMajice: TRadioButton;
    radioDuksevi: TRadioButton;
    Layout2: TLayout;
    Layout3: TLayout;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Text9: TText;
    Edit6: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    S: TListBoxItem;
    XL: TListBoxItem;
    L: TListBoxItem;
    M: TListBoxItem;
    muski: TListBoxItem;
    zenski: TListBoxItem;
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonDodajClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formNabavka: TformNabavka;

implementation

uses stanjeProizvoda, dm;

{$R *.fmx}

procedure TformNabavka.buttonDodajClick(Sender: TObject);
var
  query: string;
  naziv, opis, brend, kolicina, velicina, cena, pol, boja: string;
begin
  // Učitaj vrednosti iz edit polja i combobox-ova
  naziv := Edit1.Text;
  opis := Edit2.Text;
  brend := Edit3.Text;
  kolicina := Edit6.Text;
  cena := Edit7.Text;
  boja := Edit8.Text;
  pol := ComboBox1.Selected.Text;
  if ComboBox2.Selected <> nil then
    velicina := ComboBox2.Selected.Text
  else
    velicina := '';

  // Sastavi SQL upit u zavisnosti od selektovanog radio button-a
  if radioAksesoari.IsChecked then
  begin
    // Ako je selektovan radioAksesoari, ignorišemo veličinu
    query := 'INSERT INTO Aksesoari (naziv, opis, brend, kolicina, cena, pol, boja) VALUES (''' +
             naziv + ''', ''' + opis + ''', ''' + brend + ''', ''' + kolicina + ''', ''' +
             cena + ''', ''' + pol + ''', ''' + boja + ''')';
  end
  else if radioDuksevi.IsChecked then
  begin
    query := 'INSERT INTO Duksevi (naziv, opis, brend, kolicina, velicina, cena, pol, boja) VALUES (''' +
             naziv + ''', ''' + opis + ''', ''' + brend + ''', ''' + kolicina + ''', ''' +
             velicina + ''', ''' + cena + ''', ''' + pol + ''', ''' + boja + ''')';
  end
  else if radioMajice.IsChecked then
  begin
    query := 'INSERT INTO Majice (naziv, opis, brend, kolicina, velicina, cena, pol, boja) VALUES (''' +
             naziv + ''', ''' + opis + ''', ''' + brend + ''', ''' + kolicina + ''', ''' +
             velicina + ''', ''' + cena + ''', ''' + pol + ''', ''' + boja + ''')';
  end
  else if radioPatike.IsChecked then
  begin
    query := 'INSERT INTO Patike (naziv, opis, brend, kolicina, velicina, cena, pol, boja) VALUES (''' +
             naziv + ''', ''' + opis + ''', ''' + brend + ''', ''' + kolicina + ''', ''' +
             velicina + ''', ''' + cena + ''', ''' + pol + ''', ''' + boja + ''')';
  end
  else if radioPantalone.IsChecked then
  begin
    query := 'INSERT INTO Pantalone (naziv, opis, brend, kolicina, velicina, cena, pol, boja) VALUES (''' +
             naziv + ''', ''' + opis + ''', ''' + brend + ''', ''' + kolicina + ''', ''' +
             velicina + ''', ''' + cena + ''', ''' + pol + ''', ''' + boja + ''')';
  end
  else if radioSorcevi.IsChecked then
  begin
    query := 'INSERT INTO Sorcevi (naziv, opis, brend, kolicina, velicina, cena, pol, boja) VALUES (''' +
             naziv + ''', ''' + opis + ''', ''' + brend + ''', ''' + kolicina + ''', ''' +
             velicina + ''', ''' + cena + ''', ''' + pol + ''', ''' + boja + ''')';
  end
  else
  begin
    ShowMessage('Morate izabrati kategoriju proizvoda.');
    Exit;
  end;

  // Pokreni upit
  try
    dm.db.qtemp.SQL.Text := query;
    dm.db.qtemp.ExecSQL;
    ShowMessage('Proizvod uspešno dodat!');
  except
    on E: Exception do
      ShowMessage('Greška prilikom dodavanja proizvoda: ' + E.Message);
  end;
end;


procedure TformNabavka.buttonNazadClick(Sender: TObject);
begin
formNabavka.hide;
formStanjeProizvoda.show;
end;

end.
