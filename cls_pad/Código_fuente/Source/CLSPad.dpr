program CLSPad;

uses
  Vcl.Forms,
  MainUnit in 'Units\MainUnit.pas' {Form1} ,
  Vcl.Themes;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
