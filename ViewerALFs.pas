unit ViewerALFs;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  LUX,
  LUX.NALFs;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TViewerALFsFrame = class( TFrame )
     private
     protected
       _BMP   :TBitmap;
       _NALFs :TNALFs;   upNALFs:Boolean;
       ///// A C C E S S O R
       procedure OnUpALFs( Sender:TObject );
       function GetALFs :TNALFs;
       procedure SetALFs( const ALFs_:TNALFs );
       ///// M E T H O D
       procedure Paint; override;
       procedure DrawNALFs;
     public
       constructor Create( Owner_:TComponent ); override;
       destructor Destroy; override;
       ///// P R O P E R T Y
       property NALFs :TNALFs read GetALFs write SetALFs;
     end;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math, System.Threading,
     LUX.D2, LUX.Color;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TViewerALFsFrame

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

procedure TViewerALFsFrame.OnUpALFs( Sender:TObject );
begin
     upNALFs := True;  Repaint;
end;

function TViewerALFsFrame.GetALFs :TNALFs;
begin
     Result := _NALFs;
end;

procedure TViewerALFsFrame.SetALFs( const ALFs_:TNALFs );
begin
     if _NALFs = ALFs_ then Exit;

     if Assigned( _NALFs ) then _NALFs.OnChange.Del( OnUpALFs );

     _NALFs := ALFs_;

     if Assigned( _NALFs ) then _NALFs.OnChange.Add( OnUpALFs );

     OnUpALFs( Self );
end;

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TViewerALFsFrame.Paint;
begin
     inherited;

     if not Assigned( _NALFs ) then Exit;

     if upNALFs then
     begin
          upNALFs := False;

          DrawNALFs;
     end;

     Canvas.DrawBitmap( _BMP, TRectF.Create( 0, 0, _BMP.Width, _BMP.Height ), LocalRect, 1, True );
end;

//------------------------------------------------------------------------------

procedure TViewerALFsFrame.DrawNALFs;
var
   D :TBitmapData;
begin
     _BMP.SetSize( NALFs.DegN+1, NALFs.DegN+1 );
     _BMP.Map( TMapAccess.Write, D );

     NALFs[ 0, 0 ];  // 遅延評価を実行
     TParallel.For( 0, NALFs.DegN, procedure ( N:Integer )
     var
        P :PAlphaColor;
        M :Integer;
        C :TAlphaColorF;
     begin
          P := D.GetScanline( N );

          for M := 0 to N do
          begin
               C.R := Clamp( 0.5 + NALFs[ N, M ] / 4, 0, 1 );
               C.G := C.R;
               C.B := C.R;
               C.A := 1;

               P^ := C.ToAlphaColor;  Inc( P );
          end;
     end );

     _BMP.Unmap( D );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TViewerALFsFrame.Create( Owner_:TComponent );
begin
     inherited;

     _BMP := TBitmap.Create;
end;

destructor TViewerALFsFrame.Destroy;
begin
     _BMP.Free;

     inherited;
end;

end. //######################################################################### ■
