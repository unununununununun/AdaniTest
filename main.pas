unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts,Windows,Messages, FMX.StdCtrls, FMX.Effects,
  FMX.Ani, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.Viewport3D, FMX.Controls.Presentation, FMX.ListBox, FMX.TreeView, FMX.Edit,
  System.Threading,IOUtils, FMX.Colors;

type
  TMForm = class(TForm)
    topl: TLayout;
    toplr: TRectangle;
    mlayout: TLayout;
    sgrip: TSizeGrip;
    MRect: TRectangle;
    GE: TGlowEffect;
    startAnim: TFloatAnimation;
    logoLayout: TLayout;
    logoImg: TImage;
    logoImg0: TImage;
    logoxanim: TFloatAnimation;
    logo0xanim: TFloatAnimation;
    toplanim: TFloatAnimation;
    closeBtn: TImage;
    canim: TColorAnimation;
    blure: TBlurEffect;
    MRectLayout: TLayout;
    editPath: TEdit;
    FolderBttn: TButton;
    Image1: TImage;
    splitLine: TLine;
    runBttn: TButton;
    runInfoLabel: TLabel;
    runRect: TRectangle;
    progressLine: TLine;
    findAnim: TFloatAnimation;
    procedure toplrMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure startAnimProcess(Sender: TObject);
    procedure FormActivate(Sender: TObject);

    procedure startAnimFinish(Sender: TObject);
    procedure logoxanimFinish(Sender: TObject);
    procedure logo0xanimFinish(Sender: TObject);
    procedure toplanimProcess(Sender: TObject);
    procedure toplanimFinish(Sender: TObject);
    procedure closeBtnMouseEnter(Sender: TObject);
    procedure closeBtnMouseLeave(Sender: TObject);
    procedure closeBtnClick(Sender: TObject);
    procedure FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure FolderBttnClick(Sender: TObject);
    procedure sgripKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MForm: TMForm;
  Files,Dirs : TArray<System.string>;

implementation

{$R *.fmx}

procedure TMForm.closeBtnClick(Sender: TObject);
begin
Close;
end;

{$REGION '�������� ������ �������� ����'}
procedure TMForm.closeBtnMouseEnter(Sender: TObject);
begin
 TImage(Sender).Opacity:= 0.5;
end;

procedure TMForm.closeBtnMouseLeave(Sender: TObject);
begin
 TImage(Sender).Opacity:= 1.0;
end;
{$ENDREGION}


procedure TMForm.FolderBttnClick(Sender: TObject);
var path:string;
begin



 SelectDirectory('Select folder', path, path);

 editPath.Text := path;
 editPath.Enabled := true;
 MRectLayout.Visible:=  true;

 Files := TDirectory.GetFiles(path, '*.*', TSearchOption.soAllDirectories);
 Dirs  := TDirectory.GetDirectories(path,'*.*',  TSearchOption.soAllDirectories);
 runInfoLabel.Text := length(Files).ToString + ' files and ' + length(Dirs).ToString + 'folders found';

end;

procedure TMForm.FormActivate(Sender: TObject);
begin

 MRectLayout.Visible:= false;
 blure.Enabled := true;
 logoLayout.Visible := true;
 topl.Height := 0.01;
 //mlayout.Opacity := 0;
 logoImg.Position.X := -400;
 logoImg0.Position.X := 750;

 findAnim.StopValue := splitLine.Width-progressLine.Width; // ������� ��������� ������� ����� ��� �������� ������ ������


end;

procedure TMForm.FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
begin
blure.UpdateParentEffects;
end;

procedure TMForm.logo0xanimFinish(Sender: TObject);
begin
toplanim.Enabled := true;
end;

procedure TMForm.logoxanimFinish(Sender: TObject);
begin
logo0xanim.Enabled := true;
end;

procedure TMForm.sgripKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  findAnim.StopValue := splitLine.Width-progressLine.Width;
end;

procedure TMForm.startAnimFinish(Sender: TObject);
begin

mlayout.Enabled := true;
mlayout.Opacity := 1;
logoxanim.Enabled := true;
end;

procedure TMForm.startAnimProcess(Sender: TObject);
begin
GE.UpdateParentEffects;
end;

procedure TMForm.toplanimFinish(Sender: TObject);
begin
     MRectLayout.Visible:=true;
     topl.Height := 25;
 TTask.Run
 (
  procedure
  begin
   while true do
   begin
     MRectLayout.Visible:=true;
     topl.Height := 25;
     sleep(20);
   end;
  end
 );


end;

procedure TMForm.toplanimProcess(Sender: TObject);
begin
 sgrip.Opacity := sgrip.Opacity + 0.05;
 logoLayout.Opacity := logoLayout.Opacity - 0.1;
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
