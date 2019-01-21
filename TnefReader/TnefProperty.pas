unit TnefProperty;

interface

uses
  System.Classes, System.SysUtils, TnefPropertyReader;

type
  TTnefProperty = class
  private
    FPropertyReader: TTnefPropertyReader;
  protected
    constructor Create(APropertyReader: TTnefPropertyReader);
  public
    procedure Load; virtual; abstract;

    property PropertyReader: TTnefPropertyReader read FPropertyReader;
  end;

  TAttachDataProperty = class(TTnefProperty)
  private
    FGuid: TGUID;
    FContent: TStream;
  public
    constructor Create(APropertyReader: TTnefPropertyReader; AContent: TStream);
    procedure Load; override;

    property Guid: TGUID read FGuid;
    property Content: TStream read FContent;
  end;

  TAttachStringProperty = class(TTnefProperty)
  private
    FValue: string;
  public
    constructor Create(APropertyReader: TTnefPropertyReader);
    procedure Load; override;

    property Value: string read FValue;
  end;

  TAttachStreamProperty = class(TTnefProperty)
  private
    FContent: TStream;
  public
    constructor Create(APropertyReader: TTnefPropertyReader; AContent: TStream);
    procedure Load; override;

    property Content: TStream read FContent;
  end;

  TMapiRtfCompressedProperty = class(TAttachStreamProperty)
  public
    constructor Create(APropertyReader: TTnefPropertyReader; AContent: TStream);
  end;

implementation

{ TTnefProperty }

constructor TTnefProperty.Create(APropertyReader: TTnefPropertyReader);
begin
  inherited Create();
  FPropertyReader := APropertyReader;
end;

{ TAttachDataProperty }

constructor TAttachDataProperty.Create(APropertyReader: TTnefPropertyReader; AContent: TStream);
begin
  inherited Create(APropertyReader);
  FContent := AContent;
end;

procedure TAttachDataProperty.Load;
begin
  PropertyReader.NextValue();
  FGuid := TGUID.Create(PropertyReader.ReadBytes(16));
  PropertyReader.ReadBytes(Content, PropertyReader.ValueLength - 16);
end;

{ TAttachStringProperty }

constructor TAttachStringProperty.Create(APropertyReader: TTnefPropertyReader);
begin
  inherited Create(APropertyReader);
end;

procedure TAttachStringProperty.Load;
begin
  PropertyReader.NextValue();
  FValue := PropertyReader.ReadStringValue();
end;

{ TAttachStreamProperty }

constructor TAttachStreamProperty.Create(APropertyReader: TTnefPropertyReader; AContent: TStream);
begin
  inherited Create(APropertyReader);
  FContent := AContent;
end;

procedure TAttachStreamProperty.Load;
begin
  PropertyReader.NextValue();
  PropertyReader.ReadBytes(Content, PropertyReader.ValueLength);
end;

{ TMapiRtfCompressedProperty }

constructor TMapiRtfCompressedProperty.Create(APropertyReader: TTnefPropertyReader; AContent: TStream);
begin
  inherited Create(APropertyReader, AContent);
end;

end.
