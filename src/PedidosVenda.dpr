program PedidosVenda;

uses
  Vcl.Forms,
  frmMain in 'views\frmMain.pas' {fMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
