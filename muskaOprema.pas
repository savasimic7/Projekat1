unit muskaOprema;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.DApt.Intf;

type
  TformMuskaOprema = class(TForm)
    layoutBottom: TLayout;
    layoutclient: TLayout;
    layoutNavBar: TLayout;
    buttonMuskarci: TButton;
    buttonBrendovi: TButton;
    buttonZene: TButton;
    layoutTop: TLayout;
    Text1: TText;
    Image3: TImage;
    Line1: TLine;
    Text2: TText;
    Layout1: TLayout;
    Layout2: TLayout;
    Line2: TLine;
    Text3: TText;
    buttonDuksevi: TButton;
    buttonAksesoari: TButton;
    buttonSorcevi: TButton;
    buttonPantalone: TButton;
    buttonPatike: TButton;
    buttonMajice: TButton;
    ListBox1: TListBox;
    buttonnazad: TButton;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure buttonnazadClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure buttonZeneClick(Sender: TObject);
    procedure buttonBrendoviClick(Sender: TObject);
    procedure buttonDukseviClick(Sender: TObject);
    procedure buttonMajiceClick(Sender: TObject);
    procedure buttonPatikeClick(Sender: TObject);
    procedure buttonPantaloneClick(Sender: TObject);
    procedure buttonSorceviClick(Sender: TObject);
    procedure buttonAksesoariClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    procedure UcitajMuskuOpremu;
  public
    { Public declarations }
  end;

var
  formMuskaOprema: TformMuskaOprema;

implementation

uses nalog, dm, registeredMain, detalji, zenskaOprema, brendovi, korpa;

{$R *.fmx}

procedure TformMuskaOprema.FormShow(Sender: TObject);
begin
  UcitajMuskuOpremu;
end;

procedure TformMuskaOprema.UcitajMuskuOpremu;
begin
  ListBox1.Clear;

  with dm.db do
  begin
    // Učitavanje muških dukseva
    qtemp.SQL.Text := 'SELECT naziv, brend FROM Duksevi WHERE pol = ''muski''';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add('Dukserica: ' + qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

// Za prikaz dukseva
procedure TformMuskaOprema.buttonDukseviClick(Sender: TObject);
begin
  ListBox1.Clear;

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT naziv, brend FROM Duksevi WHERE pol = ''muski''';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add('Dukserica: ' + qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

// Za prikaz majica
procedure TformMuskaOprema.buttonMajiceClick(Sender: TObject);
begin
  ListBox1.Clear;

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT naziv, brend FROM Majice WHERE pol = ''muski''';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add('Majica: ' + qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

// Za prikaz patika
procedure TformMuskaOprema.buttonPatikeClick(Sender: TObject);
begin
  ListBox1.Clear;

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT naziv, brend FROM Patike WHERE pol = ''muski''';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add('Patike: ' + qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

// Za prikaz pantalona
procedure TformMuskaOprema.buttonPantaloneClick(Sender: TObject);
begin
  ListBox1.Clear;

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT naziv, brend FROM Pantalone WHERE pol = ''muski''';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add('Pantalone: ' + qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

// Za prikaz šorceva
procedure TformMuskaOprema.buttonSorceviClick(Sender: TObject);
begin
  ListBox1.Clear;

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT naziv, brend FROM Sorcevi WHERE pol = ''muski''';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add('Šorc: ' + qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

// Za prikaz aksesoara
procedure TformMuskaOprema.buttonAksesoariClick(Sender: TObject);
begin
  ListBox1.Clear;

  with dm.db do
  begin
    qtemp.SQL.Text := 'SELECT naziv, brend FROM Aksesoari WHERE pol = ''muski''';
    qtemp.Open;
    while not qtemp.Eof do
    begin
      ListBox1.Items.Add('Aksesoar: ' + qtemp.FieldByName('naziv').AsString + ' - ' + qtemp.FieldByName('brend').AsString);
      qtemp.Next;
    end;
  end;
end;

procedure TformMuskaOprema.ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
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
      // Popunjavanje forme detalja sa informacijama
      formDetalji.textNaziv.Text := 'Naziv: ' + qtemp.FieldByName('naziv').AsString;
      formDetalji.TextOpis.Text := 'Opis: ' + qtemp.FieldByName('opis').AsString;

      // Provera i prikaz cene
      if not qtemp.FieldByName('cena').IsNull then
      begin
        formDetalji.TextCenaP.Text := 'Cena: ' + qtemp.FieldByName('cena').AsString + ' RSD';
      end;

      formMuskaOprema.hide;
      formDetalji.ShowModal;
    end;
  end;
end;

procedure TformMuskaOprema.buttonnazadClick(Sender: TObject);
begin
  formMuskaOprema.hide;
  formRegmain.show;
end;

procedure TformMuskaOprema.Image1Click(Sender: TObject);
begin
    formMuskaOprema.hide;
    formKorpa.show;
end;

procedure TformMuskaOprema.Image3Click(Sender: TObject);
begin
  formMuskaOprema.hide;
  formNalog.show;
end;

procedure TformMuskaOprema.buttonZeneClick(Sender: TObject);
begin
  formZenskaOprema.Show;
  formMuskaOprema.hide;
end;

procedure TformMuskaOprema.buttonBrendoviClick(Sender: TObject);
begin
  formBrendovi.Show;
  formMuskaOprema.hide;
end;

end.

