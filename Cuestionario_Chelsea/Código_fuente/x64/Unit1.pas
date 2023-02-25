{ ********************************************* }
{ Delphi code    By : Apuromafo }
{ This example provide by - Apuromafo.net }
{ version 1.2 coded in RAD Studio }
{ ********************************************* }

unit Unit1;

// 1.    Unit. Hace referencia al nombre del documento de códigos.
interface

// 2.    Interface. Hace constar que lo que le sigue a esa palabra es la interfaz del formulario.
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Vcl.Imaging.pngimage;

// 3.    Uses. En esta se especifican los distintos módulos que cargará el programa
// y que se incluirán en el ejecutable una vez compilado para que éste tenga una
// independencia total del compilador.
type
  // 4.    Type.  En esta sección se especificaran los distintos objetos
  // con su correspondiente clase (NombreComponente:TipoComponente),
  // ejemplo: (Label1:TLabel), y los distintos procedimientos que
  // se ejecutarán en el programa.

  TForm1 = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    // procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    // procedure LoadFromFile( const FileName: string ); virtual;
    // Al final de ella se verán dos palabras clave “Private” y “Public”,
    // que sirven para definir variables privadas o públicas.

  private
    { Private declarations }
  public
    { Public declarations }
    contador, estilo, estilo1, estilo2, estilo3, estilo4, indeciso: Integer;
    respuesta: String;
    Tabla, Tabla2: TStringList;
    // estilo 1:
  end;

Resourcestring
  str1 = 'Este Programa es un Simple Cuestionario';
  str2 = 'Continuar';
  str3 = 'P1:Tengo fama de decir lo que pienso claramente y sin rodeos ';
  str4 = 'Instrucciones: Marca los enunciados que describen tu comportamiento';
  str5 = 'PREGUNTA'; // nombre recurso
  str6 = 'Selecciona una opción, luego ';
  str7 = 'a';
  str8 = 'b';
  str9 = 'c';
  str10 = 'Bien Hecho, he guardado tu resultado en un txt';
  str11 = 'Resultado de  _';
  str12 = '_ Preguntas  Activo->';
  str13 = 'Reflexivo->';
  str14 = 'Teorico->';
  str15 = 'Pragmático->';
  str16 = '17-01-2018 Apuromafo '; // label
  str17 = 'Cuestionario Chelsea para Estilos de Aprendizaje v 1.3 x64';
  // form title
  str18 = 'Cuestionario Chelsea para Estilos de Aprendizaje'; // label
  str19 = 'Bienvenido , pulsa Start para comenzar: '; // label
  str20 = 'Start'; // caption boton 3
  str21 = 'Siguiente>'; // caption boton 4
  str22 = 'About'; // caption Boton 2
  str23 = 'Exit';

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$I Music.pas}

procedure TForm1.Button1Click(Sender: TObject);

// var serial1, serial2,serial3,serial4,serial5,serial6,serial7,serial8,serial9,serial10  : String  ;
// var   SelectedItem: string;
  function StringToHex(S: String): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 1 to length(S) do
      Result := Result + IntToHex(ord(S[I]), 2);
  end;

begin
  Application.Terminate;
  Halt;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BorderIcons := BorderIcons - [biSystemMenu, biMinimize, biMaximize, biHelp];
  Label1.Caption := str16;
  self.Caption := str17;
  Label2.Caption := str18;
  Label3.Caption := str19;
  Button3.Caption := str20;
  Button4.Caption := str21;
  Button2.Caption := str22;
  Button1.Caption := str23;
end;

procedure TForm1.Button2Click(Sender: TObject);

var
  f: TForm;

begin
  // f := Dialogs.CreateMessageDialog('este keygen genera claves para fines educacionales', dialogs.mtInformation, [dialogs.mbOk]);
  f := Dialogs.CreateMessageDialog(str1, Dialogs.mtInformation, [Dialogs.mbOk]);
  f.Color := clBlue;
  f.Font.Color := clLime;
  if f.ShowModal = mrOk then
    f.Font.Color := clLime;
  // ShowMessage('Gracias por Participar')    ;
end;

procedure TForm1.Button3Click(Sender: TObject);
// Menu Principal  v0
begin
  Button4.Visible := False;
  Button4.Enabled := False;
  RadioGroup1.Visible := False;
  Button3.Visible := False;
  Button3.Enabled := False;
  Button4.Visible := True;
  Button4.Enabled := True;
  Button4.Caption := str2;
  // para formato, al comenzar solo muestra el caption..nada que validar de antes
  if estilo = 0 then
  begin
    RadioGroup1.Visible := True;
    Tabla := TStringList.Create;
    Label2.Caption := str3;
    Label3.Caption := str4;
    RadioGroup1.Caption := str6 + Button4.Caption;
    If respuesta = str7 then
      inc(estilo4, 1); // pregunta 1 apunta al estilo4
    If respuesta = str8 then
      inc(indeciso, 1);
    If respuesta = str9 then
      inc(indeciso, 1);
    respuesta := '';

  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
  function desencriptar(aStr: Ansistring; aKey: Integer): String;
  begin
    Result := '';
    RandSeed := aKey;
    for aKey := 1 to length(aStr) do
      Result := Result + Chr(Byte(aStr[aKey]) xor (152));
  end;
{
  function String2Hex(const Buffer: Ansistring): string;
  begin
  SetLength(result, 2*Length(Buffer));
  BinToHex(@Buffer[1], PWideChar(@result[1]), Length(Buffer));
  end;
}
  function HexToString(H: String): String;
  var
    I: Integer;
  begin
    Result := '';
    for I := 1 to length(H) div 2 do
      Result := Result + Char(StrToInt('$' + Copy(H, (I - 1) * 2 + 1, 2)));
  end;

