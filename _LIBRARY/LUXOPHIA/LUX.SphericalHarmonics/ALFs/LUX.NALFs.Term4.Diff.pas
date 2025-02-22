﻿unit LUX.NALFs.Term4.Diff;

interface //#################################################################### ■

uses LUX,
     LUX.D1.Diff,
     LUX.D1.Legendre.Diff,
     LUX.NALFs.Diff;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdNALFsTerm4

     TdNALFsTerm4 = class( TdCacheNALFs )
     private
     protected
       upALPs:Boolean;
       ///// A C C E S S O R
       procedure SetDegN( const DegN_:Integer ); override;
       procedure SetX( const X_:TdDouble ); override;
       function GetPs( const N_,M_:Integer ) :TdDouble; override;
       ///// M E T H O D
       procedure CalcALPs;
       function PN0( const N_:Integer ) :TdDouble;
       function PN1( const N_:Integer ) :TdDouble;
       function PNM22( const N_,M_:Integer; const P00_,P02_,P20_:TdDouble ) :TdDouble;
     public
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdNALFsTerm4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

procedure TdNALFsTerm4.SetDegN( const DegN_:Integer );
begin
     inherited;

     upALPs := True;
end;

//------------------------------------------------------------------------------

procedure TdNALFsTerm4.SetX( const X_:TdDouble );
begin
     inherited;

     upALPs := True;
end;

//------------------------------------------------------------------------------

function TdNALFsTerm4.GetPs( const N_,M_:Integer ) :TdDouble;
begin
     if N_ < M_ then Exit( 0 );

     if upALPs then
     begin
          upALPs := False;

          CalcALPs;
     end;

     Result := _NPs[ N_, M_ ];
end;

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TdNALFsTerm4.CalcALPs;
var
   N, M :Integer;
   P00, P02, P20, P22 :TdDouble;
begin
     ///// M = 0
     for N := 0 to DegN do _NPs[ N, 0 ] := PN0( N );

     ///// M = 1
     for N := 1 to DegN do _NPs[ N, 1 ] := PN1( N );

     ///// 2 <= M
     for M := 2 to DegN do
     for N := M to DegN do
     begin
          P00:= Ps[ N-2, M-2 ];  P02 := Ps[ N-2, M   ];
          P20:= Ps[ N  , M-2 ];  P22 := PNM22( N, M, P00, P02, P20 );

          _NPs[ N, M ] := P22;
     end;
end;

//------------------------------------------------------------------------------

function TdNALFsTerm4.PN0( const N_:Integer ) :TdDouble;
begin
     Result := NLegendre( X, N_ );
end;

//------------------------------------------------------------------------------

function TdNALFsTerm4.PN1( const N_:Integer ) :TdDouble;
begin
     Result := dNLegendreCos( ArcCos( X ), N_ ) / Sqrt( N_ * ( N_ + 1 ) );
end;

//------------------------------------------------------------------------------

//      0     1     2   M
//  0 [P00]--P01--[P02]
//      |     |     |
//  1  P10---P11---P12
//      |     |     |
//  2 [P20]--P21--[P22]
//  N

function TdNALFsTerm4.PNM22( const N_,M_:Integer; const P00_,P02_,P20_:TdDouble ) :TdDouble;
var
   N2, NM0, NM1,
   A00, A02, A20 :Double;
begin
     N2  := N_ * 2 ;
     NM0 := N_ - M_;
     NM1 := N_ + M_;

     A00 := Roo2( ( ( N2 + 1 ) * ( NM1 - 3 ) * ( NM1 - 2 ) )
                / ( ( N2 - 3 ) * ( NM1 - 1 ) * ( NM1     ) ) );
     A02 := Roo2( ( ( N2 + 1 ) * ( NM0 - 1 ) * ( NM0     ) )
                / ( ( N2 - 3 ) * ( NM1 - 1 ) * ( NM1     ) ) );
     A20 := Roo2( (              ( NM0 + 1 ) * ( NM0 + 2 ) )
                / (              ( NM1 - 1 ) * ( NM1     ) ) );

     Result := A00 * P00_ + A02 * P02_ - A20 * P20_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■