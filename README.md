# SphericalHarmonics

[English](README.md) | [日本語](ja/README.md)

Interactive spherical harmonics visualizer written in Delphi (Object Pascal) / FireMonkey.
It is the sample application of the [LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) library, rendering the real spherical harmonics $Y_n^m(\theta,\varphi)$ as a 3D surface and the normalized associated Legendre functions $\tilde{P}_n^m(x)$ as a 2D triangular table.

![SphericalHarmonics](--------/SphericalHarmonics.png)

## 利用ライブラリ

* [**LUX**](https://github.com/LUXOPHIA/LUX) ：The foundation math library of LUXOPHIA.
* [**LUX.FMX.Graphics.D3**](https://github.com/LUXOPHIA/LUX.FMX.Graphics.D3) ：Helper classes for FireMonkey 3D graphics.
* [**LUX.Sphere**](https://github.com/LUXOPHIA/LUX.Sphere) ：A geometry library for the spheres S² and S³.
* [**LUX.SphericalHarmonics**](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) ：A spherical harmonics and associated Legendre function library.

## 1. Overview

The application demonstrates the library in two tabs:

| Tab | View | Description |
|:---:|:---|:---|
| **SH** | 3D spherical harmonics | Renders the real spherical harmonic $Y_n^m(\theta,\varphi)$ as a surface with radius $r=\|\sqrt{4\pi}\,Y_n^m\|$ (Sec. 2.4). Surface normals are analytic: the parametric map is evaluated with dual numbers (the `Td...` classes), so the tangent basis and normal come from forward-mode automatic differentiation rather than finite differences. Degree $n$ and order $m$ are selectable. |
| **ALFs** | 2D ALFs table | Visualizes the triangular table of normalized associated Legendre functions $\tilde{P}_n^m(x)$ as a grayscale bitmap (row = degree $n$, column = order $m$, gray level $= \mathrm{clamp}(1/2+\tilde{P}_n^m/4,\,0,\,1)$; the region $m>n$ stays transparent). The table is recomputed on each parameter change and rendered row-parallel with `TParallel.For`. Degree $n$ and argument $x$ are controlled by sliders. |

Both views allow switching the evaluation pipeline at runtime:

| Choice | Evaluation pipeline |
|:---|:---|
| `TALFsN8` / `TdALFsN8` | Explicit polynomials (degree $n \le 8$), fully normalized via adapter |
| `TALFsTerm3` / `TdALFsTerm3` | Unnormalized three-term recurrence (5), fully normalized via adapter |
| `TNALFsTerm3` / `TdNALFsTerm3` | Normalized three-term recurrence (7) |
| `TNALFsTerm4` / `TdNALFsTerm4` | Normalized four-term recurrence (8) (Belousov; avoids underflow at very high degree [5]) |

## 2. Mathematical Background

### 2.1 Legendre and Associated Legendre Functions

The Legendre polynomials $P_n(x)$ are given by the Rodrigues formula [2, 3]:

```math
P_n(x) = \frac{1}{2^n\, n!}\,\frac{d^n}{dx^n}\left(x^2-1\right)^n \tag{1}
```

The associated Legendre functions $P_n^m(x)$ for $0 \le m \le n$, $x\in[-1,1]$, including the Condon–Shortley phase $(-1)^m$ as the code does, are

```math
P_n^m(x) = (-1)^m \left(1-x^2\right)^{m/2}\,\frac{d^m}{dx^m}\,P_n(x) \tag{2}
```

`TALFsTerm3` builds the whole triangular table $\{P_n^m\}_{0\le m\le n\le N}$ from $P_0^0=1$ using three recurrences (methods `P01`, `PN01`, `PN012`):

```math
P_m^m = (1-2m)\sqrt{1-x^2}\;P_{m-1}^{m-1},\qquad
P_{m+1}^m = (2m+1)\,x\,P_m^m, \tag{3}
```

```math
(n-m)\,P_n^m = (2n-1)\,x\,P_{n-1}^m - (n+m-1)\,P_{n-2}^m \tag{4}
```

`TALFsN8` instead evaluates hard-coded explicit polynomials $P_0^0,\dots,P_8^8$.

### 2.2 Normalized ALFs ($\tilde{P}_n^m$, class `TNALFs`)

Because $P_n^m$ grows like $(n+m)!$, the unnormalized recurrences overflow beyond moderate degrees. The library therefore also computes the *normalized* functions (normalization factor implemented in `TALFsToNALFs.NormFactor`):

```math
\tilde{P}_n^m(x) = \sqrt{\frac{2n+1}{2}\,\frac{(n-m)!}{(n+m)!}}\;P_n^m(x),
\qquad
\int_{-1}^{1} \tilde{P}_n^m(x)\,\tilde{P}_{n'}^m(x)\,dx = \delta_{nn'} \tag{5}
```

`TNALFsTerm3` propagates the normalization through the recurrence itself (methods `P01`, `PN01`, `PN012`), starting from $\tilde{P}_0^0 = 1/\sqrt{2}$:

```math
\tilde{P}_m^m = -\sqrt{\frac{2m+1}{2m}}\sqrt{1-x^2}\;\tilde{P}_{m-1}^{m-1},\qquad
\tilde{P}_{m+1}^m = \sqrt{2m+3}\;x\,\tilde{P}_m^m, \tag{6}
```

```math
\tilde{P}_n^m
= \sqrt{\frac{(2n+1)(2n-1)}{(n+m)(n-m)}}\;x\,\tilde{P}_{n-1}^m
- \sqrt{\frac{(2n+1)(n+m-1)(n-m-1)}{(2n-3)(n+m)(n-m)}}\;\tilde{P}_{n-2}^m \tag{7}
```

`TNALFsTerm4` (method `PNM22`) uses the Belousov four-term recurrence [5], which steps in the *order* direction and stays numerically stable at very high degree, seeded by $\tilde{P}_n^0$ (Legendre) and $\tilde{P}_n^1$ (derivative of Legendre):

```math
\tilde{P}_n^m
= \sqrt{\tfrac{(2n+1)(n{+}m{-}3)(n{+}m{-}2)}{(2n-3)(n{+}m{-}1)(n{+}m)}}\;\tilde{P}_{n-2}^{m-2}
+ \sqrt{\tfrac{(2n+1)(n{-}m{-}1)(n{-}m)}{(2n-3)(n{+}m{-}1)(n{+}m)}}\;\tilde{P}_{n-2}^{m}
- \sqrt{\tfrac{(n{-}m{+}1)(n{-}m{+}2)}{(n{+}m{-}1)(n{+}m)}}\;\tilde{P}_{n}^{m-2} \tag{8}
```

### 2.3 Fully Normalized ALFs ($\bar{P}_n^m$, class `TFNALFs`)

For the real spherical harmonics the geodesy-style *fully normalized* functions are used (factor implemented in `TALFsToFNALFs.NormFactor`; the `TNALFsToFNALFs` adapter multiplies $\tilde{P}_n^m$ by $\sqrt{2}$ for $m=0$ and by $2$ for $m>0$):

```math
\bar{P}_n^m(x) = \sqrt{\left(2-\delta_{m0}\right)\left(2n+1\right)\frac{(n-m)!}{(n+m)!}}\;P_n^m(x) \tag{9}
```

### 2.4 Complex and Real Spherical Harmonics

`TSPHarmonics<TNALFs_>.GetSHs` evaluates the orthonormal *complex* spherical harmonics [1]

```math
Y_n^m(\theta,\varphi)
= \frac{\tilde{P}_n^m(\cos\theta)}{\sqrt{2\pi}}\,e^{im\varphi}
= \sqrt{\frac{2n+1}{4\pi}\frac{(n-m)!}{(n+m)!}}\;P_n^m(\cos\theta)\,e^{im\varphi} \tag{10}
```

with negative orders obtained from $Y_n^{-m} = (-1)^m\,\overline{Y_n^{m}}$. `GetRSHs` (and, via $\bar{P}_n^m/\sqrt{4\pi}$, `TRSPHarmonics<TFNALFs_>.GetRSHs`) evaluates the orthonormal *real* spherical harmonics for $-n \le m \le n$:

```math
Y_n^m(\theta,\varphi) =
\begin{cases}
\sqrt{2}\,\dfrac{\tilde{P}_n^{|m|}(\cos\theta)}{\sqrt{2\pi}}\,\sin(|m|\varphi) & m<0\\[2ex]
\dfrac{\tilde{P}_n^{0}(\cos\theta)}{\sqrt{2\pi}} & m=0\\[2ex]
\sqrt{2}\,\dfrac{\tilde{P}_n^{m}(\cos\theta)}{\sqrt{2\pi}}\,\cos(m\varphi) & m>0
\end{cases} \tag{11}
```

Both pipelines yield the same values, satisfying the orthonormality relation

```math
\int_0^{2\pi}\!\!\int_0^{\pi} Y_n^m(\theta,\varphi)\,Y_{n'}^{m'}(\theta,\varphi)\,\sin\theta\,d\theta\,d\varphi = \delta_{nn'}\,\delta_{mm'} \tag{12}
```

The 3D surface (`TSPHarmonics3D.AngToPos`) is the polar plot

```math
r(\theta,\varphi) = R\,\bigl|\sqrt{4\pi}\,Y_n^m(\theta,\varphi)\bigr| \tag{13}
```

so that $Y_0^0 = 1/\sqrt{4\pi}$ renders as the unit sphere. The map $(\theta,\varphi)\mapsto(x,y,z)$ is evaluated on dual numbers; its Jacobian gives exact tangents, whose cross product is the analytic vertex normal.

## 3. Architecture

```
--- ownership: form -> tabs -> frames -> visual components -----------------

・TForm1 (Main)
  ┣・[SH tab] TViewerSH3DFrame (ViewerSH3D)
  ┃  ┗・TViewport3D
  ┃     ┣・TF3DWorld
  ┃     ┃  ┣・TCamera3D
  ┃     ┃  ┗・TLight3D x3 (R/G/B)
  ┃     ┗・TSPHarmonics3D
  ┗・[ALFs tab] TViewerALFsFrame (ViewerALFs)
     ┗・TBitmap

--- reference: view -> evaluator selected at run time ----------------------

・TSPHarmonics3D
  ┗・TdSPHarmonics                 ･･･ selected pipeline

・TBitmap
  ┗・TNALFs                        ･･･ selected pipeline

--- evaluator class hierarchy (LUX.SphericalHarmonics) ---------------------

・TALFs                             ･･･ abstract P_n^m table
  ┣・TCoreALFs
  ┃  ┣・TALFsN8                   ･･･ explicit polynomials, n <= 8
  ┃  ┗・TMapALFs
  ┃     ┗・TALFsTerm3             ･･･ unnormalized 3-term recurrence (3)-(4)
  ┗・TNALFs                        ･･･ normalized ~P_n^m
     ┣・TCoreNALFs
     ┃  ┗・TMapNALFs
     ┃     ┣・TNALFsTerm3         ･･･ normalized 3-term recurrence (6)-(7)
     ┃     ┗・TNALFsTerm4         ･･･ normalized 4-term recurrence (8)
     ┣・TALFsToNALFs<TALFs_>       ･･･ normalization adapter, Eq. (5)
     ┗・TFNALFs                    ･･･ fully normalized ^P_n^m
        ┣・TALFsToFNALFs<TALFs_>   ･･･ adapter, Eq. (9)
        ┗・TNALFsToFNALFs<TNALFs_> ･･･ adapter, x sqrt(2) / x 2

・TSPHarmonics                      ･･･ abstract Y_n^m
  ┣・TSPHarmonics<TNALFs_>         ･･･ complex (10) & real (11) SH from ~P_n^m
  ┗・TRSPHarmonics<TFNALFs_>       ･･･ real SH (11) from ^P_n^m

・Td...                             ･･･ dual-number mirrors (analytic normals)
```

```
・SphericalHarmonics/
  ┣・SphericalHarmonics.dpr     ･･･ program entry
  ┣・Main.pas / .fmx            ･･･ main form: tabs, algorithm/degree/order
  ┣・ViewerSH3D.pas / .fmx      ･･･ 3D viewer: camera, lights, TSPHarmonics3D
  ┣・ViewerALFs.pas / .fmx      ･･･ 2D viewer: triangular ALFs-table bitmap
  ┣・Core.pas                   ･･･ shared definitions (empty scaffold)
  ┣・_DATA/                     ･･･ texture (Sphere 1800x900.png)
  ┗・_LIBRARY/LUXOPHIA/
     ┣・LUX/                    ･･･ math base: dual numbers, vectors, complex
     ┣・LUX.FMX.Graphics.D3/    ･･･ FMX 3D helpers (TF3DWorld, TF3DShaper)
     ┣・LUX.Sphere/             ･･･ sphere geometry
     ┗・LUX.SphericalHarmonics/ ･･･ ALFs / NALFs / FNALFs / SH evaluators
```

The `_LIBRARY/LUXOPHIA/` directory bundles the [LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) library and its dependencies as subtrees; see that repository for the library itself.

## 4. Usage / Controls

| Tab | Control | Function |
|:---:|:---|:---|
| SH | `Algorithm` combo box | Select evaluation pipeline (`TdALFsN8` / `TdALFsTerm3` / `TdNALFsTerm3` / `TdNALFsTerm4`) |
| SH | `n` spin box | Degree $n$ ($0 \le n \le 64$) |
| SH | `m` spin box | Order $m$ (automatically clamped to $-n \le m \le n$) |
| SH | Left-drag in viewport | Orbit the camera |
| ALFs | `Algorithm` combo box | Select evaluation pipeline (`TALFsN8` / `TALFsTerm3` / `TNALFsTerm3` / `TNALFsTerm4`) |
| ALFs | `Degree` spin box + scroll bar | Table degree $N$ ($0 \le N \le 512$) |
| ALFs | `x` edit box + scroll bar | Argument $x \in [-1, 1]$ |

Note that `TALFsN8` is only valid for $n \le 8$, and the unnormalized `TALFsTerm3` overflows at high degrees — switching pipelines at a large degree makes the numerical limits of each method directly visible.

## 5. Building

1. Open `SphericalHarmonics.dproj` in RAD Studio (Delphi, FireMonkey framework).
2. Select the target platform: **Win32** or **Win64** (both are configured in the `.dproj`).
3. Build and run. All library units are referenced relatively from `_LIBRARY/`, so no extra library path setup is required.

The 3D view loads its texture from the relative path `../../_DATA/Sphere 1800x900.png`; run from the default output directory (e.g. `Win64/Debug/`) so the path resolves.

## 6. References

1. Wikipedia: [Spherical harmonics](https://en.wikipedia.org/wiki/Spherical_harmonics)
2. Wikipedia: [Associated Legendre polynomials](https://en.wikipedia.org/wiki/Associated_Legendre_polynomials)
3. M. Abramowitz, I. A. Stegun (eds.): [*Handbook of Mathematical Functions*](https://personal.math.ubc.ca/~cbm/aands/), Chapter 8 "Legendre Functions".
4. R. Green: [*Spherical Harmonic Lighting: The Gritty Details*](https://3dvar.com/Green2003Spherical.pdf), GDC 2003.
5. S. A. Holmes, W. E. Featherstone: [*A unified approach to the Clenshaw summation and the recursive computation of very high degree and order normalised associated Legendre functions*](https://doi.org/10.1007/s00190-002-0216-2), Journal of Geodesy **76** (2002) 279–299.

## 7. License

[MIT License](LICENSE) — Copyright (c) LUXOPHIA

## 💖 [Embarcadero](https://www.embarcadero.com/) [**Delphi**](https://www.embarcadero.com/products/delphi)
Integrated Development Environment (IDE) for Creating Native Cross-Platform Apps.
### Free Download: [**Delphi** Community Edition](https://www.embarcadero.com/products/delphi/starter)
