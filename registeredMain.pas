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
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formRegMain: TformRegMain;

implementation

uses nalog;

{$R *.fmx}

procedure TformRegMain.Image3Click(Sender: TObject);
begin
    formRegMain.hide;
    formNalog.show;
end;

end.
