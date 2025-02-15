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
  LUX.ALFs.Simple,
  LUX.NALFs,
  LUX.NALFs.Simple,
  LUX.FNALFs;

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

     _NALFs.Add( TALFsToNALFs<TALFsN8    >.Create );
     _NALFs.Add( TALFsToNALFs<TALFsSimple>.Create );
     _NALFs.Add( TNALFsSimple             .Create );

     ComboBox1Change( Sender );
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
