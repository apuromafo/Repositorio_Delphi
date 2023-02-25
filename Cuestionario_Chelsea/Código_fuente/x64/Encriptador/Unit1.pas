unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button3: TButton;
    Button4: TButton;
   // procedure EncriptarClick(Sender: TObject);
//    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     Tabla,Tabla2: TStringList;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
//encriptar datos
function encriptar(aStr: Ansistring; aKey: Integer): String;
begin
   Result:='';
   RandSeed:=aKey;
   for aKey:=1 to Length(aStr) do
       Result:=Result+Chr(Byte(aStr[aKey]) xor (152));
end;

//desencriptar datos
function desencriptar(aStr: Ansistring; aKey: Integer): String;
begin
   Result:='';
   RandSeed:=aKey;
   for aKey:=1 to Length(aStr) do
       Result:=Result+Chr(Byte(aStr[aKey]) xor (152));
end;


function String2Hex(const Buffer: Ansistring): string;
begin
  SetLength(result, 2*Length(Buffer));
  BinToHex(@Buffer[1], PWideChar(@result[1]), Length(Buffer));
end;
function HexToString(H: String): String;
var I : Integer;
begin
  Result:= '';
  for I := 1 to length (H) div 2 do
    Result:= Result+Char(StrToInt('$'+Copy(H,(I-1)*2+1,2)));
end;


procedure TForm1.Button3Click(Sender: TObject);
var i: Integer;

begin
//Tabla.Create;
Tabla := TStringList.Create;
Tabla2 := TStringList.Create;
Tabla.LoadFromFile( 'Preguntas.txt' );
//Tabla := TStringList.Create;
Tabla2.Clear;
for i := 0 to Tabla.Count-1 do
Tabla2.add(String2Hex(encriptar((Tabla.Strings[i]),15)));
Tabla2.SaveToFile('Resultado.txt' );


end;

procedure TForm1.Button4Click(Sender: TObject);

var i: Integer;

begin
//Tabla.Create;
Tabla := TStringList.Create;
Tabla2 := TStringList.Create;
Tabla.LoadFromFile( 'Resultado.txt' );
//Tabla := TStringList.Create;
Tabla2.Clear;
//Memo2.Clear;
for i := 0 to tabla.Count-1 do
Tabla2.add(desencriptar(HexToString(Tabla.Strings[i]),15)) ;
Tabla2.SaveToFile('Resultado_Desencriptado1pase.txt' );
Tabla.Free;
Tabla2.Free;
end;

end.
