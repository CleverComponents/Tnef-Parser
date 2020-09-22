unit TnefReaderTest;

interface

uses
  System.Classes, System.SysUtils, Winapi.Windows, TestFrameWork,
  TnefAttachmentParser;

type
  TTnefReaderTest = class(TTestCase)
  private
    function GetLocalFileSize(const AFileName: string): Integer;
  published
    procedure TestParse;
    procedure Test2;
  end;

implementation

{ TTnefReaderTest }

function TTnefReaderTest.GetLocalFileSize(const AFileName: string): Integer;
var
  h: THandle;
begin
  h := CreateFile(PChar(AFileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL, 0);
  Assert(h <> INVALID_HANDLE_VALUE, 'File not found');
  Result := GetFileSize(h, nil);
  CloseHandle(h);
end;

procedure TTnefReaderTest.Test2;
var
  stream: TStream;
  parser: TTnefAttachmentParser;
begin
  stream := nil;
  parser := nil;
  try
    stream := TFileStream.Create('d:\60\winmail.dat', fmOpenRead or fmShareDenyWrite);

    parser := TTnefAttachmentParser.Create();

    parser.Parse(stream, 'd:\60\tnef\');
  finally
    parser.Free();
    stream.Free();
  end;
end;

procedure TTnefReaderTest.TestParse;
var
  baseFolder: string;
  stream: TStream;
  parser: TTnefAttachmentParser;
begin
  baseFolder := '';

  System.SysUtils.DeleteFile(baseFolder + 'AUTOEXEC.BAT');
  System.SysUtils.DeleteFile(baseFolder + 'RtfCompressed.dat');
  System.SysUtils.DeleteFile(baseFolder + 'boot.ini');
  System.SysUtils.DeleteFile(baseFolder + 'CONFIG.SYS');

  stream := nil;
  parser := nil;
  try
    stream := TFileStream.Create('..\..\data\winmail.dat', fmOpenRead);

    parser := TTnefAttachmentParser.Create();

    parser.Parse(stream, baseFolder);
  finally
    parser.Free();
    stream.Free();
  end;

  Assert(FileExists(baseFolder + 'AUTOEXEC.BAT'));
  Assert(0 = GetLocalFileSize(baseFolder + 'AUTOEXEC.BAT'));

  Assert(FileExists(baseFolder + 'RtfCompressed.dat'));
  Assert(120 = GetLocalFileSize(baseFolder + 'RtfCompressed.dat'));

  Assert(FileExists(baseFolder + 'boot.ini'));
  Assert(289 = GetLocalFileSize(baseFolder + 'boot.ini'));

  Assert(FileExists(baseFolder + 'CONFIG.SYS'));
  Assert(0 = GetLocalFileSize(baseFolder + 'CONFIG.SYS'));
end;

initialization
  TestFramework.RegisterTest(TTnefReaderTest.Suite);

finalization

end.
