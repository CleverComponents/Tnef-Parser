unit TnefReader;

interface

uses
  System.Classes, System.SysUtils, TnefAttributeConsts;

type
  TTnefReader = class
  private
    FInputStream: TStream;
    FAttributeValueStart: Int64;
    FChecksum: SmallInt;
    FAttributeLength: Integer;
    FAttributeTag: TTnefAttributeTag;
    FAttachmentKey: SmallInt;
    FAttributeLevel: TTnefAttributeLevel;
    FTnefVersion: Integer;
    FOemCodePage: Integer;

    function GetRawReadPosition: Int64;
    function GetAttributeType: TTnefAttributeType;
    function ReadBuffer(ALength: Integer): TBytes;
    procedure UpdateCheckSum(const ABuffer: TBytes);
    function ReadAttributeLevel: TTnefAttributeLevel;
    procedure ReadAttributeValue;
    procedure ReadHeader;
    procedure ValidateNextAttributePos;
  public
    constructor Create(AInputStream: TStream);

    function GetEncoding: TEncoding;
    function NextAttribute: Boolean;
    procedure ValidateChecksum;

    function ReadByte: Byte;
    function ReadInt16: SmallInt;
    function ReadInt32: Integer;
    function ReadBytes(ALength: Integer): TBytes; overload;
    procedure ReadBytes(ADestination: TStream; ALength: Integer); overload;
    function ReadString: string;

    property AttachmentKey: SmallInt read FAttachmentKey;
    property AttributeLevel: TTnefAttributeLevel read FAttributeLevel;
    property AttributeTag: TTnefAttributeTag read FAttributeTag;
    property AttributeLength: Integer read FAttributeLength;
    property TnefVersion: Integer read FTnefVersion;
    property OemCodePage: Integer read FOemCodePage;
    property RawReadPosition: Int64 read GetRawReadPosition;
    property AttributeType: TTnefAttributeType read GetAttributeType;
  end;

implementation

uses
  TnefAttribute;

const
  TnefSignature = $223e9f78;

{ TTnefReader }

function TTnefReader.ReadBytes(ALength: Integer): TBytes;
begin
  Result := ReadBuffer(ALength);
  UpdateCheckSum(Result);
end;

constructor TTnefReader.Create(AInputStream: TStream);
begin
  inherited Create();

  FInputStream := AInputStream;

  FAttributeLevel := alMessage;
  FAttributeTag := agNull;
  FAttributeLength := 0;
  FAttributeValueStart := 0;

  FTnefVersion := 0;
  FOemCodePage := 0;

  FChecksum := 0;
  FAttachmentKey := 0;

  ReadHeader();
end;

function TTnefReader.GetAttributeType: TTnefAttributeType;
begin
  Result := GetTnefAttributeType(TnefAttributeTags[AttributeTag] and $F0000);
end;

function TTnefReader.GetEncoding: TEncoding;
begin
  try
    Result := TEncoding.GetEncoding(OemCodePage);
  except
    Result := TEncoding.Default.Clone();
  end;
end;

function TTnefReader.GetRawReadPosition: Int64;
begin
  Result := FInputStream.Position;
end;

function TTnefReader.NextAttribute: Boolean;
begin
  ValidateNextAttributePos();

  if (RawReadPosition >= FInputStream.Size) then
  begin
    Exit(False);
  end;

  FAttributeLevel := ReadAttributeLevel();

  FAttributeTag := GetTnefAttributeTag(ReadInt32());

  FAttributeLength := ReadInt32();
  FAttributeValueStart := RawReadPosition;

  FChecksum := 0;

  ReadAttributeValue();

  Exit(True);
end;

function TTnefReader.ReadAttributeLevel: TTnefAttributeLevel;
begin
  Result := GetTnefAttributeLevel(ReadByte());
end;

procedure TTnefReader.ReadAttributeValue;
var
  versionAttribute: TTnefVersionAttribute;
  codePageAttribute: TTnefOemCodePageAttribute;
