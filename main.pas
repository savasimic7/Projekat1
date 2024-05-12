unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects;

type
  TformMain = class(TForm)
    layoutBottom: TLayout;
    layoutTop: TLayout;
    layoutclient: TLayout;
    buttonPrijava: TButton;
    buttonRegistracija: TButton;
    Text1: TText;
    Image1: TImage;
    Image2: TImage;
    layoutNavBar: TLayout;
    buttonMuskarci: TButton;
    buttonBrendovi: TButton;
    buttonZene: TButton;
    procedure buttonRegistracijaClick(Sender: TObject);
    procedure buttonPrijavaClick(Sender: TObject);
    procedure buttonMuskarciClick(Sender: TObject);
    procedure buttonZeneClick(Sender: TObject);
    procedure buttonBrendoviClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

uses registracija, login;

{$R *.fmx}

procedure TformMain.buttonBrendoviClick(Sender: TObject);
begin
ShowMessage('Molimo prijavite se da bi pogledali artikle!');
end;

procedure TformMain.buttonMuskarciClick(Sender: TObject);
begin
    ShowMessage('Molimo prijavite se da bi pogledali artikle!');
end;

procedure TformMain.buttonZeneClick(Sender: TObject);
begin
ShowMessage('Molimo prijavite se da bi pogledali artikle!');
end;

procedure TformMain.buttonPrijavaClick(Sender: TObject);
begin
    formMain.hide;
    formLogin.show;
end;

procedure TformMain.buttonRegistracijaClick(Sender: TObject);
begin
    formMain.hide;
    formRegistracija.show;
end;



end.
