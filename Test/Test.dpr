program Test;

uses
  TestFramework,
  TestExtensions,
  FastMMMonitorTest,
  GUITestRunner,
  Vcl.Forms,
  TnefReaderTest in 'TnefReaderTest.pas',
  TnefAttachmentParser in '..\TnefReader\TnefAttachmentParser.pas',
  TnefAttributeConsts in '..\TnefReader\TnefAttributeConsts.pas',
  TnefAttribute in '..\TnefReader\TnefAttribute.pas',
  TnefReader in '..\TnefReader\TnefReader.pas',
  TnefPropertyReader in '..\TnefReader\TnefPropertyReader.pas',
  TnefPropertyConsts in '..\TnefReader\TnefPropertyConsts.pas',
  TnefProperty in '..\TnefReader\TnefProperty.pas',
  TnefPropertyTag in '..\TnefReader\TnefPropertyTag.pas',
  TnefPropertyName in '..\TnefReader\TnefPropertyName.pas';

{$R *.res}

begin
  System.ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
end.
