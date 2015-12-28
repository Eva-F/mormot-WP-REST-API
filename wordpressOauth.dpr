program wordpressOauth;

uses
  Vcl.Forms,
  wordpressaurh in 'wordpressaurh.pas' {Form1},
  WPRESTAPI in 'WPRESTAPI.pas',
  WPRESTAPIModels in 'WPRESTAPIModels.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
