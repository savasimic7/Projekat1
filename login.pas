unit login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts;

type
  TformLogin = class(TForm)
    layoutclient: TLayout;
    Image1: TImage;
    Rectangle1: TRectangle;
    layoutEmail: TLayout;
    editEmail: TEdit;
    Line2: TLine;
    Text2: TText;
    layoutSifra: TLayout;
    editSifra: TEdit;
    Line3: TLine;
    Text3: TText;
    buttonPrijava: TButton;
    Layout1: TLayout;
    buttonNazad: TButton;
    procedure buttonNazadClick(Sender: TObject);
    procedure buttonPrijavaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formLogin: TformLogin;

implementation

uses main, dm, registeredMain, adminMain, nalog, zaposleniNalog;

{$R *.fmx}

procedure TformLogin.buttonNazadClick(Sender: TObject);
begin
  formLogin.Hide;
  formMain.Show;
end;

procedure TformLogin.buttonPrijavaClick(Sender: TObject);
var
  pwd: string;
  zaposleniStatus: Integer;
begin
  if Trim(editEmail.Text) = '' then
  begin
    ShowMessage('Molimo unesite email!');
    editEmail.SetFocus;
  end
  else if Trim(editSifra.Text) = '' then
  begin
    ShowMessage('Molimo unesite šifru!');
    editSifra.SetFocus;
  end
  else
  begin
    // Validacija korisničkog imena i šifre
    with dm.db do
    begin
      qtemp.SQL.Clear;
      qtemp.SQL.Text := 'SELECT * FROM korisnici WHERE email = :email';
      qtemp.ParamByName('email').AsString := editEmail.Text;
      qtemp.Open;

      if qtemp.RecordCount = 0 then
      begin
        ShowMessage('Email ne postoji!');
        editEmail.SetFocus;
      end
      else
      begin
        pwd := qtemp.FieldByName('sifra').AsString;
        zaposleniStatus := qtemp.FieldByName('zaposleni').AsInteger;

        if pwd = editSifra.Text then
        begin
          // Provera statusa korisnika (0 = običan korisnik, 1 = zaposleni)
          if zaposleniStatus = 1 then
          begin
                      formZaposleniNalog.textImePrezime.Text := 'Ime i Prezime: ' + qtemp.FieldByName('imePrezime').AsString;
            formZaposleniNalog.textEmail.Text := 'Email: ' + qtemp.FieldByName('email').AsString;
            formZaposleniNalog.textSifra.Text := 'Šifra: ' + qtemp.FieldByName('sifra').AsString;
            formZaposleniNalog.textTelefon.Text := 'Telefon: ' + qtemp.FieldByName('telefon').AsString;
            formZaposleniNalog.TextAdresa.Text := 'Adresa: ' + qtemp.FieldByName('adresa').AsString;
            formZaposleniNalog.textPol.Text := 'Pol: ' + qtemp.FieldByName('pol').AsString;
            // Korisnik je zaposleni, otvori admin formu
            formLogin.Hide;
            formAdminMain.Show;
          end
          else
          begin
            // Korisnik je običan korisnik, otvori formu za registrovane korisnike
            // Prebacivanje podataka na formu za nalog
            formNalog.textImePrezime.Text := 'Ime i Prezime: ' + qtemp.FieldByName('imePrezime').AsString;
            formNalog.textEmail.Text := 'Email: ' + qtemp.FieldByName('email').AsString;
            formNalog.textSifra.Text := 'Šifra: ' + qtemp.FieldByName('sifra').AsString;
            formNalog.textTelefon.Text := 'Telefon: ' + qtemp.FieldByName('telefon').AsString;
            formNalog.TextAdresa.Text := 'Adresa: ' + qtemp.FieldByName('adresa').AsString;
            formNalog.textPol.Text := 'Pol: ' + qtemp.FieldByName('pol').AsString;



            formLogin.Hide;
            formRegMain.Show;
          end;
        end
        else
        begin
          ShowMessage('Pogrešna šifra!');
          editSifra.SetFocus;
        end;
      end;
    end;
  end;
end;

end.

