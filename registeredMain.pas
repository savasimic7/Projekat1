unit registeredMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TformRegMain = class(TForm)
    layoutBottom: TLayout;
    Image2: TImage;
    layoutclient: TLayout;
    Image1: TImage;
    layoutNavBar: TLayout;
    buttonMuskarci: TButton;
    buttonBrendovi: TButton;
    buttonZene: TButton;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    Button1: TButton;
    Image4: TImage;
    procedure Image3Click(Sender: TObject);
    procedure buttonMuskarciClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure buttonZeneClick(Sender: TObject);
    procedure buttonBrendoviClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formRegMain: TformRegMain;

implementation

uses nalog, muskaOprema, kontakt, zenskaOprema, brendovi, korpa;

{$R *.fmx}

procedure TformRegMain.Button1Click(Sender: TObject);
begin
    formRegMain.hide;
    formKontakt.show;
end;

procedure TformRegMain.buttonBrendoviClick(Sender: TObject);
begin
    formRegMain.hide;
    formBrendovi.show;
end;

procedure TformRegMain.buttonMuskarciClick(Sender: TObject);
begin
    formRegMain.hide;
    formMuskaOprema.show;
end;

procedure TformRegMain.buttonZeneClick(Sender: TObject);
begin
    formRegMain.hide;
    formZenskaOprema.show;
end;

procedure TformRegMain.Image3Click(Sender: TObject);
begin
    formRegMain.hide;
    formNalog.show;
end;

procedure TformRegMain.Image4Click(Sender: TObject);
begin
    formRegMain.hide;
    formkorpa.show;
end;

end.
