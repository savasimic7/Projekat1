unit zenskaOprema;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.DApt.Intf;

type
  TformZenskaOprema = class(TForm)
    layoutBottom: TLayout;
    buttonnazad: TButton;
    layoutclient: TLayout;
    layoutNavBar: TLayout;
    buttonMuskarci: TButton;
    buttonBrendovi: TButton;
    buttonZene: TButton;
    Line1: TLine;
    Text2: TText;
    Layout1: TLayout;
    Layout2: TLayout;
    Text3: TText;
    buttonDuksevi: TButton;
    buttonAksesoari: TButton;
    buttonSorcevi: TButton;
    buttonPantalone: TButton;
    buttonPatike: TButton;
    buttonMajice: TButton;
    Line2: TLine;
    ListBox1: TListBox;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    Image1: TImage;
    procedure buttonnazadClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure buttonMuskarciClick(Sender: TObject);
    procedure buttonBrendoviClick(Sender: TObject);
    procedure buttonDukseviClick(Sender: TObject);
    procedure buttonMajiceClick(Sender: TObject);
    procedure buttonPatikeClick(Sender: TObject);
    procedure buttonPantaloneClick(Sender: TObject);
    procedure buttonSorceviClick(Sender: TObject);
    procedure buttonAksesoariClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    procedure UcitajZenskuOpremu(const kategorija: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formZenskaOprema: TformZenskaOprema;

implementation

uses RegisteredMain, nalog, dm, detalji, korpa, muskaOprema, brendovi;

{$R *.fmx}

procedure TformZenskaOprema.FormShow(Sender: TObject);
begin
  UcitajZenskuOpremu('Duksevi'); // Automatski prikazuje dukseve pri otvaranju
end;

procedure TformZenskaOprema.UcitajZenskuOpremu(const kategorija: string);
begin
  ListBox1.Clear;

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT naziv, brend FROM ' + kategorija + ' WHERE pol = ''zenski''';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add(kategorija + ': ' + qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

procedure TformZenskaOprema.buttonDukseviClick(Sender: TObject);
begin
  UcitajZenskuOpremu('Duksevi');
end;

procedure TformZenskaOprema.buttonMajiceClick(Sender: TObject);
begin
  UcitajZenskuOpremu('Majice');
end;

procedure TformZenskaOprema.buttonPatikeClick(Sender: TObject);
begin
  UcitajZenskuOpremu('Patike');
end;

procedure TformZenskaOprema.buttonPantaloneClick(Sender: TObject);
begin
  UcitajZenskuOpremu('Pantalone');
end;

procedure TformZenskaOprema.buttonSorceviClick(Sender: TObject);
begin
  UcitajZenskuOpremu('Sorcevi');
end;

procedure TformZenskaOprema.buttonAksesoariClick(Sender: TObject);
begin
  UcitajZenskuOpremu('Aksesoari');
end;

procedure TformZenskaOprema.ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
var
  naziv, brend: string;
begin
  naziv := Item.Text.Split([':'])[1].Trim.Split(['-'])[0].Trim;
  brend := Item.Text.Split(['-'])[1].Trim;

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT naziv, brend, cena, opis FROM Duksevi WHERE naziv = :naziv AND brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, brend, cena, opis FROM Majice WHERE naziv = :naziv AND brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, brend, cena, opis FROM Patike WHERE naziv = :naziv AND brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, brend, cena, opis FROM Pantalone WHERE naziv = :naziv AND brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, brend, cena, opis FROM Sorcevi WHERE naziv = :naziv AND brend = :brend ' +
                      'UNION ALL ' +
                      'SELECT naziv, brend, cena, opis FROM Aksesoari WHERE naziv = :naziv AND brend = :brend';
    qtemp.ParamByName('naziv').AsString := naziv;
    qtemp.ParamByName('brend').AsString := brend;
    qtemp.Open;

    if not qtemp.Eof then
    begin
      formZenskaOprema.Hide;
      formDetalji.textNaziv.Text := 'Naziv: ' + qtemp.FieldByName('naziv').AsString;
      formDetalji.TextOpis.Text := 'Opis: ' + qtemp.FieldByName('opis').AsString;
      formDetalji.TextCenaP.Text := 'Cena: ' + qtemp.FieldByName('cena').AsString + ' RSD';
      formDetalji.Show;
    end;
  end;
end;

procedure TformZenskaOprema.buttonnazadClick(Sender: TObject);
begin
  Close;
end;

procedure TformZenskaOprema.Image1Click(Sender: TObject);
begin
    formZenskaOprema.hide;
    formKorpa.show;
end;

procedure TformZenskaOprema.Image3Click(Sender: TObject);
begin
  Close;
end;

procedure TformZenskaOprema.buttonMuskarciClick(Sender: TObject);
begin
  formMuskaOprema.Show;
  Close;
end;

procedure TformZenskaOprema.buttonBrendoviClick(Sender: TObject);
begin
  formBrendovi.Show;
  Close;
end;

end.

