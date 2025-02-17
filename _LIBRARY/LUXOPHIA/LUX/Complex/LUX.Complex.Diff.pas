﻿unit LUX.Complex.Diff;

interface //#################################################################### ■

uses LUX,
     LUX.D1,
     LUX.D1.Diff,
     LUX.Complex;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdSingleC

     TdSingleC = record
     private
       ///// A C C E S S O R
       class function GetImaginary :TdSingleC; static;
       //--------
       function Geto :TSingleC;
       procedure Seto( const o_:TSingleC );
       function Getd :TSingleC;
       procedure Setd( const d_:TSingleC );
       function GetSiz2 :TdSingle;
       function GetSize :TdSingle;
       procedure SetSize( const Size_:TdSingle );
       function GetUnitor :TdSingleC;
       procedure SetUnitor( const Unitor_:TdSingleC );
       function GetConj :TdSingleC;
       procedure SetConj( const Conj_:TdSingleC );
       function GetAngle :TdSingle;
     public
       R :TdSingle;
       I :TdSingle;
       /////
       constructor Create( const R_:TdSingle ); overload;
       constructor Create( const R_,I_:TdSingle ); overload;
       ///// P R O P E R T Y
       class property Imaginary :TdSingleC read GetImaginary;
       //--------
       property o      :TSingleC  read Geto      write Seto     ;
       property d      :TSingleC  read Getd      write Setd     ;
       property Siz2   :TdSingle  read GetSiz2                  ;
       property Size   :TdSingle  read GetSize   write SetSize  ;
       property Unitor :TdSingleC read GetUnitor write SetUnitor;
       property Conj   :TdSingleC read GetConj   write SetConj  ;
       property Angle  :TdSingle  read GetAngle                 ;
       ///// O P E R A T O R
       class operator Negative( const V_:TdSingleC ) :TdSingleC;
       class operator Positive( const V_:TdSingleC ) :TdSingleC;
       class operator Add( const A_,B_:TdSingleC ) :TdSingleC;
       class operator Subtract( const A_,B_:TdSingleC ) :TdSingleC;
       class operator Multiply( const A_,B_:TdSingleC ) :TdSingleC;
       class operator Multiply( const A_:TdSingleC; const B_:TdSingle ) :TdSingleC;
       class operator Multiply( const A_:TdSingle; const B_:TdSingleC ) :TdSingleC;
       class operator Divide( const A_,B_:TdSingleC ) :TdSingleC;
       class operator Divide( const A_:TdSingleC; const B_:TdSingle ) :TdSingleC;
       ///// C A S T
       class operator Implicit( const V_:Single ) :TdSingleC;
       class operator Implicit( const V_:TdSingle ) :TdSingleC;
       class operator Implicit( const V_:TSingleC ) :TdSingleC;
       ///// M E T H O D
       class function RandG( const SD_:Single = 1 ) :TdSingleC; overload; static;
       class function RandG( const SD_:TSingleC ) :TdSingleC; overload; static;
       class function RandBS1 :TdSingleC; static;
       class function RandBS2 :TdSingleC; static;
       class function RandBS4 :TdSingleC; static;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdDoubleC

     TdDoubleC = record
     private
       ///// A C C E S S O R
       class function GetImaginary :TdDoubleC; static;
       //--------
       function Geto :TDoubleC;
       procedure Seto( const o_:TDoubleC );
       function Getd :TDoubleC;
       procedure Setd( const d_:TDoubleC );
       function GetSiz2 :TdDouble;
       function GetSize :TdDouble;
       procedure SetSize( const Size_:TdDouble );
       function GetUnitor :TdDoubleC;
       procedure SetUnitor( const Unitor_:TdDoubleC );
       function GetConj :TdDoubleC;
       procedure SetConj( const Conj_:TdDoubleC );
       function GetAngle :TdDouble;
     public
       R :TdDouble;
       I :TdDouble;
       /////
       constructor Create( const R_:TdDouble ); overload;
       constructor Create( const R_,I_:TdDouble ); overload;
       ///// P R O P E R T Y
       class property Imaginary :TdDoubleC read GetImaginary;
       //--------
       property o      :TDoubleC  read Geto      write Seto     ;
       property d      :TDoubleC  read Getd      write Setd     ;
       property Siz2   :TdDouble  read GetSiz2                  ;
       property Size   :TdDouble  read GetSize   write SetSize  ;
       property Unitor :TdDoubleC read GetUnitor write SetUnitor;
       property Conj   :TdDoubleC read GetConj   write SetConj  ;
       property Angle  :TdDouble  read GetAngle                 ;
       ///// O P E R A T O R
       class operator Negative( const V_:TdDoubleC ) :TdDoubleC;
       class operator Positive( const V_:TdDoubleC ) :TdDoubleC;
       class operator Add( const A_,B_:TdDoubleC ) :TdDoubleC;
       class operator Subtract( const A_,B_:TdDoubleC ) :TdDoubleC;
       class operator Multiply( const A_,B_:TdDoubleC ) :TdDoubleC;
       class operator Multiply( const A_:TdDoubleC; const B_:TdDouble ) :TdDoubleC;
       class operator Multiply( const A_:TdDouble; const B_:TdDoubleC ) :TdDoubleC;
       class operator Divide( const A_,B_:TdDoubleC ) :TdDoubleC;
       class operator Divide( const A_:TdDoubleC; const B_:TdDouble ) :TdDoubleC;
       ///// C A S T
       class operator Implicit( const V_:Double ) :TdDoubleC;
       class operator Implicit( const V_:TdDouble ) :TdDoubleC;
       class operator Implicit( const V_:TdSingleC ) :TdDoubleC;
       class operator Explicit( const V_:TdDoubleC ) :TdSingleC;
       ///// M E T H O D
       class function RandG( const SD_:Double = 1 ) :TdDoubleC; overload; static;
       class function RandG( const SD_:TDoubleC ) :TdDoubleC; overload; static;
       class function RandBS1 :TdDoubleC; static;
       class function RandBS2 :TdDoubleC; static;
       class function RandBS4 :TdDoubleC; static;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdSingleAreaC

     TdSingleAreaC = record
     private
       ///// A C C E S S O R
       function GetCenter :TdSingleC;
       procedure SetCenter( const Center_:TdSingleC );
       function GetCenterR :TdSingle;
       procedure SetCenterR( const CenterR_:TdSingle );
       function GetCenterI :TdSingle;
       procedure SetCenterI( const CenterI_:TdSingle );
       function GetSizeR :TdSingle;
       procedure SetSizeR( const SizeR_:TdSingle );
       function GetSizeI :TdSingle;
       procedure SetSizeI( const SizeI_:TdSingle );
     public
       Min :TdSingleC;
       Max :TdSingleC;
       /////
       constructor Create( const Min_,Max_:TdSingleC ); overload;
       constructor Create( const MinR_,MinI_,MaxR_,MaxI_:TdSingle ); overload;
       ///// P R O P E R T Y
       property Center  :TdSingleC read GetCenter  write SetCenter ;
       property CenterR :TdSingle   read GetCenterR write SetCenterR;
       property CenterI :TdSingle   read GetCenterI write SetCenterI;
       property SizeR   :TdSingle   read GetSizeR   write SetSizeR  ;
       property SizeI   :TdSingle   read GetSizeI   write SetSizeI  ;
       ///// O P E R A T O R
       class operator Negative( const V_:TdSingleAreaC ) :TdSingleAreaC;
       class operator Positive( const V_:TdSingleAreaC ) :TdSingleAreaC;
       class operator Add( const A_,B_:TdSingleAreaC ) :TdSingleAreaC;
       class operator Subtract( const A_,B_:TdSingleAreaC ) :TdSingleAreaC;
       class operator Multiply( const A_:TdSingleAreaC; const B_:TdSingle ) :TdSingleAreaC;
       class operator Multiply( const A_:TdSingle; const B_:TdSingleAreaC ) :TdSingleAreaC;
       class operator Divide( const A_:TdSingleAreaC; const B_:TdSingle ) :TdSingleAreaC;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdDoubleAreaC

     TdDoubleAreaC = record
     private
       ///// A C C E S S O R
       function GetCenter :TdDoubleC;
       procedure SetCenter( const Center_:TdDoubleC );
       function GetCenterR :TdDouble;
       procedure SetCenterR( const CenterR_:TdDouble );
       function GetCenterI :TdDouble;
       procedure SetCenterI( const CenterI_:TdDouble );
       function GetSizeR :TdDouble;
       procedure SetSizeR( const SizeR_:TdDouble );
       function GetSizeI :TdDouble;
       procedure SetSizeI( const SizeI_:TdDouble );
     public
       Min :TdDoubleC;
       Max :TdDoubleC;
       /////
       constructor Create( const Min_,Max_:TdDoubleC ); overload;
       constructor Create( const MinR_,MinI_,MaxR_,MaxI_:TdDouble ); overload;
       ///// P R O P E R T Y
       property Center  :TdDoubleC read GetCenter  write SetCenter ;
       property CenterR :TdDouble   read GetCenterR write SetCenterR;
       property CenterI :TdDouble   read GetCenterI write SetCenterI;
       property SizeR   :TdDouble   read GetSizeR   write SetSizeR  ;
       property SizeI   :TdDouble   read GetSizeI   write SetSizeI  ;
       ///// O P E R A T O R
       class operator Negative( const V_:TdDoubleAreaC ) :TdDoubleAreaC;
       class operator Positive( const V_:TdDoubleAreaC ) :TdDoubleAreaC;
       class operator Add( const A_,B_:TdDoubleAreaC ) :TdDoubleAreaC;
       class operator Subtract( const A_,B_:TdDoubleAreaC ) :TdDoubleAreaC;
       class operator Multiply( const A_:TdDoubleAreaC; const B_:TdDouble ) :TdDoubleAreaC;
       class operator Multiply( const A_:TdDouble; const B_:TdDoubleAreaC ) :TdDoubleAreaC;
       class operator Divide( const A_:TdDoubleAreaC; const B_:TdDouble ) :TdDoubleAreaC;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Pow

