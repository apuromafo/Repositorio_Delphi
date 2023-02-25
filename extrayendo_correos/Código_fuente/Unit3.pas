{
  Apuromafo v1.1  07/04/2017
  Apuromafo v1.2  17/01/2018
}
unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Resourcestring
  str0 = 'v1.2  17/01/2018';
  str1 = 'Buscando el Archivo';
  str2 = 'Procesando el Archivo';
  str3 = 'Guardando el Archivo';
  str4 = 'Estado: OK, Proceso listo revisa resultado.txt';
  str5 = 'Resultado.txt';

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure GetFileNames(Path: string; TS: TStrings);
var
  sr: TSearchRec;
begin
  if FindFirst(ExtractFilePath(Path) + '*' + ExtractFileExt(Path), 32, sr) = 0
  then
    repeat
      TS.Add(ExtractFilePath(Path) + sr.Name);
    until FindNext(sr) <> 0;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  i: Int64;
  Tabla: TStrings;
  Tabla2: TStrings;
  MyString: String;
  Splitted: TArray<String>;
begin
  // Tabla.Create;
  Label2.caption := str1;
  Tabla := TStringList.Create;
  Tabla.Clear;
  Tabla2 := TStringList.Create;
  Tabla2.Clear;
  with TFileOpenDialog.Create(nil) do
    try
      // Options := [fdoPickFolders];
      if Execute then
        // ShowMessage(FileName);
        // GetFileNames(FileName, Files);
        // for i:= 0 to Files.Count-1 do
        Tabla.LoadFromFile(Filename);
      // Memo1.Lines.LoadFromFile(Filename)  ;
      // Memo2.Clear;
      // Memo2.Lines.BeginUpdate ;
      Label2.caption := str2;
      for i := 0 to Tabla.Count - 1 do
      begin
        MyString := Tabla.Strings[i];
        // MyString :=  Tabla.Strings[i] ;
        Splitted := MyString.Split([':']);
        Tabla2.Add(Splitted[0]);
        // Memo2.Lines.Add(Splitted[0]);
        // Memo2.Lines.EndUpdate;
      end;

    finally
      Free;
      Label2.caption := str3;
      Tabla2.SaveToFile(str5, TEncoding.UTF8);
      // Tabla.SaveToFile('Resultado.txt'+ FileName);
      Tabla.Free;
      Tabla2.Free;
      Label2.caption := str4;
    end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Label1.caption := str0;
end;

end.
