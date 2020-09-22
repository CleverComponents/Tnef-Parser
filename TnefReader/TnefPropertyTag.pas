unit TnefPropertyTag;

interface

uses
  TnefPropertyConsts;

type
  TTnefPropertyTag = class
  private
    FId: TTnefPropertyId;
    FPropertyType: TTnefPropertyType;
    FRawId: SmallInt;

    function GetIsMultiValued: Boolean;
    function GetIsNamed: Boolean;
  public
    constructor Create(APropertyType, AId: SmallInt);

    property IsNamed: Boolean read GetIsNamed;
    property IsMultiValued: Boolean read GetIsMultiValued;
    property PropertyType: TTnefPropertyType read FPropertyType;
    property Id: TTnefPropertyId read FId;
    property RawId: SmallInt read FRawId;
  end;

implementation

{ TTnefPropertyTag }

constructor TTnefPropertyTag.Create(APropertyType, AId: SmallInt);
begin
  inherited Create();

  FPropertyType := GetTnefPropertyType(APropertyType);
  FId := GetTnefPropertyId(AId);
  FRawId := AId;
end;

function TTnefPropertyTag.GetIsMultiValued: Boolean;
begin
  Result := (TnefPropertyTypes[PropertyType] and TnefPropertyTypes[ptMultiValued]) <> 0;
end;

function TTnefPropertyTag.GetIsNamed: Boolean;
const
  NamedMinId: SmallInt = SmallInt($8000);
  NamedMaxId: SmallInt = SmallInt($FFFE);
var
  propId: Integer;
begin
  propId := Integer(RawId);
  Result := (propId >= NamedMinId) and (propId <= NamedMaxId);
end;

end.