function Pow( const X_:TdSingleC; const N_:TdSingle ) :TdSingleC; overload;
function Pow( const X_:TdDoubleC; const N_:TdDouble ) :TdDoubleC; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Roo2

function Roo2( const X_:TdSingleC ) :TdSingleC; overload;
function Roo2( const X_:TdDoubleC ) :TdDoubleC; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cos

function Cos( const A_:TdSingleC ) :TdSingleC; overload;
function Cos( const A_:TdDoubleC ) :TdDoubleC; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sin

function Sin( const A_:TdSingleC ) :TdSingleC; overload;
function Sin( const A_:TdDoubleC ) :TdDoubleC; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Tan

function Tan( const A_:TdSingleC ) :TdSingleC; overload;
function Tan( const A_:TdDoubleC ) :TdDoubleC; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Exp

function Exp( const A_:TdSingleC ) :TdSingleC; overload;
function Exp( const A_:TdDoubleC ) :TdDoubleC; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ln

function Ln( const A_:TdSingleC ) :TdSingleC; overload;
function Ln( const A_:TdDoubleC ) :TdDoubleC; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ArcCos

function ArcCos( const X_:TdSingleC ) :TdSingleC; overload;
function ArcCos( const X_:TdDoubleC ) :TdDoubleC; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ArcSin

