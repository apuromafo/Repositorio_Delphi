(*       Apuromafo Example        *)
program VerificadorMail;

uses
  Vcl.Forms,
Unit1 in 'Unit/Unit1.pas' {Form1};

{$R *.RES}
var
Form1:TForm1;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1,Form1);
  Application.Run;
end.