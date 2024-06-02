unit brendovi;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param;

type
  TformBrendovi = class(TForm)
    layoutBottom: TLayout;
    buttonnazad: TButton;
    layoutclient: TLayout;
    layoutNavBar: TLayout;
    buttonMuskarci: TButton;
    buttonBrendovi: TButton;
    buttonZene: TButton;
    Line1: TLine;
    Text2: TText;
    ListBox1: TListBox;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    Image1: TImage;
    procedure Image3Click(Sender: TObject);
    procedure buttonMuskarciClick(Sender: TObject);
    procedure buttonZeneClick(Sender: TObject);
    procedure buttonnazadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure Image1Click(Sender: TObject);
  private
    procedure UcitajBrendove;
  public
    { Public declarations }
  end;

var
  formBrendovi: TformBrendovi;

implementation

uses nalog, muskaOprema, zenskaOprema, registeredMain, artikli, dm, korpa;  // Dodaj jedinicu `artikli` za prikaz artikala

{$R *.fmx}

// Procedura koja učitava sve jedinstvene brendove iz baze
procedure TformBrendovi.UcitajBrendove;
begin
  ListBox1.Clear;

  with dm.db do
  begin
    // SQL upit za jedinstvene brendove iz svih tabela
    qtemp.SQL.Text := 'SELECT DISTINCT brend FROM (' +
                      'SELECT brend FROM Duksevi ' +
                      'UNION ' +
                      'SELECT brend FROM Majice ' +
                      'UNION ' +
                      'SELECT brend FROM Patike ' +
                      'UNION ' +
                      'SELECT brend FROM Pantalone ' +
                      'UNION ' +
                      'SELECT brend FROM Sorcevi ' +
                      'UNION ' +
                      'SELECT brend FROM Aksesoari)';
    qtemp.Open;

    // Dodaj brendove u ListBox
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add(qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

procedure TformBrendovi.FormShow(Sender: TObject);
begin
  UcitajBrendove;  // Učitaj brendove kada se forma prikaže
end;

procedure TformBrendovi.ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
var
  odabraniBrend: string;
begin
  odabraniBrend := Item.Text;

  // Prosledi odabrani brend formi za prikaz artikala
  formArtikli.PrikaziArtikleZaBrend(odabraniBrend);

  // Sakrij trenutnu formu i prikaži formu za artikle
  formBrendovi.Hide;
  formArtikli.Show;
end;

procedure TformBrendovi.buttonMuskarciClick(Sender: TObject);
begin
  formBrendovi.Hide;
  formMuskaOprema.Show;
end;

procedure TformBrendovi.buttonZeneClick(Sender: TObject);
begin
  formBrendovi.Hide;
  formzenskaOprema.Show;
end;

procedure TformBrendovi.buttonnazadClick(Sender: TObject);
begin
  formBrendovi.Hide;
  formRegMain.Show;
end;

procedure TformBrendovi.Image1Click(Sender: TObject);
begin
    formBrendovi.hide;
    formKorpa.show;
end;

procedure TformBrendovi.Image3Click(Sender: TObject);
begin
  formBrendovi.Hide;
  formNalog.Show;
end;

end.

