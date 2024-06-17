unit adminReklamacije;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.DateTimeCtrls, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param;

type
  TformAdminReklamacije = class(TForm)
    layoutBottom: TLayout;
    buttonNazad: TButton;
    layoutClient: TLayout;
    ListBox1: TListBox;
    Layout2: TLayout;
    Layout3: TLayout;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Naziv: TText;
    Layout4: TLayout;
    editNapomena: TEdit;
    editNaziv: TEdit;
    editEmail: TEdit;
    editKolicina: TEdit;
    buttonIzmeni: TButton;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    DateEdit1: TDateEdit;
    editStatus: TEdit;
    editOpisProblema: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure buttonNazadClick(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure buttonIzmeniClick(Sender: TObject);
  private
    procedure UcitajSveReklamacije;
    procedure PrikaziPodatkeOReklamaciji;
  public
    { Public declarations }
  end;

var
  formAdminReklamacije: TformAdminReklamacije;
  IzabranaReklamacijaID: Integer;

implementation

uses dm, adminMain;

{$R *.fmx}

// Kada se forma prikaže, učitaj sve reklamacije
procedure TformAdminReklamacije.FormShow(Sender: TObject);
begin
  UcitajSveReklamacije;
end;

procedure TformAdminReklamacije.buttonNazadClick(Sender: TObject);
begin
  formAdminReklamacije.Hide;
  formAdminMain.Show;
end;

procedure TformAdminReklamacije.Image3Click(Sender: TObject);
begin
  formAdminReklamacije.Hide;
  // Možeš ovde da dodaš funkcionalnost koja će prikazati željenu formu
end;

// Procedura za učitavanje svih reklamacija iz baze
procedure TformAdminReklamacije.UcitajSveReklamacije;
begin
  ListBox1.Clear;

  with dm.db do
  begin
    // Učitaj reklamacije iz tabele reklamacija
    qtemp.SQL.Text := 'SELECT naziv_proizvoda, kolicina FROM reklamacije';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add(qtemp.FieldByName('naziv_proizvoda').AsString + ' - ' + qtemp.FieldByName('kolicina').AsString);
      qtemp.Next;
    end;
  end;
end;

// Procedura za prikaz podataka o izabranoj reklamaciji
procedure TformAdminReklamacije.PrikaziPodatkeOReklamaciji;
var
  IzabranaStavka, NazivProizvoda: string;
begin
  IzabranaStavka := ListBox1.Items[ListBox1.ItemIndex];  // Uzmi izabranu stavku

  // Izvuci naziv proizvoda pre " - " (deo pre broja količine)
  NazivProizvoda := Copy(IzabranaStavka, 1, Pos(' - ', IzabranaStavka) - 1);

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT * FROM reklamacije WHERE naziv_proizvoda = :naziv';
    qtemp.ParamByName('naziv').AsString := NazivProizvoda;  // Koristi samo naziv proizvoda
    qtemp.Open;

    // Prikaži podatke u poljima za izmenu
    editNaziv.Text := qtemp.FieldByName('naziv_proizvoda').AsString;
    editKolicina.Text := qtemp.FieldByName('kolicina').AsString;
    DateEdit1.Date := qtemp.FieldByName('datum_podnosenja_reklamacije').AsDateTime;
    editEmail.Text := qtemp.FieldByName('email').AsString;
    editStatus.Text := qtemp.FieldByName('status').AsString;
    editOpisProblema.Text := qtemp.FieldByName('opis_problema').AsString;
    editNapomena.Text := qtemp.FieldByName('napomena_admina').AsString;

    // Zapamti ID reklamacije
    IzabranaReklamacijaID := qtemp.FieldByName('id').AsInteger;
  end;
end;

// Procedura za ažuriranje podataka izabrane reklamacije
procedure TformAdminReklamacije.buttonIzmeniClick(Sender: TObject);
begin
  with dm.db do
  begin
    qtemp.SQL.Text := 'UPDATE reklamacije SET naziv_proizvoda = :naziv, kolicina = :kolicina, datum_podnosenja_reklamacije = :datum, email = :email, status = :status, opis_problema = :opis, napomena_admina = :napomena WHERE reklamacija_id = :id';
    qtemp.ParamByName('naziv').AsString := editNaziv.Text;
    qtemp.ParamByName('kolicina').AsString := editKolicina.Text;
    qtemp.ParamByName('datum').AsDateTime := DateEdit1.Date;
    qtemp.ParamByName('email').AsString := editEmail.Text;
    qtemp.ParamByName('status').AsString := editStatus.Text;
    qtemp.ParamByName('opis').AsString := editOpisProblema.Text;
    qtemp.ParamByName('napomena').AsString := editNapomena.Text;
    qtemp.ParamByName('id').AsInteger := IzabranaReklamacijaID;
    qtemp.ExecSQL;

    ShowMessage('Reklamacija uspešno izmenjena!');
  end;
end;

// Procedura koja se poziva kada se klikne na stavku u ListBox-u
procedure TformAdminReklamacije.ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  PrikaziPodatkeOReklamaciji;
end;

end.

