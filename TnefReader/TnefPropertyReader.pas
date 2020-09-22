unit TnefPropertyReader;

interface

uses
  System.Classes, System.SysUtils, TnefReader, TnefPropertyTag, TnefPropertyName, TnefPropertyConsts;

type
  TTnefPropertyReader = class
  private
    FReader: TTnefReader;
    FPropertyCount: Integer;
    FPropertyIndex: Integer;
    FValueIndex: Integer;
    FPropertyValueStart: Int64;

    FValueLength: Integer;
    FPropertyName: TTnefPropertyName;
    FPropertyTag: TTnefPropertyTag;
    FValueCount: Integer;

    procedure ReadPropertyTag;
    procedure ReadPropertyName;
    function ReadByteArray(ALength: Integer): TBytes; overload;
    function ReadByteArray: TBytes; overload;
    function ReadUnicodeString: string;
    function ReadAnsiString: string;
    function DecodeUnicodeString(const ABytes: TBytes): string;
    function DecodeAnsiString(const ABytes: TBytes): string;
    function GetValueCount: Integer;
    function GetValueLength: Integer;
    procedure ValidateNextPropertyPos;
    procedure UpdatePropertyValueStart;
  public
    constructor Create(AReader: TTnefReader);
    destructor Destroy; override;

    function ReadBytes(ALength: Integer): TBytes; overload;
    procedure ReadBytes(ADestination: TStream; ALength: Integer); overload;
    function ReadStringValue: string;
    function ReadBytesValue: TBytes;

    function NextValue: Boolean;
    function NextProperty: Boolean;

    property PropertyTag: TTnefPropertyTag read FPropertyTag;
    property PropertyName: TTnefPropertyName read FPropertyName;
    property ValueLength: Integer read FValueLength;
    property ValueCount: Integer read FValueCount;
  end;

implementation

{ TTnefPropertyReader }

constructor TTnefPropertyReader.Create(AReader: TTnefReader);
begin
  inherited Create();

  FReader := AReader;
  FPropertyCount := -1;
  FPropertyIndex := 0;
  FValueIndex := 0;
  FValueCount := -1;
  FValueLength := 0;
  FPropertyValueStart := 0;
  FPropertyTag := nil;
  FPropertyName := nil;
end;

function TTnefPropertyReader.DecodeAnsiString(const ABytes: TBytes): string;
var
  len: Integer;
  enc: TEncoding;
begin
  len := Length(ABytes);

  while (len > 0) and (ABytes[len - 1] = 0) do
  begin
    Dec(len);
  end;

  if (len = 0) then
  begin
    Result := '';
  end else
  begin
    enc := FReader.GetEncoding();
    try
      Result := enc.GetString(ABytes, 0, len);
    finally
      enc.Free();
    end;
  end;
end;

function TTnefPropertyReader.DecodeUnicodeString(const ABytes: TBytes): string;
var
  len: Integer;
begin
  len := Length(ABytes);

  len := len and (not 1);

  while (len > 1) and (ABytes[len - 1] = 0) and (ABytes[len - 2] = 0) do
  begin
    Dec(len, 2);
  end;

  if (len < 2) then
  begin
    Result := '';
  end else
  begin
    Result := TEncoding.Unicode.GetString(ABytes, 0, len);
  end;
end;

destructor TTnefPropertyReader.Destroy;
begin
  FPropertyName.Free();
  FPropertyTag.Free();
  inherited Destroy();
end;

function TTnefPropertyReader.GetValueCount: Integer;
  function GetArrayValueCount: Integer;
  begin
    Result := FReader.ReadInt32();
    UpdatePropertyValueStart();
  end;

begin
  if (PropertyTag.IsMultiValued) then
  begin
    Result := GetArrayValueCount();
    Exit;
  end;

  case (PropertyTag.PropertyType) of
    ptUnicode: Result := GetArrayValueCount();
    ptString8: Result := GetArrayValueCount();
    ptBinary: Result := GetArrayValueCount();
    ptObject: Result := GetArrayValueCount();
  else
    Result := 1;
  end;
end;

function TTnefPropertyReader.GetValueLength: Integer;
  function GetArrayLength: Integer;
  var
    len: Integer;
  begin
    len := FReader.ReadInt32();
    UpdatePropertyValueStart();
    Result := (len + 3) and (not 3);
  end;

begin
  case (PropertyTag.PropertyType) of
    ptUnspecified: Result := 0;
    ptNull: Result := 0;
    ptBoolean: Result := 4;
    ptError: Result := 4;
    ptLong: Result := 4;
    ptR4: Result := 4;
    ptI2: Result := 4;
    ptCurrency: Result := 8;
    ptDouble: Result := 8;
    ptI8: Result := 8;
    ptClassId: Result := 16;
    ptUnicode: Result := GetArrayLength();
    ptString8: Result := GetArrayLength();
    ptBinary: Result := GetArrayLength();
    ptObject: Result := GetArrayLength();
    ptAppTime: Result := 8;
    ptSysTime: Result := 8;
  else
    raise Exception.Create('Invalid Property Type');
  end;
