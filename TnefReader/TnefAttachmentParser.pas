unit TnefAttachmentParser;

interface

uses
  System.Classes, System.SysUtils, Winapi.Windows,
  TnefReader, TnefPropertyReader, TnefAttributeConsts, TnefAttribute, TnefPropertyTag,
  TnefPropertyConsts, TnefProperty;

type
  TAttachmentInfo = class
  private
    FFileName: string;
    FSaveToFileName: string;
    FTitle: string;
    FLongFileName: string;
    FBaseFolder: string;

    function ExtractFileNameWithoutExt(const AFileName: string): string;
    function GetUniqueFileName(const AFileName: string): string;
    function GetActualAttachmentFileName: string;
  protected
    procedure Clear; virtual;
  public
    constructor Create(const ABaseFolder: string);

    function GenerateSaveToFileName(const AFileName: string): string;
    procedure RenameSavedAttachment;

    property BaseFolder: string read FBaseFolder;

    property SaveToFileName: string read FSaveToFileName write FSaveToFileName;
    property LongFileName: string read FLongFileName write FLongFileName;
    property FileName: string read FFileName write FFileName;
    property Title: string read FTitle write FTitle;
  end;

  TTnefAttachmentParser = class
  private
    procedure ParseMapiProperty(APropertyReader: TTnefPropertyReader; AttachmentInfo: TAttachmentInfo);
    procedure ParseMessageLevelAttribute(AReader: TTnefReader; AttachmentInfo: TAttachmentInfo);
    procedure ParseAttachmentProperty(APropertyReader: TTnefPropertyReader; AttachmentInfo: TAttachmentInfo);
    procedure ParseAttachmentLevelAttribute(AReader: TTnefReader; AttachmentInfo: TAttachmentInfo);
  public
    procedure Parse(ASource: TStream; const ADestinationFolder: string);
  end;

implementation

{ TTnefAttachmentParser }

procedure TTnefAttachmentParser.Parse(ASource: TStream; const ADestinationFolder: string);
var
  attachmentInfo: TAttachmentInfo;
  reader: TTnefReader;
  attrLevel: TTnefAttributeLevel;
begin
  attachmentInfo := nil;
  reader := nil;
  try
    attachmentInfo := TAttachmentInfo.Create(ADestinationFolder);
    reader := TTnefReader.Create(ASource);

    while (reader.NextAttribute()) do
    begin
      attrLevel := reader.AttributeLevel;

      if (attrLevel = alMessage) then
      begin
        ParseMessageLevelAttribute(reader, attachmentInfo);
      end else
      if (attrLevel = alAttachment) then
      begin
        ParseAttachmentLevelAttribute(reader, attachmentInfo);
      end;
    end;

    attachmentInfo.RenameSavedAttachment();
  finally
    reader.Free();
    attachmentInfo.Free();
  end;
end;

procedure TTnefAttachmentParser.ParseAttachmentLevelAttribute(
  AReader: TTnefReader; AttachmentInfo: TAttachmentInfo);
var
  attrTag: TTnefAttributeTag;
  attachTitleAttr: TAttachTitleAttribute;
  attachDataAttr: TAttachDataAttribute;
  attachmentAttr: TAttachmentAttribute;
  title: string;
  content: TStream;
  propReader: TTnefPropertyReader;
begin
  attrTag := AReader.AttributeTag;
  case (attrTag) of
    agAttachRenderData: AttachmentInfo.RenameSavedAttachment();
    agAttachTitle:
    begin;
      attachTitleAttr := TAttachTitleAttribute.Create(AReader);
      try
        attachTitleAttr.Load();

        title := attachTitleAttr.Title;

        AttachmentInfo.Title := title;
      finally
        attachTitleAttr.Free();
      end;
    end;
    agAttachData:
    begin
      content := nil;
      attachDataAttr := nil;
      try
        content := TFileStream.Create(AttachmentInfo.GenerateSaveToFileName('Untitled.dat'), fmCreate);
        attachDataAttr := TAttachDataAttribute.Create(AReader, content);

        attachDataAttr.Load();
      finally
        attachDataAttr.Free();
        content.Free();
      end;
    end;
    agAttachMetaFile: ;
    agAttachCreateDate: ;
    agAttachModifyDate: ;
    agAttachTransportFilename: ;
    agAttachment:
    begin
      attachmentAttr := TAttachmentAttribute.Create(AReader);
      try
        attachmentAttr.Load();
        propReader := attachmentAttr.PropertyReader;
        while (propReader.NextProperty()) do
        begin
          ParseAttachmentProperty(propReader, attachmentInfo);
        end;
      finally
        attachmentAttr.Free();
      end;
    end;
  end;
