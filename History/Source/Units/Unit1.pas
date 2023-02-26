{ ********************************************* }
{ Delphi code    By : Apuromafo }
{ This example provide by - Apuromafo.net }
{ version 1.0 coded in RAD Studio }
{ ********************************************* }
unit Unit1;
// 1.    Unit. Hace referencia al nombre del documento de códigos.

interface

// 2.    Interface. Hace constar que lo que le sigue a esa palabra es la interfaz del formulario.
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  // JvExStdCtrls, JvListBox, JvComboListBox,
  Vcl.ComCtrls, Vcl.CheckLst,
  System.Generics.Collections, Vcl.Imaging.pngimage, Vcl.Menus;

// 3.    Uses. En esta se especifican los distintos módulos que cargará el programa
// y que se incluirán en el ejecutable una vez compilado para que éste tenga una
// independencia total del compilador.
type
  // declare new,removed,changed,fixed,info
  // TLeyenda22 = (lnew, lRemoved, lchanged, lfixed, linfo);

  // leyenda fijo
  TComentario = record
    Comentario: String;
    // Leyenda22: TLeyenda22;
  end;

  // 4.    Type.  En esta sección se especificaran los distintos objetos
  // con su correspondiente clase (NombreComponente:TipoComponente),
  // ejemplo: (Label1:TLabel), y los distintos procedimientos que
  // se ejecutarán en el programa.
  TForm1 = class(TForm)
    Fecha: TDateTimePicker;
    Prog_Edt: TEdit;
    VERSION_Label: TLabel;
    WEB_Edt: TEdit;
    Prog_Label: TLabel;
    GenerarBtn: TButton;
    Preview: TMemo;
    Leyenda: TRadioGroup;
    Fecha_Label: TLabel;
    WEB_Label: TLabel;
    VERSION_Edt: TEdit;
    VersionBtn: TButton;
    DescripcionBtn: TButton;
    SaveBtn: TButton;
    ExitBtn: TButton;
    Clear: TButton;
    description_Label: TEdit;
    CheckListBox1: TCheckListBox;
    Label1: TLabel;
    Mostrar: TButton;
    Label2: TLabel;
    Image2: TImage;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Menu11: TMenuItem;
    N2: TMenuItem;
    Menu21: TMenuItem;
    AcercaSource1: TMenuItem;
    Autor1: TMenuItem;
    procedure GenerarBtnClick(Sender: TObject);
    procedure VersionBtnClick(Sender: TObject);
    procedure DescripcionBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure MostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Menu11Click(Sender: TObject);
    procedure Menu21Click(Sender: TObject);
    procedure Autor1Click(Sender: TObject);
    procedure AcercaSource1Click(Sender: TObject);
    // Al final de ella se verán dos palabras clave “Private” y “Public”,
    // que sirven para definir variables privadas o públicas.
  private
    { Private declarations }
  public
    { Public declarations }
    hola, Programa, version, WEB: String;
    counter: int64;
    Etapa1: String;
    dic: TDictionary<string, TList<TComentario>>;
    ComentarioTemporal: TComentario;
    // Leyenda22: TLeyenda22;

  const
    Titulo_prog = ' History v1.3 un  Changelog por Apuromafo';
    encabezado1 = '============*{ History }*============';
    encabezado2 = '=================================';
    espacio = ' ';
    opc01 = 'Leyenda:';
    opc02 = '[+] Agregado / Nuevo';
    opc03 = '[-] Removido';
    opc04 = '[*] Cambiado';
    opc05 = '[%] Arreglado(bugs)';
    opc06 = '[^] Actualizaciones y / o Información ';
    opc07 = 'Nombre';
    opc08 = 'http://www.';
    opc09 = '1.0';
    opc10 = 'aqui va la descripción';
    salto = #13#10;

  end;

resourcestring
  str0 = 'YYYY-MM-DD'; // formato fecha
  str1 = 'favor tildar alguna Versión'; // si no agregan opciones
  str2 = 'guardado como History.txt';
  str3 = 'History.txt';
  str4 = 'Version ';
  str5 = '';
  str6 = '';
  str7 = '';
  str8 = '';
  str9 = '';
  str10 = '';
  str11 = '';
  str12 = '';
  str13 = '';
  // uso de history
  strcls1 = 'Programa que ayuda en el proceso de creación de changelog';
  strcls2 = 'Edita los campos solicitados, y luego de verlos';
  strcls3 = 'puedes guardarlo ';
  // autor
  strcls4 = 'Autor: Apuromafo';
  strcls5 = 'imagen Vector:';
  strcls6 = 'https://pixabay.com/es/vectors/desplazamiento-de-papel-antigua-34696/';
  // Source
strcls7 = 'https://github.com/apuromafo/History-by-Apuromafo';

var
  Form1: TForm1;

  // resourcestring

implementation

{$R *.dfm}

{ *************** Genera Version  ************ }
procedure TForm1.VersionBtnClick(Sender: TObject);
var
  hola: string;
  // valor: int64;