function ArcSin( const X_:TdSingleC ) :TdSingleC; overload;
function ArcSin( const X_:TdDoubleC ) :TdDoubleC; overload;

implementation //############################################################### ■

uses System.Math;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdSingleC

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////// A C C E S S O R

class function TdSingleC.GetImaginary :TdSingleC;
begin
     Result.R := 0;
     Result.I := 1;
end;

//------------------------------------------------------------------------------

function TdSingleC.Geto :TSingleC;
begin
     Result.R := R.o;
     Result.I := I.o;
end;

procedure TdSingleC.Seto( const o_:TSingleC );
begin
     R.o := o_.R;
     I.o := o_.I;
end;

function TdSingleC.Getd :TSingleC;
begin
     Result.R := R.d;
     Result.I := I.d;
end;

procedure TdSingleC.Setd( const d_:TSingleC );
begin
     R.d := d_.R;
     I.d := d_.I;
end;

//------------------------------------------------------------------------------

function TdSingleC.GetSiz2 :TdSingle;
begin
     Result := Pow2( R ) + Pow2( I );
end;

function TdSingleC.GetSize :TdSingle;
begin
     Result := Roo2( GetSiz2 );
end;

procedure TdSingleC.SetSize( const Size_:TdSingle );
begin
     Self := Size_ * Unitor;
end;

function TdSingleC.GetUnitor :TdSingleC;
begin
     Result := Self / Size;
end;

procedure TdSingleC.SetUnitor( const Unitor_:TdSingleC );
begin
     Self := Size * Unitor_;
end;

function TdSingleC.GetConj :TdSingleC;
begin
     Result.R := +R;
     Result.I := -I;
end;

procedure TdSingleC.SetConj( const Conj_:TdSingleC );
begin
     R := +Conj_.R;
     I := -Conj_.I;
end;

