unit TnefPropertyName;

interface

type
  TTnefNameIdKind = (ikId, ikName);

  TTnefPropertyName = class
  private
    FName: string;
    FId: Integer;
    FKind: TTnefNameIdKind;
    FGuid: TGUID;
  public
    constructor Create(AKind: TTnefNameIdKind; const AName: string; AGuid: TGUID; AId: Integer);

    property Kind: TTnefNameIdKind read FKind;
    property Name: string read FName;
    property Guid: TGUID read FGuid;
    property Id: Integer read FId;
  end;

function GetTnefNameIdKind(AKind: Integer): TTnefNameIdKind;

implementation

function GetTnefNameIdKind(AKind: Integer): TTnefNameIdKind;
const
  ids: array[0..1] of TTnefNameIdKind = (ikId, ikName);
begin
  Result := ids[AKind];
end;

{ TTnefPropertyName }

constructor TTnefPropertyName.Create(AKind: TTnefNameIdKind; const AName: string; AGuid: TGUID; AId: Integer);
begin
  inherited Create();

  FKind := AKind;
  FName := AName;
  FGuid := AGuid;
  FId := AId;
end;

end.
