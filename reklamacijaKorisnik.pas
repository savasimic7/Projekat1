unit reklamacijaKorisnik;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, dm;  // Dodaj dm za pristup bazi

type
  TformReklamacijaK = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Text1: TText;
    buttonPotvrdi: TButton;
    buttonOdustani: TButton;
    textNazivArtikla: TText;
    editOpisProblema: TEdit;
    Text2: TText;
    procedure buttonPotvrdiClick(Sender: TObject);
    procedure buttonOdustaniClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formReklamacijaK: TformReklamacijaK;

implementation

uses login;

{$R *.fmx}

// Procedura za potvrđivanje reklamacije i unos u bazu
procedure TformReklamacijaK.buttonPotvrdiClick(Sender: TObject);
begin
  with dm.db do
  begin
    // Unos reklamacije u bazu
    qtemp.SQL.Text := 'INSERT INTO reklamacije (naziv_proizvoda, kolicina, email, datum_podnosenja_reklamacije, status, opis_problema) ' +
                      'VALUES (:naziv, :kolicina, :email, CURRENT_TIMESTAMP, :status, :opis)';
    qtemp.ParamByName('naziv').AsString := textNazivArtikla.Text;
    // Dodaj parametre za količinu, cenu i veličinu (iz baze ili dodatni unos)
    qtemp.ParamByName('kolicina').AsInteger := 1;  // Primer vrednosti, zameni sa stvarnim
    qtemp.ParamByName('email').AsString := formLogin.editEmail.Text;
    qtemp.ParamByName('status').AsString := 'Na čekanju';  // Inicijalni status
    qtemp.ParamByName('opis').AsString := editOpisProblema.Text;

    qtemp.ExecSQL;  // Izvrši SQL upit

    ShowMessage('Reklamacija uspešno poslata!');
  end;

  formReklamacijaK.Hide;  // Sakrij formu nakon potvrde
end;

// Procedura za odustajanje od reklamacije
procedure TformReklamacijaK.buttonOdustaniClick(Sender: TObject);
begin
  formReklamacijaK.Hide;  // Sakrij formu bez unosa reklamacije
end;

end.

