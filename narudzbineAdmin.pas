unit narudzbineAdmin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param;

type
  TformNarudzbineAdmin = class(TForm)
    layoutBottom: TLayout;
    buttonNazad: TButton;
    layoutClient: TLayout;
    ListBox1: TListBox;
    Layout2: TLayout;
    Layout3: TLayout;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Naziv: TText;
    Layout4: TLayout;
    editStanje: TEdit;
    editSumaCene: TEdit;
    editKolicina: TEdit;
    editVelicina: TEdit;
    editCena: TEdit;
    editNaziv: TEdit;
    editEmail: TEdit;
    buttonIzmeni: TButton;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure buttonNazadClick(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure buttonIzmeniClick(Sender: TObject);
  private
    procedure UcitajSveNarudzbine;
    procedure PrikaziPodatkeONarudzbini;
  public
    { Public declarations }
  end;

var
  formNarudzbineAdmin: TformNarudzbineAdmin;
  IzabranaNarudzbinaID: Integer;

implementation

uses zaposleniNalog, dm, adminMain;

{$R *.fmx}

// Kada se forma prikaže, učitaj sve narudžbine
procedure TformNarudzbineAdmin.FormShow(Sender: TObject);
begin
  UcitajSveNarudzbine;
end;

procedure TformNarudzbineAdmin.buttonNazadClick(Sender: TObject);
begin
  formNarudzbineAdmin.Hide;
  formAdminMain.Show;
end;

procedure TformNarudzbineAdmin.Image3Click(Sender: TObject);
begin
  formNarudzbineAdmin.Hide;
  formZaposleniNalog.Show;
end;

// Procedura za učitavanje svih narudžbina iz baze
procedure TformNarudzbineAdmin.UcitajSveNarudzbine;
begin
  ListBox1.Clear;

  with dm.db.qtemp do
  begin
    SQL.Text := 'SELECT narudzbina_id, naziv_proizvoda, kolicina FROM proizvodi_u_narudzbini';
    Open;
    while not Eof do
    begin
      ListBox1.Items.Add(FieldByName('naziv_proizvoda').AsString + ' - ' + FieldByName('kolicina').AsString);
      Next;
    end;
  end;
end;

// Procedura za prikaz podataka o izabranoj narudžbini
procedure TformNarudzbineAdmin.PrikaziPodatkeONarudzbini;
var
  IzabranaStavka, NazivProizvoda: string;
begin
  IzabranaStavka := ListBox1.Items[ListBox1.ItemIndex];  // Uzmi izabranu stavku
  NazivProizvoda := Copy(IzabranaStavka, 1, Pos(' - ', IzabranaStavka) - 1); // Izdvoji naziv proizvoda

  with dm.db.qtemp do
  begin
    SQL.Text := 'SELECT * FROM proizvodi_u_narudzbini WHERE naziv_proizvoda = :naziv';
    ParamByName('naziv').AsString := NazivProizvoda;
    Open;

    // Prikaži podatke u poljima za izmenu
    editNaziv.Text := FieldByName('naziv_proizvoda').AsString;
    editKolicina.Text := FieldByName('kolicina').AsString;
    editVelicina.Text := FieldByName('velicina').AsString;
    editCena.Text := FieldByName('cena').AsString;
    editSumaCene.Text := FieldByName('ukupna_cena').AsString;
    editEmail.Text := FieldByName('email').AsString;
    editStanje.Text := FieldByName('stanje').AsString;

    // Zapamti ID narudžbine
    IzabranaNarudzbinaID := FieldByName('narudzbina_id').AsInteger;
  end;
end;



// Procedura za ažuriranje podataka izabrane narudžbine
procedure TformNarudzbineAdmin.buttonIzmeniClick(Sender: TObject);
begin
  with dm.db.qtemp do
  begin
    SQL.Text := 'UPDATE proizvodi_u_narudzbini SET naziv_proizvoda = :naziv, kolicina = :kolicina, velicina = :velicina, cena = :cena, ukupna_cena = :ukupna_cena, email = :email, stanje = :stanje WHERE narudzbina_id = :id';
    ParamByName('naziv').AsString := editNaziv.Text;
    ParamByName('kolicina').AsString := editKolicina.Text;
    ParamByName('velicina').AsString := editVelicina.Text;
    ParamByName('cena').AsString := editCena.Text;
    ParamByName('ukupna_cena').AsString := editSumaCene.Text;
    ParamByName('email').AsString := editEmail.Text;
    ParamByName('stanje').AsString := editStanje.Text;
    ParamByName('id').AsInteger := IzabranaNarudzbinaID;
    ExecSQL;

    ShowMessage('Narudžbina uspešno izmenjena!');
  end;
end;

// Procedura koja se poziva kada se klikne na stavku u ListBox-u
procedure TformNarudzbineAdmin.ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  PrikaziPodatkeONarudzbini;
end;

end.