function TdSingleC.GetAngle :TdSingle;
begin
     Result := ArcTan2( I, R );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TdSingleC.Create( const R_:TdSingle );
begin
     R := R_;
     I := 0 ;
end;

constructor TdSingleC.Create( const R_,I_:TdSingle );
begin
     R := R_;
     I := I_;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TdSingleC.Negative( const V_:TdSingleC ) :TdSingleC;
begin
     with Result do
     begin
          R := -V_.R;
          I := -V_.I;
     end;
end;

class operator TdSingleC.Positive( const V_:TdSingleC ) :TdSingleC;
begin
     with Result do
     begin
          R := +V_.R;
          I := +V_.I;
     end;
end;

class operator TdSingleC.Add( const A_,B_:TdSingleC ) :TdSingleC;
begin
     with Result do
     begin
          R := A_.R + B_.R;
          I := A_.I + B_.I;
     end;
end;

class operator TdSingleC.Subtract( const A_,B_:TdSingleC ) :TdSingleC;
begin
     with Result do
     begin
          R := A_.R - B_.R;
          I := A_.I - B_.I;
     end;
end;

class operator TdSingleC.Multiply( const A_,B_:TdSingleC ) :TdSingleC;
begin
     with Result do
     begin
          R := A_.R * B_.R - A_.I * B_.I;
          I := A_.R * B_.I + A_.I * B_.R;
     end;
end;

class operator TdSingleC.Multiply( const A_:TdSingleC; const B_:TdSingle ) :TdSingleC;
begin
     with Result do
     begin
          R := A_.R * B_;
          I := A_.I * B_;
     end;
end;

class operator TdSingleC.Multiply( const A_:TdSingle; const B_:TdSingleC ) :TdSingleC;
begin
     with Result do
     begin
          R := A_ * B_.R;
          I := A_ * B_.I;
     end;
end;

class operator TdSingleC.Divide( const A_,B_:TdSingleC ) :TdSingleC;
var
   C :TdSingle;
begin
     C := B_.Siz2;

     with Result do
     begin
          R := ( A_.R * B_.R + A_.I * B_.I ) / C;
          I := ( A_.I * B_.R - A_.R * B_.I ) / C;
     end;
end;

class operator TdSingleC.Divide( const A_:TdSingleC; const B_:TdSingle ) :TdSingleC;
begin
     with Result do
     begin
          R := A_.R / B_;
          I := A_.I / B_;
     end;
end;

//////////////////////////////////////////////////////////////////////// C A S T

class operator TdSingleC.Implicit( const V_:Single ) :TdSingleC;
begin
     with Result do
     begin
          R := V_;
          I := 0;
     end;
end;

class operator TdSingleC.Implicit( const V_:TdSingle ) :TdSingleC;
begin
     with Result do
     begin
          R := V_;
          I := 0;
     end;
end;

class operator TdSingleC.Implicit( const V_:TSingleC ) :TdSingleC;
begin
     with Result do
     begin
          o := V_;
          d := 0;
     end;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

class function TdSingleC.RandG( const SD_:Single = 1 ) :TdSingleC;
begin
     with Result do
     begin
          R := System.Math.RandG( 0, SD_ );
          I := System.Math.RandG( 0, SD_ );
     end;
end;

class function TdSingleC.RandG( const SD_:TSingleC ) :TdSingleC;
begin
     with Result do
     begin
          R := System.Math.RandG( 0, SD_.R );
          I := System.Math.RandG( 0, SD_.I );
     end;
end;

//------------------------------------------------------------------------------

class function TdSingleC.RandBS1 :TdSingleC;
begin
     with Result do
     begin
          R := TdSingle.RandBS1;
          I := TdSingle.RandBS1;
     end;
end;

class function TdSingleC.RandBS2 :TdSingleC;
begin
     with Result do
     begin
          R := TdSingle.RandBS2;
          I := TdSingle.RandBS2;
     end;
end;

class function TdSingleC.RandBS4 :TdSingleC;
begin
     with Result do
     begin
          R := TdSingle.RandBS4;
          I := TdSingle.RandBS4;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdDoubleC

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////// A C C E S S O R

class function TdDoubleC.GetImaginary :TdDoubleC;
begin
     Result.R := 0;
     Result.I := 1;
end;

//------------------------------------------------------------------------------

function TdDoubleC.Geto :TDoubleC;
begin
     Result.R := R.o;
     Result.I := I.o;
end;

procedure TdDoubleC.Seto( const o_:TDoubleC );
begin
     R.o := o_.R;
     I.o := o_.I;
