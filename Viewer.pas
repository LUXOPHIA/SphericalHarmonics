unit Viewer;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Viewport3D,
  LUX,
  LUX.D4x4,
  LUX.FMX.Graphics.D3,
  LUX.Sphere.FMX,
  LUX.SH.Diff,
  LUX.SH.FMX.Graphics.D3;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TViewerFrame = class( TFrame )
       Viewport3D1: TViewport3D;
       procedure Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
       procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
       procedure Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
     private
       _MouseS :TShiftState;
       _MouseP :TPointF;
     protected
       _World3D  :TF3DWorld;
       _Camera3D :TCamera3D;
       _Light3DX :TLight3D;
       _Light3DY :TLight3D;
       _Light3DZ :TLight3D;
       _SPHarm3D :TSPHarmonics3D;
       ///// A C C E S S O R
       function GetSPHarm :TdSPHarmonics;
       procedure SetSPHarm( const SPHarm_:TdSPHarmonics );
       function GetN :Integer;
       procedure SetN( const N_:Integer );
       function GetM :Integer;
       procedure SetM( const M_:Integer );
     public
       constructor Create( Owner_:TComponent ); override;
       destructor Destroy; override;
       ///// P R O P E R T Y
       property SPHarm :TdSPHarmonics read GetSPHarm write SetSPHarm;
       property N      :Integer       read GetN           write SetN          ;
       property M      :Integer       read GetM           write SetM          ;
     end;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TViewerFrame

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

function TViewerFrame.GetSPHarm :TdSPHarmonics;
begin
     Result := _SPHarm3D.SPHarm;
end;

procedure TViewerFrame.SetSPHarm( const SPHarm_:TdSPHarmonics );
begin
     _SPHarm3D.SPHarm := SPHarm_;
end;

//------------------------------------------------------------------------------

function TViewerFrame.GetN :Integer;
begin
     Result := _SPHarm3D.N;
end;

procedure TViewerFrame.SetN( const N_:Integer );
begin
     _SPHarm3D.N := N_;
end;

function TViewerFrame.GetM :Integer;
begin
     Result := _SPHarm3D.M;
end;

procedure TViewerFrame.SetM( const M_:Integer );
begin
     _SPHarm3D.M := M_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TViewerFrame.Create( Owner_:TComponent );
var
   M :TSingleM4;
begin
     inherited;

     _World3D := TF3DWorld.Create( Viewport3D1 );

     _Camera3D := TCamera3D.Create( _World3D );

     Viewport3D1.Camera := _Camera3D.Camera;

     _Light3DX := TLight3D.Create( _Camera3D );
     _Light3DY := TLight3D.Create( _Camera3D );
     _Light3DZ := TLight3D.Create( _Camera3D );

     _Light3DX.Color := TAlphaColorF.Create( 1.0, 0.0, 0.0 ).ToAlphaColor;
     _Light3DY.Color := TAlphaColorF.Create( 0.0, 1.0, 0.0 ).ToAlphaColor;
     _Light3DZ.Color := TAlphaColorF.Create( 0.0, 0.0, 1.0 ).ToAlphaColor;

     M := TSingleM4.RotateX( ArcTan( 1/Sqrt(2) ) );
     _Light3DX.Pose := M * TSingleM4.RotateX( DegToRad( +90 ) );
     _Light3DY.Pose := M * TSingleM4.RotateY( DegToRad( -135 ) );
     _Light3DZ.Pose := M * TSingleM4.RotateY( DegToRad( +135 ) );

     _SPHarm3D := TSPHarmonics3D.Create( _World3D );
end;

destructor TViewerFrame.Destroy;
begin

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TViewerFrame.Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := Shift;
     _MouseP := TPointF.Create( X, Y );
end;

procedure TViewerFrame.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
   P :TPointF;
begin
     if ssLeft in _MouseS then
     begin
          P := TPointF.Create( X, Y );

          with _Camera3D do
          begin
               AngleX := AngleX - DegToRad( P.X - _MouseP.X );
               AngleY := AngleY + DegToRad( P.Y - _MouseP.Y );
          end;

          _MouseP := P;
     end;
end;

procedure TViewerFrame.Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     Viewport3D1MouseMove( Sender, Shift, X, Y );

     _MouseS := [];
end;

end. //######################################################################### ■
