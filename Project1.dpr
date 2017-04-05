program Project1;

{$R *.dres}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cuestionario 1.2';
  TStyleManager.TrySetStyle('Obsidian');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