end;

function TdDoubleC.Getd :TDoubleC;
begin
     Result.R := R.d;
     Result.I := I.d;
end;

procedure TdDoubleC.Setd( const d_:TDoubleC );
begin
     R.d := d_.R;
     I.d := d_.I;
end;

//------------------------------------------------------------------------------

function TdDoubleC.GetSiz2 :TdDouble;
begin
     Result := Pow2( R ) + Pow2( I );
end;

function TdDoubleC.GetSize :TdDouble;
begin
     Result := Roo2( GetSiz2 );
end;

procedure TdDoubleC.SetSize( const Size_:TdDouble );
begin
     Self := Size_ * Unitor;
end;

function TdDoubleC.GetUnitor :TdDoubleC;
begin
     Result := Self / Size;
end;

procedure TdDoubleC.SetUnitor( const Unitor_:TdDoubleC );
begin
     Self := Size * Unitor_;
end;

function TdDoubleC.GetConj :TdDoubleC;
begin
     Result.R := +R;
     Result.I := -I;
end;

procedure TdDoubleC.SetConj( const Conj_:TdDoubleC );
begin
     R := +Conj_.R;
     I := -Conj_.I;
end;

function TdDoubleC.GetAngle :TdDouble;
begin
     Result := ArcTan2( I, R );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TdDoubleC.Create( const R_:TdDouble );
begin
     R := R_;
     I := 0 ;
end;

constructor TdDoubleC.Create( const R_,I_:TdDouble );
begin
     R := R_;
     I := I_;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TdDoubleC.Negative( const V_:TdDoubleC ) :TdDoubleC;
begin
     with Result do
     begin
          R := -V_.R;
          I := -V_.I;
     end;
end;

class operator TdDoubleC.Positive( const V_:TdDoubleC ) :TdDoubleC;
begin
     with Result do
     begin
          R := +V_.R;
          I := +V_.I;
     end;
end;

class operator TdDoubleC.Add( const A_,B_:TdDoubleC ) :TdDoubleC;
begin
     with Result do
     begin
          R := A_.R + B_.R;
          I := A_.I + B_.I;
     end;
end;

class operator TdDoubleC.Subtract( const A_,B_:TdDoubleC ) :TdDoubleC;
begin
     with Result do
     begin
          R := A_.R - B_.R;
          I := A_.I - B_.I;
     end;
end;

class operator TdDoubleC.Multiply( const A_,B_:TdDoubleC ) :TdDoubleC;
begin
     with Result do
     begin
          R := A_.R * B_.R - A_.I * B_.I;
          I := A_.R * B_.I + A_.I * B_.R;
     end;
end;

class operator TdDoubleC.Multiply( const A_:TdDoubleC; const B_:TdDouble ) :TdDoubleC;
begin
     with Result do
     begin
          R := A_.R * B_;
          I := A_.I * B_;
     end;
end;

class operator TdDoubleC.Multiply( const A_:TdDouble; const B_:TdDoubleC ) :TdDoubleC;
begin
     with Result do
     begin
          R := A_ * B_.R;
          I := A_ * B_.I;
     end;
end;

class operator TdDoubleC.Divide( const A_,B_:TdDoubleC ) :TdDoubleC;
var
   C :TdDouble;
begin
     C := B_.Siz2;

     with Result do
     begin
          R := ( A_.R * B_.R + A_.I * B_.I ) / C;
          I := ( A_.I * B_.R - A_.R * B_.I ) / C;
     end;
end;

class operator TdDoubleC.Divide( const A_:TdDoubleC; const B_:TdDouble ) :TdDoubleC;
begin
     with Result do
     begin
          R := A_.R / B_;
          I := A_.I / B_;
     end;
end;

//////////////////////////////////////////////////////////////////////// C A S T

class operator TdDoubleC.Implicit( const V_:Double ) :TdDoubleC;
begin
     with Result do
     begin
          R := V_;
          I := 0;
     end;
end;

class operator TdDoubleC.Implicit( const V_:TdDouble ) :TdDoubleC;
begin
     with Result do
     begin
          R := V_;
          I := 0;
     end;
end;

class operator TdDoubleC.Implicit( const V_:TdSingleC ) :TdDoubleC;
begin
     with Result do
     begin
          R := V_.R;
          I := V_.I;
     end;
end;

class operator TdDoubleC.Explicit( const V_:TdDoubleC ) :TdSingleC;
begin
     with Result do
     begin
          R := TdSingle( V_.R );
          I := TdSingle( V_.I );
     end;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

