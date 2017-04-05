unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Tabla: TStringList;
  i  : Integer;
begin
  Tabla := TStringList.Create;
  try
  Memo1.Clear;

    Tabla.add('IDPREGUNTA=1,PREGUNTA=PREGUNTA1,ESTILO=1'); //pregunta1
    Tabla.add('IDPREGUNTA=2, PREGUNTA=PREGUNTA2, ESTILO=2');//pregunta2
    Memo1.Clear;

  //Memo1.lines.add('mi tabla dice --------------');
  //Memo1.Lines.AddStrings(Tabla);
  //Memo1.lines.add('----------------------------');
   for i := 0 to Tabla.Count-1 do
  begin
  Label1.Caption:= Tabla.Strings[0];
  Memo1.Lines.Add( '^^' + Tabla.Strings[i]);
    end;

  finally
   Tabla.Free;
  end;
  //Tabla.Free;

end;

end.
