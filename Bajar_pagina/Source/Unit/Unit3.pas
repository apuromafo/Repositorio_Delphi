unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  WinInet, Winsock, // para GetIP
  URLMon, ShellApi; // para Download

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Label3: TLabel;
    Edit3: TEdit;
    Opcion: TRadioGroup;
    Image1: TImage;

    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

Resourcestring
  destfile1 = 'pagina2.html';
  DownOK = 'Download ok!';
  op = 'open';
  ErrorOp = 'Error maybe need http:// ';
  null = '';

var
  Form3: TForm3;

implementation

{$R *.dfm}

function DownloadFile(SourceFile, DestFile: string): Boolean;
begin
  try
    Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile),
      0, nil) = 0;
  except
    Result := False;
  end;
end;

function GetIp: string;
var
  Buffer: array [0 .. 127] of char;
  WSAData: TWSADATA;
  HostEnt: phostent;
begin
  Result := '';
  FillChar(Buffer, SizeOf(Buffer), #0);
  if WSAStartup(MAKEWORD(1, 1), WSAData) = 0 then
  begin
    if GetHostName(@Buffer, SizeOf(Buffer)) = 0 then
    begin
      HostEnt := gethostbyname(@Buffer);
      if HostEnt <> nil then
        Result := String(inet_ntoa(PInAddr(HostEnt.h_addr_list^)^));
    end;
    WSACleanup;
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);

var
  DestFile, SourceFile: string;
begin
  SourceFile := Edit1.text;
  DestFile := Edit3.text;
  if length(DestFile) < 1 then
  begin
    DestFile := destfile1;
  end;

  if DownloadFile(SourceFile, DestFile) then
  begin
    Edit2.text := GetIp;
    ShowMessage(DownOK);
    if Opcion.ItemIndex = 0 then
    begin
      ShellExecute(Application.Handle, PChar(op), PChar(DestFile), PChar(null),
        nil, SW_NORMAL)
    end;
  end
  else
    ShowMessage(ErrorOp + SourceFile)
end;

end.
