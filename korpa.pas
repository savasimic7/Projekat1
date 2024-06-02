unit korpa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.Edit;

type
  TProizvod = record
    Naziv: string;
    Kolicina: Integer;
    Cena: Double;
    Velicina: string;  // Dodaj polje za veličinu proizvoda
  end;

  TformKorpa = class(TForm)
    ListBoxKorpa: TListBox;
    buttonNaruci: TButton;
    buttonNazad: TButton;
    TextUkupnaCena: TText;
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonNaruciClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure buttonMuskarciClick(Sender: TObject);
  private
    procedure IzracunajUkupnuCenu;
  public
    procedure DodajUkorpu(Proizvod: TProizvod);
  end;

var
  formKorpa: TformKorpa;
  ListaProizvoda: array of TProizvod;

implementation

uses main, dm, nalog, muskaOprema, RegisteredMain, login;

{$R *.fmx}

procedure TformKorpa.buttonNazadClick(Sender: TObject);
begin
  formKorpa.Hide;
  formMuskaOprema.Show;
end;

procedure TformKorpa.buttonMuskarciClick(Sender: TObject);
begin
  formKorpa.hide;
  formMuskaOprema.show;
end;

procedure TformKorpa.buttonNaruciClick(Sender: TObject);
var
  I: Integer;
  NarudzbinaID: Integer;
  KorisnikEmail: string;
begin
  // Preuzmi email korisnika iz forme za login
  KorisnikEmail := formLogin.editEmail.Text;

  // Upisivanje narudžbine u bazu
  with dm.db do
  begin
    // Upis nove narudžbine
    qtemp.SQL.Text := 'INSERT INTO narudzbine (email) VALUES (:email)';
    qtemp.ParamByName('email').AsString := KorisnikEmail;
    qtemp.ExecSQL;

    // Dohvati poslednje uneseni ID narudžbine
    qtemp.SQL.Text := 'SELECT last_insert_rowid() AS id';
    qtemp.Open;
    NarudzbinaID := qtemp.FieldByName('id').AsInteger;
  end;

  // Upisivanje svakog proizvoda iz korpe u tabelu proizvodi_u_narudzbini
  for I := 0 to High(ListaProizvoda) do
  begin
    with dm.db do
    begin
      qtemp.SQL.Text := 'INSERT INTO proizvodi_u_narudzbini (narudzbina_id, naziv_proizvoda, velicina, kolicina, cena) ' +
                        'VALUES (:narudzbina_id, :naziv_proizvoda, :velicina, :kolicina, :cena)';
      qtemp.ParamByName('narudzbina_id').AsInteger := NarudzbinaID;
      qtemp.ParamByName('naziv_proizvoda').AsString := ListaProizvoda[I].Naziv;
      qtemp.ParamByName('velicina').AsString := ListaProizvoda[I].Velicina;  // Veličina proizvoda
      qtemp.ParamByName('kolicina').AsInteger := ListaProizvoda[I].Kolicina;
      qtemp.ParamByName('cena').AsFloat := ListaProizvoda[I].Cena;
      qtemp.ExecSQL;
    end;
  end;

  ShowMessage('Narudžbina je uspešno poslata!');

  // Očisti korpu nakon naručivanja
  ListBoxKorpa.Clear;
  SetLength(ListaProizvoda, 0);
  TextUkupnaCena.Text := 'Ukupna cena: 0 RSD';
end;


procedure TformKorpa.DodajUkorpu(Proizvod: TProizvod);
var
  ListBoxItem: TListBoxItem;
begin
  // Dodaj proizvod u listu
  SetLength(ListaProizvoda, Length(ListaProizvoda) + 1);
  ListaProizvoda[High(ListaProizvoda)] := Proizvod;

  // Kreiraj novi ListBoxItem
  ListBoxItem := TListBoxItem.Create(ListBoxKorpa);

  // Postavi tekst za ListBoxItem sa prikazom veličine
  ListBoxItem.Text := Format('%s - Veličina: %s - Količina: %d - %.2f RSD',
    [Proizvod.Naziv, Proizvod.Velicina, Proizvod.Kolicina, Proizvod.Cena]);
  ListBoxKorpa.AddObject(ListBoxItem);

  // Ažuriraj ukupnu cenu
  IzracunajUkupnuCenu;
end;

procedure TformKorpa.Image3Click(Sender: TObject);
begin
  formKorpa.hide;
  formNalog.show;
end;

procedure TformKorpa.IzracunajUkupnuCenu;
var
  I: Integer;
  UkupnaCena: Double;
begin
  UkupnaCena := 0;
  for I := 0 to High(ListaProizvoda) do
    UkupnaCena := UkupnaCena + (ListaProizvoda[I].Cena * ListaProizvoda[I].Kolicina);

  TextUkupnaCena.Text := Format('Ukupna cena: %.2f RSD', [UkupnaCena]);
end;

end.

