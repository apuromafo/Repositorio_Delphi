// Proyecto Notepad Personalizado SoftDPad 01/06/2017
// Proyecto Notepad Retomado Apuromafo 20/06/2019
// v1.1 Ajuste de ventana

unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, PngImage,
  Clipbrd, Spin, Vcl.ExtCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList,
  inifiles, Vcl.Grids, Printers, Vcl.ExtDlgs, Shellapi, Vcl.Outline,
  Vcl.Samples.DirOutln, Data.DB, Vcl.DBGrids, Vcl.DBCtrls, System.Actions,
  Vcl.ActnList, richedit, System.RegularExpressions;
// , Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc; // , Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

const
  RAC = 'CLSpad'; // no colocar espacio por regeditvalue
  titRAC = ' -  ' + RAC; // titulo
  aviRAC = ' Información de ' + RAC; // aviso

const
  Blue: array [1 .. 328] of string = ('!DOCTYPE', '</head>', '<table', '<body>',
    '</body>', '<a>', '<a', '</a>', '<p>', '</p>', '<html>', '</html>',
    '<abbr>', '</abbr>', '<address>', '</address>', '<br>', '</br>', '<h1>',
    '</h1>', '<h2>', '<b>', '</b>', '</h2>', '<h3>', '<h4>', '<h5>', '<h6>',
    '</h3>', '<h4>', '</h5>', '<h6>', '</h7>', '<audio>', '</audio>',
    '<blockquote>', '</blockquote>', '<bdo>', '<bdi>', '<base>', '<td ', '<tr>',
    '</tr>', '<td>', '</td>', '</span>', '<span', '</span>', '<meta', '<meta>',
    '</meta>', '<accesskey>', '<action>', '<address>', '<align>', ' <alink>',
    '<alt>', '<applet>', '<archive>', '<area>', '<article>', '<aside>',
    '<audio> ', '<autocomplete>', '<autofocus>', '<axis>', '<b>',
    '<background> ', '<base>', '<basefont>', '<bdi>', '<bdo>', '<bgcolor>',
    '<bgsound> ', '<big>', '<blink>', '<blockquote>', '<body>', '<border>',
    '<br>', '<Button>', '<Canvas>', '<Caption>', '<cellpadding>',
    '<cellspacing> ', '<center>', '<Char>', '<charoff>', '<charset>',
    '<checkbox>', '<Checked>', '<cite>', '< class>', '<classid>', '<Clear>',
    '<code>', '<codebase> ', '<codetype>', '<col>', '<colgroup>', '<Color>',
    '<cols>', '<colspan>', '<command>', '<compact>', '<content>',
    '<contenteditable> ', '<contextmenu>', '<coords>', '<Data>', '<datafld>',
    '<dataformatas>', '<datalist>', '<datapagesize> ', '<datasrc>',
    '<datetime>', '<dd>', '<declare>', '<defer>', '<del>', '<details>', '<dfn>',
    '<dialog>', '<dir>', '<disabled>', '< div > ', '<dl>', '<draggable>',
    '<dropzone>', '<dt>', '<element>', '<em>', '<embed>', '<enctype>',
    '<event>', '<face>', '<fieldset>', '<figcaption> ', '<figure>', '< file>',
    '<Font>', '<footer>', '< for >', '<form> ', '<formaction>', '<formenctype>',
    '<formmethod>', '<formnovalidate> ', '<formtarget>', '<frame>',
    '<frameborder>', '<frameset>', '<h1>', '<h2>', '<h3>', '<h4>', '<h5>',
    '<h6>', '<head>', '<header>', '<headers> ', '<Height>', '<hgroup>',
    '<hidden>', '<hr>', '<href>', '<hreflang>', '<hspace>', '<html>', '<http>',
    '< - >', '<equiv>', '<i>', '<id>', '<iframe> ', '<image>', '<img>',
    '<input>', '<ins>', '<isindex>', '<ismap>', '<kbd> ', '<keygen>',
    '< label >', '<lang>', '<language>', '<leftmargin>', '<legend>', '<li>',
    '<link>', '</link>', '<list>', '<listing>', '<longdesc>', '<main> ',
    '<manifest>', '<map>', '<marginheight>', '<marginwidth>', '<mark>',
    '<marquee>', '<max>', '<maxlength>', '<media>', '<Menu>', '<menuitem>',
    '<meta>', '<meter>', '<method>', '<min>', '<multicol>', '<multiple>',
    '<name>', '<nav> ', '<nobr>', '<noembed>', '<noframes>', '<nohref>',
    '<noresize>', '<noscript>', '<noshade>', '<novalidate>', '<nowrap>',
    '< object>', '<ol>', '<onabort>', '<onafterprint>', '<onautocomplete>',
    '<onautocompleteerror> ', '<onbeforeonload>', '<onbeforeprint>', '<onblur>',
    '<oncancel>', '<oncanplay>', '<oncanplaythrough>', '<onchange>',
    '<onclick> ', '<onclose>', '<oncontextmenu>', '<oncuechange>',
    '<ondblclick>', '<ondrag>', '<ondragend>', '<ondragenter>', '<ondragleave>',
    '<ondragover> ', '<ondragstart>', '<ondrop>', '<ondurationchange>',
    '<onemptied>', '<onended>', '<onerror>', '<onfocus>', '<onhashchange>',
    '<oninput> ', '<oninvalid>', '<onkeydown>', '<onkeypress>', '<onkeyup>',
    '<onload>', '<onloadeddata>', '<onloadedmetadata>', '<onloadstart> ',
    '<onmessage>', '<onmousedown>', '<onmouseenter>', '<onmouseleave>',
    '<onmousemove>', '<onmouseout>', '<onmouseover> ', '<onmouseup>',
    '<onmousewheel>', '<onoffline>', '<ononline>', '<onpagehide>',
    '<onpageshow>', '<onpause>', '<onplay> ', '<onplaying>',
    '<onpointercancel>', '<onpointerdown>', '<onpointerenter>',
    '<onpointerleave>', '<onpointerlockchange> ', '<onpointerlockerror>',
    '<onpointermove> ', '<onpointerout>', '<onpointerover> ', '<onpointerup>',
    '<onpopstate>', '<onprogress> ', '<onratechange>', '<onreadystatechange>',
    '<onredo>', '<onreset>', '<onresize>', '<onscroll>', '<onseeked>',
    '<onseeking> ', '<onselect>', '<onshow>', '<onsort>', '<onstalled>',
    '<onstorage> ', '<onsubmit>', '<onsuspend>', '<ontimeupdate>', '<ontoggle>',
    '<onundo>', '<onunload>', '<onvolumechange>', '< onwaiting ', '<optgroup>',
    '<option>', '<output>', '<p>', '<param>', '<password>', '<pattern>',
    '<picture>', '<placeholder>', '</table>', '</style>', '<style', '<style',
    '<acronym>', '</title>', '<title>');

  Red: array [1 .. 13] of string = ('href=', 'content=', 'class=', 'value=',
    'cellpadding=', 'type=', 'http-equiv', 'async=', 'rel=', 'accept-charset',
    'cellspacing', 'acronym', 'accept');

  // Black: array [1 .. 5] of string = (#$21, #$22,'!', '<', '>', '/', '\');
  Green: array [1 .. 7] of widestring = ('<!-', '<!', '<-', '->', ';',
    '}', '{');

Resourcestring
  Version = ' 2.1 ';
  Untitled = 'Sin título ';
  Save_Info = 'Salir sin guardar los cambios?';
  NotFounded = 'no se encuentra ';
  // SoftPad  creado por
  Info = 'creado desde SoftPad de ';
  ProgAutor = 'SoftDat CLS';
  Revisor = 'Edición : Apuromafo CLS';
  sLineBreak = #13;
  InspiradoStr = 'Idea base: Notepad ©Microsoft ';
  Iconos = 'Iconos:htts://all-free-download.com/' + #13 +
    'GlyphPack: https://www.iconfinder.com/iconsets/glyphpack ';

  // noencontradostr = 'No se encuentra desde la posición actual';
  saveinfostr = '¿Deseas Guardar los cambios hechos?';
  STRyes = 'Guardar';
  STRno = 'No guardar';
  STRcancel = 'Cancelar';
  STRSave1 = 'Guardando desde Abrir';

  STRSave2 = 'Guardando desde Cerrar';
  STRSave3 = 'Guardando desde ReAbrir';
  STRSave4 = 'Guardando desde Drag&drop';
  STRSave5 = 'Guardando desde Nuevo';

  SavingStr = 'Guardando...'; // usado en status bar
  ListoStr = 'Ready';
  iralinea1 = 'Número de Línea';
  iralinea2 = 'Ir a';
  iralinea3 = 'Cancelar';
  Strposition = 'Actualmente en la línea ';
  StrTotalLn = 'Total de líneas: ';
  StrPosY = 'Posición: línea ';
  StrDelim = ', ';
  SrtPosX = 'columna ';
  STRCodifActual = ' Codificación Actual :';
  STRSpacio = ' ';