class function TdDoubleC.RandG( const SD_:Double = 1 ) :TdDoubleC;
begin
     with Result do
     begin
          R := TdDouble.RandG( SD_ );
          I := TdDouble.RandG( SD_ );
     end;
end;

class function TdDoubleC.RandG( const SD_:TDoubleC ) :TdDoubleC;
begin
     with Result do
     begin
          R := TdDouble.RandG( SD_.R );
          I := TdDouble.RandG( SD_.I );
     end;
end;

//------------------------------------------------------------------------------

class function TdDoubleC.RandBS1 :TdDoubleC;
begin
     with Result do
     begin
          R := TdDouble.RandBS1;
          I := TdDouble.RandBS1;
     end;
end;

class function TdDoubleC.RandBS2 :TdDoubleC;
begin
     with Result do
     begin
          R := TdDouble.RandBS2;
          I := TdDouble.RandBS2;
     end;
end;

class function TdDoubleC.RandBS4 :TdDoubleC;
begin
     with Result do
     begin
          R := TdDouble.RandBS4;
          I := TdDouble.RandBS4;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdSingleAreaC

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////// A C C E S S O R

function TdSingleAreaC.GetCenter :TdSingleC;
begin
     Result := ( Max + Min ) / 2;
end;

procedure TdSingleAreaC.SetCenter( const Center_:TdSingleC );
begin
     with Center_ do
     begin
          CenterR := R;
          CenterI := I;
     end;
end;

function TdSingleAreaC.GetCenterR :TdSingle;
begin
     Result := ( Max.R + Min.R ) / 2;
end;

procedure TdSingleAreaC.SetCenterR( const CenterR_:TdSingle );
var
   S :TdSingle;
begin
     S := SizeR / 2;

     Min.R := CenterR_ - S;
     Max.R := CenterR_ + S;
end;

function TdSingleAreaC.GetCenterI :TdSingle;
begin
     Result := ( Max.I + Min.I ) / 2;
end;

procedure TdSingleAreaC.SetCenterI( const CenterI_:TdSingle );
var
   S :TdSingle;
begin
     S := SizeI / 2;

     Min.I := CenterI_ - S;
     Max.I := CenterI_ + S;
end;

function TdSingleAreaC.GetSizeR :TdSingle;
begin
     Result := Max.R - Min.R;
end;

procedure TdSingleAreaC.SetSizeR( const SizeR_:TdSingle );
var
   C, S :TdSingle;
begin
     C := CenterR;
     S := SizeR_ / 2;

     Min.R := C - S;
     Max.R := C + S;
end;

function TdSingleAreaC.GetSizeI :TdSingle;
begin
     Result := Max.I - Min.I;
end;

procedure TdSingleAreaC.SetSizeI( const SizeI_:TdSingle );
var
   C, S :TdSingle;
begin
     C := CenterI;
     S := SizeI_ / 2;

     Min.I := C - S;
     Max.I := C + S;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TdSingleAreaC.Create( const Min_,Max_:TdSingleC );
begin
     Min := Min_;
     Max := Max_;
end;

constructor TdSingleAreaC.Create( const MinR_,MinI_,MaxR_,MaxI_:TdSingle );
begin
     with Min do
     begin
          R := MinR_;
          I := MinI_;
     end;
     with Max do
     begin
          R := MaxR_;
          I := MaxI_;
     end;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TdSingleAreaC.Negative( const V_:TdSingleAreaC ) :TdSingleAreaC;
begin
     with Result do
     begin
          Min := -V_.Min;
          Max := -V_.Max;
     end;
end;

class operator TdSingleAreaC.Positive( const V_:TdSingleAreaC ) :TdSingleAreaC;
begin
     with Result do
     begin
          Min := +V_.Min;
          Max := +V_.Max;
     end;
end;

class operator TdSingleAreaC.Add( const A_,B_:TdSingleAreaC ) :TdSingleAreaC;
begin
     with Result do
     begin
          Min := A_.Min + B_.Min;
          Max := A_.Max + B_.Max;
     end;
end;

class operator TdSingleAreaC.Subtract( const A_,B_:TdSingleAreaC ) :TdSingleAreaC;
begin
     with Result do
     begin
          Min := A_.Min - B_.Min;
          Max := A_.Max - B_.Max;
     end;
end;

