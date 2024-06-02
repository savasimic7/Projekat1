unit artikli;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TformArtikli = class(TForm)
    layoutBottom: TLayout;
    buttonnazad: TButton;
    layoutclient: TLayout;
    layoutNavBar: TLayout;
    buttonMuskarci: TButton;
    buttonBrendovi: TButton;
    buttonZene: TButton;
    Line1: TLine;
    Text2: TText;  // Polje gde se prikazuje brend
    Layout1: TLayout;
    Layout2: TLayout;
    Text3: TText;
    buttonDuksevi: TButton;
    buttonAksesoari: TButton;
    buttonSorcevi: TButton;
    buttonPantalone: TButton;
    buttonPatike: TButton;
    buttonMajice: TButton;
    Line2: TLine;
    ListBox1: TListBox;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    Image1: TImage;
    procedure Image3Click(Sender: TObject);
    procedure buttonnazadClick(Sender: TObject);
    procedure buttonBrendoviClick(Sender: TObject);
    procedure buttonZeneClick(Sender: TObject);
    procedure buttonMuskarciClick(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure buttonDukseviClick(Sender: TObject);
    procedure buttonMajiceClick(Sender: TObject);
    procedure buttonPatikeClick(Sender: TObject);
    procedure buttonPantaloneClick(Sender: TObject);
    procedure buttonSorceviClick(Sender: TObject);
    procedure buttonAksesoariClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);

  private
    { Private declarations }
    FSelectedCategory: string;  // Promenljiva za čuvanje selektovane kategorije
  public
    procedure PrikaziArtikleZaBrend(Brend: string); // Procedura za prikaz artikala po brendu
  end;

var
  formArtikli: TformArtikli;

implementation

uses nalog, brendovi, dm, zenskaOprema, MuskaOprema, registeredMain, detalji, korpa;

{$R *.fmx}

// Procedura za prikaz artikala po brendu
procedure TformArtikli.PrikaziArtikleZaBrend(Brend: string);
begin
  ListBox1.Clear;  // Očisti ListBox pre dodavanja novih artikala
  Text2.Text := '• Brendovi - ' + Brend;  // Ažuriraj Text2 sa izabranim brendom

  with dm.db do
  begin
    // SQL upit za artikle određenog brenda
    qtemp.SQL.Text := 'SELECT naziv, cena FROM (' +
                      'SELECT naziv, cena FROM Duksevi WHERE brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, cena FROM Majice WHERE brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, cena FROM Patike WHERE brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, cena FROM Pantalone WHERE brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, cena FROM Sorcevi WHERE brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, cena FROM Aksesoari WHERE brend = :brend)';
    qtemp.ParamByName('brend').AsString := Brend;
    qtemp.Open;

    // Dodaj artikle u ListBox
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add(qtemp.FieldByName('naziv').AsString + ' - ' +
                         IntToStr(qtemp.FieldByName('cena').AsInteger) + ' RSD');
      qtemp.Next;
    end;
  end;
end;

procedure TformArtikli.buttonAksesoariClick(Sender: TObject);
begin
  FSelectedCategory := 'Aksesoari';
end;

procedure TformArtikli.buttonDukseviClick(Sender: TObject);
begin
  FSelectedCategory := 'Duksevi';
end;

procedure TformArtikli.buttonMajiceClick(Sender: TObject);
begin
  FSelectedCategory := 'Majice';
end;

procedure TformArtikli.buttonPatikeClick(Sender: TObject);
begin
  FSelectedCategory := 'Patike';
end;

procedure TformArtikli.buttonPantaloneClick(Sender: TObject);
begin
  FSelectedCategory := 'Pantalone';
end;

procedure TformArtikli.buttonSorceviClick(Sender: TObject);
begin
  FSelectedCategory := 'Sorcevi';
end;

procedure TformArtikli.buttonBrendoviClick(Sender: TObject);
begin
  formArtikli.Hide;
  formBrendovi.Show;
end;

procedure TformArtikli.buttonZeneClick(Sender: TObject);
begin
  formArtikli.Hide;
  formZenskaOprema.Show;
end;

procedure TformArtikli.buttonMuskarciClick(Sender: TObject);
begin
  formArtikli.Hide;
  formMuskaOprema.Show;
end;

procedure TformArtikli.buttonnazadClick(Sender: TObject);
begin
  formArtikli.Hide;
  formBrendovi.Show;
end;

procedure TformArtikli.Image1Click(Sender: TObject);
begin
    formArtikli.hide;
    formKorpa.show;
end;

procedure TformArtikli.image3Click(Sender: TObject);
begin
  formArtikli.Hide;
  formKorpa.Show;
end;

// Kada korisnik klikne na artikal u ListBox-u
procedure TformArtikli.ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
var
  naziv, cena: string;
begin
  // Parsiraj naziv i cenu iz Item.Text
  if Pos('-', Item.Text) > 0 then
  begin
    naziv := Trim(Copy(Item.Text, 1, Pos('-', Item.Text) - 1)); // Pre '-'
    cena := Trim(Copy(Item.Text, Pos('-', Item.Text) + 1, Length(Item.Text))); // Posle '-'

    // Sada radi upit u bazi da dobijemo dodatne detalje
    with dm.db do
    begin
      qtemp.SQL.Text := 'SELECT naziv, brend, cena, opis FROM ' + FSelectedCategory + ' WHERE naziv = :naziv';
      qtemp.ParamByName('naziv').AsString := naziv;
      qtemp.Open;

      // Ako su pronađeni podaci, prebaci na formu sa detaljima
      if not qtemp.Eof then
      begin
        // Popuni formu sa detaljima
        formDetalji.textNaziv.Text := 'Naziv: ' + qtemp.FieldByName('naziv').AsString;
        formDetalji.TextOpis.Text := 'Opis: ' + qtemp.FieldByName('opis').AsString;

        // Provera i prikaz cene
        if not qtemp.FieldByName('cena').IsNull then
        begin
          formDetalji.TextCenaP.Text := 'Cena: ' + IntToStr(qtemp.FieldByName('cena').AsInteger) + ' RSD';
        end
        else
        begin
          formDetalji.TextCenaP.Text := 'Cena: N/A';
        end;

        formDetalji.textKolicina.Text := '1';  // Inicijalna količina

        // Prebaci na formu 'Detalji'
        formArtikli.Hide;
        formDetalji.Show;
      end
      else
      begin
        ShowMessage('Nema podataka za izabrani artikal!');
      end;
    end;
  end
  else
  begin
    ShowMessage('Greška u formatu unosa artikla!');
  end;
end;

end.

