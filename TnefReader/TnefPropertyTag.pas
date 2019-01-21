unit TnefPropertyTag;

interface

uses
  TnefPropertyConsts;

type
  TTnefPropertyTag = class
  private
    FId: TTnefPropertyId;
    FPropertyType: TTnefPropertyType;

    function GetIsMultiValued: Boolean;
    function GetIsNamed: Boolean;
  public
    constructor Create(APropertyType: TTnefPropertyType; AId: TTnefPropertyId);

    property IsNamed: Boolean read GetIsNamed;
    property IsMultiValued: Boolean read GetIsMultiValued;
    property PropertyType: TTnefPropertyType read FPropertyType;
    property Id: TTnefPropertyId read FId;
  end;

implementation

{ TTnefPropertyTag }

constructor TTnefPropertyTag.Create(APropertyType: TTnefPropertyType; AId: TTnefPropertyId);
begin
  inherited Create();

  FPropertyType := APropertyType;
  FId := AId;
end;

function TTnefPropertyTag.GetIsMultiValued: Boolean;
begin
  Result := (TnefPropertyTypes[PropertyType] and TnefPropertyTypes[ptMultiValued]) <> 0;
end;

function TTnefPropertyTag.GetIsNamed: Boolean;
const
  NamedMinId: Integer = $8000;
  NamedMaxId: Integer = $FFFE;
var
  propId: Integer;
begin
  propId := Integer(TnefPropertyIds[Id]);
  Result := (propId >= NamedMinId) and (propId <= NamedMaxId);
end;

end.