end;

function TTnefPropertyReader.NextProperty: Boolean;
begin
  ValidateNextPropertyPos();

  if (FPropertyCount < 0) then
  begin
    FPropertyCount := FReader.ReadInt32();
    if (FPropertyCount < 0) then
    begin
      raise Exception.Create('Invalid Property Count');
    end;
  end;

  if (FPropertyIndex >= FPropertyCount) then
  begin
    FReader.ValidateChecksum();
    Result := False;
    Exit;
  end;

  FValueCount := -1;
  FValueIndex := 0;
  FValueLength := 0;

  ReadPropertyTag();

  ReadPropertyName();

  UpdatePropertyValueStart();

  Inc(FPropertyIndex);

  Result := True;
end;

function TTnefPropertyReader.NextValue: Boolean;
begin
  if (ValueCount < 0) then
  begin
    FValueCount := GetValueCount();
  end;

  if (FValueIndex >= ValueCount) then
  begin
    Result := False;
    Exit;
  end;

  FValueLength := GetValueLength();

  Inc(FValueIndex);

  Result := True;
end;

function TTnefPropertyReader.ReadByteArray(ALength: Integer): TBytes;
var
  padding: Integer;
begin
  Result := FReader.ReadBytes(ALength);

  if ((ALength mod 4) <> 0) then
  begin
    padding := 4 - (ALength mod 4);

    if (padding > 0) then
    begin
      FReader.ReadBytes(padding);
    end;
  end;
end;

function TTnefPropertyReader.ReadAnsiString: string;
var
  bytes: TBytes;
begin
  bytes := ReadByteArray();
  Result := DecodeAnsiString(bytes);
end;

function TTnefPropertyReader.ReadByteArray: TBytes;
begin
  Result := ReadByteArray(ValueLength);
end;

procedure TTnefPropertyReader.ReadBytes(ADestination: TStream; ALength: Integer);
begin
  FReader.ReadBytes(ADestination, ALength);
end;

function TTnefPropertyReader.ReadBytesValue: TBytes;
begin
  case (PropertyTag.PropertyType) of
    ptUnicode: Result := ReadByteArray();
    ptString8: Result := ReadByteArray();
    ptBinary: Result := ReadByteArray();
    ptObject: Result := ReadByteArray();
    ptClassId: Result := ReadBytes(16);
  else
    raise Exception.Create('Invalid property value');
  end;
end;

procedure TTnefPropertyReader.ReadPropertyName;
var
  guid: TGUID;
  kind: TTnefNameIdKind;
  id, len: Integer;
  bytes: TBytes;
  name: string;
begin
  FreeAndNil(FPropertyName);

  if (not PropertyTag.IsNamed) then Exit;

  guid := TGUID.Create(FReader.ReadBytes(16));

  kind := GetTnefNameIdKind(FReader.ReadInt32());

  if (kind = ikName) then
  begin
    len := FReader.ReadInt32();
    bytes := ReadByteArray(len);
    name := DecodeUnicodeString(bytes);

    FPropertyName := TTnefPropertyName.Create(ikName, name, guid, 0);
  end else
  if (kind = ikId) then
  begin
    id := FReader.ReadInt32();

    FPropertyName := TTnefPropertyName.Create(ikId, '', guid, id);
  end else
  begin
    raise Exception.Create('Invalid NameId');
  end;
end;

procedure TTnefPropertyReader.ReadPropertyTag;
var
  propertyType, propertyId: Integer;
begin
  propertyType := FReader.ReadInt16();
  propertyId := FReader.ReadInt16();

  FreeAndNil(FPropertyTag);
  FPropertyTag := TTnefPropertyTag.Create(propertyType, propertyId);
end;

function TTnefPropertyReader.ReadStringValue: string;
begin
  case (PropertyTag.PropertyType) of
    ptUnicode: Result := ReadUnicodeString();
    ptString8: Result := ReadAnsiString();
    ptBinary: Result := ReadAnsiString();
  else
    raise Exception.Create('Invalid property value');
  end;
end;

function TTnefPropertyReader.ReadUnicodeString: string;
var
  bytes: TBytes;
begin
  bytes := ReadByteArray();
  Result := DecodeUnicodeString(bytes);
end;

procedure TTnefPropertyReader.UpdatePropertyValueStart;
begin
  FPropertyValueStart := FReader.RawReadPosition;
end;

procedure TTnefPropertyReader.ValidateNextPropertyPos;
var
  nextPropertyPos: Int64;
begin
  if (FPropertyValueStart = 0) then Exit;

  while(NextValue()) do
  begin
    nextPropertyPos := FPropertyValueStart + ValueLength;

    if (nextPropertyPos > FReader.RawReadPosition) then
    begin
      FReader.ReadBytes(ValueLength);
    end else
    if (nextPropertyPos < FReader.RawReadPosition) then
    begin
      raise Exception.Create('The property was read incorrectly');
    end;
  end;
end;

function TTnefPropertyReader.ReadBytes(ALength: Integer): TBytes;
begin
  Result := FReader.ReadBytes(ALength);
end;

end.
