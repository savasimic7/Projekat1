program SportskaOprema;

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {formMain},
  registracija in 'registracija.pas' {formRegistracija},
  login in 'login.pas' {formLogin},
  registeredMain in 'registeredMain.pas' {formRegMain},
  dm in 'dm.pas' {db},
  nalog in 'nalog.pas' {formNalog},
  kontakt in 'kontakt.pas' {formKontakt},
  muskaOprema in 'muskaOprema.pas' {formMuskaOprema},
  detalji in 'detalji.pas' {formDetalji},
  korpa in 'korpa.pas' {formKorpa},
  zenskaOprema in 'zenskaOprema.pas' {formZenskaOprema},
  brendovi in 'brendovi.pas' {formBrendovi},
  artikli in 'artikli.pas' {formArtikli},
  narudzbine in 'narudzbine.pas' {formNarudzbine},
  reklamacijaKorisnik in 'reklamacijaKorisnik.pas' {formReklamacijaK},
  adminMain in 'adminMain.pas' {formAdminMain},
  zaposleniNalog in 'zaposleniNalog.pas' {formZaposleniNalog},
  stanjeProizvoda in 'stanjeProizvoda.pas' {formStanjeProizvoda},
  nabavka in 'nabavka.pas' {formNabavka},
  narudzbineAdmin in 'narudzbineAdmin.pas' {formNarudzbineAdmin},
  adminReklamacije in 'adminReklamacije.pas' {formAdminReklamacije};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformRegistracija, formRegistracija);
  Application.CreateForm(TformLogin, formLogin);
  Application.CreateForm(TformRegMain, formRegMain);
  Application.CreateForm(Tdb, db);
  Application.CreateForm(TformNalog, formNalog);
  Application.CreateForm(TformKontakt, formKontakt);
  Application.CreateForm(TformMuskaOprema, formMuskaOprema);
  Application.CreateForm(TformDetalji, formDetalji);
  Application.CreateForm(TformKorpa, formKorpa);
  Application.CreateForm(TformZenskaOprema, formZenskaOprema);
  Application.CreateForm(TformBrendovi, formBrendovi);
  Application.CreateForm(TformArtikli, formArtikli);
  Application.CreateForm(TformNarudzbine, formNarudzbine);
  Application.CreateForm(TformReklamacijaK, formReklamacijaK);
  Application.CreateForm(TformAdminMain, formAdminMain);
  Application.CreateForm(TformZaposleniNalog, formZaposleniNalog);
  Application.CreateForm(TformStanjeProizvoda, formStanjeProizvoda);
  Application.CreateForm(TformNabavka, formNabavka);
  Application.CreateForm(TformNarudzbineAdmin, formNarudzbineAdmin);
  Application.CreateForm(TformAdminReklamacije, formAdminReklamacije);
  Application.Run;
end.
