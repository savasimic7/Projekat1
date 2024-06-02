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
  artikli in 'artikli.pas' {formArtikli};

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
  Application.Run;
end.
