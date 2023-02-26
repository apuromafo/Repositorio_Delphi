program History_Changelog_Apuromafo;

uses
  Vcl.Forms,
  Unit1 in 'Units\Unit1.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Obsidian');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