begin
  if (AttributeLevel <> alMessage) then Exit;

  case (AttributeTag) of
    agTnefVersion:
    begin
      versionAttribute := TTnefVersionAttribute.Create(Self);
      try
        versionAttribute.Load();
        FTnefVersion := versionAttribute.TnefVersion;
      finally
        versionAttribute.Free();
      end;
    end;
    agOemCodepage:
    begin
      codePageAttribute := TTnefOemCodePageAttribute.Create(Self);
      try
        codePageAttribute.Load();
        FOemCodePage := codePageAttribute.OemCodePage;
      finally
        codePageAttribute.Free();
      end;
    end;
  end;
end;

function TTnefReader.ReadBuffer(ALength: Integer): TBytes;
var
  readLength: Integer;
begin
  SetLength(Result, ALength);
  readLength := FInputStream.Read(Result, 0, ALength);

  if (readLength <> ALength) then
  begin
    raise Exception.Create('Invalid Stream');
  end;
end;

function TTnefReader.ReadByte: Byte;
var
  buffer: TBytes;
begin
  buffer := ReadBuffer(1);
  UpdateCheckSum(buffer);
  Result := buffer[0];
end;

procedure TTnefReader.ReadBytes(ADestination: TStream; ALength: Integer);
const
  MaxBufSize = 4096;
var
  bufSize, n: Integer;
  buf: TBytes;
begin
  bufSize := ALength;
  if (bufSize > MaxBufSize) then
  begin
    bufSize := MaxBufSize;
  end;

  while (ALength <> 0) do
  begin
    n := bufSize;
    if (n > ALength) then
    begin
      n := ALength;
    end;

    buf := ReadBytes(n);
    ADestination.Write(buf, 0, n);
    Dec(ALength, n);
  end;
end;

procedure TTnefReader.ReadHeader;
var
  signature: Integer;
begin
  signature := ReadInt32();

  if (signature <> TnefSignature) then
  begin
    raise Exception.Create('Invalid TNEF format');
  end;

  FAttachmentKey := ReadInt16();
end;

function TTnefReader.ReadInt16: SmallInt;
var
  index: Integer;
  buffer: TBytes;
begin
  index := 0;
  buffer := ReadBuffer(2);
  UpdateCheckSum(buffer);

  Result := SmallInt(buffer[index] or (buffer[index + 1] shl 8));
end;

function TTnefReader.ReadInt32: Integer;
var
  index: Integer;
  buffer: TBytes;
begin
  index := 0;
  buffer := ReadBuffer(4);
  UpdateCheckSum(buffer);

  Result := buffer[index] or (buffer[index + 1] shl 8) or (buffer[index + 2] shl 16) or (buffer[index + 3] shl 24);
end;

function TTnefReader.ReadString: string;
var
  bytes: TBytes;
  len: Integer;
  enc: TEncoding;
begin
  bytes := ReadBytes(AttributeLength);

  len := Length(bytes);
  if (len > 0) and (bytes[len - 1] = 0) then
  begin
    Dec(len);
  end;

  enc := GetEncoding();
  try
    Result := enc.GetString(bytes, 0, len);
  finally
    enc.Free();
  end;
end;

procedure TTnefReader.UpdateCheckSum(const ABuffer: TBytes);
var
  i: Integer;
begin
  for i := 0 to Length(ABuffer) - 1 do
  begin
    FChecksum := SmallInt((FChecksum + ABuffer[i]) and $FFFF);
  end;
end;

procedure TTnefReader.ValidateChecksum;
var
  nextAttributePos: Int64;
  real, etalon: SmallInt;
begin
  nextAttributePos := FAttributeValueStart + AttributeLength;
  if (nextAttributePos = RawReadPosition) then
  begin
    real := FChecksum;
    etalon := ReadInt16();

    if (real <> etalon) then
    begin
      raise Exception.Create('Invalid checksum');
    end;
  end;
end;

procedure TTnefReader.ValidateNextAttributePos;
var
  nextAttributePos: Int64;
begin
  if (FAttributeValueStart = 0) then Exit;

  nextAttributePos := FAttributeValueStart + AttributeLength + 2;
  if (nextAttributePos > RawReadPosition) then
  begin
    FInputStream.Seek(nextAttributePos, soBeginning);
    if (RawReadPosition > FInputStream.Size) then
    begin
      raise Exception.Create('Invalid stream');
    end;
  end else
  if (nextAttributePos < RawReadPosition) then
  begin
    raise Exception.Create('The attribute was read incorrectly');
  end;
end;

end.