begin
  // Preview.Lines.Add(salto + encabezado2);
  hola := VERSION_Edt.Text + espacio;
  hola := hola + FormatDateTime(str0, Fecha.Date);
  // Preview.Lines.Add(VERSION_Label.Caption + espacio + hola);
  // Preview.Lines.Add(encabezado2);
  VERSION_Edt.Text := opc09;
  inc(counter, 1);
  // valor:= counter;
  // CheckListBox1.Items.Add(inttostr(counter) + ')' + hola);
  dic.Add(hola, TList<TComentario>.Create);
  CheckListBox1.Sorted := True;
  CheckListBox1.Items.Add(hola);

  DescripcionBtn.Enabled := True;

end;

procedure TForm1.DescripcionBtnClick(Sender: TObject);
var
  i: integer;
begin
  counter := 0;
  for i := 0 to CheckListBox1.Items.Count - 1 do
    If CheckListBox1.Checked[i] then
    begin
      inc(counter, 1)
    end;
  if counter > 0 then
  begin

    for i := 0 to CheckListBox1.Items.Count - 1 do
      If CheckListBox1.Checked[i] then
      begin
        // Preview.Lines.Add('CheckListBox1 en ' + CheckListBox1.Items[i]);
        CheckListBox1.Checked[i] := False;
        hola := (Copy((Leyenda.Items[Leyenda.ItemIndex]), 1, 4) +
          description_Label.Text);
        ComentarioTemporal.Comentario := hola;
        // agrego un comentario temporal, para ayudar a que se ingrese la variable como corresponde
        // sin esta linea entonces el programa no tiene al add, los comentarios
        dic.Items[CheckListBox1.Items[i]].Add(ComentarioTemporal);
      end;
  end
  else
  begin
    showmessage(str1);
  end;

  // hola := (Copy((Leyenda.Items[Leyenda.ItemIndex]), 1, 4) +
  // description_Label.Text);
  // Preview.Lines.Add(hola);
  description_Label.Text := opc10;
end;

procedure TForm1.SaveBtnClick(Sender: TObject);
begin
  showmessage(str2);
  Preview.Lines.SaveToFile(str3, TEncoding.UTF8);
end;

procedure TForm1.ExitBtnClick(Sender: TObject);
begin
  halt;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // creamos el dicionario de las versiones
  dic := TDictionary < string, TList < TComentario >>.Create;
  caption := espacio + Titulo_prog;
end;

procedure TForm1.GenerarBtnClick(Sender: TObject);
var
  Leyenda2: String;
begin

  Preview.Lines.Clear; // borro el memo
  Programa := Prog_Label.caption;
  version := VERSION_Label.caption;
  WEB := WEB_Label.caption;
  Preview.Lines.Add(encabezado1 + salto + Programa + Prog_Edt.Text + espacio);
  Preview.Lines.Add(WEB + WEB_Edt.Text + espacio + salto + encabezado2);
  Leyenda2 := opc01 + salto + opc02 + salto;
  Leyenda2 := Leyenda2 + opc03 + salto + opc04 + salto;
  Leyenda2 := Leyenda2 + opc05 + salto + opc06; // + salto;
  Preview.Lines.Add(Leyenda2);
  Prog_Edt.Text := opc07;
  WEB_Edt.Text := opc08;
  VERSION_Edt.Text := opc09;
end;

procedure TForm1.AcercaSource1Click(Sender: TObject);

begin

  showmessage(strcls7);
end;

procedure TForm1.Autor1Click(Sender: TObject);

begin

  showmessage(strcls4 + #13 + strcls5 + #13 + strcls6);
end;

procedure TForm1.ClearClick(Sender: TObject);
begin
  Preview.Clear;
end;

procedure TForm1.Menu11Click(Sender: TObject);
begin
  halt;
end;

procedure TForm1.Menu21Click(Sender: TObject);

begin

  showmessage(strcls1 + #13 + strcls2 + #13 + strcls3);
end;

procedure TForm1.MostrarClick(Sender: TObject);
var
  key: string;

  i, j: integer;

begin
  // ComentarioTemporal.Comentario := 'hola';
  // ComentarioTemporal.Leyenda22 := lnew;
  // dic := TDictionary < string, TList < TComentario >>.Create;
  // dic.Add('1.1', TList<TComentario>.Create);
  // dic.Items['1.1'].Add(ComentarioTemporal);
  // Preview.Clear;
  Preview.Lines.Add(espacio);
  for i := CheckListBox1.Items.Count - 1 Downto 0 do
  begin
    key := CheckListBox1.Items[i];
    Preview.Lines.Add(encabezado2);
    Preview.Lines.Add(str4 + key);
    Preview.Lines.Add(encabezado2);

    for j := 0 to dic.Items[key].Count - 1 do
    begin

      Preview.Lines.Add(dic.Items[key][j].Comentario);
      // Preview.Lines.Add(dic.Items[key][i].Comentario);
      // case dic.Items[key][i].Leyenda22 of
      // lnew:
      // begin
      // Preview.Lines.Add(('[+] ') + dic.Items[key][i].Comentario);

      // end;
    end;

    Preview.Lines.Add(espacio);
  end;

end;

end.
