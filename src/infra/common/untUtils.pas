unit untUtils;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  Vcl.Forms,
  Vcl.Controls;

type
  TMsgType = (mtInfo, mtWarn, mtErr, mtQuest);

function ShowMsg(const Msg: string; MsgType: TMsgType): TModalResult;

implementation

function ShowMsg(const Msg: string; MsgType: TMsgType): TModalResult;
var
  Handle: HWND;
  uType: UINT;
  Title: String;
  Ret: Integer;
begin
  Handle := 0;
  if Assigned(Screen.ActiveForm) then
    Handle := Screen.ActiveForm.Handle;

  uType := MB_OK or MB_ICONINFORMATION;

  case MsgType of
    mtInfo:
      begin
        uType := MB_OK or MB_ICONINFORMATION;
        Title := 'Informação';
      end;

    mtWarn:
      begin
        uType := MB_OK or MB_ICONEXCLAMATION;
        Title := 'Aviso';
      end;

    mtErr:
      begin
        uType := MB_OK or MB_ICONERROR;
        Title := 'Erro';
      end;

    mtQuest:
      begin
        uType := MB_YESNO or MB_ICONQUESTION;
        Title := 'Confirmação';
      end;
  end;

  Ret := MessageBox(Handle, PChar(Msg), PChar(Title), uType);

  case Ret of
    IDOK:  Result := mrOk;
    IDYES: Result := mrYes;
    IDNO:  Result := mrNo;
  else
    Result := mrNone;
  end;

end;

end.