class operator TdSingleAreaC.Multiply( const A_:TdSingleAreaC; const B_:TdSingle ) :TdSingleAreaC;
begin
     with Result do
     begin
          Min := A_.Min * B_;
          Max := A_.Max * B_;
     end;
end;

class operator TdSingleAreaC.Multiply( const A_:TdSingle; const B_:TdSingleAreaC ) :TdSingleAreaC;
begin
     with Result do
     begin
          Min := A_ * B_.Min;
          Max := A_ * B_.Max;
     end;
end;

class operator TdSingleAreaC.Divide( const A_:TdSingleAreaC; const B_:TdSingle ) :TdSingleAreaC;
begin
     with Result do
     begin
          Min := A_.Min / B_;
          Max := A_.Max / B_;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdDoubleAreaC

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////// A C C E S S O R

function TdDoubleAreaC.GetCenter :TdDoubleC;
begin
     Result := ( Max + Min ) / 2;
end;

procedure TdDoubleAreaC.SetCenter( const Center_:TdDoubleC );
begin
     with Center_ do
     begin
          CenterR := R;
          CenterI := I;
     end;
end;

function TdDoubleAreaC.GetCenterR :TdDouble;
begin
     Result := ( Max.R + Min.R ) / 2;
end;

procedure TdDoubleAreaC.SetCenterR( const CenterR_:TdDouble );
var
   S :TdDouble;
begin
     S := SizeR / 2;

     Min.R := CenterR_ - S;
     Max.R := CenterR_ + S;
end;

function TdDoubleAreaC.GetCenterI :TdDouble;
begin
     Result := ( Max.I + Min.I ) / 2;
end;

procedure TdDoubleAreaC.SetCenterI( const CenterI_:TdDouble );
var
   S :TdDouble;
begin
     S := SizeI / 2;

     Min.I := CenterI_ - S;
     Max.I := CenterI_ + S;
end;

function TdDoubleAreaC.GetSizeR :TdDouble;
begin
     Result := Max.R - Min.R;
end;

procedure TdDoubleAreaC.SetSizeR( const SizeR_:TdDouble );
var
   C, S :TdDouble;
begin
     C := CenterR;
     S := SizeR_ / 2;

     Min.R := C - S;
     Max.R := C + S;
end;

function TdDoubleAreaC.GetSizeI :TdDouble;
begin
     Result := Max.I - Min.I;
end;

procedure TdDoubleAreaC.SetSizeI( const SizeI_:TdDouble );
var
   C, S :TdDouble;
begin
     C := CenterI;
     S := SizeI_ / 2;

     Min.I := C - S;
     Max.I := C + S;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TdDoubleAreaC.Create( const Min_,Max_:TdDoubleC );
begin
     Min := Min_;
     Max := Max_;
end;

constructor TdDoubleAreaC.Create( const MinR_,MinI_,MaxR_,MaxI_:TdDouble );
begin
     with Min do
     begin
          R := MinR_;
          I := MinI_;
     end;
     with Max do
     begin
          R := MaxR_;
          I := MaxI_;
     end;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TdDoubleAreaC.Negative( const V_:TdDoubleAreaC ) :TdDoubleAreaC;
begin
     with Result do
     begin
          Min := -V_.Min;
          Max := -V_.Max;
     end;
end;

class operator TdDoubleAreaC.Positive( const V_:TdDoubleAreaC ) :TdDoubleAreaC;
begin
     with Result do
     begin
          Min := +V_.Min;
          Max := +V_.Max;
     end;
end;

class operator TdDoubleAreaC.Add( const A_,B_:TdDoubleAreaC ) :TdDoubleAreaC;
begin
     with Result do
     begin
          Min := A_.Min + B_.Min;
          Max := A_.Max + B_.Max;
     end;
end;

class operator TdDoubleAreaC.Subtract( const A_,B_:TdDoubleAreaC ) :TdDoubleAreaC;
begin
     with Result do
     begin
          Min := A_.Min - B_.Min;
          Max := A_.Max - B_.Max;
     end;
end;

class operator TdDoubleAreaC.Multiply( const A_:TdDoubleAreaC; const B_:TdDouble ) :TdDoubleAreaC;
begin
     with Result do
     begin
          Min := A_.Min * B_;
          Max := A_.Max * B_;
     end;
end;

class operator TdDoubleAreaC.Multiply( const A_:TdDouble; const B_:TdDoubleAreaC ) :TdDoubleAreaC;
begin
     with Result do
     begin
          Min := A_ * B_.Min;
          Max := A_ * B_.Max;
     end;
