unit TnefAttributeConsts;

interface

uses
  System.SysUtils;

type
  TTnefAttributeLevel = (
    alMessage,
    alAttachment
  );

  TTnefAttributeType = (
    atTriples,
    atString,
    atText,
    atDate,
    atShort,
    atLong,
    atByte,
    atWord,
    atDWord,
    atMax
  );

  TTnefAttributeTag = (
    agNull,
    agOwner,
    agSentFor,
    agDelegate,
    agOriginalMessageClass,
    agDateStart,
    agDateEnd,
    agAidOwner,
    agRequestResponse,
    agFrom,
    agSubject,
    agDateSent,
    agDateReceived,
    agMessageStatus,
    agMessageClass,
    agMessageId,
    agParentId,
    agConversationId,
    agBody,
    agPriority,
    agAttachData,
    agAttachTitle,
    agAttachMetaFile,
    agAttachCreateDate,
    agAttachModifyDate,
    agDateModified,
    agAttachTransportFilename,
    agAttachRenderData,
    agMapiProperties,
    agRecipientTable,
    agAttachment,
    agTnefVersion,
    agOemCodepage
  );

const
  TnefAttributeLevels: array[TTnefAttributeLevel] of Integer = (
    1, //alMessage
    2  //alAttachment
  );

  TnefAttributeTypes: array[TTnefAttributeType] of Integer = (
    $00000000, //atTriples
    $00010000, //atString
    $00020000, //atText
    $00030000, //atDate
    $00040000, //atShort
    $00050000, //atLong
    $00060000, //atByte
    $00070000, //atWord
    $00080000, //atDWord
    $00090000  //atMax
  );

  TnefAttributeTags: array[TTnefAttributeTag] of Integer = (
    $00000000, //agNull
    $00060000, //agOwner
    $00060001, //agSentFor
    $00060002, //agDelegate
    $00070006, //agOriginalMessageClass
    $00030006, //agDateStart
    $00030007, //agDateEnd
    $00050008, //agAidOwner
    $00040009, //agRequestResponse
    $00008000, //agFrom
    $00018004, //agSubject
    $00038005, //agDateSent
    $00038006, //agDateReceived
    $00068007, //agMessageStatus
    $00078008, //agMessageClass
    $00018009, //agMessageId
    $0001800A, //agParentId
    $0001800B, //agConversationId
    $0002800C, //agBody
    $0004800D, //agPriority
    $0006800F, //agAttachData
    $00018010, //agAttachTitle
    $00068011, //agAttachMetaFile
    $00038012, //agAttachCreateDate
    $00038013, //agAttachModifyDate
    $00038020, //agDateModified
    $00069001, //agAttachTransportFilename
    $00069002, //agAttachRenderData
    $00069003, //agMapiProperties
    $00069004, //agRecipientTable
    $00069005, //agAttachment
    $00089006, //agTnefVersion
    $00069007  //agOemCodepage
  );

function GetTnefAttributeLevel(ALevel: Integer): TTnefAttributeLevel;
function GetTnefAttributeType(AType: Integer): TTnefAttributeType;
function GetTnefAttributeTag(ATag: Integer): TTnefAttributeTag;

implementation

function GetTnefAttributeLevel(ALevel: Integer): TTnefAttributeLevel;
var
  i: TTnefAttributeLevel;
begin
  for i := Low(TTnefAttributeLevel) to High(TTnefAttributeLevel) do
  begin
    if (TnefAttributeLevels[i] = ALevel) then
    begin
      Exit(i);
    end;
  end;

  raise Exception.Create('Invalid attribute level');
end;

function GetTnefAttributeType(AType: Integer): TTnefAttributeType;
var
  i: TTnefAttributeType;
begin
  for i := Low(TTnefAttributeType) to High(TTnefAttributeType) do
  begin
    if (TnefAttributeTypes[i] = AType) then
    begin
      Exit(i);
    end;
  end;

  raise Exception.Create('Invalid attribute type');
end;

function GetTnefAttributeTag(ATag: Integer): TTnefAttributeTag;
var
  i: TTnefAttributeTag;
begin
  for i := Low(TTnefAttributeTag) to High(TTnefAttributeTag) do
  begin
    if (TnefAttributeTags[i] = ATag) then
    begin
      Exit(i);
    end;
  end;

  Exit(agNull);
end;

end.
