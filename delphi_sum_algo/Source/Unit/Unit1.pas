unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    Edit3: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    RadioGroup1: TRadioGroup;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Stop: Boolean;

resourcestring

  str1 = '-----------Working From ';
  str2 = ' to ';
  str3 = ' with value ';
  str4 = '-----------';
  str5 = 'The number ';
  str6 = ' the sum is ';
  str7 = ' equal to ';
  str8 = 'Total =';
  str9 = 'You was Stop/clear, now for work press Start :)';

  // about Form
  str10 = 'Digit sum algo by  Apuromafo v1.3';
  str110 = 'Welcome press ';
  str111 = ' to calculate the values ';
  str12 = 'Start'; // Label1.caption
  str13 = 'End'; // label2.caption
  str14 = 'Algoritm'; // label3 .caption
  str15 = 'Algo:'; // radiogroup1.caption
  str16 = 'Start'; // Button1 caption
  str17 = 'Clear/Stop'; // button2 caption
  str18 = 'Exit'; // button3 caption
  str19 = 'Sum Divisible (mod)'; //radiogroup.item1
  str20 = 'Sum  value ( = )';//radiogroup.item2

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  n, test, sum, d: integer;
begin
  Memo1.Clear;
  n := 0;
  // Memo1.text := 'Welcome you was pressed the button and now im';
  Memo1.Lines.Add(str1 + Edit1.text + str2 + Edit2.text + str3 +
    Edit3.text + str4);
  Application.ProcessMessages;
  RadioGroup1.Enabled := False;
  for n := strtoint(Edit1.text) { from 0 } to strtoint(Edit2.text)
  { to 1000 } do { Loop for all  digit numbers }
  begin
    Application.ProcessMessages;
    test := n; { Make "test" the work field }
    sum := test mod 10; { Put the low order digit of "test" into "sum" }
    test := test div 10; { shift "test" one digit to the right }
    sum := sum + test mod 10; { add the second digit to sum }
    test := test div 10; { get down to the final digit }
    sum := sum + test; { add it to "sum" }
    { Memo1.Lines.Add(inttostr(sum)); }
    { is n an exact multiple of sum and does n div sum =35? }
    { if (n mod sum = 0) and (n div sum =7) }
    { then }

    Case RadioGroup1.ItemIndex of
      0:
        begin
          Case sum mod strtoint(Edit3.text) of
            { P Divide a primary integer by the text 3, as value - Mod returns the remainder  if are divisible , reminder is 0 }
            0:
              begin
                { if wana not show the 0 you must enable this code from // to nothing }
                { if (n =0) then }
                { else }
                Memo1.Lines.Add(str5 + inttostr(n) + str6 + inttostr(sum) +
                  ' divisible by ' + Edit3.text);
                if Stop = True then
                begin
                  Memo1.Clear;
                  break
                end

                // beep;
              end;
          end;
        end;

      1:
        begin
          if sum = strtoint(Edit3.text) then
          begin
            { P Divide a primary integer by the text 3, as value - Mod returns the remainder  if are divisible , reminder is 0 }
            { if wana not show the 0 you must enable this code from // to nothing }
            { if (n =0) then }
            { else }
            Memo1.Lines.Add(str5 + inttostr(n) + str6 + inttostr(sum) + str7 +
              Edit3.text);
            if Stop = True then
            begin
              Memo1.Clear;
              break
            end
          end;
          // beep;
        end; { end begin }
    end; { end procedure }
  end;
  if Memo1.Lines.Count > 0 then
  begin
    Memo1.Lines.Add(str8 + inttostr(Memo1.Lines.Count - 1));
  end;
  if Memo1.Lines.Count = 0 then
  begin
    Memo1.Lines.Add(str9);
  end;
  RadioGroup1.Enabled := True;
  Stop := False;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Stop := True;

  Stop := True;
  Memo1.Clear;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  halt
end;

procedure TForm1.FormCreate(Sender: TObject);

begin
  Memo1.Clear;
  caption := str10;
  Memo1.text := str110 + str16 + str111;
  Label1.caption := str12;
  Label2.caption := str13;
  Label3.caption := str14;
  RadioGroup1.caption := str15;
  Button1.caption := str16;
  Button2.caption := str17;
  Button3.caption := str18;
  RadioGroup1.Items.Strings[0] := str19;
  RadioGroup1.Items.Strings[1] := str20;
end;

end. { end program }