end;

class operator TdDoubleAreaC.Divide( const A_:TdDoubleAreaC; const B_:TdDouble ) :TdDoubleAreaC;
begin
     with Result do
     begin
          Min := A_.Min / B_;
          Max := A_.Max / B_;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Pow

function Pow( const X_:TdSingleC; const N_:TdSingle ) :TdSingleC;
var
   S, A :TdSingle;
begin
     S := Power( X_.Size, N_ );
     A := X_.Angle * N_;

     Result.R := S * Cos( A );
     Result.I := S * Sin( A );
end;

function Pow( const X_:TdDoubleC; const N_:TdDouble ) :TdDoubleC;
var
   S, A :TdDouble;
begin
     S := Power( X_.Size, N_ );
     A := X_.Angle * N_;

     Result.R := S * Cos( A );
     Result.I := S * Sin( A );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Roo2

function Roo2( const X_:TdSingleC ) :TdSingleC;
var
   S, A :TdSingle;
begin
     S := Roo2( X_.Size );
     A := X_.Angle / 2;

     Result.R := S * Cos( A );
     Result.I := S * Sin( A );
end;

function Roo2( const X_:TdDoubleC ) :TdDoubleC;
var
   S, A :TdDouble;
begin
     S := Roo2( X_.Size );
     A := X_.Angle / 2;

     Result.R := S * Cos( A );
     Result.I := S * Sin( A );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cos

function Cos( const A_:TdSingleC ) :TdSingleC;
begin
     with A_ do
     begin
          Result.R := +Cos( R ) * Cosh( I );
          Result.I := -Sin( R ) * Sinh( I );
     end;
end;

function Cos( const A_:TdDoubleC ) :TdDoubleC;
begin
     with A_ do
     begin
          Result.R := +Cos( R ) * Cosh( I );
          Result.I := -Sin( R ) * Sinh( I );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sin

function Sin( const A_:TdSingleC ) :TdSingleC;
begin
     with A_ do
     begin
          Result.R := +Sin( R ) * Cosh( I );
          Result.I := +Cos( R ) * Sinh( I );
     end;
end;

function Sin( const A_:TdDoubleC ) :TdDoubleC;
begin
     with A_ do
     begin
          Result.R := +Sin( R ) * Cosh( I );
          Result.I := +Cos( R ) * Sinh( I );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Tan

function Tan( const A_:TdSingleC ) :TdSingleC;
begin
     Result := Sin( A_ ) / Cos( A_ );
end;

function Tan( const A_:TdDoubleC ) :TdDoubleC;
begin
     Result := Sin( A_ ) / Cos( A_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Exp

function Exp( const A_:TdSingleC ) :TdSingleC;
var
   E :TdSingle;
begin
     with A_ do
     begin
          E := Exp( R );

          Result.R := E * Cos( I );
          Result.I := E * Sin( I );
     end;
end;

function Exp( const A_:TdDoubleC ) :TdDoubleC;
var
   E :TdDouble;
begin
     with A_ do
     begin
          E := Exp( R );

          Result.R := E * Cos( I );
          Result.I := E * Sin( I );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ln

function Ln( const A_:TdSingleC ) :TdSingleC;
begin
     with A_ do
     begin
          Result.R := Ln( Size );
          Result.I := Angle;
     end;
end;

function Ln( const A_:TdDoubleC ) :TdDoubleC;
begin
     with A_ do
     begin
          Result.R := Ln( Size );
          Result.I := Angle;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ArcCos

function ArcCos( const X_:TdSingleC ) :TdSingleC;
begin
     Result := +TdSingleC.Imaginary * Ln( X_ + TdSingleC.Imaginary * Roo2( 1 - X_ * X_ ) );
end;

function ArcCos( const X_:TdDoubleC ) :TdDoubleC;
begin
     Result := +TdDoubleC.Imaginary * Ln( X_ + TdDoubleC.Imaginary * Roo2( 1 - X_ * X_ ) );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ArcSin

function ArcSin( const X_:TdSingleC ) :TdSingleC;
begin
     Result := -TdSingleC.Imaginary * Ln( TdSingleC.Imaginary * X_ + Roo2( 1 - X_ * X_ ) );
end;

function ArcSin( const X_:TdDoubleC ) :TdDoubleC;
begin
     Result := -TdDoubleC.Imaginary * Ln( TdDoubleC.Imaginary * X_ + Roo2( 1 - X_ * X_ ) );
end;

end. //######################################################################### ■