end;

procedure TTnefAttachmentParser.ParseAttachmentProperty(
  APropertyReader: TTnefPropertyReader; AttachmentInfo: TAttachmentInfo);
var
  propTag: TTnefPropertyTag;
  stringProp: TAttachStringProperty;
  dataProp: TAttachDataProperty;
  content: TStream;
begin
  propTag := APropertyReader.PropertyTag;
  case (propTag.Id) of
    piAttachLongFilename:
    begin
      stringProp := TAttachStringProperty.Create(APropertyReader);
      try
        stringProp.Load();
        attachmentInfo.LongFileName := stringProp.Value;
      finally
        stringProp.Free();
      end;
    end;
    piAttachFilename:
    begin
      stringProp := TAttachStringProperty.Create(APropertyReader);
      try
        stringProp.Load();
        attachmentInfo.FileName := stringProp.Value;
      finally
        stringProp.Free();
      end;
    end;
    piAttachContentLocation:
    begin
      stringProp := TAttachStringProperty.Create(APropertyReader);
      try
        stringProp.Load();
        //contentLocation := stringProp.Value;
      finally
        stringProp.Free();
      end;
    end;
    piAttachContentBase:
    begin
      stringProp := TAttachStringProperty.Create(APropertyReader);
      try
        stringProp.Load();
        //contentBase := stringProp.Value;
      finally
        stringProp.Free();
      end;
    end;
    piAttachContentId:
    begin
      stringProp := TAttachStringProperty.Create(APropertyReader);
      try
        stringProp.Load();
        //contentId := stringProp.Value;
      finally
        stringProp.Free();
      end;
    end;
    piAttachDisposition:
    begin
      stringProp := TAttachStringProperty.Create(APropertyReader);
      try
        stringProp.Load();
        //disposition := stringProp.Value;
      finally
        stringProp.Free();
      end;
    end;
    piAttachMimeTag:
    begin
      stringProp := TAttachStringProperty.Create(APropertyReader);
      try
        stringProp.Load();
        //mimeTag := stringProp.Value;
      finally
        stringProp.Free();
      end;
    end;
    piDisplayName:
    begin
      stringProp := TAttachStringProperty.Create(APropertyReader);
      try
        stringProp.Load();
        //displayName := stringProp.Value;
      finally
        stringProp.Free();
      end;
    end;
    piAttachData:
    begin
      content := nil;
      dataProp := nil;
      try
        content := TFileStream.Create(AttachmentInfo.GenerateSaveToFileName('Untitled.dat'), fmCreate);
        dataProp := TAttachDataProperty.Create(APropertyReader, content);

        dataProp.Load();
        //guid := dataProp.Guid;
      finally
        dataProp.Free();
        content.Free();
      end;
    end;
  end;
end;

procedure TTnefAttachmentParser.ParseMapiProperty(
  APropertyReader: TTnefPropertyReader; AttachmentInfo: TAttachmentInfo);
var
  propTag: TTnefPropertyTag;
  content: TStream;
  prop: TTnefProperty;
