program SportskaOprema;

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {formMain},
  registracija in 'registracija.pas' {formRegistracija},
  login in 'login.pas' {formLogin},
  registeredMain in 'registeredMain.pas' {formRegMain},
  dm in 'dm.pas' {db},
  nalog in 'nalog.pas' {formNalog};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformRegistracija, formRegistracija);
  Application.CreateForm(TformLogin, formLogin);
  Application.CreateForm(TformRegMain, formRegMain);
  Application.CreateForm(Tdb, db);
  Application.CreateForm(TformNalog, formNalog);
  Application.Run;
end.
