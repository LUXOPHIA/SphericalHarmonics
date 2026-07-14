# SphericalHarmonics

Interactive Spherical Harmonics visualizer for Delphi (Object Pascal) / FireMonkey.
This is the sample application for the [LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) library.

**English** | [日本語](ja/README.md)

![](--------/SphericalHarmonics.png)

## Overview

The application demonstrates the library in two tabs:

| Tab | View | Description |
|:---:|:---|:---|
| **SH** | 3D Spherical Harmonics | Renders the real spherical harmonic $\overline{Y}_n^m(\theta,\phi)$ as a 3D surface with radius $r = \|\overline{Y}_n^m\|$. Surface normals are analytic, obtained by automatic differentiation with dual numbers (`Td...` classes) rather than finite differences. Degree $n$ and order $m$ are selectable. |
| **ALFs** | 2D ALFs Table | Visualizes the triangular table of normalized associated Legendre functions $\tilde{P}_n^m(x)$ as a grayscale bitmap (row = degree $n$, column = order $m$). The table is computed once per parameter change and rendered row-parallel with `TParallel.For`. Degree $n$ and argument $x$ are controlled by sliders. |

Both views allow switching the evaluation pipeline at runtime:

| Choice | Evaluation pipeline |
|:---|:---|
| `TALFsN8` / `TdALFsN8` | Explicit polynomials (degree $n \le 8$), fully normalized via adapter |
| `TALFsTerm3` / `TdALFsTerm3` | Unnormalized 3-term recurrence, fully normalized via adapter |
| `TNALFsTerm3` / `TdNALFsTerm3` | Normalized 3-term recurrence |
| `TNALFsTerm4` / `TdNALFsTerm4` | Normalized 4-term recurrence (Belousov / Swarztrauber; avoids underflow at ultra-high degree) |

## Project Structure

| File | Description |
|:---|:---|
| `Main.pas` / `.fmx` | Main form: tabs and algorithm / degree / order controls |
| `ViewerSH3D.pas` / `.fmx` | 3D viewer frame: camera, lights and the `TSPHarmonics3D` mesh |
| `ViewerALFs.pas` / `.fmx` | 2D viewer frame: triangular table bitmap |
| `Core.pas` | Shared definitions |
| `_LIBRARY/LUXOPHIA/` | Bundled libraries: `LUX`, `LUX.FMX.Graphics.D3`, `LUX.Sphere`, `LUX.SphericalHarmonics` |

## Build

Open `SphericalHarmonics.dproj` in Delphi (FireMonkey) and run.

## License

[MIT License](LICENSE) — Copyright (c) LUXOPHIA
