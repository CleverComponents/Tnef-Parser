unit TnefAttribute;

interface

uses
  System.Classes, TnefReader, TnefPropertyReader;

type
  TTnefAttribute = class
  private
    FReader: TTnefReader;
  protected
    constructor Create(AReader: TTnefReader);
  public
    procedure Load; virtual; abstract;

    property Reader: TTnefReader read FReader;
  end;

  TTnefVersionAttribute = class(TTnefAttribute)
  private
    FTnefVersion: Integer;
  public
    constructor Create(AReader: TTnefReader);
    procedure Load; override;
    property TnefVersion: Integer read FTnefVersion;
  end;

  TTnefOemCodePageAttribute = class(TTnefAttribute)
  private
    FOemCodePage: Integer;
  public
    constructor Create(AReader: TTnefReader);
    procedure Load; override;
    property OemCodePage: Integer read FOemCodePage;
  end;

  TAttachTitleAttribute = class(TTnefAttribute)
  private
    FTitle: string;
  public
    constructor Create(AReader: TTnefReader);
    procedure Load; override;
    property Title: string read FTitle;
  end;

  TAttachmentAttribute = class(TTnefAttribute)
  private
    FPropertyReader: TTnefPropertyReader;
  public
    constructor Create(AReader: TTnefReader);
    destructor Destroy; override;

    procedure Load; override;
    property PropertyReader: TTnefPropertyReader read FPropertyReader;
  end;

  TAttachDataAttribute = class(TTnefAttribute)
  private
    FContent: TStream;
  public
    constructor Create(AReader: TTnefReader; AContent: TStream);
    procedure Load; override;
    property Content: TStream read FContent;
  end;

  TMapiPropertiesAttribute = class(TTnefAttribute)
  private
    FPropertyReader: TTnefPropertyReader;
  public
    constructor Create(AReader: TTnefReader);
    destructor Destroy; override;

    procedure Load; override;
    property PropertyReader: TTnefPropertyReader read FPropertyReader;
  end;

implementation

{ TTnefAttribute }

constructor TTnefAttribute.Create(AReader: TTnefReader);
begin
  inherited Create();

  FReader := AReader;
end;

{ TTnefVersionAttribute }

constructor TTnefVersionAttribute.Create(AReader: TTnefReader);
begin
  inherited Create(AReader);
end;

procedure TTnefVersionAttribute.Load;
begin
  FTnefVersion := Reader.ReadInt32();
  Reader.ValidateChecksum();
end;

{ TTnefOemCodePageAttribute }

constructor TTnefOemCodePageAttribute.Create(AReader: TTnefReader);
begin
  inherited Create(AReader);
end;

procedure TTnefOemCodePageAttribute.Load;
begin
  FOemCodePage := Reader.ReadInt32();
  Reader.ReadInt32();
  Reader.ValidateChecksum();
end;

{ TAttachTitleAttribute }

constructor TAttachTitleAttribute.Create(AReader: TTnefReader);
begin
  inherited Create(AReader);
end;

procedure TAttachTitleAttribute.Load;
begin
  FTitle := Reader.ReadString();
  Reader.ValidateChecksum();
end;

{ TAttachmentAttribute }

constructor TAttachmentAttribute.Create(AReader: TTnefReader);
begin
  inherited Create(AReader);
  FPropertyReader := TTnefPropertyReader.Create(AReader);
end;

destructor TAttachmentAttribute.Destroy;
begin
  FPropertyReader.Free();
  inherited Destroy();
end;

procedure TAttachmentAttribute.Load;
begin
end;

{ TAttachDataAttribute }

constructor TAttachDataAttribute.Create(AReader: TTnefReader; AContent: TStream);
begin
  inherited Create(AReader);
  FContent := AContent;
end;

procedure TAttachDataAttribute.Load;
begin
  Reader.ReadBytes(Content, Reader.AttributeLength);
end;

{ TMapiPropertiesAttribute }

constructor TMapiPropertiesAttribute.Create(AReader: TTnefReader);
begin
  inherited Create(AReader);
  FPropertyReader := TTnefPropertyReader.Create(AReader);
end;

destructor TMapiPropertiesAttribute.Destroy;
begin
  FPropertyReader.Free();
  inherited Destroy();
end;

procedure TMapiPropertiesAttribute.Load;
begin
end;

end.
