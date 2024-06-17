unit stanjeProizvoda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.DApt.Intf,
  FMX.Edit;

type
  TformStanjeProizvoda = class(TForm)
    layoutBottom: TLayout;
    layoutclient: TLayout;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    ListBox1: TListBox;
    buttonNazad: TButton;
    Layout1: TLayout;
    buttonPotvrdiFilter: TButton;
    comboBoxVrsta: TComboBox;
    Aksesoari: TListBoxItem;
    Duksevi: TListBoxItem;
    Majice: TListBoxItem;
    Pantalone: TListBoxItem;
    Patike: TListBoxItem;
    Sorcevi: TListBoxItem;
    Button1: TButton;
    Layout2: TLayout;
    Layout3: TLayout;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Text9: TText;
    Layout4: TLayout;
    editNaziv: TEdit;
    editKolicina: TEdit;
    editBrend: TEdit;
    editCena: TEdit;
    editOpis: TEdit;
    editVelicina: TEdit;
    editPol: TEdit;
    editBoja: TEdit;
    buttonIzmeni: TButton;
    procedure FormShow(Sender: TObject);
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonPotvrdiFilterClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure buttonIzmeniClick(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem); // Dodata procedura
  private
    procedure UcitajSveProizvode;
    procedure PrikaziPodatkeProizvoda; // Dodata procedura
  public
    { Public declarations }
  end;

var
  formStanjeProizvoda: TformStanjeProizvoda;
  IzabraniProizvodID: Integer; // Dodata promenljiva za čuvanje ID-a izabranog proizvoda

implementation

uses dm, adminMain, zaposleniNalog, nabavka;

{$R *.fmx}

// Kada se forma prikaže, učitaj sve proizvode
procedure TformStanjeProizvoda.FormShow(Sender: TObject);
begin
  UcitajSveProizvode;  // Pozovi proceduru koja će učitati sve proizvode iz baze
end;

procedure TformStanjeProizvoda.Image3Click(Sender: TObject);
begin
  formStanjeProizvoda.Hide;
  formZaposleniNalog.Show;
end;

procedure TformStanjeProizvoda.Button1Click(Sender: TObject);
begin
  formStanjeProizvoda.Hide;
  formNabavka.Show;
end;

procedure TformStanjeProizvoda.buttonPotvrdiFilterClick(Sender: TObject);
var
  filterSQL: string;
begin
  ListBox1.Clear;

  // Osnovni upit
  filterSQL := 'SELECT naziv, brend FROM ';

  // Proveri da li je izabrana vrsta
  if comboBoxVrsta.Selected <> nil then
    filterSQL := filterSQL + comboBoxVrsta.Selected.Text
  else
  begin
    ShowMessage('Morate izabrati vrstu proizvoda.');
    Exit;
  end;

  // Otvaranje baze i prikazivanje rezultata
  with dm.db do
  begin
    qtemp.SQL.Text := filterSQL;
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add(qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

procedure TformStanjeProizvoda.buttonNazadClick(Sender: TObject);
begin
  formStanjeProizvoda.Hide;
  formAdminMain.Show;
end;

// Procedura za učitavanje svih proizvoda iz svih tabela
procedure TformStanjeProizvoda.UcitajSveProizvode;
begin
  ListBox1.Clear;

  with dm.db do
  begin
    // Učitavanje muških dukseva
    qtemp.SQL.Text := 'SELECT id, naziv, brend FROM Duksevi';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add(qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;

    // Učitavanje ostalih kategorija
    qtemp.SQL.Text := 'SELECT id, naziv, brend FROM Majice';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add(qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;

    // (Nastavi sa učitavanjem ostalih kategorija na sličan način)
  end;
end;

// Procedura za prikaz podataka o izabranom proizvodu u poljima
procedure TformStanjeProizvoda.PrikaziPodatkeProizvoda;
var
  IzabranaStavka: string;
  NazivProizvoda: string;
begin
  // Provera da li je nešto izabrano
  if ListBox1.ItemIndex = -1 then
  begin
    ShowMessage('Izaberite stavku iz liste.');
    Exit;
  end;

  // Uzimanje naziva proizvoda iz izabrane stavke (izdvajanjem naziva pre " - ")
  IzabranaStavka := ListBox1.Items[ListBox1.ItemIndex];
  NazivProizvoda := Copy(IzabranaStavka, 1, Pos(' - ', IzabranaStavka) - 1);

  // Provera i otvaranje upita za učitavanje podataka
  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT * FROM Duksevi WHERE naziv = :naziv';
    qtemp.ParamByName('naziv').AsString := NazivProizvoda;  // Koristimo samo naziv proizvoda
    qtemp.Open;

    if not qtemp.IsEmpty then
    begin
      // Popunjavanje edit polja
      editNaziv.Text := qtemp.FieldByName('naziv').AsString;
      editBrend.Text := qtemp.FieldByName('brend').AsString;
      editKolicina.Text := qtemp.FieldByName('kolicina').AsString;
      editCena.Text := qtemp.FieldByName('cena').AsString;
      editOpis.Text := qtemp.FieldByName('opis').AsString;
      editVelicina.Text := qtemp.FieldByName('velicina').AsString;
      editPol.Text := qtemp.FieldByName('pol').AsString;
      editBoja.Text := qtemp.FieldByName('boja').AsString;

      // Zapamti ID proizvoda
      IzabraniProizvodID := qtemp.FieldByName('id').AsInteger;
    end
    else
      ShowMessage('Proizvod nije pronađen u bazi.');
  end;
end;


// Procedura za ažuriranje podataka izabranog proizvoda
procedure TformStanjeProizvoda.buttonIzmeniClick(Sender: TObject);
begin
  with dm.db do
  begin
    qtemp.SQL.Text := 'UPDATE Duksevi SET naziv = :naziv, brend = :brend, kolicina = :kolicina, cena = :cena, opis = :opis, velicina = :velicina, pol = :pol, boja = :boja WHERE id = :id';
    qtemp.ParamByName('naziv').AsString := editNaziv.Text;
    qtemp.ParamByName('brend').AsString := editBrend.Text;
    qtemp.ParamByName('kolicina').AsString := editKolicina.Text;
    qtemp.ParamByName('cena').AsString := editCena.Text;
    qtemp.ParamByName('opis').AsString := editOpis.Text;
    qtemp.ParamByName('velicina').AsString := editVelicina.Text;
    qtemp.ParamByName('pol').AsString := editPol.Text;
    qtemp.ParamByName('boja').AsString := editBoja.Text;
    qtemp.ParamByName('id').AsInteger := IzabraniProizvodID;
    qtemp.ExecSQL;

    ShowMessage('Proizvod uspešno izmenjen!');
  end;
end;

procedure TformStanjeProizvoda.ListBox1ItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  PrikaziPodatkeProizvoda;
end;

end.

