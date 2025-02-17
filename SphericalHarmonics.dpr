program SphericalHarmonics;

uses
  System.StartUpCopy,
  FMX.Forms,
  LUX in '_LIBRARY\LUXOPHIA\LUX\LUX.pas',
  LUX.D1 in '_LIBRARY\LUXOPHIA\LUX\LUX.D1.pas',
  LUX.D1.Diff in '_LIBRARY\LUXOPHIA\LUX\LUX.D1.Diff.pas',
  LUX.D2 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2.pas',
  LUX.D2.Diff in '_LIBRARY\LUXOPHIA\LUX\LUX.D2.Diff.pas',
  LUX.D2x2 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2x2.pas',
  LUX.D3 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3.pas',
  LUX.D3.Diff in '_LIBRARY\LUXOPHIA\LUX\LUX.D3.Diff.pas',
  LUX.D3x3 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3x3.pas',
  LUX.D4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D4.pas',
  LUX.D4x4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D4x4.pas',
  LUX.Complex in '_LIBRARY\LUXOPHIA\LUX\Complex\LUX.Complex.pas',
  LUX.Complex.Diff in '_LIBRARY\LUXOPHIA\LUX\Complex\LUX.Complex.Diff.pas',
  LUX.Color in '_LIBRARY\LUXOPHIA\LUX\Color\LUX.Color.pas',
  LUX.FMX.Graphics.D3 in '_LIBRARY\LUXOPHIA\LUX.FMX.Graphics.D3\LUX.FMX.Graphics.D3.pas',
  LUX.FMX.Graphics.D3.Shaper in '_LIBRARY\LUXOPHIA\LUX.FMX.Graphics.D3\LUX.FMX.Graphics.D3.Shaper.pas',
  LUX.Sphere.FMX in '_LIBRARY\LUXOPHIA\LUX.Sphere\FMX\LUX.Sphere.FMX.pas',
  LUX.S2 in '_LIBRARY\LUXOPHIA\LUX.Sphere\S2\LUX.S2.pas',
  LUX.SH in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\LUX.SH.pas',
  LUX.SH.FMX.Graphics.D3 in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\FMX\LUX.SH.FMX.Graphics.D3.pas',
  LUX.ALFs in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.ALFs.pas',
  LUX.ALFs.Diff in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.ALFs.Diff.pas',
  LUX.ALFs.N8 in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.ALFs.N8.pas',
  LUX.ALFs.N8.DIff in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.ALFs.N8.DIff.pas',
  LUX.ALFs.Term3 in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.ALFs.Term3.pas',
  LUX.ALFs.Term3.Diff in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.ALFs.Term3.Diff.pas',
  LUX.NALFs in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.NALFs.pas',
  LUX.NALFs.Diff in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.NALFs.Diff.pas',
  LUX.NALFs.Term3 in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.NALFs.Term3.pas',
  LUX.NALFs.Term3.Diff in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.NALFs.Term3.Diff.pas',
  LUX.NALFs.Term4 in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.NALFs.Term4.pas',
  LUX.NALFs.Term4.Diff in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.NALFs.Term4.Diff.pas',
  LUX.FNALFs in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.FNALFs.pas',
  LUX.FNALFs.Diff in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\ALFs\LUX.FNALFs.Diff.pas',
  LUX.SH.Diff in '_LIBRARY\LUXOPHIA\LUX.SphericalHarmonics\LUX.SH.Diff.pas',
  Viewer in 'Viewer.pas' {ViewerFrame: TFrame},
  ViewerALFs in 'ViewerALFs.pas' {ViewerALFsFrame: TFrame},
  Main in 'Main.pas' {Form1},
  Core in 'Core.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
