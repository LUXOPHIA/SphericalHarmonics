﻿unit LUX.S2.Bary.Glerp;

// Glerp :Gnomonic Linear Interpolation

interface //#################################################################### ■

uses LUX.S2,
     LUX.S2.Bary;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TBaryGLerp2S

     TBaryGLerp2S = class( TDoubleBary2S )
     private
     protected
     public
       ///// M E T H O D
       function Center( const Ps_:TArray<TDoubleW2S> ) :TDouble2S; override;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Glerp

function Glerp( const P1_,P2_:TSingle2S ) :TSingle2S; overload;
function Glerp( const P1_,P2_:TDouble2S ) :TDouble2S; overload;

function Glerp( const P1_,P2_:TSingle2S; const T_:Single ) :TSingle2S; overload;
function Glerp( const P1_,P2_:TDouble2S; const T_:Double ) :TDouble2S; overload;

function Glerp( const P1_,P2_:TSingle2S; const W1_,W2_:Single ) :TSingle2S; overload;
function Glerp( const P1_,P2_:TDouble2S; const W1_,W2_:Double ) :TDouble2S; overload;

function Glerp( const P1_,P2_:TSingleW2S ) :TSingleW2S; overload;
function Glerp( const P1_,P2_:TDoubleW2S ) :TDoubleW2S; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GlerpSum

function GlerpSum( const Ps_:TArray<TSingleW2S> ) :TSingleW2S; overload;
function GlerpSum( const Ps_:TArray<TDoubleW2S> ) :TDoubleW2S; overload;

implementation //############################################################### ■

uses LIB.D3;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TBaryGLerp2S

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//////////////////////////////////////////////////////////////////// M E T H O D

function TBaryGLerp2S.Center( const Ps_:TArray<TDoubleW2S> ) :TDouble2S;
var
   P :TDoubleW2S;
begin
     Result := 0;

     for P in Ps_ do Result := Result + P.w * P.v;

     Result := Result.Unitor;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Glerp

function Glerp( const P1_,P2_:TSingle2S ) :TSingle2S;
begin
     Result := Lerp( P1_, P2_ ).Unitor;
end;

function Glerp( const P1_,P2_:TDouble2S ) :TDouble2S;
begin
     Result := Lerp( P1_, P2_ ).Unitor;
end;

//------------------------------------------------------------------------------

function Glerp( const P1_,P2_:TSingle2S; const T_:Single ) :TSingle2S;
begin
     Result := Lerp( P1_, P2_, T_ ).Unitor;
end;

function Glerp( const P1_,P2_:TDouble2S; const T_:Double ) :TDouble2S;
begin
     Result := Lerp( P1_, P2_, T_ ).Unitor;
end;

//------------------------------------------------------------------------------

function Glerp( const P1_,P2_:TSingle2S; const W1_,W2_:Single ) :TSingle2S;
begin
     Result := Lerp( P1_, P2_, W1_, W2_ ).Unitor;
end;

function Glerp( const P1_,P2_:TDouble2S; const W1_,W2_:Double ) :TDouble2S;
begin
     Result := Lerp( P1_, P2_, W1_, W2_ ).Unitor;
end;

//------------------------------------------------------------------------------

function Glerp( const P1_,P2_:TSingleW2S ) :TSingleW2S;
begin
     Result.v := Glerp( P1_.v, P2_.v, P1_.w, P2_.w );
     Result.w := P1_.w + P2_.w;
end;

function Glerp( const P1_,P2_:TDoubleW2S ) :TDoubleW2S;
begin
     Result.v := Glerp( P1_.v, P2_.v, P1_.w, P2_.w );
     Result.w := P1_.w + P2_.w;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GlerpSum

function GlerpSum( const Ps_:TArray<TSingleW2S> ) :TSingleW2S;
var
   P :TSingleW2S;
begin
     Result.v := 0;
     Result.w := 0;
     for P in Ps_ do
     begin
          Result.v := Result.v + P.w * P.v;
          Result.w := Result.w + P.w;
     end;
     Result.v := Result.v / Result.w;
end;

function GlerpSum( const Ps_:TArray<TDoubleW2S> ) :TDoubleW2S;
var
   P :TDoubleW2S;
begin
     Result.v := 0;
     Result.w := 0;
     for P in Ps_ do
     begin
          Result.v := Result.v + P.w * P.v;
          Result.w := Result.w + P.w;
     end;
     Result.v := Result.v / Result.w;
end;

end. //######################################################################### ■