type

  TfrmMain = class(TForm)
    StBarra: TStatusBar;
    FontDlg: TFontDialog;
    Menu: TMainMenu;
    MenuArchivo: TMenuItem;
    mnAbrir: TMenuItem;
    mnGuardar: TMenuItem;
    mnGuardarC: TMenuItem;
    mnSalir: TMenuItem;
    MenuEdicion: TMenuItem;
    MenuFormato: TMenuItem;
    MenuVer: TMenuItem;
    mnAyuda: TMenuItem;
    mnNuevo: TMenuItem;
    mnRAC: TMenuItem;
    mnSelTodo: TMenuItem;
    mnDeshacer: TMenuItem;
    mnCopiar: TMenuItem;
    mnCortat: TMenuItem;
    mnPegar: TMenuItem;
    mnFecha: TMenuItem;
    mnHora: TMenuItem;
    mnFechHora: TMenuItem;
    mnReabrir: TMenuItem;
    mnAjusteLin: TMenuItem;
    mnFuente: TMenuItem;
    mnBarra: TMenuItem;
    mnInvColores: TMenuItem;
    ColorDlg: TColorDialog;
    mnColorF: TMenuItem;
    mnColorT: TMenuItem;
    PrintDlg: TPrintDialog;
    PageSetupDlg: TPageSetupDialog;
    mnConfPag: TMenuItem;
    mnImprimir: TMenuItem;
    mnBuscar: TMenuItem;
    FindDlg: TFindDialog;
    mnEliminar: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    BuscarSiguiente1: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    ReplaceDialog1: TReplaceDialog;
    Remplazar1: TMenuItem;
    BorrarAnteriorCtrlH1: TMenuItem;
    Ira1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    PrintSetupDlg: TPrinterSetupDialog;
    Imprimircomogrfico1: TMenuItem;
    ImprimirBN1: TMenuItem;
    SaveTextFileDialog1: TSaveTextFileDialog;
    OpenTextFileDialog1: TOpenTextFileDialog;
    Abrir1: TMenuItem;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    Guardar1: TMenuItem;
    GuardarC: TMenuItem;
    N7: TMenuItem;
    Memo1: TMemo; // probaré el cambio
    LneaenEscritura1: TMenuItem;
    Timer1: TTimer;
    Integracin1: TMenuItem;
    Extensiones1: TMenuItem;
    OpenWith1: TMenuItem;
    Lenguaje1: TMenuItem;
    SpinEdit1: TSpinEdit;
    Abrirymostrarsoloprintables1: TMenuItem;
    Linebreacksvisibles1: TMenuItem;
    WindowsStile1: TMenuItem;
    MacStyler1: TMenuItem;
    LimpiarEspaciosyStyle1: TMenuItem;
    Cambiarformatodeseleccin1: TMenuItem;
    Pad: TRichEdit;

    CambiarTamaoSeleccion1: TMenuItem;
    Barra1: TToolBar;
    // tool_modo:TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    oolbar1: TMenuItem;
    Cursiva1: TMenuItem;
    Subrayar1: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    Aumentarzoom1: TMenuItem;
    AumentarZoom2: TMenuItem;
    DisminuirZoom1: TMenuItem;
    RestablecerZoom1: TMenuItem;
    Barra2: TToolBar;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    BarraModoTextoRtf1: TMenuItem;
    BarraZoom: TMenuItem;
    Barra3: TToolBar;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton14: TToolButton;
    FormatoEspecial1: TMenuItem;
    Negrita2: TMenuItem;
    ToolButton15: TToolButton;
    // XMLDocument1: TXMLDocument;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    VerBarras1: TMenuItem;
    Formato1: TMenuItem;
    ListBlue: TListBox;
    ListRed: TListBox;
    ListGreen: TListBox;
    ReHacer1: TMenuItem;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    Abrircomobinario1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure mnAbrirClick(Sender: TObject);
    procedure mnSalirClick(Sender: TObject);
    procedure mnNuevoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CanClose: Boolean);
    // procedure PadChange(Sender: TObject);
    procedure mnGuardarClick(Sender: TObject);
    procedure mnGuardarCClick(Sender: TObject);
    procedure mnSelTodoClick(Sender: TObject);
    procedure mnReabrirClick(Sender: TObject);
    procedure mnCortatClick(Sender: TObject);
    procedure mnCopiarClick(Sender: TObject);
    procedure mnPegarClick(Sender: TObject);
    procedure mnAjusteLinClick(Sender: TObject);
    procedure mnFuenteClick(Sender: TObject);
    procedure mnBarraClick(Sender: TObject);
    procedure mnInvColoresClick(Sender: TObject);
    procedure mnColorFClick(Sender: TObject);
    procedure mnColorTClick(Sender: TObject);
    procedure mnDeshacerClick(Sender: TObject);
    procedure mnFechaClick(Sender: TObject);
    procedure mnHoraClick(Sender: TObject);
    procedure mnFechHoraClick(Sender: TObject);
    procedure mnRACClick(Sender: TObject);
    procedure mnConfPagClick(Sender: TObject);
    procedure mnImprimirClick(Sender: TObject);

    // procedure FindDlgFind(Sender: TObject);
    procedure mnEliminarClick(Sender: TObject);
    procedure MenuFormatoClick(Sender: TObject);
    // procedure FindClick(Sender: TObject);
    // procedure FindNextClick(Sender: TObject);
    // procedure ReplaceDialog1Find(Sender: TObject);
    // procedure ReplaceDialog1Replace(Sender: TObject);
    procedure Remplazar1Click(Sender: TObject);
    function SaveChanges: Boolean;
    function SaveChanges2: Boolean;

    procedure Ira1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    // procedure PadContextPopup(Sender: TObject; MousePos: TPoint;
    // var Handled: Boolean);

    procedure Imprimircomogrfico1Click(Sender: TObject);
    procedure ImprimirBN1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure Guardar1Click(Sender: TObject);
    procedure GuardarCClick(Sender: TObject);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;

    procedure LneaenEscritura1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Extensiones1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure OpenWith1Click(Sender: TObject);
    procedure Lenguaje1Click(Sender: TObject);
    procedure Abrirymostrarsoloprintables1Click(Sender: TObject);
    procedure Linebreacksvisibles1Click(Sender: TObject);
    procedure WindowsStile1Click(Sender: TObject);
    procedure MacStyler1Click(Sender: TObject);
    procedure PadChange(Sender: TObject);
    procedure PadMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Cambiarformatodeseleccin1Click(Sender: TObject);
    procedure CambiarTamaoSeleccion1Click(Sender: TObject);
    // procedure Action1Execute(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure oolbar1Click(Sender: TObject);
    procedure Cursiva1Click(Sender: TObject);
    procedure Subrayar1Click(Sender: TObject);
    procedure infobarra;
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);

    procedure PadContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure RestablecerZoom1Click(Sender: TObject);
    procedure AumentarZoom2Click(Sender: TObject);
    procedure DisminuirZoom1Click(Sender: TObject);
    procedure mnBuscarClick(Sender: TObject);
    procedure FindDlgFind(Sender: TObject);
    procedure BuscarSiguiente1Click(Sender: TObject);
    procedure ReplaceDialog1Find(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
    // procedure Button3Click(Sender: TObject);
    // procedure FormPaint(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure BarraModoTextoRtf1Click(Sender: TObject);
    procedure BarraZoomClick(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure Negrita2Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    // procedure InitRichEditURLDetection(RE: TRichEdit);
    procedure ToolButton16Click(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);

    function StringReplace2(const Source, OldPattern, NewPattern: string;
      Flags: TReplaceFlags; Ucolor: Tcolor): string;
    procedure Button3Click(Sender: TObject);
    procedure ReHacer1Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure ToolButton19Click(Sender: TObject);
    procedure ToolButton20Click(Sender: TObject);
//    procedure Abrircomobinario1Click(Sender: TObject);
    // procedure Button3Click(Sender: TObject);
    // procedure Button4Click(Sender: TObject);
    // procedure ListBox2Click(Sender: TObject);

    // procedure Button3Click(Sender: TObject);

    // procedure TrackBar1Change(Sender: TObject);
    // procedure RichEdit1Change(Sender: TObject);

    // procedure Memo1Change(Sender: TObject);

    // procedure PadDragDrop(Sender, Source: TObject; X, Y: Integer);
    // procedure ImprimeActual1Click(Sender: TObject);
    // procedure PadKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    // procedure PadKeyPress(Sender: TObject; var Key: Char);
    // procedure PadKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);


    // procedure Pad1Change(Sender: TObject);
    // procedure Pad1MouseUp(Sender: TObject; Button: TMouseButton);
    // procedure Guardar(Sender: TObject; var Action: TCloseAction);
    // areglado ajuste linea

  private
    { Private declarations }
    // para sincronizar links
    procedure WndProc(var Msg: TMessage); override;

    // sincronizando barras
    // OldPadProc: TWndMethod;
    // procedure PadWindowProc(var Message: TMessage);
    // PrevWndProc: TWndMethod;


    // sincronizando

  public
    { Public declarations }

  end;

var
  frmMain: TfrmMain;
  VisibleLinea: Integer;
  txtArchivo: TextFile; // el archivo en cuestion
  strNombreArch: String; // el nombre del archivo
  RadioGroup1: TRadiogroup;
  extension: String;

  // ssVertical : TScrollStyle ;
  // ssBoth : TScrollStyle ;
const
  validacion =
    '^(ht|f)tp(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)( [a-zA-Z0-9\-\.\?\,\'
    + #39 + '\/\\\+&%\$#_]*)?$';

implementation

{$R *.dfm}   // Include form definitions

procedure TfrmMain.WndProc(var Msg: TMessage);
var
  p: TENLink;
  sURL: string;
  CE: TRichEdit;
begin
  if (Msg.Msg = WM_NOTIFY) then
  begin
    if (PNMHDR(Msg.lParam).code = EN_LINK) then
    begin
      p := TENLink(Pointer(TWMNotify(Msg).NMHdr)^);
      if (p.Msg = WM_LBUTTONDOWN) then
      begin
        try
          CE := TRichEdit(Self.ActiveControl);
          SendMessage(CE.Handle, EM_EXSETSEL, 0, Longint(@(p.chrg)));
          sURL := CE.SelText;
          ShellExecute(Handle, 'open', PChar(sURL), 0, 0, SW_SHOWNORMAL);
        except
        end;
      end;
    end;
  end;

  inherited;
end; (* TForm1.WndProc *)

function Search_And_Replace2(richedit: TRichEdit; SearchText: String;
  startposition, endposition: Integer; Ucolor: Tcolor): Boolean;
var
  StartPos, Position, endpos: Integer;
  FoundAt: Integer;
begin

  StartPos := startposition;
  with richedit do
  begin
    endpos := endposition;
    Application.ProcessMessages;
    Lines.BeginUpdate;
    while FindText(SearchText, StartPos, endpos, [stMatchCase]) <> -1 do
    begin
      endpos := Length(richedit.Text) - StartPos;
      Position := FindText(SearchText, StartPos, endpos, [stMatchCase]);
      inc(StartPos, Length(SearchText));
      SetFocus;
      SelStart := Position;
      SelLength := Length(SearchText);
      SelAttributes.Color := Ucolor;
      richedit.ClearSelection;
      SelText := SearchText;
      SelAttributes.Color := Ucolor;
    end;
    Lines.EndUpdate;
  end;
end;

{ Revisado en la version 1.1 }
// zona de funciones
function MyMessageDlg(CONST Msg: string; DlgTypt: TmsgDlgType;
  Button: TMsgDlgButtons; Caption: ARRAY OF string; dlgcaption: string)
  : Integer;
var
  aMsgdlg: TForm;
  i: Integer;
  Dlgbutton: TButton;
  Captionindex: Integer;
begin
  aMsgdlg := createMessageDialog(Msg, DlgTypt, Button);
  aMsgdlg.Caption := dlgcaption;
  // aMsgdlg.BiDiMode := bdRightToLeft;
  Captionindex := 0;
  for i := 0 to aMsgdlg.componentcount - 1 Do
  begin
    if (aMsgdlg.components[i] is TButton) then
    Begin
      Dlgbutton := TButton(aMsgdlg.components[i]);
      if Captionindex <= High(Caption) then
        Dlgbutton.Caption := Caption[Captionindex];
      inc(Captionindex);
    end;
  end;
  Result := aMsgdlg.Showmodal;
end;

procedure RichEditPopupMenu(RE: TRichEdit);
const
  IDM_UNDO = WM_UNDO;
  IDM_CUT = WM_CUT;
  IDM_COPY = WM_COPY;
  IDM_PASTE = WM_PASTE;
  IDM_DELETE = WM_CLEAR;
  IDM_SELALL = EM_SETSEL;
  IDM_RTL = $8000; // WM_APP ?

  Enables: array [Boolean] of DWORD = (MF_DISABLED or MF_GRAYED, MF_ENABLED);
  Checks: array [Boolean] of DWORD = (MF_UNCHECKED, MF_CHECKED);
var
  hUser32: HMODULE;
  hmnu, hmenuTrackPopup: HMENU;
  Cmd: DWORD;
  Flags: Cardinal;
  HasSelText: Boolean;
  FormHandle: HWND;
  // IsRTL: Boolean;
begin
  hUser32 := LoadLibraryEx(user32, 0, LOAD_LIBRARY_AS_DATAFILE);
  if (hUser32 <> 0) then
    try
      hmnu := LoadMenu(hUser32, MAKEINTRESOURCE(1));
      if (hmnu <> 0) then
        try
          hmenuTrackPopup := GetSubMenu(hmnu, 0);

          HasSelText := Length(RE.SelText) <> 0;
          EnableMenuItem(hmnu, IDM_UNDO, Enables[RE.CanUndo]);
          EnableMenuItem(hmnu, IDM_CUT, Enables[HasSelText]);
          EnableMenuItem(hmnu, IDM_COPY, Enables[HasSelText]);
          EnableMenuItem(hmnu, IDM_PASTE,
            Enables[Clipboard.HasFormat(CF_TEXT)]);
          EnableMenuItem(hmnu, IDM_DELETE, Enables[HasSelText]);
          EnableMenuItem(hmnu, IDM_SELALL, Enables[Length(RE.Text) <> 0]);

          // IsRTL := GetWindowLong(re.Handle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0;
          // EnableMenuItem(hmnu, IDM_RTL, Enables[True]);
          // CheckMenuItem(hmnu, IDM_RTL, Checks[IsRTL]);

          FormHandle := GetParentForm(RE).Handle;
          Flags := TPM_LEFTALIGN or TPM_RIGHTBUTTON or TPM_NONOTIFY or
            TPM_RETURNCMD;
          Cmd := DWORD(TrackPopupMenu(hmenuTrackPopup, Flags, Mouse.CursorPos.X,
            Mouse.CursorPos.Y, 0, FormHandle, nil));
          if Cmd <> 0 then
          begin
            case Cmd of
              IDM_UNDO:
                RE.Undo;
              IDM_CUT:
                RE.CutToClipboard;
              IDM_COPY:
                RE.CopyToClipboard;
              IDM_PASTE:
                RE.PasteFromClipboard;
              IDM_DELETE:
                RE.ClearSelection;
              IDM_SELALL:
                RE.SelectAll;
              IDM_RTL:
                ; // ?
            end;
          end;
        finally
          DestroyMenu(hmnu);
        end;
    finally
      FreeLibrary(hUser32);
    end;
end;

{ Revisado en la version 1.4 }
function ApuStandardEncodingFromName(const Name: string): TEncoding;
begin
  Result := nil;
  if Name = 'ANSI' then
    Result := TEncoding.Default
  else if Name = 'ASCII' then
    Result := TEncoding.ASCII
  else if Name = 'Unicode' then
    Result := TEncoding.Unicode
  else if Name = 'Big Endian Unicode' then
    Result := TEncoding.BigEndianUnicode
  else if Name = 'UTF-7' then
    Result := TEncoding.UTF7
  else if Name = 'UTF-8' then
    Result := TEncoding.UTF8;
end;

// zona de funciones

{ Revisado en la version Actual }
procedure TfrmMain.FormCreate(Sender: TObject);
var
  appINI: TIniFile;
  Dato1, Dato2: Tcolor;
  Existe_el_ini00, Dato3, Dato4: Integer;
  hola, namefileini, Dato5, Dato7: String;
  Dato6: String;
  Stylevalue, Pitchvalue: Integer;

begin
  // permite aceptar drag and drop en el handle actual
  Pad.PlainText := True;
  DragAcceptFiles(Self.Handle, True); // importante
  // Barra1.Visible := False;
  // Barra2.Visible := False;
  StBarra.SimpleText := STRSpacio;
  Self.Caption := Untitled + titRAC;
  Self.Pad.WordWrap := True;

  Self.StBarra.Visible := True;
  StBarra.Panels[0].Text := STRSpacio;
  StBarra.Panels[1].Text := STRSpacio;
  StBarra.Panels[2].Text := STRSpacio;
  StBarra.Panels[3].Text := STRSpacio;
  StBarra.Panels[4].Text := STRSpacio;
  { ir a }

  SpinEdit1.Hide;
  Button1.Hide;
  Button2.Hide;
  // Edit1.Hide;
  { ir a }

  // abre el archivo que se pasa como parametro en la linea de comandos
  if ParamCount > 0 then
  begin
    strNombreArch := ParamStr(1);
  end;

  if strNombreArch <> '' then
  begin
    Pad.Lines.LoadFromFile(strNombreArch);
    Self.Caption := ExtractFileName(strNombreArch) + titRAC;
    Pad.Modified := False;
  end;
  Self.mnAjusteLin.Checked := True;
  mnAjusteLin.Click; // primer click lo desactiva
  mnAjusteLin.Click; // segundo click lo activa
  mnBarra.Click; // mostrar barra
  // crea el archivo
  LneaenEscritura1.Click; // habilita la línea
  namefileini := ChangeFileExt(Application.ExeName, '.ini');
  // Showmessage(namefileini);
  if fileexists(namefileini) then
  begin
    Existe_el_ini00 := 1;
  end
  else
  begin
    Existe_el_ini00 := 0;
  end;

  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    // if no last user return an empty string
    // LastUser := appINI.ReadString('User', 'Last', '');
    // if no last date return todays date
    // LastDate := appINI.ReadDate('User', 'Date', Date); // show the message
      ;
    // LastNombreProg := appINI.ReadString('Programa', 'Nombre', 'Nombre');

    // LastWebProg := appINI.ReadString('Programa', 'Web', 'http://');

    // Prog_Edt.Text := LastNombreProg;
    // WEB_Edt.Text := LastWebProg;

    // showmessage('This program was previously used by ' + LastUser + ' on ' +
    // DateToStr(LastDate));
    Top := appINI.ReadInteger('Placement', 'Top', Top);
    Left := appINI.ReadInteger('Placement', 'Left', Left);
    Width := appINI.ReadInteger('Placement', 'Width', Width);
    Height := appINI.ReadInteger('Placement', 'Height', Height);
    if fileexists(namefileini) then
    begin

      if Existe_el_ini00 = 1 then
      begin

        Dato1 := appINI.ReadInteger('Font', 'Pad.Color', Pad.Color);
        Dato2 := appINI.ReadInteger('Font', 'Font.Color', Pad.Font.Color);
        Dato3 := appINI.ReadInteger('Font', 'Font.Size', Pad.Font.Size);
        Dato4 := appINI.ReadInteger('Font', 'Font.Height', Pad.Font.Height);
        Dato5 := appINI.ReadString('Font', 'Name', Pad.Font.Name);
        // hola es solo un string vacio.
        Dato6 := appINI.ReadString('Font', 'Pitch', hola);
        Dato7 := appINI.ReadString('Style', 'Style', hola);
        // si existe el .ini Escribe la información

        Pad.Color := Dato1;
        Pad.Font.Color := Dato2;
        Pad.Font.Size := Dato3;
        Memo1.Font.Size := Dato3;

        Pad.Font.Height := Dato4;
        Memo1.Font := Pad.Font;
        Pad.Font.Name := Dato5;
        if Dato6 = 'fpDefault' then
          Pitchvalue := 0;
        if Dato6 = 'fpVariable' then
          Pitchvalue := 1;
        if Dato6 = 'fpFixed' then
          Pitchvalue := 2;

        if Dato7 = 'fsBold' then
          Stylevalue := 1;
        if Dato7 = 'fsItalic' then
          Stylevalue := 2;
        if Dato7 = 'fsUnderline' then
          Stylevalue := 3;
        if Dato7 = 'fsStrikeOut' then
          Stylevalue := 4;

        Case Pitchvalue of
          0:
            Pad.Font.Pitch := fpDefault;
          1:
            Pad.Font.Pitch := fpVariable;
          2:
            Pad.Font.Pitch := fpFixed;
        End;

        case Stylevalue of
          1:
            Pad.Font.Style := [fsBold];
          2:
            Pad.Font.Style := [fsItalic];
          3:
            Pad.Font.Style := [fsUnderline];
          4:
            Pad.Font.Style := [fsStrikeOut];

        end;

      end
      else
      begin
        Showmessage('Alerta:no estoy guardando la información del .ini');
      end;
    end;
  finally
    appINI.Free;
  end;

end;

procedure TfrmMain.Guardar1Click(Sender: TObject);

begin
  if strNombreArch = '' then

  begin
    if SaveDlg.Execute then
    begin
      strNombreArch := SaveDlg.FileName;
    end
    else
    begin
      strNombreArch := 'nombre.txt';
      Showmessage('Alerta:Ningun nombre de archivo seleccionado>' +
        strNombreArch);
    end;
  end;

  Pad.Lines.SaveToFile(strNombreArch + extension);
  Pad.Modified := False;
  Self.Caption := ExtractFileName(strNombreArch) + titRAC;
end;

procedure TfrmMain.GuardarCClick(Sender: TObject);
begin

  if SaveDlg.Execute then
  begin
    strNombreArch := SaveDlg.FileName;
  end
  else
  begin
    strNombreArch := 'nombre.bak';
    Showmessage('Alerta:Ningun nombre de archivo seleccionado->' +
      strNombreArch);
  end;
  Pad.Lines.SaveToFile(strNombreArch + extension);
  Pad.Modified := False;
  Self.Caption := ExtractFileName(strNombreArch) + titRAC;

end;

{ Revisado en la version 1.3 }
procedure TfrmMain.ImprimirBN1Click(Sender: TObject);

var
  rectPage: TRect;
  sText: string;
  Color: Integer;
  // PrintDialog1:TPrintDlg;
begin
  if PrintDlg.Execute then
  begin
    rectPage := Rect(0, 0, Printer.PageWidth, Printer.PageHeight);
    with Printer do
    begin
      // start printing
      BeginDoc;

      sText := Pad.Text;
      // setting font details//
      Canvas.Font.Name := Pad.Font.Name;
      Canvas.Font.Size := Pad.Font.Size;
      Canvas.Font.Style := Pad.Font.Style;
      // Canvas.Pen.Width := 3;
      // Canvas.Pen.Color := Pad.Color;
      // BeginDoc;
      // Color := Pad.Color;
      // Canvas.Brush:=Pad.Color;
      // Canvas.Brush.Color := Color;
      // Canvas.FillRect(rectPage);
      Canvas.Font.Color := clBlack;
      // Canvas.Font.Color := Pad.Font.Color;
      // draws the text to print//
      Canvas.TextRect(rectPage, sText, [tfWordBreak]);
      EndDoc;
    end;
  end;

  // ShowMessage('Print is done.');
end;

{ Revisado en la version 1.3 }
procedure TfrmMain.Imprimircomogrfico1Click(Sender: TObject);

begin
  if PrintDlg.Execute then
  begin
    Print;
  end;

end;

{ Revisado en la version 1.7 }
procedure TfrmMain.Ira1Click(Sender: TObject);

var
  // i: Integer;
  apu: Integer;
  LineNo: Integer;

begin
  Pad.SetFocus;
  { Este radioGroup será creado en runtime y destruido al pulsar el botón de cancelar
  }
  SpinEdit1.MaxValue := Pad.Lines.count + 1;
  RadioGroup1 := TRadiogroup.Create(Self);
  RadioGroup1.Parent := Self;
  RadioGroup1.Width := 185;
  RadioGroup1.Height := 105;
  RadioGroup1.Left := 192;
  RadioGroup1.Top := 98;
  Pad.SendToBack;

  // panel1.BringToFront
  RadioGroup1.Caption := iralinea1;
  Button1.Caption := iralinea2;
  Button2.Caption := iralinea3;
  SpinEdit1.Visible := True;
  SpinEdit1.BringToFront;
  Button1.BringToFront;
  Button2.BringToFront;



  // RadioGroup1.Show;
  // Edit1.Show;


  // if Pad.Lines.Count>SpinEdit1.MaxValue then

  // if Pad.Lines.Count<SpinEdit1.MaxValue then
  // SpinEdit1.MaxValue:=Pad.Lines.Count;

  Button1.Show;
  Button2.Show;

end;

{ Revisado en la version 1.7 }
procedure TfrmMain.OpenWith1Click(Sender: TObject);
var
  Memo3: TMemo;
  s: string;
  after: String;
begin
  Memo3 := TMemo.Create(Self);
  Memo3.Parent := Self;
  Memo3.Visible := True;
  Memo3.Clear;
  s := Application.ExeName;

  after := stringreplace(s, '/', '\', [rfReplaceAll, rfIgnoreCase]);
  after := stringreplace(s, '\', '\\', [rfReplaceAll, rfIgnoreCase]);

  Memo3.Lines.Add('REGEDIT4');
  Memo3.Lines.Add('');
  Memo3.Lines.Add('[HKEY_CLASSES_ROOT\*\shell\' + RAC + ']');
  Memo3.Lines.Add('@="Open with ' + RAC + '"');
  Memo3.Lines.Add('"Icon"="\"' + after + '\",0"');
  Memo3.Lines.Add('');
  Memo3.Lines.Add('[HKEY_CLASSES_ROOT\*\shell\' + RAC + '\command]');
  Memo3.Lines.Add('@="\"' + after + '\" \"%1\""');

  Memo3.Lines.SaveToFile('import.reg', TEncoding.Default);
  Memo3.Destroy;
  Showmessage('Abre el archivo import.reg');
  ShellExecute(GetDesktopWindow, nil, @(ExtractFileDir(Application.ExeName))[1],
    nil, nil, SW_SHOWNORMAL);
  { ShellExecute(GetDesktopWindow, nil, Pchar('/select,')+@(ExtractFileDir(Application.ExeName)+'import.reg')[1],
    nil, nil, SW_SHOWNORMAL);
  }
  // ShellExecute(GetDesktopWindow, 'open', @('import.reg')[1], nil, nil, SW_Hide)
end;

Procedure MarkString(richedit: TRichEdit; strtomark: string; Start: Integer;
  Ucolor: Tcolor);
Var
  FoundAt: Integer;
begin
  FoundAt := richedit.FindText(strtomark, Start, maxInt, [stMatchCase]);
  while FoundAt <> -1 do
  begin
    richedit.SelStart := FoundAt;
    richedit.SelLength := Length(strtomark);
    // RichEdit.SelAttributes.Style := [fsBold];
    richedit.SelAttributes.Color := Ucolor;
    // richedit.SelText := strtomark;
    FoundAt := richedit.FindText(strtomark, FoundAt + Length(strtomark), maxInt,
      [stMatchCase]);
  end;
end;

Procedure UnMarkString(richedit: TRichEdit; strtomark: string);
Var
  FoundAt: Integer;
begin
  FoundAt := richedit.FindText(strtomark, 0, maxInt, [stWholeWord]);
  while FoundAt <> -1 do
  begin

    richedit.SelStart := FoundAt;
    richedit.SelLength := Length(strtomark);
    richedit.SelAttributes.Style := [];
    // richedit.SelAttributes.Color := clBlack;
    richedit.SelText := strtomark;
    FoundAt := richedit.FindText(strtomark, FoundAt + Length(strtomark), maxInt,
      [stWholeWord]);
  end;
end;

function InitRichEditURLDetection(RE: TRichEdit; value1: Boolean): Integer;

var
  EventMask: Word;
  CharRange: TCharRange;
begin
  EventMask := SendMessage(RE.Handle, EM_GETEVENTMASK, 0, 0); // imp
  SendMessage(RE.Handle, EM_SETEVENTMASK, 0, EventMask or ENM_LINK); // imp
  SendMessage(RE.Handle, EM_AUTOURLDETECT, WPARAM(value1), 0); // imp
  SendMessage(RE.Handle, EM_EXGETSEL, 0, lParam(@CharRange));
  SendMessage(RE.Handle, WM_SETTEXT, 0, lParam(RE.Text));
  SendMessage(RE.Handle, EM_EXSETSEL, 0, lParam(@CharRange));
end;

function TfrmMain.StringReplace2(const Source, OldPattern, NewPattern: string;
  Flags: TReplaceFlags; Ucolor: Tcolor): string;
var
  // Ucolor:Tcolor;
  Str: string;
  xOldPattern: string;
  FoundPos: Integer;
  i, J: Integer;
  SourceIdx: Integer;
  DestIdx: Integer;
  LCharsToCopy: Integer;
  FindCount: Integer;
  PosArray: array of Integer;
  LenOP: Integer;
  LenNP: Integer;
  LenS: Integer;
  ArrLen: Integer;
  LPResult, LPSource, LPNewPattern: PChar;
  LReplaceAll: Boolean;

begin

  LenOP := Length(OldPattern);

  LenS := Length(Source);
  if (LenOP = 0) or (LenS = 0) then
    Exit(Source);

  if rfIgnoreCase in Flags then
  begin
    xOldPattern := AnsiUpperCase(OldPattern);
    LenOP := Length(xOldPattern);
    if SameStr(xOldPattern, AnsiLowerCase(OldPattern)) then
      // Special case, for example only symbols (+ - , * .....)
      Str := Source
    else
    begin
      Str := AnsiUpperCase(Source);
      LenS := Length(Str);
    end;
  end
  else
  begin
    xOldPattern := OldPattern;
    Str := Source;
  end;

  if Str.Length <> Source.Length then
  begin
    Result := '';
    i := Low(string);
    while i <= High(Source) do
    begin
      if string.Compare(Source, i - Low(string), OldPattern, 0, LenOP, True) = 0
      then
      begin
        Result := Result + NewPattern;
        inc(i, LenOP);
        if not(rfReplaceAll in Flags) then
        begin
          Result := Result + Source.Substring(i - Low(string), maxInt);

          Break;
        end;
      end
      else
      begin
        Result := Result + Source[i];
        inc(i);
      end;
    end;
  end
  else
  begin
    FoundPos := 1;
    FindCount := 0;
    ArrLen := 0;
    LReplaceAll := not(rfReplaceAll in Flags);
    repeat
      FoundPos := Pos(xOldPattern, Str, FoundPos);
      if FoundPos = 0 then
        Break;

      inc(FindCount);
      if ArrLen < FindCount then
      begin
        if ArrLen = 0 then
          ArrLen := 32
        else
          ArrLen := ArrLen * 2;
        SetLength(PosArray, ArrLen);
        // call SetLength less frequently makes a huge difference when replacing multiple occurrences
      end;
      PosArray[FindCount - 1] := FoundPos - 1; // Zero based array
      inc(FoundPos, LenOP);

    until LReplaceAll;

    if FindCount > 0 then
    begin

      LenNP := Length(NewPattern);
      LPSource := Pointer(Source);
      // We use a pointer cast to avoid the _UStrToPWChar call injected by the compiler
      LPNewPattern := Pointer(NewPattern);
      // We use a pointer cast to avoid the _UStrToPWChar call injected by the compiler
      if LenNP = LenOP then
      begin // special case where Length(OldPattern) = Length(NewPattern)
        SetLength(Result, LenS);
        // in this case, we can optimize it even further
        LPResult := Pointer(Result);
        // We use a pointer cast to avoid the uniquestring call injected by the compiler
        Move(LPSource^, LPResult^, LenS * SizeOf(Char));
        if LenNP = 1 then
          for i := 0 to FindCount - 1 do
            LPResult[PosArray[i]] := LPNewPattern^
        else if LenNP <= 8 then
          for i := 0 to FindCount - 1 do
            for J := 0 to LenNP - 1 do
              LPResult[PosArray[i] + J] := LPNewPattern[J]
        else
          for i := 0 to FindCount - 1 do
            Move(LPNewPattern^, LPResult[PosArray[i]], LenNP * SizeOf(Char));
        Pad.SelAttributes.Color := clBlue;
      end
      else
      begin
        SetLength(Result, LenS + ((LenNP - LenOP) * FindCount));
        LPResult := Pointer(Result);
        // We use a pointer cast to avoid the uniquestring call injected by the compiler
        SourceIdx := 0;
        DestIdx := 0;
        if LenNP = 0 then
          for i := 0 to FindCount - 1 do
          begin
            LCharsToCopy := PosArray[i] - SourceIdx;
            if LCharsToCopy > 0 then
            begin
              if LCharsToCopy = 1 then
              begin
                LPResult[DestIdx] := LPSource[SourceIdx];
                inc(SourceIdx);
                inc(DestIdx);
              end
              else if LCharsToCopy <= 8 then
              begin
                for J := 0 to LCharsToCopy - 1 do
                  LPResult[DestIdx + J] := LPSource[SourceIdx + J];
                inc(SourceIdx, LCharsToCopy);
                inc(DestIdx, LCharsToCopy);
              end
              else
              begin
                Move(LPSource[SourceIdx], LPResult[DestIdx],
                  LCharsToCopy * SizeOf(Char));
                inc(SourceIdx, LCharsToCopy);
                inc(DestIdx, LCharsToCopy);
              end;
            end;
            inc(SourceIdx, LenOP);
          end
        else if LenNP = 1 then
          for i := 0 to FindCount - 1 do
          begin
            LCharsToCopy := PosArray[i] - SourceIdx;
            if LCharsToCopy > 0 then
            begin
              if LCharsToCopy = 1 then
              begin
                LPResult[DestIdx] := LPSource[SourceIdx];
                inc(SourceIdx);
                inc(DestIdx);
              end
              else if LCharsToCopy <= 8 then
              begin
                for J := 0 to LCharsToCopy - 1 do
                  LPResult[DestIdx + J] := LPSource[SourceIdx + J];
                inc(SourceIdx, LCharsToCopy);
                inc(DestIdx, LCharsToCopy);
              end
              else
              begin
                Move(LPSource[SourceIdx], LPResult[DestIdx],
                  LCharsToCopy * SizeOf(Char));
                inc(SourceIdx, LCharsToCopy);
                inc(DestIdx, LCharsToCopy);
              end;
            end;
            LPResult[DestIdx] := LPNewPattern[0];
            inc(DestIdx);
            inc(SourceIdx, LenOP);
          end
        else
          for i := 0 to FindCount - 1 do
          begin
            LCharsToCopy := PosArray[i] - SourceIdx;
            if LCharsToCopy > 0 then
            begin
              if LCharsToCopy = 1 then
              begin
                LPResult[DestIdx] := LPSource[SourceIdx];
                inc(SourceIdx);
                inc(DestIdx);
              end
              else if LCharsToCopy <= 8 then
              begin
                for J := 0 to LCharsToCopy - 1 do
                  LPResult[DestIdx + J] := LPSource[SourceIdx + J];
                inc(SourceIdx, LCharsToCopy);
                inc(DestIdx, LCharsToCopy);
              end
              else
              begin
                Move(LPSource[SourceIdx], LPResult[DestIdx],
                  LCharsToCopy * SizeOf(Char));
                inc(SourceIdx, LCharsToCopy);
                inc(DestIdx, LCharsToCopy);
              end;
            end;
            Move(LPNewPattern^, LPResult[DestIdx], LenNP * SizeOf(Char));
            inc(DestIdx, LenNP);
            inc(SourceIdx, LenOP);
          end;

        LCharsToCopy := LenS - SourceIdx;
        if LCharsToCopy > 0 then
          Move(LPSource[SourceIdx], LPResult[DestIdx],
            LCharsToCopy * SizeOf(Char));
        Pad.SelAttributes.Color := clBlue;
      end;

    end
    else
      Result := Source;
  end;

end;

procedure TfrmMain.PadChange(Sender: TObject);
// var
// i: Integer;

// strings: TStringList;
/// astr: string;

// regex: TRegEx;
// input: string;
// myEval: TMatchEvaluator;
begin
  Memo1.Text := '';
  // experimento
  // pad.Text:=Stringreplace2(Pad.text, '< ', '<', [rfReplaceAll, rfIgnoreCase],clblue);
  // pad.Text:=stringreplace2(Pad.text, '> ', '{*blueend*}', [rfReplaceAll, rfIgnoreCase],clBlue);
  if StBarra.Visible = True then
  begin
    StBarra.Panels[4].Text := 'Zoom Actual:' + InttoStr(Pad.Zoom) + '%';
  end;

  infobarra;
  Pad.Modified := True;
end;

procedure TfrmMain.PadContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  RichEditPopupMenu(TRichEdit(Sender));
  Handled := True;
end;

procedure TfrmMain.infobarra;
var
  LineaActual: Integer;
  CodificacionStr, TotalLn2, StringX, StringY: String;
  i: Integer;

  LineNo: Integer;
  LineIndex: Integer;
  LineLength: Integer;
  // Row, Col: Integer;
  CurrentTopLine: Integer;
  // DIFERENCIALn: Integer;
begin
  if VisibleLinea = 1 then
  begin
    for i := 1 to Pad.Lines.count do
    begin
      Memo1.Lines.Add(InttoStr(i));
    end;

    Pad.SetFocus;
  end;

  if StBarra.Visible = True then
  begin
    StringY := StrPosY + InttoStr(Pad.CaretPos.Y + 1);
    StringX := StrDelim + SrtPosX + InttoStr(Pad.CaretPos.X + 1);
    TotalLn2 := InttoStr(Pad.Lines.count);
    StBarra.Panels[0].Text := 'Hoy es: ' +
      FormatDateTime('dd/mm/yyyy hh:nn', Now);
    StBarra.Panels[1].Text := StringY + StringX;
    StBarra.Panels[2].Text := StrTotalLn + TotalLn2;
    StBarra.Panels[3].Text := STRSpacio;
    StBarra.Panels[4].Text := 'Zoom Actual:' + InttoStr(Pad.Zoom) + '%';
  end;
  if Pad.PlainText = False then
  begin
    StBarra.Panels[3].Text := 'Trabajando modo RTF';
    extension := '.RTF';
  end
  else
  begin
    StBarra.Panels[3].Text := 'Trabajando modo Texto';
    extension := '';
  end;

end;

procedure TfrmMain.PadMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);

var
  APoint: TPoint;
  Index: Integer;
begin
  APoint := Point(X, Y);
  Index := SendMessage(TRichEdit(Sender).Handle, EM_CHARFROMPOS, 0,
    Integer(@APoint));
  if Index < 0 then
    Exit;
  TRichEdit(Sender).SelStart := Index;
end;

procedure TfrmMain.Lenguaje1Click(Sender: TObject);
var
  Memo3: TMemo;
begin
  Memo3 := TMemo.Create(Self);
  Memo3.Parent := Self;
  Memo3.Visible := True;
  Memo3.Clear;
  Memo3.Lines.Add('REGEDIT4');
  Memo3.Lines.Add('');
  Memo3.Lines.Add('[-HKEY_CLASSES_ROOT\*\shell\' + RAC + ']');
  Memo3.Lines.SaveToFile('RemoveFromShell.reg', TEncoding.Default);
  Memo3.Destroy;
  Showmessage('Abre el archivo RemoveFromShell.reg');
  ShellExecute(GetDesktopWindow, nil, @(ExtractFileDir(Application.ExeName))[1],
    nil, nil, SW_SHOWNORMAL);

  // ShellExecute(GetDesktopWindow, 'runas', @('RemoveFromShell.reg')[1], nil,
  // nil, SW_Hide)
end;

procedure TfrmMain.Linebreacksvisibles1Click(Sender: TObject);
begin
  Pad.Text := AdjustLineBreaks(Pad.Text, tlbsCRLF);
  // #10 lf  #13 cr
  Pad.Text := stringreplace(Pad.Text, #13#10, #10, [rfReplaceAll]);
  // strip CR/LF pairs and replace with CR

  // Pad.Text:=   stringreplace(Pad.Text, #10, '{\n}', [rfReplaceAll, rfIgnoreCase]);

end;

procedure TfrmMain.LneaenEscritura1Click(Sender: TObject);
begin

  if LneaenEscritura1.Checked then
  begin
    VisibleLinea := 1;
    Memo1.Visible := True;
    Timer1.Enabled := True;
    // mnBarra.Checked := FALSE;
    // StBarra.Visible := FALSE;
  end
  else
  begin
    VisibleLinea := 0;
    Timer1.Enabled := False;
    Memo1.Text := ('');
    // Memo1.Visible := FALSE;
    // mnBarra.Checked := True;
    // StBarra.Visible := True;
  end;
end;

procedure TfrmMain.MacStyler1Click(Sender: TObject);
begin
  // #10 lf  #13 cr
  Pad.Text := AdjustLineBreaks(Pad.Text, tlbsCRLF);
  Pad.Text := stringreplace(Pad.Text, #13#10, #13, [rfReplaceAll]);
  // strip CR/LF pairs and replace with CR

end;

procedure TfrmMain.MenuFormatoClick(Sender: TObject);
begin
  Pad.Modified := True;
end;
{

  wiii





  // StBarra.SimpleText := StringY + StringX + StrTotalLn + TotalLn2;
  if Pad.Lines.Encoding <> nil then
  begin
  CodificacionStr := Pad.Lines.Encoding.EncodingName;
  StBarra.Panels[3].Text := STRCodifActual + CodificacionStr;
  end;

  end;
  end; }

procedure TfrmMain.WindowsStile1Click(Sender: TObject);
begin

  Pad.Text := AdjustLineBreaks(Pad.Text, tlbsCRLF);
  // #10 lf  #13 cr
  // Memo.Text := stringreplace(Pad.Text,#13#10,#13,[rfReplaceAll]);//strip CR/LF pairs and replace with CR

  // Pad.Text:=   stringreplace(Pad.Text, #13#10, '{\r\n}', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TfrmMain.WMDropFiles(var Msg: TWMDropFiles);
// procedure TfrmMain.PadDragDrop(Sender, Source: TObject; X, Y: Integer );
var
  buffer: array [0 .. 255] of Char;
  extension1: String;
  // Message: PadDragDrop;
begin
  DragQueryFile(Msg.Drop, 0, @buffer, SizeOf(buffer));
  strNombreArch := WideCharToString((@buffer));

  extension1 := uppercase(ExtractFileExt(ExtractFileName(strNombreArch)));
  Showmessage(extension1);
  if extension = InttoStr(Integer(nil)) then
  begin
    Showmessage('aun no verás bien estos archivos por aqui');
  end
  else
  begin
    Showmessage('Aceptando el archivo -> ' + strNombreArch);
  end;
  if not(Pad.Modified) then
  begin
    // OpenDlg.Execute;
    // strNombreArch := OpenDlg.FileName;

    if strNombreArch = '' then
    begin
      strNombreArch := Untitled;
    end
    else
    begin
      Pad.Lines.LoadFromFile(strNombreArch);
    end;

    Self.Caption := ExtractFileName(strNombreArch) + titRAC;
  end

  else if (Pad.Modified) then
  begin
    ModalResult := MyMessageDlg(saveinfostr, mtConfirmation, [mbYes, mbNo],
      [STRyes, STRno], STRSave4);

    if ((ModalResult = mrYes) and (SaveChanges2)) or (ModalResult = mrNo) then
    begin
      // showmessage('Ha sido Guardado');
      // SaveDlg.Execute;
      //
      // OpenDlg.Execute;

      // strNombreArch := OpenDlg.FileName;

      if strNombreArch = '' then
      begin
        strNombreArch := Untitled; // + titRAC;
      end
      else
      begin
        DragQueryFile(Msg.Drop, 0, @buffer, SizeOf(buffer));

        Pad.Lines.LoadFromFile(buffer);
        Pad.Lines.LoadFromFile(strNombreArch);
      end;
      Self.Caption := ExtractFileName(strNombreArch) + titRAC;
      Pad.Modified := False;
    end;
  end;
end;

{ if not(Pad.Modified) then
  begin
  OpenDlg.Execute;
  strNombreArch := OpenDlg.FileName;
  if strNombreArch = '' then
  begin
  strNombreArch := Untitled;
  end
  else
  begin
  Pad.Lines.LoadFromFile(strNombreArch);
  end;

  Self.Caption := strNombreArch + RAC;
  end

  else if (Pad.Modified) then
  begin
  ModalResult := MyMessageDlg(saveinfostr, mtConfirmation, [mbYes, mbNo],
  [STRyes, STRno], STRSave1);

  if ((ModalResult = mrYes) and (SaveChanges2)) or (ModalResult = mrNo) then
  begin
  // showmessage('Ha sido Guardado');
  // SaveDlg.Execute;
  //
  OpenDlg.Execute;

  strNombreArch := OpenDlg.FileName;

  if strNombreArch = '' then
  begin
  strNombreArch := Untitled; // + titRAC;
  end
  else
  begin
  Pad.Lines.LoadFromFile(strNombreArch);
  end;
  Self.Caption := strNombreArch + titRAC;
  Pad.Modified := FALSE;
  end;
  end;
  end; }

{
  procedure TfrmMain.PadKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

  var
  Message: TMessage;
  begin

  OldPadProc(Message);
  if (Message.Msg = WM_VSCROLL) or (Message.Msg = WM_Mousewheel) then
  Memo1.WindowProc(Message);
  end; }
{
  procedure TfrmMain.PadKeyPress(Sender: TObject; var Key: Char);

  var
  Message: TMessage;
  begin

  OldPadProc(Message);
  if (Message.Msg = WM_VSCROLL) or (Message.Msg = WM_Mousewheel) then
  Memo1.WindowProc(Message);
  end;
}
{
  procedure TfrmMain.PadKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  var
  Message: TMessage;
  begin

  OldPadProc(Message);
  if (Message.Msg = WM_VSCROLL) or (Message.Msg = WM_Mousewheel) then
  Memo1.WindowProc(Message);
  end;
}

procedure TfrmMain.FindDlgFind(Sender: TObject);

var
  FoundAt: Longint;
  StartPos, ToEnd: Integer;
  mySearchTypes: TSearchTypes;
  myFindOptions: TFindOptions;
begin
  mySearchTypes := [];
  with Pad do
  begin
    if frMatchCase in FindDlg.Options then
      mySearchTypes := mySearchTypes + [stMatchCase];
    if frWholeWord in FindDlg.Options then
      mySearchTypes := mySearchTypes + [stWholeWord];
    { Begin the search after the current selection, if there is one. }
    { Otherwise, begin at the start of the text. }
    if SelLength <> 0 then
      StartPos := SelStart + SelLength
    else
      StartPos := 0;
    { ToEnd is the length from StartPos through the end of the
      text in the rich edit control. }
    ToEnd := Length(Text) - StartPos;
    FoundAt := FindText(FindDlg.FindText, StartPos, ToEnd, mySearchTypes);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart := FoundAt;
      SelLength := Length(FindDlg.FindText);
    end
    else
      // Beep;
  end;

end;

procedure TfrmMain.FormClose(Sender: TObject; var CanClose: Boolean);
var
  appINI: TIniFile;
var
  // Color1: Tcolor;
  namefileini: String;
  // Existe_el_ini00: Integer;

begin
  if Pad.Modified then
  Begin
    ModalResult := MyMessageDlg(saveinfostr, mtConfirmation,
      [mbYes, mbNo, mbCancel], [STRyes, STRno, STRcancel], STRSave2);

    if ((ModalResult = mrYes) and (SaveChanges)) then

    begin
      // showmessage('Ha sido Guardado');
      // SaveDlg.Execute;
      CanClose := True;
      //
    End;
    if ModalResult = mrCancel then
    begin
      // ShowMessage('cerramos');
      CanClose := False;
    end;

  end;
  namefileini := ChangeFileExt(Application.ExeName, '.ini');
  appINI := TIniFile.Create(namefileini);
  if fileexists(namefileini) then
  begin

    try
      // propiedades del form1
      with appINI, frmMain do
      begin
        WriteInteger('Placement', 'Top', Top);
        WriteInteger('Placement', 'Left', Left);
        WriteInteger('Placement', 'Width', Width);
        WriteInteger('Placement', 'Height', Height);
      end;
      with appINI, Pad do
      begin

        WriteInteger('Font', 'Pad.Color', Pad.Color);
        WriteInteger('Font', 'Font.Color', Pad.Font.Color);
        WriteInteger('Font', 'Font.Size', Pad.Font.Size);
        WriteInteger('Font', 'Font.Height', Pad.Font.Height);
        WriteString('Font', 'Name', Pad.Font.Name);
        if (Pad.Font.Pitch) = fpDefault then
        begin
          WriteString('Font', 'Pitch', 'fpDefault');
        end;
        if (Pad.Font.Pitch) = fpVariable then
        begin
          WriteString('Font', 'Pitch', 'fpVariable');
        end;
        if (Pad.Font.Pitch) = fpFixed then
        begin
          WriteString('Font', 'Pitch', 'fpFixed');
        end;

        if Pad.Font.Style = [fsBold] then
        begin
          WriteString('Style', 'Style', 'fsBold');
        end;
        if Pad.Font.Style = [fsItalic] then
        begin
          WriteString('Style', 'Style', 'fsItalic');
        end;

        if Pad.Font.Style = [fsUnderline] then
        begin
          WriteString('Style', 'Style', 'fsUnderline');
        end;
        if (Pad.Font.Style) = [fsStrikeOut] then
        begin
          WriteString('Style', 'Style', 'fsStrikeOut');
        end;

      end;

    finally
      appINI.Free;
    end;
  end;
end;

{
  begin
  if MessageBox(0, PChar(Save_Info), aviRAC, MB_YESNO OR MB_ICONQUESTION OR
  MB_TASKMODAL) = IDYES then
  Action := caFree
  else
  Action := caNone;
  end; }


// menu archivo

procedure TfrmMain.mnNuevoClick(Sender: TObject);
var
  TotalLn2, StringX, StringY: String;
begin
  if (Pad.Modified) then
  begin
    ModalResult := MyMessageDlg(saveinfostr, mtConfirmation, [mbYes, mbNo],
      [STRyes, STRno], STRSave5);
    if ((ModalResult = mrYes) and (SaveChanges)) { or (ModalResult = mrNo) }
    then
    begin

      if strNombreArch = '' then

      begin
        if SaveDlg.Execute then
        begin
          strNombreArch := SaveDlg.FileName;
        end
        else
        begin
          strNombreArch := 'nombre.txt';
          Showmessage('Alerta:Ningun nombre de archivo seleccionado>' +
            strNombreArch);
        end;
      end;
      Pad.Lines.SaveToFile(strNombreArch + extension);
      Self.Caption := ExtractFileName(strNombreArch) + titRAC;
    end;

    Pad.Modified := False;

  end;

  Pad.Clear;

  Pad.Modified := False;
  Self.Caption := Untitled + titRAC;
  if StBarra.Visible = True then
  begin
    StringY := StrPosY + InttoStr(Pad.CaretPos.Y + 1);
    StringX := StrDelim + SrtPosX + InttoStr(Pad.CaretPos.X + 1);
    TotalLn2 := InttoStr(Pad.Lines.count);
    StBarra.SimpleText := StringY + StringX + StrTotalLn + TotalLn2;

    if Pad.SelText <> '' then
    begin
      Showmessage('has seleccionado texto');
      StBarra.SimpleText := StringY + StringX + StrTotalLn + TotalLn2 + 'Sel :'
        + InttoStr(Length(Pad.SelText)) + '|' + InttoStr(Length(Pad.Text));
    end;
  end;

end;

procedure TfrmMain.mnAbrirClick(Sender: TObject);

var
  // codificacion: Integer;
  String1: String;
  EncodingA: TEncoding;
  NombreencodingA: String;
  // EncodingB:TEncoding;
  // procedure TForm1.FileOpenClick(Sender: TObject);
begin
  OpenTextFileDialog1.FileName := '';
  SaveTextFileDialog1.FileName := '';
  if not(Pad.Modified) then
  begin

    begin
      OpenTextFileDialog1.Execute;
      strNombreArch := OpenTextFileDialog1.FileName;

      if strNombreArch = '' then
      begin
        strNombreArch := Untitled;
        Self.Caption := strNombreArch + titRAC;
      end;
      if fileexists(strNombreArch) then
        // Display the contents in a memo based on the selected encoding.
        NombreencodingA :=
          (OpenTextFileDialog1.Encodings[OpenTextFileDialog1.EncodingIndex]);
      EncodingA := ApuStandardEncodingFromName(NombreencodingA);
      Pad.Lines.LoadFromFile(strNombreArch, EncodingA);

      Self.Caption := ExtractFileName(strNombreArch) + titRAC;
      Pad.Modified := False;
    end;
  end;

  if (Pad.Modified) then
  begin
    ModalResult := MyMessageDlg(saveinfostr, mtConfirmation, [mbYes, mbNo],
      [STRyes, STRno], STRSave1);

    if ((ModalResult = mrYes) and (SaveChanges)) or (ModalResult = mrNo) then
    begin
      // showmessage('Ha sido Guardado');
      // SaveDlg.Execute;
      //
      OpenTextFileDialog1.Execute;

      strNombreArch := OpenTextFileDialog1.FileName;

      if strNombreArch = '' then
      begin
        strNombreArch := Untitled;
        Self.Caption := strNombreArch + titRAC;
      end
      else
      begin
        EncodingA := ApuStandardEncodingFromName
          (OpenTextFileDialog1.Encodings[OpenTextFileDialog1.EncodingIndex]);
        Pad.Lines.LoadFromFile(strNombreArch, EncodingA);
        Self.Caption := ExtractFileName(strNombreArch) + titRAC;
      end;
      Pad.Modified := False;
    end;
  end;
end;

procedure TfrmMain.mnReabrirClick(Sender: TObject);

// var
// codificacion: Integer;
// EncodingC: TEncoding;
begin

  if strNombreArch <> '' then
  begin
    if (Pad.Modified) then
    begin
      ModalResult := MyMessageDlg(saveinfostr, mtConfirmation, [mbYes, mbNo],
        [STRyes, STRno], STRSave3);
      if ((ModalResult = mrYes) and (SaveChanges)) or (ModalResult = mrNo) then

      begin
        Pad.Lines.LoadFromFile(strNombreArch);
        {
          if Pad.Lines.Encoding <> nil then
          begin
          EncodingC := StandardEncodingFromName(Pad.Lines.Encoding.EncodingName);
          Pad.Lines.LoadFromFile(strNombreArch, EncodingC);
          end
          else
          begin
          ShowMessage('press open and not reopen and select the encoding please');
          end;

        }

        { codificacion := (OpenTextFileDialog1.EncodingIndex);
          if codificacion = 0 then
          Pad.Lines.LoadFromFile(strNombreArch, Tencoding.ANSI);
          if codificacion = 1 then
          Pad.Lines.LoadFromFile(strNombreArch, Tencoding.ASCII);
          if codificacion = 2 then
          Pad.Lines.LoadFromFile(strNombreArch, Tencoding.Unicode);
          if codificacion = 3 then
          Pad.Lines.LoadFromFile(strNombreArch, Tencoding.BigEndianUnicode);
          if codificacion = 4 then
          Pad.Lines.LoadFromFile(strNombreArch, Tencoding.UTF8);
          if codificacion = 5 then
          Pad.Lines.LoadFromFile(strNombreArch, Tencoding.UTF7);
        }
        // Self.Caption:=strNombreArch+titRAC; //...
        Self.Caption := ExtractFileName(strNombreArch) + titRAC;
        Pad.Modified := False;
      end;
    end;
  end;
end;

procedure TfrmMain.mnGuardarClick(Sender: TObject);
var
  codificacion: Integer;
  EncodingF: TEncoding;
begin
  if strNombreArch = '' then
  begin
    if SaveTextFileDialog1.Execute then
    begin
      strNombreArch := SaveTextFileDialog1.FileName;
      Showmessage(SaveTextFileDialog1.Encodings
        [SaveTextFileDialog1.EncodingIndex]);
      EncodingF := ApuStandardEncodingFromName
        (SaveTextFileDialog1.Encodings[SaveTextFileDialog1.EncodingIndex]);
      Pad.Lines.SaveToFile(strNombreArch + extension, EncodingF);

      { codificacion := (SaveTextFileDialog1.EncodingIndex);
        ShowMessage('encoding es '+inttostr(Integer(Pad.Lines.Encoding)+));
        if codificacion = 0 then
        // Pad.Lines.SaveToFile(strNombreArch);
        Pad.Lines.SavetoFile(strNombreArch, Tencoding.ANSI);

        // Pad.Text.Encoding:=Tencoding.ANSI;
        if codificacion = 1 then
        Pad.Lines.SavetoFile(strNombreArch, Tencoding.ASCII);
        Pad.Text := SaveTextFileDialog1.Encodings[SaveTextFileDialog1.EncodingIndex];
        if codificacion = 2 then
        Pad.Lines.SavetoFile(strNombreArch, Tencoding.Unicode);
        Pad.Text := SaveTextFileDialog1.Encodings[SaveTextFileDialog1.EncodingIndex];

        if codificacion = 3 then
        Pad.Lines.SavetoFile(strNombreArch, Tencoding.BigEndianUnicode);
        Pad.Text := SaveTextFileDialog1.Encodings[SaveTextFileDialog1.EncodingIndex];
        if codificacion = 4 then
        Pad.Lines.SavetoFile(strNombreArch, Tencoding.UTF8);
        Pad.Text := SaveTextFileDialog1.Encodings[SaveTextFileDialog1.EncodingIndex];
        if codificacion = 5 then
        Pad.Lines.SavetoFile(strNombreArch, Tencoding.UTF7);
        Pad.Text := SaveTextFileDialog1.Encodings[SaveTextFileDialog1.EncodingIndex]; }
      // Pad.Lines.SaveToFile(strNombreArch);
      Pad.Modified := False;
      Self.Caption := ExtractFileName(strNombreArch) + titRAC;
    end;
  end
  else
  begin
    // ShowMessage('encoding es ' + inttostr(Integer(Pad.Lines.Encoding)));
    Pad.Lines.SaveToFile(strNombreArch + extension, Pad.Lines.Encoding);
    Pad.Modified := False;
    Self.Caption := ExtractFileName(strNombreArch) + titRAC;
  end;

end;

{ verificado en version 1.4 }
procedure TfrmMain.mnGuardarCClick(Sender: TObject);
var
  codificacion: Integer;
  EncodingG: TEncoding;
begin
  if SaveTextFileDialog1.Execute then
  begin
    strNombreArch := SaveTextFileDialog1.FileName;
    // ShowMessage(SaveTextFileDialog1.Encodings
    // [SaveTextFileDialog1.EncodingIndex]);
    EncodingG := ApuStandardEncodingFromName(SaveTextFileDialog1.Encodings
      [SaveTextFileDialog1.EncodingIndex]);
    Pad.Lines.SaveToFile(strNombreArch + extension, EncodingG);

    {
      if codificacion = 0 then
      // Pad.Lines.SaveToFile(strNombreArch);
      Pad.Lines.SaveToFile(strNombreArch, TEncoding.ANSI);
      if codificacion = 1 then
      Pad.Lines.SaveToFile(strNombreArch, TEncoding.ASCII);
      if codificacion = 2 then
      Pad.Lines.SaveToFile(strNombreArch, TEncoding.Unicode);
      if codificacion = 3 then
      Pad.Lines.SaveToFile(strNombreArch, TEncoding.BigEndianUnicode);
      if codificacion = 4 then
      Pad.Lines.SaveToFile(strNombreArch, TEncoding.UTF8);
      if codificacion = 5 then
      Pad.Lines.SaveToFile(strNombreArch, TEncoding.UTF7);
      // Pad.Lines.SaveToFile(strNombreArch);
    }
    Pad.Modified := False;
    Self.Caption := ExtractFileName(strNombreArch) + titRAC;
  end;
end;

procedure TfrmMain.mnConfPagClick(Sender: TObject);
begin
  PageSetupDlg.Execute;
end;

procedure TfrmMain.mnImprimirClick(Sender: TObject);

var
  rectPage: TRect;
  sText: string;
  Color: Integer;
  // PrintDialog1:TPrintDlg;
begin
  if PrintDlg.Execute then
  begin
    rectPage := Rect(0, 0, Printer.PageWidth, Printer.PageHeight);
    with Printer do
    begin
      // start printing
      BeginDoc;

      sText := Pad.Text;
      // setting font details//
      Canvas.Font.Name := Pad.Font.Name;
      Canvas.Font.Size := Pad.Font.Size;
      Canvas.Font.Style := Pad.Font.Style;
      // Canvas.Pen.Width := 3;
      // Canvas.Pen.Color := Pad.Color;
      // BeginDoc;
      Color := Pad.Color;
      // Canvas.Brush:=Pad.Color;
      Canvas.Brush.Color := Color;
      Canvas.FillRect(rectPage);

      Canvas.Font.Color := Pad.Font.Color;



      // draws the text to print//

      Canvas.TextRect(rectPage, sText, [tfWordBreak]);

      EndDoc;
    end;
  end;

  // ShowMessage('Print is done.');
end;


// finish printing

procedure TfrmMain.mnSalirClick(Sender: TObject);
begin
  Close();
end;

// fin menu archivo

// menu Edicion

procedure TfrmMain.mnDeshacerClick(Sender: TObject);
begin
  Pad.Undo;
end;

procedure TfrmMain.mnSelTodoClick(Sender: TObject);
begin
  // Pad.SelAttributes.Color := clyellow;
  Pad.SelectAll;

end;

procedure TfrmMain.Negrita2Click(Sender: TObject);
begin
  with Pad.SelAttributes do
    if not(fsBold in Style) then
      Style := Style + [fsBold]
    else
      Style := Style - [fsBold];

  Pad.SetFocus;
end;

procedure TfrmMain.oolbar1Click(Sender: TObject);
begin

  if oolbar1.Checked then
  begin
    Barra1.Visible := True;
  end
  else
  begin
    Barra1.Visible := False;
  end;

end;

procedure TfrmMain.mnCortatClick(Sender: TObject);
begin
  Clipboard.AsText := Pad.SelText;
  Pad.SelText := '';

end;

procedure TfrmMain.mnCopiarClick(Sender: TObject);
begin
  Clipboard.AsText := Pad.SelText;
end;

procedure TfrmMain.mnPegarClick(Sender: TObject);
begin
  Pad.SelText := Clipboard.AsText;
  { if Pad.SelText <> '' then
    begin
    Showmessage('has seleccionado texto');
    Showmessage( 'Sel :' +
    inttostr(Length(Pad.SelText)) + '|' + inttostr(Length(Pad.Text)));
    end; end;
  }
end;

procedure TfrmMain.mnEliminarClick(Sender: TObject);
begin
  Pad.SelText := '';
  // lo mismo que cortar jejeje
end;

{
  procedure TfrmMain.ReplaceDialog1Replace(Sender: TObject);
  function DoTheReplace: Boolean;
  begin
  Result := False;
  if Pad.SelLength > -1 then
  begin
  if frMatchCase in ReplaceDialog1.Options then
  Result := Pad.SelText = ReplaceDialog1.FindText
  else
  Result := AnsiUpperCase(Pad.SelText)
  = AnsiUpperCase(ReplaceDialog1.FindText);
  if Result then
  Pad.SelText := ReplaceDialog1.ReplaceText;
  end;
  end;

  var
  replaced: Boolean;
  // CursorPos: TPoint;
  // i,J,SkipChars, PosReturn: Integer;
  // String1: String;
  // String2: String;
  // String3: String;
  begin
  DoTheReplace;
  ReplaceDialog1Find(ReplaceDialog1);
  // if frReplace in ReplaceDialog1.Options then

  if frReplaceAll in ReplaceDialog1.Options then
  begin
  replaced := DoTheReplace;
  while replaced do
  begin
  ReplaceDialog1Find(ReplaceDialog1);
  replaced := DoTheReplace;
  end;
  end;
  end;
}
procedure TfrmMain.RestablecerZoom1Click(Sender: TObject);
begin
  Pad.Zoom := 100;
end;

{
  procedure TfrmMain.RichEdit1Change(Sender: TObject);
  begin
  richedit1.SelStart:= length(richedit1.Lines[0])+2;
  richedit1.SelLength:= length(richedit1.Lines[1]);
  RichEdit1.SelAttributes.Name := 'Arial';
  richedit1.SelAttributes.Color:= clBlack ;
  RichEdit1.SelAttributes.Size := 15;
  RichEdit1.SelAttributes.Style := [fsBold];
  RichEdit1.Lines.Add('This line will be Arial, size 15, color Black and Bold');
  RichEdit1.SelAttributes.Name := 'Times New Roman';
  RichEdit1.SelAttributes.Color := clRed;
  RichEdit1.SelAttributes.Size := 10;
  RichEdit1.SelAttributes.Style := [fsItalic];
  RichEdit1.Lines.Add('This line will be... you get the picture');

  end;
}
function TfrmMain.SaveChanges2: Boolean;
begin
  // showmessage('usandosavechanges');
  Result := False;
  if (OpenDlg.FileName = '') and (SaveDlg.FileName = '') then
  begin
    if SaveDlg.Execute then
    begin

      Screen.Cursor := crHourGlass;
      // StBarra.SimpleText := SavingStr;
      Pad.Lines.SaveToFile(SaveDlg.FileName + extension);
      strNombreArch := SaveDlg.FileName;
      if strNombreArch = '' then
      begin
        strNombreArch := 'sinnombre.txt';
      end;
      // Self.Caption := SaveDlg.FileName + titRAC + RAC;
      Self.Caption := ExtractFileName(strNombreArch) + titRAC;
      // StBarra.SimpleText := ListoStr;
      Screen.Cursor := crDefault;
      Result := True;
    end;
  end
  else
  begin
    Screen.Cursor := crHourGlass;
    // StatusBar1.SimpleText := 'Saving...';
    if OpenDlg.FileName <> '' then
    begin
      Self.Caption := ExtractFileName(strNombreArch) + titRAC;
      Pad.Lines.SaveToFile(OpenDlg.FileName + extension);
      // Self.Caption := OpenDlg.FileName + titRAC ;
    end
    else if SaveDlg.FileName <> '' then
    begin
      Pad.Lines.SaveToFile(SaveDlg.FileName + extension);
      Self.Caption := ExtractFileName(SaveDlg.FileName) + titRAC
      //
    end;

    // StatusBar1.SimpleText := 'Ready';
    Screen.Cursor := crDefault;
    Result := True;
  end;
end;

procedure TfrmMain.SpinEdit1Change(Sender: TObject);
begin
  if True then

end;

procedure TfrmMain.SpinEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in [#8, '0' .. '9']) then
  begin
    Showmessage('Invalid key');
    // Discard the key
    Key := #0;
  end;
end;

procedure TfrmMain.Subrayar1Click(Sender: TObject);
begin
  with Pad.SelAttributes do
    if not(fsUnderline in Style) then
      Style := Style + [fsUnderline]
    else
      Style := Style - [fsUnderline];

  Pad.SetFocus;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
  CurrentTopLine: Integer;
begin

  Timer1.Interval := 90;
  CurrentTopLine := 0;

  // ->correcto indica el inicio  Showmessage(inttostr(Pad.Perform(EM_GetFirstVisibleLine, 0, 0)));
  CurrentTopLine := Pad.Perform(EM_GetFirstVisibleLine, 0, 0);
  Memo1.Lines.BeginUpdate;
  with Memo1 do
    Perform(em_linescroll, 0, CurrentTopLine -
      Perform(EM_GetFirstVisibleLine, 0, 0));
  Memo1.Lines.EndUpdate;
  // aprovecho de actualizar el máximo numero de lineas

end;

procedure TfrmMain.ToolButton10Click(Sender: TObject);
begin
  Pad.Zoom := 100;

  if StBarra.Visible = True then
  begin
    StBarra.Panels[4].Text := 'Zoom Actual:' + InttoStr(Pad.Zoom) + '%';
  end;
end;

procedure TfrmMain.ToolButton11Click(Sender: TObject);

begin
  if Pad.Zoom < 1500 then
  begin
    Pad.Zoom := Pad.Zoom + 10;
  end;
  if StBarra.Visible = True then
  begin
    StBarra.Panels[4].Text := 'Zoom Actual:' + InttoStr(Pad.Zoom) + '%';
  end;
end;

procedure TfrmMain.ToolButton12Click(Sender: TObject);

begin
  Pad.PlainText := False;
  infobarra;
  extension := '.RTF';
end;

procedure TfrmMain.ToolButton13Click(Sender: TObject);
begin
  Pad.PlainText := True;
  infobarra;
end;

procedure TfrmMain.ToolButton14Click(Sender: TObject);
begin
  if Pad.Zoom >= 10 then
  begin
    Pad.Zoom := Pad.Zoom - 10;
  end;
  if StBarra.Visible = True then
  begin
    StBarra.Panels[4].Text := 'Zoom Actual:' + InttoStr(Pad.Zoom) + '%';
  end;
end;

procedure TfrmMain.ToolButton15Click(Sender: TObject);
var
  s: TStrings;

  MyListBlue, MyListRed, MyListGreen: TStringList;
  MyListBluefiltred, MyListRedfiltred, MyListGreenFiltred: TStringList;
  u: Integer;
  maxlenght: Integer;
  CurrentTopLine: Integer;

  // 134,217,728 strings Tstringlist

  // t: string;
  J, i: Integer;
  strtomark: String;
  K: Integer;
  CurrentTopLine2: Integer;
  Pad2: TMemo;
begin
  Pad2 := TMemo.Create(Self);
  Pad2.Parent := Self;
  Pad2.Width := Pad.Width;
  Pad2.Height := Pad.Height;
  Pad2.Top := Pad.Top;
  Pad2.Visible := True;
  Pad2.Text := 'Dame un tiempo prudente, trabajando para ti';

  Pad.Text := AdjustLineBreaks(Pad.Text, tlbsCRLF);
  maxlenght := Length(Pad.Text);

  if Length(Pad.Text) > 134217727 then
  begin
    maxlenght := 134217727;
  end
  else
  begin
    Pad2.Lines.Add('tengo :' + InttoStr(maxlenght) + ' cadenas de texto');
    maxlenght := Length(Pad.Text);
  end;

  // MyList := TStringList.Create();
  CurrentTopLine2 := Pad.Perform(EM_GetFirstVisibleLine, 0, 0);
  Pad2.Lines.Add('estoy en la línea ' + InttoStr(CurrentTopLine2));
  Pad.ReadOnly := True;
  // Screen.Cursor := crHandpoint;

  Pad.Lines.BeginUpdate;

  MyListBlue := TStringList.Create();
  MyListBluefiltred := TStringList.Create();
  MyListRed := TStringList.Create();
  MyListRedfiltred := TStringList.Create();
  MyListGreen := TStringList.Create();
  MyListGreenFiltred := TStringList.Create();

  try
    for u := 1 to Length(Blue) do
    begin
      MyListBlue.Add(Blue[u]);
    end;
    for u := 1 to Length(Red) do
    begin
      MyListRed.Add(Red[u]);
    end;
    for u := 1 to Length(Green) do
    begin
      MyListGreen.Add(Green[u]);
    end;

    ListBlue.Items := MyListBlue;
    ListRed.Items := MyListRed;
    ListGreen.Items := MyListGreen;
    // a:=ListBox2.Items.Text.IndexOf[1];
    // Showmessage(listbox1.items[1]);

    for K := 0 to ListBlue.count - 1 do
    begin
      strtomark := ListBlue.Items[K];
      i := Pad.FindText(strtomark, CurrentTopLine2, maxInt, [stMatchCase]);
      if i <> -1 then
      begin
        MyListBluefiltred.Sorted := True;
        MyListBluefiltred.Duplicates := dupIgnore;
        MyListBluefiltred.Add(strtomark);
        // Break
      end;
    end;
    for K := 0 to ListRed.count - 1 do
    begin
      strtomark := ListRed.Items[K];
      i := Pad.FindText(strtomark, CurrentTopLine2, maxInt, [stMatchCase]);
      if i <> -1 then
      begin
        MyListRedfiltred.Sorted := True;
        MyListRedfiltred.Duplicates := dupIgnore;
        MyListRedfiltred.Add(strtomark);
        // Break
      end;
    end;
    for K := 0 to ListGreen.count - 1 do
    begin
      strtomark := ListGreen.Items[K];
      i := Pad.FindText(strtomark, CurrentTopLine2, maxInt, [stMatchCase]);
      if i <> -1 then
      begin
        MyListGreenFiltred.Sorted := True;
        MyListGreenFiltred.Duplicates := dupIgnore;
        MyListGreenFiltred.Add(strtomark);
        // Break
      end;
    end;

  finally
    Pad2.Lines.Add('actualmente voy a reemplazar ' +
      InttoStr(MyListBluefiltred.count + MyListRedfiltred.count +
      MyListGreenFiltred.count) +
      ' Patrones de String encontrados en tu texto ');
    Pad2.Lines.Add
      ('Como estimado: tardo ((cadenas de texto)/Patrones de string ) seg, dividido la velocidad de lectura (palabras por línea)');
    Pad2.Lines.Add('10% completo');
    // comenzamos a colorear
    if MyListBluefiltred.count <> 0 then
    begin
      J := MyListBluefiltred.count;
      for i := 1 to J do
      begin
        Search_And_Replace2(Pad, MyListBluefiltred[i - 1], CurrentTopLine2,
          maxlenght, clBlue);

      end;
    end;
    Pad2.Lines.Add('60% completo');
    if MyListRedfiltred.count <> 0 then
    begin
      J := MyListRedfiltred.count;
      for i := 1 to J do
      begin
        Search_And_Replace2(Pad, MyListRedfiltred[i - 1], CurrentTopLine2,
          maxlenght, clRed);

      end;
    end;
    Pad2.Lines.Add('80% completo, al llegar al 100% volveré al texto');
    if MyListGreenFiltred.count <> 0 then
    begin
      J := MyListGreenFiltred.count;
      for i := 1 to J do
      begin
        Search_And_Replace2(Pad, MyListGreenFiltred[i - 1], CurrentTopLine2,
          maxlenght, clGreen);

      end;
    end;
    Pad2.Lines.Add('100% completo ya podremos escribir denuevo ');

    Pad2.Lines.Clear;
    Pad2.Destroy;

    FreeAndNil(MyListBluefiltred);
    FreeAndNil(MyListRedfiltred);
    FreeAndNil(MyListGreenFiltred);
    FreeAndNil(MyListBlue);
    FreeAndNil(MyListRed);
    FreeAndNil(MyListGreen);
    Pad.Lines.EndUpdate;
    Pad.ReadOnly := False;
    beep;
  end;
end;

{
  MyList := TStringList.Create();
  MyListBlue := TStringList.Create();
  MyListRed := TStringList.Create();
  MyListGreen := TStringList.Create();
  try
  // MyList.Add(IntToStr(1));
  // MyList.Add(IntToStr(2));
  // MyList.Add(IntToStr(3));
  for delta := 1 to Length(Blue) do
  begin
  MyListBlue.Add(Blue[delta]);
  end;
  for delta := 1 to Length(Red) do
  begin
  MyListBlue.Add(Red[delta]);
  end;
  for delta := 1 to Length(Green) do
  begin
  MyListBlue.Add(Green[delta]);
  end;

  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,
  'Sintaxis1.ini'));
  try
  // write to the file
  IniFile.WriteString('HTML', 'Blue', MyListBlue.commaText);
  IniFile.WriteString('HTML', 'Red', MyListRed.commaText);
  IniFile.WriteString('HTML', 'Green', MyListGreen.commaText);
  // read from the file
  MyListBlue.commaText := IniFile.ReadString('HTML', 'Blue', '');
  MyListRed.commaText := IniFile.ReadString('HTML', 'Red', '');
  MyListGreen.commaText := IniFile.ReadString('HTML', 'Green', '');
  // show results
  Showmessage('Found ' + inttostr(MyListBlue.count+MyListred.count+MyListGreen.count) + ' items ' +
  MyList.commaText);
  finally
  IniFile.Free;
  end;
  finally
  FreeAndNil(MyList);
  FreeAndNil(MyListBlue);
  FreeAndNil(MyListRed);
  FreeAndNil(MyListGreen);
  end;
}{

  for i := 1 to Length(Red) do
  begin
  // StartPos := startposition;
  // UnMarkString(Pad, Red[i]);

  Search_And_Replace2(Pad, Red[i], 0, endposition, clRed);
  // MarkString(Pad, Red[i], 0, clRed);
  end;
  Pad.Lines.EndUpdate;
  // Pad.Text := '30% Trabajando para ud';
  Pad.Lines.BeginUpdate;
  for i := 1 to Length(Green) do
  begin

  // UnMarkString(Pad, Green[i]);
  // Search_And_Replace2(Pad, Green[i], 0, endposition, clGreen);
  MarkString(Pad, Green[i], 0, clGreen);
  end;
  Pad.Lines.EndUpdate;
  // Pad.Text := '60% Trabajando para ud';
  Pad.Lines.BeginUpdate;
  for i := 1 to Length(Blue) do
  begin
  Application.ProcessMessages;
  // UnMarkString(Pad, Blue[i]);
  MarkString(Pad, Blue[i], 0, clBlue);
  // Search_And_Replace2(Pad, Blue[i], 0, endposition, clBlue);
  end;
  Pad.Lines.EndUpdate;
  // Pad.Text := '90% Trabajando para ud';
  Pad.Lines.BeginUpdate;

  // memo5.Lines.BeginUpdate;
  // Pad.Text := memo5.Text;
  Pad.Lines.EndUpdate;

  endposition := Length(Pad.Text);
  if endposition >= 100 then
  begin
  for i := 1 to Length(Red) do
  begin

  // UnMarkString(Pad, Red[i]);

  // Search_And_Replace2(Pad, Red[i], 100, endposition, clRed);
  MarkString(Pad, Red[i], 0, clRed);
  end;
  Pad.Lines.EndUpdate;
  // Pad.Text := '30% Trabajando para ud';
  Pad.Lines.BeginUpdate;
  for i := 1 to Length(Green) do
  begin

  // UnMarkString(Pad, Green[i]);
  // Search_And_Replace2(Pad, Green[i], 100, endposition, clGreen);
  MarkString(Pad, Green[i], 0, clGreen);
  end;
  Pad.Lines.EndUpdate;
  // Pad.Text := '60% Trabajando para ud';
  Pad.Lines.BeginUpdate;
  for i := 1 to Length(Blue) do
  begin
  Application.ProcessMessages;
  // UnMarkString(Pad, Blue[i]);
  // MarkString(Pad, Blue[i], 0, clBlue);
  Search_And_Replace2(Pad, Blue[i], 100, endposition, clBlue);
  end;
  Pad.Lines.EndUpdate;
  // Pad.Text := '90% Trabajando para ud';
  Pad.Lines.BeginUpdate;

  // memo5.Lines.BeginUpdate;
  // Pad.Text := memo5.Text;
  Pad.Lines.EndUpdate;
  end;


  // memo5.Destroy;

  {
  for i := 1 to Length(Black) do
  begin
  MarkString(Pad, Black[i], clBlack);
  UnMarkString(Pad, Black[i], clBlack);
  end; }

{
  name := ('idea_____.html');
  if extension = 'RTF' then
  begin
  devuelveme := 1;
  Pad.PlainText := True;
  end;
  Pad.Lines.SaveToFile(name);
  if devuelveme = 1 then
  begin
  Pad.PlainText := False;
  end;
  if fileexists(name) then
  begin
  ShellExecute(Self.WindowHandle, 'open', PChar(name), nil, nil,
  SW_SHOWNORMAL);
  end;
}
// copy(cadena_de_la_que_extraes,posicion_desde_la_cual_empezaras_a_extraer,cantidad_de_caracteres_a_extraer_a_partir_de_la_posicion_anteriormente_especificada)
{ devuelveme2 := copy(Pad.Text, AnsiPos('href=', Pad.Text) + 6, 100);

  aux1 := AnsiPos('"', devuelveme2);
  devuelveme2 := copy(devuelveme2, 1, aux1 - 1);
  Green := devuelveme2;
  if TRegEx.IsMatch(Green, validacion) then
  begin

  MarkString(Pad, Green, clGreen); // To Mark a string
  end;
}
{
  if TRegEx.IsMatch(Pad.SelText, validacion) then
  begin
  Showmessage('valid');
  MarkString(Pad, Pad.SelText, clBlue); // To Mark a string
  end
  else
  Showmessage('no valid');
  // function AnsiMatchText( const AText: string; const AValues: array of string ): Boolean;
}
{
  end;
}
procedure TfrmMain.ToolButton16Click(Sender: TObject);
begin
  InitRichEditURLDetection(Pad, True);
end;

procedure TfrmMain.ToolButton17Click(Sender: TObject);
begin
  InitRichEditURLDetection(Pad, False);
end;

function Delimitador(cadena, delm1, delm2: string): string;
var
  pos1, pos2: Integer;
  ext, sfinal: string;
begin
  sfinal := '';
  pos1 := AnsiPos(delm1, cadena);
  if pos1 <> 0 then
  begin
    ext := copy(cadena, pos1 + Length(delm1), Length(cadena) - Length(delm1));
    pos2 := AnsiPos(delm2, ext);
    if pos2 <> 0 then
    begin
      sfinal := copy(ext, 1, pos2 - 1);
    end;
  end;
  Result := sfinal;
end;

function getOperatingSystem: string;
var
  osVersionInfo: TOSVersionInfo;
  majorVersion, minorVersion: DWORD;
begin
  Result := 'Unknown';
  osVersionInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);

  if GetVersionEx(osVersionInfo) then
  begin

    majorVersion := osVersionInfo.dwMajorVersion;
    minorVersion := osVersionInfo.dwMinorVersion;

    if (majorVersion = 10) and (minorVersion = 0) then
      Result := 'Windows 10'

    else if (majorVersion = 6) and (minorVersion = 3) then
      Result := 'Windows 8.1'

    else if (majorVersion = 6) and (minorVersion = 2) then
      Result := 'Windows 8'

    else if (majorVersion = 6) and (minorVersion = 1) then
      Result := 'Windows 7'

    else if (majorVersion = 6) and (minorVersion = 0) then
      Result := 'Windows vista'

    else if (majorVersion = 5) and (minorVersion = 1) then
      Result := 'Windows xp'
  end;
end;

function getArchitecture: string;
var
  sysInfo: SYSTEM_INFO;
begin
  GetSystemInfo(sysInfo);
  case sysInfo.wProcessorArchitecture of
    0:
      Result := 'x86';
    9:
      Result := 'x64';
  else
    Result := 'unknown';
  end;
end;

function numberOfProcessors: DWORD;
var
  sysInfo: SYSTEM_INFO;
begin
  GetSystemInfo(sysInfo);
  Result := sysInfo.dwNumberOfProcessors;
end;

function GetProcessorType: string;
var
  sysInfo: SYSTEM_INFO;
begin
  GetSystemInfo(sysInfo);
  case sysInfo.dwProcessorType of
    220:
      Result := 'PROCESSOR_INTEL_IA64';
    386:
      Result := 'PROCESSOR_INTEL_386';
    486:
      Result := 'PROCESSOR_INTEL_486';
    586:
      Result := 'PROCESSOR_INTEL_PENTIUM_586';
    8664:
      Result := 'PROCESSOR_AMD_X8664';
  else
    Result := 'Unknown';
  end;
end;

procedure TfrmMain.ToolButton18Click(Sender: TObject);
var
  ProcessorType, proc, Arq, SO: string;
begin

  // Showmessage(Delimitador('hola_mundo_como_estas', 'hola', 'estas'));

  // uso de la funcion  sistema oeprativo
  SO := getOperatingSystem;
  Arq := getArchitecture;
  ProcessorType := ' Tipo de procesador: ' + GetProcessorType;
  proc := ' Total Procesadores ' + InttoStr(numberOfProcessors);
  Showmessage('Sistema operativo actual: ' + SO + sLineBreak + ' Arquitectura: '
    + Arq + sLineBreak + proc + sLineBreak + ProcessorType);
  // Nos muestra el S.O

end;

function stringToHex(const Data: string): string;
var
  i: Integer;
  sfinal: String;
begin
  sfinal := '';

  for i := 0 to Length(Data) do
  begin
    sfinal := sfinal + IntToHex(ord(Data[i]), 2);
  end;
  Result := sfinal;
end;

function hexTostring(const Data: string): string;
var
  i: Integer;
  sfinal: String;
begin
  i := 1;
  sfinal := '';

  if (Length(Data) mod 2 <> 0) then
  begin
    Result := '';
    Exit;
  end;

  while (i <= Length(Data)) do
  begin
    sfinal := sfinal + chr(strtoint('$' + (copy(Data, i, 2))));
    i := i + 2;
  end;
  Result := sfinal;
end;

procedure TfrmMain.ToolButton19Click(Sender: TObject);
begin
  with Pad.SelAttributes do
    Pad.SetFocus;
  Pad.SelText := stringToHex(Pad.SelText)

end;

procedure TfrmMain.ToolButton1Click(Sender: TObject);
begin

  with Pad.SelAttributes do
    if not(fsBold in Style) then
      Style := Style + [fsBold]
    else
      Style := Style - [fsBold];

  Pad.SetFocus;
end;

procedure TfrmMain.ToolButton20Click(Sender: TObject);
var
  a: String;
begin

  a := hexTostring(Pad.SelText);
  Pad.SelText := a;
end;

procedure TfrmMain.ToolButton2Click(Sender: TObject);
begin
  if ColorDlg.Execute then

    Pad.SelAttributes.Color := ColorDlg.Color;
  // StBarra.Panels[3].Text := 'Color de selección';

end;

procedure TfrmMain.ToolButton3Click(Sender: TObject);
begin
  with Pad.SelAttributes do
    if not(fsItalic in Style) then
      Style := Style + [fsItalic]
    else
      Style := Style - [fsItalic];

  Pad.SetFocus;
end;

procedure TfrmMain.ToolButton4Click(Sender: TObject);
begin
  if FontDlg.Execute then
    Pad.SelAttributes.Name := FontDlg.Font.Name;
  Pad.SelAttributes.Size := FontDlg.Font.Size;
  Pad.SelAttributes.Color := FontDlg.Font.Color;
  Pad.SelAttributes.Pitch := FontDlg.Font.Pitch;
  Pad.SelAttributes.Style := FontDlg.Font.Style;
  Pad.SelAttributes.Height := FontDlg.Font.Height;
end;

procedure TfrmMain.ToolButton5Click(Sender: TObject);
begin
  with Pad.SelAttributes do
    if not(fsUnderline in Style) then
      Style := Style + [fsUnderline]
    else
      Style := Style - [fsUnderline];

  Pad.SetFocus;
end;

procedure TfrmMain.ToolButton6Click(Sender: TObject);
begin
  // Pad.PlainText:=True;

  begin
    with Pad.Paragraph do
      if Numbering = nsNone then
        Numbering := nsBullet
      else
        Numbering := nsNone;

    Pad.SetFocus;
  end;
end;

procedure TfrmMain.ToolButton7Click(Sender: TObject);
begin
  Pad.Paragraph.Alignment := taLeftJustify;
end;

procedure TfrmMain.ToolButton8Click(Sender: TObject);
begin
  Pad.Paragraph.Alignment := taRightJustify;
end;

procedure TfrmMain.ToolButton9Click(Sender: TObject);
begin
  Pad.Paragraph.Alignment := taCenter;
end;

{
  begin

  begin
  Pad.SelText := ReplaceDialog1.ReplaceText
  // ReplaceDialog1.CloseDialog;
  end

  else if frReplaceAll in ReplaceDialog1.Options then
  begin
  CursorPos := Pad.CaretPos;
  for i := CursorPos.Y + 1 to Pad.Lines.Count do
  begin
  PosReturn := Pos(ReplaceDialog1.FindText, Pad.Lines[i]);
  if PosReturn <> 0 then
  begin
  SkipChars := 0;
  for J := 0 to i - 1 do
  SkipChars := SkipChars + Length(Pad.Lines[J]);
  SkipChars := SkipChars + (i * 2);
  SkipChars := SkipChars + PosReturn - 1;

  Pad.SelStart := SkipChars;
  Pad.SelLength := Length(ReplaceDialog1.FindText);
  // Pad.SetFocus;

  Pad.SelText := ReplaceDialog1.ReplaceText

  end;

  end;

  end;
  end;
}
function Search_And_Replace(richedit: TRichEdit;
  SearchText, ReplaceText: string): Boolean;

var
  StartPos, Position, endpos: Integer;

begin
  StartPos := 0;
  with richedit do
  begin
    endpos := Length(richedit.Text);
    Lines.BeginUpdate;
    while FindText(SearchText, StartPos, endpos, [stMatchCase]) <> -1 do
    begin
      endpos := Length(richedit.Text) - StartPos;
      Position := FindText(SearchText, StartPos, endpos, [stMatchCase]);
      inc(StartPos, Length(SearchText));
      SetFocus;
      SelStart := Position;
      SelLength := Length(SearchText);
      richedit.ClearSelection;
      SelText := ReplaceText;
    end;
    Lines.EndUpdate;
  end;
end;

procedure TfrmMain.ReHacer1Click(Sender: TObject);
begin
  Pad.Perform(EM_REDO, 0, 0);
end;

procedure TfrmMain.Remplazar1Click(Sender: TObject);
begin
  ReplaceDialog1.Execute;

  // Search_And_Replace(Pad, ReplaceDialog1.FindText, ReplaceDialog1.ReplaceText);
end;

procedure TfrmMain.ReplaceDialog1Find(Sender: TObject);

var
  FoundAt: Longint;
  StartPos, ToEnd: Integer;
begin
  with Pad do
  begin
    { if there's selected text, start looking from that place, in other case, start looking from the beginning }
    if SelLength <> 0 then
      StartPos := SelStart + SelLength
    else
      StartPos := 0;

    { find the end of text }
    ToEnd := Length(Text) - StartPos;

    FoundAt := FindText(ReplaceDialog1.FindText, StartPos, ToEnd,
      [stMatchCase]);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart := FoundAt;
      SelLength := Length(ReplaceDialog1.FindText);
    end;
  end;
end;

procedure TfrmMain.ReplaceDialog1Replace(Sender: TObject);
var
  FoundAt: Longint;
  StartPos, ToEnd: Integer;
  st: TSearchTypes;
begin
  if (frReplaceAll in ReplaceDialog1.Options) then
  begin
    Search_And_Replace(Pad, ReplaceDialog1.FindText,
      ReplaceDialog1.ReplaceText);
  end;
  if (frReplace in ReplaceDialog1.Options) then
  begin

    if Pad.SelLength <> 0 then
    begin

      StartPos := Pad.SelStart + Pad.SelLength
    end
    else
    begin
      StartPos := 0;
    end;

    { find the end of text }
    ToEnd := Length(Text) - StartPos;

    FoundAt := Pad.FindText(ReplaceDialog1.FindText, StartPos, ToEnd,
      [stMatchCase]);
    if FoundAt <> -1 then
    begin
      SetFocus;
      Pad.SelStart := FoundAt;
      Pad.SelLength := Length(ReplaceDialog1.FindText);
      Pad.SelText := ReplaceDialog1.ReplaceText;
    end;

  end;
end;




// if FoundAt=-1 then
// ShowMessage('????!');

{
  var
  SelPos: Integer;

  begin

  with TReplaceDialog(Sender) do
  begin
  SelPos := Pos(FindText, Pad.Lines.Text);
  if SelPos > 0 then
  begin
  Pad.SelStart := SelPos - 1;
  pad.SelLength := Length(FindText);
  // Replace selected text with ReplaceText
  pad.SelText := ReplaceText;
  end
  else MessageDlg(Concat('No more matches for: "', FindText, '" have been found in the current document'), mtError, [mbOk], 0);

  end;

  end; }

{
  procedure TfrmMain.ReplaceDialog1Find(Sender: TObject);
  var
  i, J, PosReturn, SkipChars: Integer;
  CursorPos: TPoint;
  begin
  CursorPos := Pad.CaretPos;
  for i := CursorPos.Y + 1 to Pad.Lines.Count do
  begin
  PosReturn := Pos(ReplaceDialog1.FindText, Pad.Lines[i]);
  if PosReturn <> 0 then
  begin
  SkipChars := 0;
  for J := 0 to i - 1 do
  SkipChars := SkipChars + Length(Pad.Lines[J]);
  SkipChars := SkipChars + (i * 2);
  SkipChars := SkipChars + PosReturn - 1;

  Pad.SelStart := SkipChars;
  Pad.SelLength := Length(ReplaceDialog1.FindText);
  Pad.SetFocus;
  Break;
  end;
  end;
  end;

  {
  var
  Posicion: longint;
  Cadena: string;
  nCont, band, lpos: integer;

  begin
  lpos := SendMessage(Pad.Handle, EM_LINEFROMCHAR, Pad.SelStart, 0);
  if lpos > 0 then
  lpos := lpos + 1;
  Cadena := FindDlg.FindText;
  band := 0;
  For nCont := lpos to Pad.Lines.Count - 1 do
  begin
  if pos((Cadena), (Pad.Lines[nCont])) > 0 then
  begin
  Posicion := pos((Cadena), (Pad.Lines[nCont])) - 1;
  Pad.SelStart := Posicion + Pad.Perform(EM_LINEINDEX, nCont, 0);
  Pad.SelLength := Length(Cadena);
  Pad.SetFocus;
  band := 1;
  break;
  end;
  end;
  if band = 0 then
  showmessage(NotFounded + Cadena);

  end;
}
{ working }       {
  procedure TfrmMain.ReplaceDialog1Find(Sender: TObject);

  var

  StartPos, Position, endpos: Integer;

  begin
  Showmessage('remplace');
  StartPos := 0;
  begin

  with Pad do

  begin

  endpos := Length(Pad.Text);

  Lines.BeginUpdate;

  while FindText(ReplaceDialog1.FindText, StartPos, endpos,
  [stMatchCase]) <> -1 do

  begin

  endpos := Length(Pad.Text) - StartPos;

  Position := FindText(ReplaceDialog1.FindText, StartPos, endpos,
  [stMatchCase]);

  inc(StartPos, Length(ReplaceDialog1.FindText));

  SetFocus;

  SelStart := Position;

  SelLength := Length(ReplaceDialog1.FindText);

  Pad.ClearSelection;

  SelText := ReplaceDialog1.ReplaceText;

  end;

  Lines.EndUpdate;

  end;

  end;

  end; }

procedure TfrmMain.Abrir1Click(Sender: TObject);
begin
  OpenDlg.FileName := '';
  SaveDlg.FileName := '';
  if not(Pad.Modified) then
  begin
    OpenDlg.Execute;
    strNombreArch := OpenDlg.FileName;
    if strNombreArch = '' then
    begin
      strNombreArch := Untitled;
    end
    else
    begin
      Pad.Lines.LoadFromFile(strNombreArch);
    end;

    Self.Caption := strNombreArch + titRAC;
  end

  else if (Pad.Modified) then
  begin
    ModalResult := MyMessageDlg(saveinfostr, mtConfirmation, [mbYes, mbNo],
      [STRyes, STRno], STRSave1);

    if ((ModalResult = mrYes) and (SaveChanges2)) or (ModalResult = mrNo) then
    begin
      // showmessage('Ha sido Guardado');
      // SaveDlg.Execute;
      //
      OpenDlg.Execute;

      strNombreArch := OpenDlg.FileName;

      if strNombreArch = '' then
      begin
        strNombreArch := Untitled; // + titRAC;
      end
      else
      begin
        Pad.Lines.LoadFromFile(strNombreArch);
      end;
      Self.Caption := strNombreArch + titRAC;
      Pad.Modified := False;
    end;
  end;
end;
{
function stringToBinary(const nameExe, Source: string): Boolean;
var
  _File: TFileStream;
begin
  Result := False;
  _File := TFileStream.Create(nameExe, fmCreate);
  try
    _File.Write(Source[1], Length(Source));
  finally
    _File.Free;
  end;

  Result := True;
end;

function binaryToString(const path: string): String;
var
  _File: TFileStream;
  Size: Int64;
begin
  if fileexists(path) then
  begin
    _File := TFileStream.Create(path, fmOpenRead);
    try
      Size := _File.Size;
      SetLength(Result, Size);
      _File.Read(Result[1], Size);
    finally
      _File.Free;
    end;
  end
  else
    Result := '';
end;
}

procedure TfrmMain.Abrirymostrarsoloprintables1Click(Sender: TObject);

var
  i: Integer;
  s: AnsiString;
  Stream: TFileStream;
  apuromafo: Boolean;
begin
  OpenDlg.FileName := '';
  SaveDlg.FileName := '';
  apuromafo := Pad.Modified;
  if apuromafo = True then
  begin
    ModalResult := MyMessageDlg(saveinfostr, mtConfirmation, [mbYes, mbNo],
      [STRyes, STRno], STRSave1);

    if ((ModalResult = mrYes) and (SaveChanges2)) or (ModalResult = mrNo) then
    begin
      // showmessage('Ha sido Guardado');
      // SaveDlg.Execute;
      //
      OpenDlg.Execute;

      strNombreArch := OpenDlg.FileName;

      if strNombreArch = '' then
      begin
        strNombreArch := Untitled; // + titRAC;
      end
      else
      begin
        // Pad.Lines.LoadFromFile(strNombreArch);

        Stream := TFileStream.Create(strNombreArch, fmOpenRead);
        try
          SetLength(s, Stream.Size);
          if Stream.Size > 0 then
            Stream.ReadBuffer(s[1], Stream.Size);
        finally
          Stream.Free;
        end;

        for i := 1 to Length(s) do

          if s[i] < #32 then
          begin

            if s[i] = #13 then
            begin
              s[i] := #13;
            end
            else
              s[i] := ' ';
          end;
        Pad.Text := s;
        Self.Caption := strNombreArch + titRAC;

      end;
      Self.Caption := strNombreArch + titRAC;
      Pad.Modified := False;
    end;
  end;
  if apuromafo = False then
  begin
    OpenDlg.Execute;
    strNombreArch := OpenDlg.FileName;
    if strNombreArch = '' then
    begin
      strNombreArch := Untitled;
    end
    else
    begin

      Stream := TFileStream.Create(strNombreArch, fmOpenRead);
      try
        SetLength(s, Stream.Size);
        if Stream.Size > 0 then
          Stream.ReadBuffer(s[1], Stream.Size);
      finally
        Stream.Free;
      end;

      for i := 1 to Length(s) do

        if s[i] < #32 then
        begin

          if s[i] = #13 then
          begin
            s[i] := #13;
          end
          else
            s[i] := ' ';
        end;
      Pad.Text := s;
      Self.Caption := strNombreArch + titRAC;
    end;
  end;
end;

procedure TfrmMain.AumentarZoom2Click(Sender: TObject);
begin

  if Pad.Zoom < 1500 then
  begin
    Pad.Zoom := Pad.Zoom + 10;
  end;
  infobarra;
end;

procedure TfrmMain.BarraZoomClick(Sender: TObject);
begin
  if BarraZoom.Checked then
  begin
    Barra3.Visible := True;
    infobarra;
  end
  else
  begin
    Barra3.Visible := False;
    infobarra;
  end;
end;

procedure TfrmMain.BarraModoTextoRtf1Click(Sender: TObject);

begin
  if BarraModoTextoRtf1.Checked then
  begin
    Barra2.Visible := True;
  end
  else
  begin
    Barra2.Visible := False;
  end;

end;

procedure TfrmMain.BuscarSiguiente1Click(Sender: TObject);
begin
  FindDlg.Execute();
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  LineNo: Integer;
  /// Cadena: String;

  // i: Integer;
begin
  // Cadena := 'Apuromafowasherecls';
  // i := 0;
  // if extension=1 then
  // RadioGroup1.Hide;
  SpinEdit1.MaxValue := Pad.Lines.count + 1;

  LineNo := SpinEdit1.value;

  if LineNo <= Pad.Lines.count + 1 then
  begin
    Pad.SelLength := 1;

    Pad.SetFocus;
    Pad.SelStart := Pad.Perform(EM_LINEINDEX, LineNo - 1, 0);
    Pad.Perform(EM_SCROLLCARET, 0, 0);
  end;

end;

procedure TfrmMain.Button2Click(Sender: TObject);

begin
  RadioGroup1.Destroy;
  // RadioGroup1.Hide;
  // RadioGroup1.Destroy;
  Button1.Hide;
  Button2.Hide;
  SpinEdit1.Hide;
  // Edit1.Hide;

end;

procedure TfrmMain.Button3Click(Sender: TObject);
var
  wii: Integer;
  patron: string;
begin
  patron := '<tr>';
  wii := Pos((patron), Pad.Text);
  if wii <> -1 then
  begin
    Pad.SelStart := wii - 1;
    Pad.SelLength := Length(patron);
    Pad.SelAttributes.Color := clRed;

    wii := Pos((patron), Pad.Text);
  end;

end;



// hRegEx := , [roIgnoreCase, roMultiLine]);



// Regarding the Regular Expression there should only be one Match in the Collection.
// Thats Subject to Change

{
  procedure TfrmMain.Button3Click(Sender: TObject);

  var
  rgn :hrgn;
  begin
  rgn := CreateRoundRectRgn(0,0,Button3.width,Button1.height,10,10);
  SetWindowRgn(button3.handle,rgn,true);
  end;
}
{ procedure TfrmMain.FormPaint(Sender: TObject); begin Canvas.pen.Width := 5;
  Canvas.pen.Color := clBlue; with Button1 do Canvas.RoundRect(Left, Top,
  Width + Left, Height + Top, 20, 20); end;
}
procedure TfrmMain.Cambiarformatodeseleccin1Click(Sender: TObject);
begin
  if ColorDlg.Execute then

    Pad.SelAttributes.Color := ColorDlg.Color;
  // StBarra.Panels[3].Text := 'trabajando para ud';

end;

procedure TfrmMain.CambiarTamaoSeleccion1Click(Sender: TObject);
begin

  if FontDlg.Execute then
    Pad.SelAttributes.Name := FontDlg.Font.Name;
  Pad.SelAttributes.Size := FontDlg.Font.Size;
  Pad.SelAttributes.Color := FontDlg.Font.Color;
  Pad.SelAttributes.Pitch := FontDlg.Font.Pitch;
  Pad.SelAttributes.Style := FontDlg.Font.Style;
  Pad.SelAttributes.Height := FontDlg.Font.Height;
end;

procedure TfrmMain.Cursiva1Click(Sender: TObject);
begin
  with Pad.SelAttributes do
    if not(fsItalic in Style) then
      Style := Style + [fsItalic]
    else
      Style := Style - [fsItalic];

  Pad.SetFocus;
end;

procedure TfrmMain.DisminuirZoom1Click(Sender: TObject);
begin

  if Pad.Zoom >= 10 then
  begin
    Pad.Zoom := Pad.Zoom - 10;
  end;
end;

procedure TfrmMain.Extensiones1Click(Sender: TObject);

begin
  // SpinEdit1.Hide;
  // RadioGroup1.Visible := True;
  // RadioGroup1.Caption := 'Extensiones';
  // Edit1.Visible := True;
  // Edit1.Text := '.txt';
  // RadioGroup1.Items.Add('agregando segun el edit');

end;

{
  procedure TfrmMain.FindClick(Sender: TObject);
  begin
  FindDlg.Execute;
  end;
}
{
  procedure TfrmMain.FindNextClick(Sender: TObject);
  begin
  FindDlgFind(nil);
  FindDlg.Execute;
  //
  end;
}
{
  //procedure TfrmMain.BuscarSiguiente1Click(Sender: TObject);
  var
  I, J, PosReturn, SkipChars: Integer;
  begin
  for I := 0 to Pad.Lines.Count do
  begin
  PosReturn := Pos(FindDlg.FindText, Pad.Lines[I]);

  if PosReturn <> 0 then { encontrado! }   {
  begin
  SkipChars := 0;
  for J := 0 to I - 1 do
  SkipChars := SkipChars + Length(Pad.Lines[J]);

  SkipChars := SkipChars + (I * 2);
  SkipChars := SkipChars + PosReturn - 1;

  Pad.SetFocus;
  Pad.SelStart := SkipChars;
  Pad.SelLength := Length(FindDlg.FindText);
  Break;
  end
  else if MessageBox(0, 'No halle nada...', aviRAC, MB_TASKMODAL or
  MB_ICONEXCLAMATION or MB_OK) = MB_OK then
  begin
  FindDlg.CloseDialog;
  Abort;
  end; // este closeDialog deberia de cerrar el dialogo (obvio) pero.... no lo hace :S
  end; // el Abort es una silent exeption, eso es que no da mensaje al usuario

  end;
}
procedure TfrmMain.mnFechaClick(Sender: TObject);
begin
  Pad.SelText := DateToStr(Date);
end;

procedure TfrmMain.mnHoraClick(Sender: TObject);
begin
  Pad.SelText := TimeToStr(time);
end;

procedure TfrmMain.mnFechHoraClick(Sender: TObject);
begin
  Pad.SelText := TimeToStr(time) + ' ' + DateToStr(Date);
end;

// fin menu Edicion

// menu formato

procedure TfrmMain.mnAjusteLinClick(Sender: TObject);
// const
// SCROLL:array[Boolean] of TScrollStyle =(ssBOTH,SSvertical)

begin
  if mnAjusteLin.Checked = True then
  begin

    Pad.WordWrap := True;

    Pad.ScrollBars := ssVertical;
    // Self.Pad.WordWrap := TRUE;
    //
    // Self.AutoSize := FALSE;

    // showmessage('soy true');

  end
  else
  begin
    Pad.WordWrap := False;
    Pad.ScrollBars := ssBoth;

    // Self.Pad.WordWrap := FALSE;
    // Self.AutoSize := FALSE;
    // Self.AutoSize := TRUE;

    // showmessage('soy false');

  end;
  {
    begin
    mnAjusteLin.Checked := FALSE;
    Self.Pad.WordWrap := FALSE;
    end
    else
    begin
    mnAjusteLin.Checked := TRUE;
    Self.Pad.WordWrap := TRUE;
    end; }
end;

procedure TfrmMain.mnFuenteClick(Sender: TObject);
begin

  FontDlg.Font := Pad.Font;
  // tiene que saber que fuente esta antes!
  if FontDlg.Execute then
    Pad.Font := FontDlg.Font;

  if Pad.Font.Size > 100 then
    Showmessage('¿Porqué tan grande? mas de 100 !! ');

  begin
    // Pad.Font.Size := 99;
    Memo1.Font := Pad.Font;
  end;
  // Memo1.Font.Size := Pad.Font.Size;
  Memo1.Font := Pad.Font;
  // Memo1.Font.Name := Pad.Font.Name;
  Memo1.Width := Pad.Font.Size * 2 + 3;
  // Showmessage('Color= ' + inttostr(Pad.Font.Color) + 'size= ' +
  // inttostr(Pad.Font.Size) + 'orientacion= ' + inttostr(Pad.Font.Orientation) +
  // 'height' + inttostr(Pad.Font.Height) + 'Name =' +  + 'Charset= '
  // + inttostr(Font.Charset));
  // BoolToStr(Font.Style) 'Quality ='+inttostr(Font.Quality)

  // fin menu formato
end;
// menu ver

procedure TfrmMain.mnBarraClick(Sender: TObject);
begin
  if mnBarra.Checked then
  begin
    mnBarra.Checked := False;
    StBarra.Visible := False;
  end
  else
  begin
    mnBarra.Checked := True;
    StBarra.Visible := True;
  end;
end;

procedure TfrmMain.mnBuscarClick(Sender: TObject);

begin
  // FindDlg.Position := Point(Pad.Left + Pad.Width, Pad.Top);
  FindDlg.Execute;

end;

procedure TfrmMain.mnInvColoresClick(Sender: TObject);
var
  Color: Tcolor;
begin

  Color := Pad.Color;
  Pad.Color := Pad.Font.Color;
  Pad.Font.Color := Color;
end;

procedure TfrmMain.mnColorFClick(Sender: TObject);
begin
  if ColorDlg.Execute then
    Pad.Color := ColorDlg.Color;
end;

procedure TfrmMain.mnColorTClick(Sender: TObject);
begin
  if ColorDlg.Execute then
    Pad.Font.Color := ColorDlg.Color;
end;

// fin menu ver

// menu ayuda

procedure TfrmMain.mnRACClick(Sender: TObject);

var
  stri0, stri1: string;

begin
  stri1 := sLineBreak + InspiradoStr + sLineBreak + Iconos + sLineBreak;
  stri0 := RAC + Version + Info + ProgAutor + sLineBreak + Revisor + stri1;

  MessageBox(0, PChar(stri0), aviRAC, MB_OK or MB_TASKMODAL);
end;
{
  Function TfrMain.codificacion:String;
  begin
  Result := TRUE;
  end;
}

function TfrmMain.SaveChanges: Boolean;
begin
  // showmessage('usandosavechanges');
  Result := False;
  if (OpenTextFileDialog1.FileName = '') and (SaveTextFileDialog1.FileName = '')
  then
  begin
    if SaveTextFileDialog1.Execute then
    begin

      Screen.Cursor := crHourGlass;
      // StBarra.SimpleText := SavingStr;
      Pad.Lines.SaveToFile(SaveTextFileDialog1.FileName + extension,
        TEncoding.Default);
      Self.Caption := SaveTextFileDialog1.FileName + titRAC;
      // StBarra.SimpleText := ListoStr;
      Screen.Cursor := crDefault;
      Result := True;
    end;
  end
  else
  begin
    Screen.Cursor := crHourGlass;
    // StatusBar1.SimpleText := 'Saving...';
    if OpenTextFileDialog1.FileName <> '' then
    begin
      Pad.Lines.SaveToFile(OpenTextFileDialog1.FileName + extension);
      Self.Caption := OpenTextFileDialog1.FileName + titRAC;
    end
    else if SaveTextFileDialog1.FileName <> '' then
    begin
      Pad.Lines.SaveToFile(SaveTextFileDialog1.FileName + extension);
      Self.Caption := SaveTextFileDialog1.FileName + titRAC;
    end;

    // StatusBar1.SimpleText := 'Ready';
    Screen.Cursor := crDefault;
    Result := True;
  end;
end;

end.
