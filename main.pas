unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts,Windows,Messages, FMX.StdCtrls, FMX.Effects,
  FMX.Ani, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.Viewport3D;

type
  TMForm = class(TForm)
    topl: TLayout;
    toplr: TRectangle;
    mlayout: TLayout;
    sgrip: TSizeGrip;
    Rectangle1: TRectangle;
    GE: TGlowEffect;
    startAnim: TFloatAnimation;
    logoLayout: TLayout;
    logoImg: TImage;
    logoImg0: TImage;
    logoxanim: TFloatAnimation;
    logo0xanim: TFloatAnimation;
    procedure toplrMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure startAnimProcess(Sender: TObject);
    procedure FormActivate(Sender: TObject);

    procedure startAnimFinish(Sender: TObject);
    procedure logoxanimProcess(Sender: TObject);
    procedure logoxanimFinish(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MForm: TMForm;

implementation

{$R *.fmx}

procedure TMForm.FormActivate(Sender: TObject);
begin
 mlayout.Opacity := 0;
 logoImg.Position.X := -400;
 logoImg0.Position.X := 750;
end;

procedure TMForm.logoxanimFinish(Sender: TObject);
begin
logo0xanim.Enabled := true;
end;

procedure TMForm.logoxanimProcess(Sender: TObject);
begin
logoImg.Repaint();
end;

procedure TMForm.startAnimFinish(Sender: TObject);
begin
logoxanim.Enabled := true;
end;

procedure TMForm.startAnimProcess(Sender: TObject);
begin
GE.UpdateParentEffects;
end;

procedure TMForm.toplrMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
 var
  hw : HWND;
begin
 hw := FindWindow(nil,PChar(MForm.Caption));
 ReleaseCapture;
 SendMessage(hw, WM_SysCommand,61458,0);
end;

end.
