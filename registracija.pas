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
    editImePrezime: TEdit;
    Line1: TLine;
    Text1: TText;
    layoutEmail: TLayout;
    editEmail: TEdit;
    Line2: TLine;
    Text2: TText;
    layoutSifra: TLayout;
    editSifra: TEdit;
    Line3: TLine;
    Text3: TText;
    layoutAdresa: TLayout;
    editAdresa: TEdit;
    Line4: TLine;
    Text4: TText;
    layoutPol: TLayout;
    CheckBoxMuski: TCheckBox;
    CheckBoxZenski: TCheckBox;
    layoutTelefon: TLayout;
    editTelefon: TEdit;
    Line5: TLine;
    Text5: TText;
    buttonRegistracija: TButton;
    Layout1: TLayout;
    buttonNazad: TButton;
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonRegistracijaClick(Sender: TObject);
  private
    function Validacija: Boolean;
    function DobaviPol: string;
    function EmailPostoji(const Email: string): Boolean;
  public
    { Public declarations }
  end;

var
  formRegistracija: TformRegistracija;

implementation

uses main, dm;

{$R *.fmx}

procedure TformRegistracija.buttonNazadClick(Sender: TObject);
begin
  formRegistracija.Hide;
  formMain.Show;
end;

procedure TformRegistracija.buttonRegistracijaClick(Sender: TObject);
var
  Pol: string;
begin
  if not Validacija then
    Exit;

  // Provera da li email već postoji u bazi
  if EmailPostoji(editEmail.Text) then
  begin
    ShowMessage('Korisnik sa unetim emailom već postoji.');
    editEmail.SetFocus;
    Exit;
  end;

  Pol := DobaviPol;

  with dm.db do
  begin
    qtemp.SQL.Text := 'INSERT INTO korisnici (imePrezime, email, sifra, pol, adresa, telefon) VALUES (:imePrezime, :email, :sifra, :pol, :adresa, :telefon)';
    qtemp.ParamByName('imePrezime').AsString := editImePrezime.Text;
    qtemp.ParamByName('email').AsString := editEmail.Text;
    qtemp.ParamByName('sifra').AsString := editSifra.Text;
    qtemp.ParamByName('pol').AsString := Pol;
    qtemp.ParamByName('adresa').AsString := editAdresa.Text;
    qtemp.ParamByName('telefon').AsString := editTelefon.Text;
    qtemp.ExecSQL;

    ShowMessage('Uspešno ste se registrovali!');
    formRegistracija.Hide;
    formMain.Show;
  end;
end;

function TformRegistracija.Validacija: Boolean;
begin
  Result := False;
  if Trim(editImePrezime.Text) = '' then
  begin
    ShowMessage('Unesite ime i prezime.');
    editImePrezime.SetFocus;
    Exit;
  end;
  if Trim(editEmail.Text) = '' then
  begin
    ShowMessage('Unesite email.');
    editEmail.SetFocus;
    Exit;
  end;
  if Trim(editSifra.Text) = '' then
  begin
    ShowMessage('Unesite šifru.');
    editSifra.SetFocus;
    Exit;
  end;

  // Provera da li je tačno jedan checkbox odabran
  if (CheckBoxMuski.IsChecked) and (CheckBoxZenski.IsChecked) then
  begin
    ShowMessage('Odaberite samo jedan pol.');
    CheckBoxMuski.SetFocus;
    Exit;
  end
  else if (not CheckBoxMuski.IsChecked) and (not CheckBoxZenski.IsChecked) then
  begin
    ShowMessage('Odaberite pol.');
    CheckBoxMuski.SetFocus;
    Exit;
  end;

  if Trim(editAdresa.Text) = '' then
  begin
    ShowMessage('Unesite adresu.');
    editAdresa.SetFocus;
    Exit;
  end;
  if Trim(editTelefon.Text) = '' then
  begin
    ShowMessage('Unesite telefon.');
    editTelefon.SetFocus;
    Exit;
  end;

  Result := True;
end;

function TformRegistracija.DobaviPol: string;
begin
  if CheckBoxMuski.IsChecked then
    Result := 'muski'
  else if CheckBoxZenski.IsChecked then
    Result := 'zenski'
  else
    Result := '';
end;

function TformRegistracija.EmailPostoji(const Email: string): Boolean;
begin
  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT COUNT(*) FROM korisnici WHERE email = :email';
    qtemp.ParamByName('email').AsString := Email;
    qtemp.Open;
    Result := qtemp.Fields[0].AsInteger > 0;
    qtemp.Close;
  end;
end;

end.