begin
  propTag := APropertyReader.PropertyTag;
  case (propTag.Id) of
    piRtfCompressed:
    begin
      if (propTag.PropertyType <> ptString8) and
        (propTag.PropertyType <> ptUnicode) and
        (propTag.PropertyType <> ptBinary) then
      begin
        raise Exception.Create('Invalid tnef format for the message body');
      end;

      content := nil;
      prop := nil;
      try
        content := TFileStream.Create(AttachmentInfo.GenerateSaveToFileName('RtfCompressed.dat'), fmCreate);
        prop := TMapiRtfCompressedProperty.Create(APropertyReader, content);

        prop.Load();
      finally
        prop.Free();
        content.Free();
      end;
    end;
    piBodyHtml:
    begin
      if (propTag.PropertyType <> ptString8) and
        (propTag.PropertyType <> ptUnicode) and
        (propTag.PropertyType <> ptBinary) then
      begin
        raise Exception.Create('Invalid tnef format for the message body');
      end;

      content := nil;
      prop := nil;
      try
        content := TFileStream.Create(AttachmentInfo.GenerateSaveToFileName('Body.html'), fmCreate);
        prop := TAttachStreamProperty.Create(APropertyReader, content);

        prop.Load();
      finally
        prop.Free();
        content.Free();
      end;
    end;
    piBody:
    begin
      if (propTag.PropertyType <> ptString8) and
        (propTag.PropertyType <> ptUnicode) and
        (propTag.PropertyType <> ptBinary) then
      begin
        raise Exception.Create('Invalid tnef format for the message body');
      end;

      content := nil;
      prop := nil;
      try
        content := TFileStream.Create(AttachmentInfo.GenerateSaveToFileName('Body.txt'), fmCreate);
        prop := TAttachStreamProperty.Create(APropertyReader, content);

        prop.Load();
      finally
        prop.Free();
        content.Free();
      end;
    end;
  end;
end;

procedure TTnefAttachmentParser.ParseMessageLevelAttribute(AReader: TTnefReader; AttachmentInfo: TAttachmentInfo);
var
  attrTag: TTnefAttributeTag;
  mapiPropsAttr: TMapiPropertiesAttribute;
  propReader: TTnefPropertyReader;
begin
  attrTag := AReader.AttributeTag;
  case (attrTag) of
    agMapiProperties:
    begin
      mapiPropsAttr := TMapiPropertiesAttribute.Create(AReader);
      try
        mapiPropsAttr.Load();
        propReader := mapiPropsAttr.PropertyReader;
        while (propReader.NextProperty()) do
        begin
          ParseMapiProperty(propReader, attachmentInfo);
        end;
      finally
        mapiPropsAttr.Free();
      end;
    end;
  end;
end;

{ TAttachmentInfo }

procedure TAttachmentInfo.Clear;
begin
  SaveToFileName := '';
  LongFileName := '';
  FileName := '';
  Title := '';
end;

constructor TAttachmentInfo.Create(const ABaseFolder: string);
begin
  inherited Create();

  FBaseFolder := ABaseFolder;
  Clear();
end;

function TAttachmentInfo.ExtractFileNameWithoutExt(const AFileName: string): string;
var
  ind: Integer;
begin
  ind := FileName.LastDelimiter('.' + PathDelim + DriveDelim);
  if (ind < Low(string)) or (FileName.Chars[ind] <> '.') then
  begin
    ind := MaxInt;
  end;
  Result := FileName.SubString(0, ind);
end;

function TAttachmentInfo.GenerateSaveToFileName(const AFileName: string): string;
begin
  SaveToFileName := GetUniqueFileName(AFileName);
  Result := SaveToFileName;
end;

function TAttachmentInfo.GetActualAttachmentFileName: string;
begin
  Result := LongFileName;
  if (Result = '') then
  begin
    Result := FileName;
  end;

  if (Result = '') and (Title <> '') then
  begin
    Result := Title + '.dat';
  end;

  if (Result = '') then
  begin
    Result := '';
  end else
  begin
    Result := GetUniqueFileName(Result);
  end;
end;

function TAttachmentInfo.GetUniqueFileName(const AFileName: string): string;
var
  count: Integer;
begin
  Result := BaseFolder + AFileName;

  count := 1;
  while (FileExists(Result)) do
  begin
    Result := BaseFolder + ExtractFileNameWithoutExt(fileName) + IntToStr(count) + ExtractFileExt(fileName);
    Inc(count);
  end;
end;

procedure TAttachmentInfo.RenameSavedAttachment;
var
  newFileName: string;
begin
  if (not FileExists(SaveToFileName)) then Exit;

  newFileName := GetActualAttachmentFileName();

  if (newFileName <> '') then
  begin
    RenameFile(SaveToFileName, newFileName);
  end;

  Clear();
end;

end.
