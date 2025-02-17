﻿unit LUX.FNALFs.Diff;

interface //#################################################################### ■

uses LUX,
     LUX.D1.Diff,
     LUX.ALFs.Diff,
     LUX.NALFs.Diff;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdFNALFs :Fully Normalized Associated Legendre functions

     TdFNALFs = class( TdNALFs )
     private
     protected
       ///// A C C E S S O R
       function GetNFs( const N_,M_:Integer ) :TdDouble; override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TALFsToFNALFs

     TdALFsToFNALFs<TdALFs_:TdALFs,constructor> = class( TdNALFs )
     private
     protected
       _dALFs :TdALFs_;
       _NFs   :TArray2<TdDouble>;  upNFs:Boolean;
       ///// A C C E S S O R
       function GetDegN :Integer; override;
       procedure SetDegN( const DegN_:Integer ); override;
       function GetX :TdDouble; override;
       procedure SetX( const X_:TdDouble ); override;
       function GetNFs( const N_,M_:Integer ) :TdDouble; override;
       function GetPs( const N_,M_:Integer ) :TdDouble; override;
       ///// M E T H O D
       procedure InitNFs;
     public
       constructor Create; overload;
       constructor Create( const DegN_:Integer ); overload;
       destructor Destroy; override;
       ///// P R O P E R T Y
       property ALFs :TdALFs_ read _dALFs;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdNALFsToFNALFs<TdNALFs_>

     TdNALFsToFNALFs<TdNALFs_:TdNALFs,constructor> = class( TdFNALFs )
     private
     protected
       _dNALFs :TdNALFs_;
       ///// A C C E S S O R
       function GetDegN :Integer; override;
       procedure SetDegN( const DegN_:Integer ); override;
       function GetX :TdDouble; override;
       procedure SetX( const X_:TdDouble ); override;
       function GetNFs( const N_,M_:Integer ) :TdDouble; override;
       function GetPs( const N_,M_:Integer ) :TdDouble; override;
     public
       constructor Create; overload;
       constructor Create( const DegN_:Integer ); overload;
       destructor Destroy; override;
       ///// P R O P E R T Y
       property dNALFs :TdNALFs_ read _dNALFs;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdFNALFs

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

function TdFNALFs.GetNFs( const N_,M_:Integer ) :TdDouble;
var
   K :TdDouble;
   I :Integer;
begin
     if M_ = 0 then K := 1
               else K := 2;

     Result := Roo2( K * ( 2 * N_ + 1 ) );

     for I := N_ - M_ + 1 to N_ + M_ do Result := Result / Sqrt( I );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdALFsToFNALFs

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

function TdALFsToFNALFs<TdALFs_>.GetDegN :Integer;
begin
     Result := _dALFs.DegN;
end;

procedure TdALFsToFNALFs<TdALFs_>.SetDegN( const DegN_:Integer );
begin
     inherited;

     _dALFs.DegN := DegN_;  upNFs := True;
end;

//------------------------------------------------------------------------------

function TdALFsToFNALFs<TdALFs_>.GetX :TdDouble;
begin
     Result := _dALFs.X;
end;

procedure TdALFsToFNALFs<TdALFs_>.SetX( const X_:TdDouble );
begin
     inherited;

     _dALFs.X := X_;
end;

//------------------------------------------------------------------------------

function TdALFsToFNALFs<TdALFs_>.GetNFs( const N_,M_:Integer ) :TdDouble;
begin
     if upNFs then
     begin
          upNFs := False;

          InitNFs;
     end;

     Result := _NFs[ N_, M_ ];
end;

//------------------------------------------------------------------------------

function TdALFsToFNALFs<TdALFs_>.GetPs( const N_,M_:Integer ) :TdDouble;
begin
     Result := NFs[ N_, M_ ] * _dALFs.Ps[ N_, M_ ];
end;

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TdALFsToFNALFs<TdALFs_>.InitNFs;
var
   N, M :Integer;
begin
     SetLength( _NFs, DegN+1 );
     for N := 0 to DegN do
     begin
          SetLength( _NFs[ N ], N+1 );

          for M := 0 to N do _NFs[ N, M ] := inherited GetNFs( N, M );
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TdALFsToFNALFs<TdALFs_>.Create;
begin
     _dALFs := TdALFs_.Create;

     inherited;
end;

constructor TdALFsToFNALFs<TdALFs_>.Create( const DegN_:Integer );
begin
     _dALFs := TdALFs_.Create;

     inherited;
end;

destructor TdALFsToFNALFs<TdALFs_>.Destroy;
begin
     _dALFs.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdNALFsToFNALFs<TdNALFs_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

function TdNALFsToFNALFs<TdNALFs_>.GetDegN :Integer;
begin
     Result := _dNALFs.DegN;
end;

procedure TdNALFsToFNALFs<TdNALFs_>.SetDegN( const DegN_:Integer );
begin
     inherited;

     _dNALFs.DegN := DegN_;
end;

//------------------------------------------------------------------------------

function TdNALFsToFNALFs<TdNALFs_>.GetX :TdDouble;
begin
     Result := _dNALFs.X;
end;

procedure TdNALFsToFNALFs<TdNALFs_>.SetX( const X_:TdDouble );
begin
     inherited;

     _dNALFs.X := X_;
end;

//------------------------------------------------------------------------------

function TdNALFsToFNALFs<TdNALFs_>.GetNFs( const N_,M_:Integer ) :TdDouble;
begin
     if M_ = 0 then Result := 1
               else Result := Sqrt(2);
end;
//------------------------------------------------------------------------------

function TdNALFsToFNALFs<TdNALFs_>.GetPs( const N_,M_:Integer ) :TdDouble;
begin
     Result := NFs[ N_, M_ ] * _dNALFs.Ps[ N_, M_ ];
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TdNALFsToFNALFs<TdNALFs_>.Create;
begin
     inherited;

     _dNALFs := TdNALFs_.Create;
end;

constructor TdNALFsToFNALFs<TdNALFs_>.Create( const DegN_:Integer );
begin
     Create;

     _dNALFs.DegN := DegN_;
end;

destructor TdNALFsToFNALFs<TdNALFs_>.Destroy;
begin
     _dNALFs.Free;

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■