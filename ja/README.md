# SphericalHarmonics

[English](../README.md) | [日本語](README.md)

Delphi (Object Pascal) / FireMonkey 製のインタラクティブな球面調和関数ビジュアライザ。
[LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) ライブラリのサンプルアプリケーションであり、実球面調和関数 $Y_n^m(\theta,\varphi)$ を3D曲面として、正規化ルジャンドル陪関数 $\tilde{P}_n^m(x)$ を2D三角配列として描画します。

![SphericalHarmonics](../--------/SphericalHarmonics.png)

## 利用ライブラリ

* [**LUX**](https://github.com/LUXOPHIA/LUX) ：LUXOPHIA の基盤数学ライブラリ。
* [**LUX.FMX.Graphics.D3**](https://github.com/LUXOPHIA/LUX.FMX.Graphics.D3) ：FireMonkey 3D の補助クラスライブラリ。
* [**LUX.Sphere**](https://github.com/LUXOPHIA/LUX.Sphere) ：球面 S²/S³ の幾何ライブラリ。
* [**LUX.SphericalHarmonics**](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) ：球面調和関数・ルジャンドル陪関数ライブラリ。

## 1. 概要

本アプリケーションは2つのタブでライブラリの機能を実演します：

| タブ | 表示 | 説明 |
|:---:|:---|:---|
| **SH** | 球面調和関数の3D表示 | 実球面調和関数 $Y_n^m(\theta,\varphi)$ を半径 $r=\|\sqrt{4\pi}\,Y_n^m\|$（2.4節）の曲面として描画します。パラメトリック写像を二重数（`Td...` クラス）で評価するため、接ベクトルと法線は有限差分ではなく前進型自動微分により解析的に得られます。次数 $n$・位数 $m$ を選択できます。 |
| **ALFs** | ルジャンドル陪関数の2D表示 | 正規化ルジャンドル陪関数 $\tilde{P}_n^m(x)$ の三角配列（行 = 次数 $n$、列 = 位数 $m$、輝度 $= \mathrm{clamp}(1/2+\tilde{P}_n^m/4,\,0,\,1)$、$m>n$ の領域は透明）をグレースケール画像として表示します。表はパラメータ変更のたびに再計算され、`TParallel.For` による行並列でレンダリングされます。次数 $n$ と引数 $x$ はスライダで操作します。 |

どちらの画面でも、計算経路を実行時に切り替えられます：

| 選択肢 | 計算経路 |
|:---|:---|
| `TALFsN8` / `TdALFsN8` | 明示的多項式（次数 $n \le 8$）＋アダプタで完全正規化 |
| `TALFsTerm3` / `TdALFsTerm3` | 無正規化3項漸化式 (5)＋アダプタで完全正規化 |
| `TNALFsTerm3` / `TdNALFsTerm3` | 正規化3項漸化式 (7) |
| `TNALFsTerm4` / `TdNALFsTerm4` | 正規化4項漸化式 (8)（Belousov 型。超高次でもアンダーフローを回避 [5]） |

## 2. 数学的背景

### 2.1 ルジャンドル多項式とルジャンドル陪関数

ルジャンドル多項式 $P_n(x)$ はロドリゲスの公式で与えられます [2, 3]：

```math
P_n(x) = \frac{1}{2^n\, n!}\,\frac{d^n}{dx^n}\left(x^2-1\right)^n \tag{1}
```

ルジャンドル陪関数 $P_n^m(x)$（$0 \le m \le n$、$x\in[-1,1]$）は、コードと同じくコンドン＝ショートレー位相 $(-1)^m$ を含めて

```math
P_n^m(x) = (-1)^m \left(1-x^2\right)^{m/2}\,\frac{d^m}{dx^m}\,P_n(x) \tag{2}
```

と定義されます。`TALFsTerm3` は $P_0^0=1$ から3つの漸化式（メソッド `P01`・`PN01`・`PN012`）で三角配列 $\{P_n^m\}_{0\le m\le n\le N}$ 全体を構成します：

```math
P_m^m = (1-2m)\sqrt{1-x^2}\;P_{m-1}^{m-1},\qquad
P_{m+1}^m = (2m+1)\,x\,P_m^m, \tag{3}
```

```math
(n-m)\,P_n^m = (2n-1)\,x\,P_{n-1}^m - (n+m-1)\,P_{n-2}^m \tag{4}
```

一方 `TALFsN8` は $P_0^0,\dots,P_8^8$ をハードコードされた明示的多項式で評価します。

### 2.2 正規化ルジャンドル陪関数（$\tilde{P}_n^m$、クラス `TNALFs`）

$P_n^m$ は $(n+m)!$ のオーダーで増大するため、無正規化の漸化式は中程度の次数でオーバーフローします。そこでライブラリは*正規化*された関数も計算します（正規化係数は `TALFsToNALFs.NormFactor` に実装）：

```math
\tilde{P}_n^m(x) = \sqrt{\frac{2n+1}{2}\,\frac{(n-m)!}{(n+m)!}}\;P_n^m(x),
\qquad
\int_{-1}^{1} \tilde{P}_n^m(x)\,\tilde{P}_{n'}^m(x)\,dx = \delta_{nn'} \tag{5}
```

`TNALFsTerm3` は $\tilde{P}_0^0 = 1/\sqrt{2}$ を起点に、正規化を漸化式自体に織り込んで伝播させます（メソッド `P01`・`PN01`・`PN012`）：

```math
\tilde{P}_m^m = -\sqrt{\frac{2m+1}{2m}}\sqrt{1-x^2}\;\tilde{P}_{m-1}^{m-1},\qquad
\tilde{P}_{m+1}^m = \sqrt{2m+3}\;x\,\tilde{P}_m^m, \tag{6}
```

```math
\tilde{P}_n^m
= \sqrt{\frac{(2n+1)(2n-1)}{(n+m)(n-m)}}\;x\,\tilde{P}_{n-1}^m
- \sqrt{\frac{(2n+1)(n+m-1)(n-m-1)}{(2n-3)(n+m)(n-m)}}\;\tilde{P}_{n-2}^m \tag{7}
```

`TNALFsTerm4`（メソッド `PNM22`）は Belousov 型の4項漸化式 [5] を用います。これは*位数*方向にも進む漸化式で、超高次でも数値的に安定であり、$\tilde{P}_n^0$（ルジャンドル多項式）と $\tilde{P}_n^1$（その微分）を種として計算します：

```math
\tilde{P}_n^m
= \sqrt{\tfrac{(2n+1)(n{+}m{-}3)(n{+}m{-}2)}{(2n-3)(n{+}m{-}1)(n{+}m)}}\;\tilde{P}_{n-2}^{m-2}
+ \sqrt{\tfrac{(2n+1)(n{-}m{-}1)(n{-}m)}{(2n-3)(n{+}m{-}1)(n{+}m)}}\;\tilde{P}_{n-2}^{m}
- \sqrt{\tfrac{(n{-}m{+}1)(n{-}m{+}2)}{(n{+}m{-}1)(n{+}m)}}\;\tilde{P}_{n}^{m-2} \tag{8}
```

### 2.3 完全正規化ルジャンドル陪関数（$\bar{P}_n^m$、クラス `TFNALFs`）

実球面調和関数には測地学式の*完全正規化*関数を用います（係数は `TALFsToFNALFs.NormFactor` に実装。アダプタ `TNALFsToFNALFs` は $\tilde{P}_n^m$ を $m=0$ で $\sqrt{2}$ 倍、$m>0$ で $2$ 倍します）：

```math
\bar{P}_n^m(x) = \sqrt{\left(2-\delta_{m0}\right)\left(2n+1\right)\frac{(n-m)!}{(n+m)!}}\;P_n^m(x) \tag{9}
```

### 2.4 複素球面調和関数と実球面調和関数

`TSPHarmonics<TNALFs_>.GetSHs` は正規直交な*複素*球面調和関数 [1] を評価します：

```math
Y_n^m(\theta,\varphi)
= \frac{\tilde{P}_n^m(\cos\theta)}{\sqrt{2\pi}}\,e^{im\varphi}
= \sqrt{\frac{2n+1}{4\pi}\frac{(n-m)!}{(n+m)!}}\;P_n^m(\cos\theta)\,e^{im\varphi} \tag{10}
```

負の位数は $Y_n^{-m} = (-1)^m\,\overline{Y_n^{m}}$ から得ます。`GetRSHs`（および $\bar{P}_n^m/\sqrt{4\pi}$ を経由する `TRSPHarmonics<TFNALFs_>.GetRSHs`）は $-n \le m \le n$ に対する正規直交な*実*球面調和関数を評価します：

```math
Y_n^m(\theta,\varphi) =
\begin{cases}
\sqrt{2}\,\dfrac{\tilde{P}_n^{|m|}(\cos\theta)}{\sqrt{2\pi}}\,\sin(|m|\varphi) & m<0\\[2ex]
\dfrac{\tilde{P}_n^{0}(\cos\theta)}{\sqrt{2\pi}} & m=0\\[2ex]
\sqrt{2}\,\dfrac{\tilde{P}_n^{m}(\cos\theta)}{\sqrt{2\pi}}\,\cos(m\varphi) & m>0
\end{cases} \tag{11}
```

どちらの経路も同一の値を与え、正規直交関係

```math
\int_0^{2\pi}\!\!\int_0^{\pi} Y_n^m(\theta,\varphi)\,Y_{n'}^{m'}(\theta,\varphi)\,\sin\theta\,d\theta\,d\varphi = \delta_{nn'}\,\delta_{mm'} \tag{12}
```

を満たします。3D曲面（`TSPHarmonics3D.AngToPos`）は極表示

```math
r(\theta,\varphi) = R\,\bigl|\sqrt{4\pi}\,Y_n^m(\theta,\varphi)\bigr| \tag{13}
```

であり、$Y_0^0 = 1/\sqrt{4\pi}$ が単位球として描画されるようスケールされています。写像 $(\theta,\varphi)\mapsto(x,y,z)$ は二重数上で評価され、そのヤコビアンから厳密な接ベクトルが得られ、その外積が解析的な頂点法線となります。

## 3. アーキテクチャ

```
--- 所有：フォーム → タブ → フレーム → ビジュアルコンポーネント -----------

・TForm1 (Main)
  ┣・[SH タブ] TViewerSH3DFrame (ViewerSH3D)
  ┃  ┗・TViewport3D
  ┃     ┣・TF3DWorld
  ┃     ┃  ┣・TCamera3D
  ┃     ┃  ┗・TLight3D x3 (R/G/B)
  ┃     ┗・TSPHarmonics3D
  ┗・[ALFs タブ] TViewerALFsFrame (ViewerALFs)
     ┗・TBitmap

--- 参照：ビュー → 実行時に選択される評価器 -------------------------------

・TSPHarmonics3D
  ┗・TdSPHarmonics                 ･･･ 選択中の計算経路

・TBitmap
  ┗・TNALFs                        ･･･ 選択中の計算経路

--- 評価器のクラス階層 (LUX.SphericalHarmonics) ----------------------------

・TALFs                             ･･･ 抽象基底：P_n^m の表
  ┣・TCoreALFs
  ┃  ┣・TALFsN8                   ･･･ 明示的多項式（n <= 8）
  ┃  ┗・TMapALFs
  ┃     ┗・TALFsTerm3             ･･･ 無正規化3項漸化式 (3)-(4)
  ┗・TNALFs                        ･･･ 正規化 ~P_n^m
     ┣・TCoreNALFs
     ┃  ┗・TMapNALFs
     ┃     ┣・TNALFsTerm3         ･･･ 正規化3項漸化式 (6)-(7)
     ┃     ┗・TNALFsTerm4         ･･･ 正規化4項漸化式 (8)
     ┣・TALFsToNALFs<TALFs_>       ･･･ 正規化アダプタ（式 (5)）
     ┗・TFNALFs                    ･･･ 完全正規化 ^P_n^m
        ┣・TALFsToFNALFs<TALFs_>   ･･･ アダプタ（式 (9)）
        ┗・TNALFsToFNALFs<TNALFs_> ･･･ アダプタ（sqrt(2) 倍 / 2 倍）

・TSPHarmonics                      ･･･ 抽象基底：Y_n^m
  ┣・TSPHarmonics<TNALFs_>         ･･･ ~P_n^m から複素 SH (10)・実 SH (11)
  ┗・TRSPHarmonics<TFNALFs_>       ･･･ ^P_n^m から実 SH (11)

・Td...                             ･･･ 二重数版ミラー（法線の解析計算用）
```

```
・SphericalHarmonics/
  ┣・SphericalHarmonics.dpr     ･･･ プログラムエントリ
  ┣・Main.pas / .fmx            ･･･ メインフォーム：タブと計算経路／次数／位数
  ┣・ViewerSH3D.pas / .fmx      ･･･ 3Dビューア：カメラ・ライト・TSPHarmonics3D
  ┣・ViewerALFs.pas / .fmx      ･･･ 2Dビューア：ALFs 三角配列のビットマップ
  ┣・Core.pas                   ･･･ 共通定義（空の雛形）
  ┣・_DATA/                     ･･･ テクスチャ（Sphere 1800x900.png）
  ┗・_LIBRARY/LUXOPHIA/
     ┣・LUX/                    ･･･ 数学基盤：二重数・ベクトル・複素数
     ┣・LUX.FMX.Graphics.D3/    ･･･ FMX 3D シーン補助（TF3DWorld・TF3DShaper）
     ┣・LUX.Sphere/             ･･･ 球面ジオメトリ
     ┗・LUX.SphericalHarmonics/ ･･･ ALFs / NALFs / FNALFs / SH 評価器
```

`_LIBRARY/LUXOPHIA/` ディレクトリには [LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) ライブラリとその依存ライブラリがサブツリーとして同梱されています。ライブラリ本体は当該リポジトリを参照してください。

## 4. 使い方・操作

| タブ | コントロール | 機能 |
|:---:|:---|:---|
| SH | `Algorithm` コンボボックス | 計算経路の選択（`TdALFsN8` / `TdALFsTerm3` / `TdNALFsTerm3` / `TdNALFsTerm4`） |
| SH | `n` スピンボックス | 次数 $n$（$0 \le n \le 64$） |
| SH | `m` スピンボックス | 位数 $m$（$-n \le m \le n$ に自動制限） |
| SH | ビューポート内を左ドラッグ | カメラの回転 |
| ALFs | `Algorithm` コンボボックス | 計算経路の選択（`TALFsN8` / `TALFsTerm3` / `TNALFsTerm3` / `TNALFsTerm4`） |
| ALFs | `Degree` スピンボックス＋スクロールバー | 表の次数 $N$（$0 \le N \le 512$） |
| ALFs | `x` エディットボックス＋スクロールバー | 引数 $x \in [-1, 1]$ |

`TALFsN8` は $n \le 8$ でのみ有効であり、無正規化の `TALFsTerm3` は高次数でオーバーフローします。大きな次数で計算経路を切り替えると、各手法の数値的限界を直接観察できます。

## 5. ビルド

1. `SphericalHarmonics.dproj` を RAD Studio（Delphi、FireMonkey フレームワーク）で開きます。
2. ターゲットプラットフォームを選択します：**Win32** または **Win64**（いずれも `.dproj` に構成済み）。
3. ビルドして実行します。すべてのライブラリユニットは `_LIBRARY/` からの相対パスで参照されるため、追加のライブラリパス設定は不要です。

3D表示は相対パス `../../_DATA/Sphere 1800x900.png` からテクスチャを読み込むため、既定の出力ディレクトリ（例：`Win64/Debug/`）から実行してください。

## 6. 参考文献

1. Wikipedia: [Spherical harmonics](https://en.wikipedia.org/wiki/Spherical_harmonics)
2. Wikipedia: [Associated Legendre polynomials](https://en.wikipedia.org/wiki/Associated_Legendre_polynomials)
3. M. Abramowitz, I. A. Stegun (eds.): [*Handbook of Mathematical Functions*](https://personal.math.ubc.ca/~cbm/aands/), Chapter 8 "Legendre Functions".
4. R. Green: [*Spherical Harmonic Lighting: The Gritty Details*](https://3dvar.com/Green2003Spherical.pdf), GDC 2003.
5. S. A. Holmes, W. E. Featherstone: [*A unified approach to the Clenshaw summation and the recursive computation of very high degree and order normalised associated Legendre functions*](https://doi.org/10.1007/s00190-002-0216-2), Journal of Geodesy **76** (2002) 279–299.

## 7. ライセンス

[MIT License](../LICENSE) — Copyright (c) LUXOPHIA

## 💖 [Embarcadero](https://www.embarcadero.com/jp/) [**Delphi**](https://www.embarcadero.com/jp/products/delphi)
ネイティブなクロスプラットフォームアプリを開発するための統合開発環境（ＩＤＥ）。
### Free Download: [**Delphi** Community Edition](https://www.embarcadero.com/jp/products/delphi/starter)
