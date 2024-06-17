unit narudzbine;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TformNarudzbine = class(TForm)
    layoutBottom: TLayout;
    buttonnazad: TButton;
    layoutTop: TLayout;
    Text1: TText;
    Image1: TImage;
    Layout1: TLayout;
    ListBox1: TListBox;
    procedure buttonnazadClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem); // Procedura za klik na stavku
  private
    procedure UcitajNarudzbineKorisnika;
  public
    { Public declarations }
  end;

var
  formNarudzbine: TformNarudzbine;

implementation

uses nalog, korpa, dm, login, reklamacijaKorisnik;  // Dodaj reklamacijaKorisnik za pristup formi reklamacija

{$R *.fmx}

// Procedura koja se izvršava prilikom prikazivanja forme
procedure TformNarudzbine.FormShow(Sender: TObject);
begin
  UcitajNarudzbineKorisnika;  // Pozovi proceduru za učitavanje narudžbina
end;

// Procedura za učitavanje narudžbina korisnika
procedure TformNarudzbine.UcitajNarudzbineKorisnika;
var
  Item: TListBoxItem;
begin
  ListBox1.Clear;  // Očisti prethodne stavke u listi

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT naziv_proizvoda, kolicina, cena, velicina FROM proizvodi_u_narudzbini WHERE email = :email';
    qtemp.ParamByName('email').AsString := formLogin.editEmail.Text;  // Preuzmi email korisnika koji je ulogovan
    qtemp.Open;

    // Prolaz kroz sve proizvode u narudžbini i dodavanje u ListBox
    while not qtemp.Eof do
    begin
      Item := TListBoxItem.Create(ListBox1);
      Item.Text := Format('%s - Količina: %d - Cena: %.2f RSD - Veličina: %s',
                          [qtemp.FieldByName('naziv_proizvoda').AsString,
                           qtemp.FieldByName('kolicina').AsInteger,
                           qtemp.FieldByName('cena').AsFloat,
                           qtemp.FieldByName('velicina').AsString]);
      ListBox1.AddObject(Item);

      qtemp.Next;  // Idi na sledeći zapis
    end;

    qtemp.Close;
  end;
end;

// Procedura koja se pokreće kada se klikne na stavku u ListBoxu
procedure TformNarudzbine.ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  // Preneće podatke iz selektovanog proizvoda u formu za reklamaciju
  formReklamacijaK.textNazivArtikla.Text := Item.Text;
  formReklamacijaK.Show;  // Prikaz forme za reklamaciju
end;

procedure TformNarudzbine.buttonnazadClick(Sender: TObject);
begin
  formNarudzbine.Hide;
  formNalog.Show;
end;

procedure TformNarudzbine.Image1Click(Sender: TObject);
begin
  formNarudzbine.Hide;
  formKorpa.Show;
end;

end.
