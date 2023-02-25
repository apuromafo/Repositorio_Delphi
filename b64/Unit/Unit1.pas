unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.NetEncoding, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Button3: TButton;
    Label1: TLabel;
    Button4: TButton;
    Image1: TImage;
    Button5: TButton;
    Button6: TButton;
    MainMenu1: TMainMenu;
    About1: TMenuItem;
    Archivo1: TMenuItem;
    Salir1: TMenuItem;
    Source1: TMenuItem;
    Autor1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Source1Click(Sender: TObject);
    procedure Autor1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

Resourcestring
  str1 = 'Base64 Simple Encode/decode v1.0.1';
  str2 = '';
  str3 = 'Bienvenido Sigue las instrucciones y funcionara bien :) ';
  str4 = 'Base 64 Encoding';
  str5 = 'Base 64 Decoding';
  str6 = 'Encode b64';
  str7 = 'Decode b64';
  str8 = 'Decode ';
  str9 = 'No olvides que fue creado para decodificar base64 no texto ;) ';
  // excepcion
  str10 = 'Guardar como .b64';
  str11 = 'Decidete a cargar un archivo';
  str12 = 'File does not exist.';
  str13 = 'Abrir .b64';
  str14 = 'Borrar Texto';
  Str15 = 'https://github.com/apuromafo/B64-Apuromafo/releases';
  Str16 = 'Creado con fines educativos';
  Str17 = 'Imagen de fondo gratuita desde :pixabay.com';
  Str19  = 'Icono: htts://all-free-download.com/';
  Str18 = 'Recuerda escribir antes de pulsar';

  SAVED = 'encoded.b64';
  SAVETEXT = 'Guardando el b64 '; // 3
  DFilter = 'Archivo en Base64 |*.b64'; // 4
  EXT = 'b64';
  space = #13;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{
  image from https://pixabay.com/es/photos/diente-de-le%C3%B3n-colorido-2817950/
  Pixabay License
  Gratis para usos comerciales
  No es necesario reconocimiento
}

procedure TForm1.Autor1Click(Sender: TObject);
begin
  Showmessage(str1 + space + Str16 + space + Str17+ space +Str19);
end;

procedure TForm1.Button1Click(Sender: TObject);

begin
  if Memo1.Text <> '' then
  begin
    Memo3.Lines.BeginUpdate;
    Application.ProcessMessages;
    Memo3.Text := TNetEncoding.Base64.Encode(Memo1.Text);
    Memo1.Text := Memo3.Text;
    Memo3.Lines.EndUpdate;
    Label1.Visible := False;
  end
  else
  begin
    Showmessage(Str18);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  if length(Memo1.Text) <1 then

  begin

    Showmessage(Str18);
  end
  else
  begin
    try
      Application.ProcessMessages;

      Memo3.Text := TNetEncoding.Base64.Decode(Memo1.Text);
      Memo1.Text := Memo3.Text;

      Label1.Visible := True;
      Button1.Visible := True;

    except
      on E: Exception do
      begin
        // ShowMessage('Exception class name = ' + E.ClassName);
        // ShowMessage('Exception message = ' + E.Message);
        Showmessage(str9);
      end;

    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);

begin
  try
    Memo3.Clear;

    Memo3.Text := TNetEncoding.Base64.Decode(Memo1.Text);
    Memo2.Text := Memo3.Text;

  except
    on E: Exception do
    begin
      // ShowMessage('Exception class name = ' + E.ClassName);
      // ShowMessage('Exception message = ' + E.Message);
      Showmessage(str9);
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);

var
  saveDialog: tsavedialog; // Save dialog variable

begin

  begin
    // Create the save dialog object - assign to our save dialog variable
    saveDialog := tsavedialog.Create(self);
    // Give the dialog a title
    saveDialog.Title := SAVETEXT;
    // Set up the starting directory to be the current one
    saveDialog.InitialDir := GetCurrentDir;
    // Allow only .txt file types to be saved
    saveDialog.Filter := DFilter;
    // Set the default extension
    saveDialog.DefaultExt := EXT;
    // Select text files as the starting filter type
    saveDialog.FilterIndex := 1;
    // Display the open file dialog
    if saveDialog.Execute then
    begin
      // showmessage(MSGSAVED + saveDialog.FileName);
      Memo1.Lines.SaveToFile(saveDialog.FileName, Tencoding.utf8)
    end
    else
    begin
      // ShowMessage('Save file was cancelled');
      Memo1.Lines.SaveToFile(SAVED, Tencoding.utf8);
      // showmessage(dia2);
    end;
    // Free up the dialog
    saveDialog.Free;
  end;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
  OpenDialog: TOpenDialog; // Save dialog variable

begin
  try
    OpenDialog := TOpenDialog.Create(self);
    // Give the dialog a title
    OpenDialog.Title := SAVETEXT;
    // Set up the starting directory to be the current one
    OpenDialog.InitialDir := GetCurrentDir;
    // Allow only .txt file types to be saved
    OpenDialog.Filter := DFilter;
    // Set the default extension
    OpenDialog.DefaultExt := EXT;
    // Select text files as the starting filter type
    OpenDialog.FilterIndex := 1;

    { Execute an open file dialog. }
    if OpenDialog.Execute then
      { First check if the file exists. }
      if FileExists(OpenDialog.FileName) then
        { If it exists, load the data into the memo box. }
        Memo1.Lines.LoadFromFile(OpenDialog.FileName, Tencoding.utf8)
  except
    on E: Exception do
    begin
      // ShowMessage('Exception class name = ' + E.ClassName);
      // ShowMessage('Exception message = ' + E.Message);
      Showmessage(str11);
    end;
  end;

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo2.Clear;
  Memo3.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  self.Caption := str1; // titulo
  Memo1.Text := str2;
  Memo2.Text := str2;
  Label1.Caption := str3;
  Label2.Caption := str4;
  Label3.Caption := str5;
  Button1.Caption := str6;
  Button2.Caption := str7;
  Button3.Caption := str8;
  Button4.Caption := str10;
  Button5.Caption := str13;
  Button6.Caption := str14;
  Button3.Visible := False;
  Memo1.Clear;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  Button3.Visible := True;
  if Memo1.Text = '' then
  begin
    Button3.Visible := False;
  end;

end;

procedure TForm1.Salir1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TForm1.Source1Click(Sender: TObject);
begin
  Showmessage(Str15);
end;

end.