var
  I: Integer;
  ResStream: TResourceStream;

begin
  Tabla.Create;
  // Tabla.LoadFromFile( ExtractFilePath( Application.ExeName ) + 'preguntas.txt' );
  ResStream := TResourceStream.Create(hInstance, str5, RT_RCDATA);
  Tabla.LoadFromStream(ResStream, TEncoding.ASCII);
  // Tabla.LoadFromStream( 'Preguntas.txt');
  Tabla2 := TStringList.Create;
  Tabla2.Clear;
  for I := 0 to Tabla.Count - 1 do
    Tabla2.add(desencriptar(HexToString(Tabla.Strings[I]), 15));
  Tabla2.add('P80');

  Case RadioGroup1.ItemIndex of
    0:
      begin
        // showmessage('radiobutton1 is selected');
        respuesta := str7;
        inc(contador, 1);
        inc(estilo, 1);
      end;
    1:
      begin
        respuesta := str8;
        inc(contador, 1);
        inc(estilo, 1);
        // showmessage('radiobutton2 is selected');
      end;
  End;
  for I := 0 to Tabla2.Count - 1 do
  begin
    Label2.Caption := Tabla2.Strings[contador];
    // +'contador>'+inttostr(contador);
  end;
  case contador of
    80:
      begin
        // Label2.Caption:='P81: Dime Si gustó el Cuestionario '     ;
        // i:=79;
        I := 79;
        If respuesta = str8 then
          dec(contador, 1);
      end;
    81:
      begin
        Tabla2.Free;
        Label3.Caption := str10;
        Tabla2 := TStringList.Create;
        Tabla2.Clear;
        Tabla2.add(str11 + Inttostr(contador) + str12 + Inttostr(estilo1) + ' '
          + str13 + Inttostr(estilo2) + ' ' + str14 + Inttostr(estilo3) + ' ' +
          str15 + Inttostr(estilo4) + '');
        // Tabla.SaveToFile( ExtractFilePath( Application.ExeName ) + 'Resultado.txt' );
        Tabla2.SaveToFile('Resultado.txt', TEncoding.utf8);
        Label2.Caption := Tabla2.Strings[0];
        Tabla2.Free;
        Button3.Visible := False;
        Button4.Visible := False;
        Button3.Enabled := False;
        Button4.Enabled := False;
        RadioGroup1.Visible := False;
      end;
    // Label2.Caption:='Gracias por Participar en esta encuesta';
    // If Respuesta='a' then inc(estilo1,1);  //pregunta 5 apunta al estilo1
    // If Respuesta='b' then inc(indeciso,1);
    // If Respuesta='c' then inc(indeciso,1);
    // respuesta:='';
    // showmessage('Fin del cuestionario Contador _'+Inttostr(contador)+'_   estilo 1->'+Inttostr(estilo1)+' '+'estilo 2->'+Inttostr(estilo2)+' '+'estilo 3->'+Inttostr(estilo3)+' '+'estilo 4->'+Inttostr(estilo4)+'');

  end;
  case estilo of
    3, 5, 7, 9, 13, 20, 26, 27, 35, 37, 41, 43, 46, 48, 51, 61, 67, 74, 75,
      77: { definiremos estilo 1 }
      begin
        If respuesta = str7 then // a
          inc(estilo1, 1); // pregunta x apunta al estilo1
        If respuesta = str8 then // b
          inc(indeciso, 1);
        If respuesta = str9 then // c
          inc(indeciso, 1);
        respuesta := '';
      end;
    10, 16, 18, 19, 28, 31, 32, 34, 36, 39, 42, 44, 49, 55, 58, 63, 65, 69, 70,
      79: { definiremos estilo 2 }
      begin
        If respuesta = str7 then // a
          inc(estilo2, 1); // pregunta x apunta al estilo2
        If respuesta = str8 then // b
          inc(indeciso, 1);
        If respuesta = str9 then // c
          inc(indeciso, 1);
        respuesta := '';
      end;
    2, 4, 6, 11, 15, 17, 21, 23, 25, 29, 33, 45, 50, 54, 60, 64, 66, 71, 78,
      80: { definiremos estilo 3 }
      begin
        If respuesta = str7 then // a
          inc(estilo3, 1); // pregunta x apunta al estilo3
        If respuesta = str8 then // b
          inc(indeciso, 1);
        If respuesta = str9 then // c
          inc(indeciso, 1);
        respuesta := '';
      end;
    1, 8, 12, 14, 22, 24, 30, 38, 40, 47, 52, 53, 56, 57, 59, 62, 68, 72, 73,
      76: { definiremos estilo 4 }
      begin
        If respuesta = str7 then // a
          inc(estilo4, 1); // pregunta x apunta al estilo4
        If respuesta = str8 then // b
          inc(indeciso, 1);
        If respuesta = str9 then // c
          inc(indeciso, 1);
        respuesta := '';
      end;
  end;
end;

end.
