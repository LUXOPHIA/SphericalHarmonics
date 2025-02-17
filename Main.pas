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
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
     ViewerSH3DFrameS.SPHarm := TdSPHarmonicsT4.Create;

     SpinBoxSNChange( Sender );
     SpinBoxSMChange( Sender );

     _NALFs := TObjectList<TNALFs>.Create;

     _NALFs.Add( TALFsToNALFs<TALFsN8   >.Create );
     _NALFs.Add( TALFsToNALFs<TALFsTerm3>.Create );
     _NALFs.Add( TNALFsTerm3             .Create );
     _NALFs.Add( TNALFsTerm4             .Create );

     ComboBoxAAChange( Sender );
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _NALFs.Free;
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
