unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.TabControl, FMX.ListBox,
  Viewer, ViewerALFs,
  LUX.ALFs,
  LUX.ALFs.N8,
  LUX.ALFs.N8.Diff,
  LUX.ALFs.Term3,
  LUX.ALFs.Term3.Diff,
  LUX.NALFs,
  LUX.NALFs.Diff,
  LUX.NALFs.Term3,
  LUX.NALFs.Term3.Diff,
  LUX.NALFs.Term4,
  LUX.NALFs.Term4.Diff,
  LUX.FNALFs,
  LUX.SH.Diff;

type
  TForm1 = class(TForm)
    ViewerFrame1: TViewerFrame;
    Panel1: TPanel;
      Button1: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ScrollBar1: TScrollBar;
    ViewerALFsFrame1: TViewerALFsFrame;
    ScrollBar2: TScrollBar;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _NALFs :TObjectList<TNALFs>;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
     _NALFs := TObjectList<TNALFs>.Create;

     _NALFs.Add( TALFsToNALFs<TALFsN8   >.Create );
     _NALFs.Add( TALFsToNALFs<TALFsTerm3>.Create );
     _NALFs.Add( TNALFsTerm3             .Create );
     _NALFs.Add( TNALFsTerm4             .Create );

     ComboBox1Change( Sender );

     ViewerFrame1.SPHarm := TdSPHarmonicsT4.Create( 8 );

     ViewerFrame1.N := 8;
     ViewerFrame1.M := 4;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _NALFs.Free;
end;

//------------------------------------------------------------------------------

procedure TForm1.Button1Click(Sender: TObject);
begin
     /////
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
     ViewerALFsFrame1.NALFs := _NALFs[ ComboBox1.ItemIndex ];

     ScrollBar2Change( Sender );
     ScrollBar1Change( Sender );
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
     ViewerALFsFrame1.NALFs.X := ScrollBar1.Value;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
     ViewerALFsFrame1.NALFs.DegN := Round( ScrollBar2.Value );
end;

end. //######################################################################### ■
