# SphericalHarmonics

Delphi (Object Pascal) / FireMonkey 製の球面調和関数ビジュアライザ。
[LUX.SphericalHarmonics](https://github.com/LUXOPHIA/LUX.SphericalHarmonics) ライブラリのサンプルアプリケーションです。

[English](../README.md) | **日本語**

![](../--------/SphericalHarmonics.png)

## 概要

2つのタブでライブラリの機能を実演します：

| タブ | 表示 | 説明 |
|:---:|:---|:---|
| **SH** | 球面調和関数の3D表示 | 実球面調和関数 $\overline{Y}_n^m(\theta,\phi)$ を半径 $r = \|\overline{Y}_n^m\|$ の3D曲面として描画します。法線は有限差分ではなく、二重数（`Td...` クラス）による自動微分で解析的に求めています。次数 $n$・位数 $m$ を選択できます。 |
| **ALFs** | ルジャンドル陪関数の2D表示 | 正規化ルジャンドル陪関数 $\tilde{P}_n^m(x)$ の三角配列（行 = 次数 $n$、列 = 位数 $m$）をグレースケール画像として表示します。表はパラメータ変更時に一括計算され、`TParallel.For` による行並列でレンダリングされます。次数 $n$ と引数 $x$ はスライダで操作します。 |

どちらの画面でも、計算アルゴリズムを実行時に切り替えられます：

| 選択肢 | 計算経路 |
|:---|:---|
| `TALFsN8` / `TdALFsN8` | 明示的多項式（次数 $n \le 8$）＋アダプタで完全正規化 |
| `TALFsTerm3` / `TdALFsTerm3` | 無正規化3項漸化式＋アダプタで完全正規化 |
| `TNALFsTerm3` / `TdNALFsTerm3` | 正規化3項漸化式 |
| `TNALFsTerm4` / `TdNALFsTerm4` | 正規化4項漸化式（Belousov / Swarztrauber。超高次でもアンダーフローを回避） |

## プロジェクト構成

| ファイル | 説明 |
|:---|:---|
| `Main.pas` / `.fmx` | メインフォーム：タブとアルゴリズム／次数／位数のコントロール |
| `ViewerSH3D.pas` / `.fmx` | 3Dビューアフレーム：カメラ・ライト・`TSPHarmonics3D` メッシュ |
| `ViewerALFs.pas` / `.fmx` | 2Dビューアフレーム：三角配列のビットマップ |
| `Core.pas` | 共通定義 |
| `_LIBRARY/LUXOPHIA/` | 同梱ライブラリ：`LUX`、`LUX.FMX.Graphics.D3`、`LUX.Sphere`、`LUX.SphericalHarmonics` |

## ビルド

`SphericalHarmonics.dproj` を Delphi (FireMonkey) で開いて実行してください。

## ライセンス

[MIT License](../LICENSE) — Copyright (c) LUXOPHIA
