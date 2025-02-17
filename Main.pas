unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.TabControl, FMX.ListBox, FMX.Edit, FMX.EditBox, FMX.SpinBox,
  ViewerSH3D, ViewerALFs,
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
  LUX.SH.Diff;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
      TabItemS: TTabItem;
        ViewerSH3DFrameS: TViewerSH3DFrame;
        PanelS: TPanel;
          LabelSN: TLabel;
            SpinBoxSN: TSpinBox;
          LabelSM: TLabel;
            SpinBoxSM: TSpinBox;
      TabItemA: TTabItem;
        ViewerALFsFrameA: TViewerALFsFrame;
        PanelA: TPanel;
          LabelAA: TLabel;
          ScrollBarAX: TScrollBar;
            ComboBoxAA: TComboBox;
          LabelAD: TLabel;
            SpinBoxAD: TSpinBox;
            ScrollBarAD: TScrollBar;
          LabelAX: TLabel;
            EditAX: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpinBoxSNChange(Sender: TObject);
    procedure SpinBoxSMChange(Sender: TObject);
    procedure ComboBoxAAChange(Sender: TObject);
    procedure SpinBoxADChange(Sender: TObject);
    procedure ScrollBarADChange(Sender: TObject);
    procedure EditAXChange(Sender: TObject);
    procedure ScrollBarAXChange(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _NALFs :TObjectList<TNALFs>;
    _SPHs  :TObjectList<TdSPHarmonics>;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
     _SPHs := TObjectList<TdSPHarmonics>.Create;

     _SPHs.Add( TdSPHarmonics<TdALFsToNALFs<TdALFsN8   >>.Create );  // 0
     _SPHs.Add( TdSPHarmonics<TdALFsToNALFs<TdALFsTerm3>>.Create );  // 1
     _SPHs.Add( TdSPHarmonics<TdNALFsTerm3              >.Create );  // 2
     _SPHs.Add( TdSPHarmonics<TdNALFsTerm4              >.Create );  // 3

     ViewerSH3DFrameS.SPHarm := _SPHs[ 3 ];

     SpinBoxSNChange( Sender );
     SpinBoxSMChange( Sender );

     _NALFs := TObjectList<TNALFs>.Create;

     _NALFs.Add( TALFsToNALFs<TALFsN8   >.Create );  // 0
     _NALFs.Add( TALFsToNALFs<TALFsTerm3>.Create );  // 1
     _NALFs.Add( TNALFsTerm3             .Create );  // 2
     _NALFs.Add( TNALFsTerm4             .Create );  // 3

     ComboBoxAAChange( Sender );
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _NALFs.Free;
     _SPHs .Free;
end;

//------------------------------------------------------------------------------

procedure TForm1.SpinBoxSNChange(Sender: TObject);
begin
     ViewerSH3DFrameS.N := Round( SpinBoxSN.Value );

     SpinBoxSM.Min := -ViewerSH3DFrameS.N;
     SpinBoxSM.Max := +ViewerSH3DFrameS.N;
end;

procedure TForm1.SpinBoxSMChange(Sender: TObject);
begin
     ViewerSH3DFrameS.M := Round( SpinBoxSM.Value );
end;

//------------------------------------------------------------------------------

procedure TForm1.ComboBoxAAChange(Sender: TObject);
begin
     ViewerALFsFrameA.NALFs := _NALFs[ ComboBoxAA.ItemIndex ];

     ScrollBarADChange( Sender );
     ScrollBarAXChange( Sender );
end;

//------------------------------------------------------------------------------

procedure TForm1.SpinBoxADChange(Sender: TObject);
begin
     ViewerALFsFrameA.NALFs.DegN := Round( SpinBoxAD.Value );

     ScrollBarAD.Value := SpinBoxAD.Value;
end;

procedure TForm1.ScrollBarADChange(Sender: TObject);
begin
     ViewerALFsFrameA.NALFs.DegN := Round( ScrollBarAD.Value );

     SpinBoxAD.Value := ScrollBarAD.Value;
end;

//------------------------------------------------------------------------------

procedure TForm1.EditAXChange(Sender: TObject);
begin
     try
        ViewerALFsFrameA.NALFs.X := EditAX.Text.ToDouble;

        ScrollBarAX.Value := ViewerALFsFrameA.NALFs.X;
     finally

     end;
end;

procedure TForm1.ScrollBarAXChange(Sender: TObject);
begin
     ViewerALFsFrameA.NALFs.X := ScrollBarAX.Value;

     EditAX.Text := ScrollBarAX.Value.ToString;
end;

end. //######################################################################### ■
