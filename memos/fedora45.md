# Fedora 45 セットアップ記録

更新日: 2026-11-15

## 目的と運用方針

2012年のMacBook ProをFedora 45で再利用し、職場Ubuntu 24.04を基準とする研究・執筆環境を整える。

- デスクトップはGNOME（Wayland）。動作に問題があればMATE等への移行を検討する。
- ホーム直下の設定ファイルを増やさず、可能な限り `~/.config` 以下へ集約する。
- Linux共通の設定はchezmoiで管理する。ただし、職場Ubuntuが共通設定の基準環境。
- 設定ファイルの取り込みはchezmoi、Git操作はリポジトリ内の通常の `git` コマンドで行う。
- Fedora固有の設定や、個人認証情報・バイナリDBは無理にdotfilesへ含めない。

## 基本環境

| 項目 | 設定・確認内容 |
| --- | --- |
| PC | MacBook Pro（2012年モデル） |
| OS | Fedora 45 |
| デスクトップ | GNOME / Wayland |
| カーネル | 7.3.3-300.fc45.x86_64 で動作確認 |
| Wi-Fi | Broadcom BCM4331。RPM Fusionの `akmod-wl` / `wl` ドライバーで接続 |
| シェル | zsh、Starship |
| 端末内作業 | tmux、Vim、Emacs |
| 日本語入力 | fcitx5 + Mozc |

### ハードウェア・GNOME

- Broadcom BCM4331は標準ドライバーではなく、`wl` を使用してWi-Fi接続を確立。
- Intel Ivy Bridgeのi915環境でGNOME/Waylandを使用。サスペンド・復帰も確認済み。
- 以前のカーネル7.2.11は予備として保持。
- 画面に一時的な横線が見られたことがあるが、確認時点ではGPU関連エラーを特定できていない。再発時に調査する。
- 自動ログイン、画面ロック関連の設定を調整。
- Appleキーボードのファンクションキーを通常のF1–F12として使うため、`hid_apple fnmode=2` を `/etc/modprobe.d/hid_apple.conf` に設定し、dracutで反映。
- Firefoxの日本語フォント表示対策として、`font.cjk_pref_fallback_order` の優先順を `ja` 始まりに調整。
- GNOMEのEmacs風キーバインドは `gsettings set org.gnome.desktop.interface gtk-key-theme 'Emacs'` で設定。Firefoxの一部入力欄には効くが、ChatGPTの独自エディターでは `Ctrl-a` が全選択になる場合がある。

### 日本語入力（fcitx5 + Mozc）

- JISキーボードの英数キー（`Hangul_Hanja` として認識）を入力切り替えに利用。
- Wayland上で候補ウィンドウの点滅が発生したため、`GTK_IM_MODULE=fcitx` を設定しない構成に変更したところ改善。
- `fcitx5-autostart` パッケージを外し、ユーザーのautostart設定でfcitx5を起動。
- `~/.config/environment.d/90-fcitx5.conf` では `QT_IM_MODULE=fcitx` と `XMODIFIERS=@im=fcitx` を設定（GTK用変数は設定しない）。
- fcitx5のプロファイルとMozcのバイナリ設定DBは、機種・デスクトップ・バージョン依存性を考慮してchezmoiの管理対象から除外。各マシンで設定する。

## dotfiles / シェル / Git

リポジトリ: [yamryo/dotfiles](https://github.com/yamryo/dotfiles)

- chezmoiのGit作業ツリー: `~/.local/share/chezmoi`
- Linux向けソースディレクトリ: `~/.local/share/chezmoi/linux`
- chezmoiの設定: `~/.config/chezmoi/chezmoi.toml` の `sourceDir` と `workingTree`
- `ZDOTDIR=~/.config/zsh` を採用。ホーム直下の `~/.zshenv` は引き続き必要。
- `~/.config/zsh/.zshrc`、Starship、Git、tmux、Vim、Emacs等をchezmoiで管理。
- zshのクリップボード貼り付け（Ctrl-Y）にはWayland用の `wl-paste --no-newline` を利用。
- tmuxはプレフィックス `Ctrl-U`、マウス操作有効、コピー先は `wl-copy`。TPM、tmux-resurrect、tmux-continuumを利用。
- GitHubのHTTPS認証はGitHub CLI（`gh auth login` / `gh auth setup-git`）へ移行。認証トークン本体はdotfilesに含めない。
- StarshipのPythonバージョン表示は、Python関連のファイルがあるディレクトリで自動表示される既定動作を維持。

設定変更後の通常手順:

```sh
chezmoi re-add
cd ~/.local/share/chezmoi
git status
git diff
git add -A
git diff --cached
git commit -m "Update dotfiles"
git push
```

**注意:** Fedora側で変更した共通設定は、職場Ubuntuへの反映前に互換性を確認する。特にWayland専用コマンド・Fedora固有のパスには注意。

## Emacs / LaTeX

### Emacs

- FedoraではEmacs 31（PGTK版）を使用。
- Vertico、Consult、cmigemo、AUCTeX、RefTeX等を使用。
- `init.el` にあった、ログインシェルからPATHを取得する処理がzshの出力を取り込んで `exec-path` を壊すことがあったため、呼び出しを無効化。これにより `cmigemo` の検出が正常化。
- AUCTeXのPDFビューアーは特定アプリ（Papers / Atril）に固定せず、`xdg-open %o` を使用。FedoraとUbuntuで既定のビューアーを使い分ける。
- WaylandではEmacsのウィンドウ位置指定（`left` / `top`）が効かない場合がある。

### TeX Live

FedoraのDNFからTeX Live 2026を導入した。

```sh
sudo dnf install \
  texlive-scheme-medium \
  texlive-collection-latexextra \
  texlive-collection-mathscience \
  texlive-collection-fontsrecommended \
  texlive-collection-langjapanese \
  latexmk biber
```

確認済み: pdfTeX 1.40.29、LuaHBTeX 1.24.0、latexmk 4.88、`amsmath.sty`、`bxjsarticle.cls`。Emacs/AUCTeXからのタイプセットも成功。

## Miniforge / SageMath / JupyterLab

### インストール先と方針

- Miniforge: `~/.local/share/miniforge3`
- conda環境名: `sage109`
- condaとmambaは同じ環境を扱う。運用コマンドは原則 `conda` に統一。
- 確認時のcondaは26.9.4、solverは`libmamba`。
- `conda init` に頼らず、zshの設定で `conda.sh` を読み込む。
- `condarc` は `~/.config/conda/condarc` に置き、chezmoiで共有。

`condarc` の内容:

```yaml
auto_activate: false
changeps1: false
channel_priority: strict
```

構築時のコマンド（再現用）:

```sh
curl -fL \
  https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh \
  -o ~/Downloads/Miniforge3-Linux-x86_64.sh

bash ~/Downloads/Miniforge3-Linux-x86_64.sh \
  -b -p "$HOME/.local/share/miniforge3"

# conda.sh をシェルから利用できる状態で:
conda create -n sage109 \
  'python=3.13' 'sage=10.9' 'jupyterlab=4.6.*' ipykernel

conda activate sage109
python -m pip install snappy knot_floer_homology
```

実際の初回環境作成にはmambaを使ったが、上記の`conda create`でも同等の環境を構築できる。

### 2026-11-15 の確認結果

| 項目 | 結果 |
| --- | --- |
| SageMath | 10.9 |
| Python | 3.13.18 |
| JupyterLab | 4.6.6 |
| SnapPy | 3.3.2 |
| knot_floer_homology | import成功 |
| Jupyter kernelspec | `python3`、`sagemath` |
| knot_floer_homology テスト | module: 40/40成功、regression: 1/1成功 |

確認コマンド:

```sh
conda activate sage109
sage --version
python --version
jupyter lab --version
jupyter kernelspec list
python -c "import snappy; print(snappy.__version__)"
python -c "import knot_floer_homology; print('OK')"
python -m knot_floer_homology.test
```

### Jupyter Serverの起動と認証

設定ファイル: `~/.config/jupyter/jupyter_server_config.py`（chezmoi管理）

```python
c = get_config()
c.ServerApp.open_browser = False
c.ServerApp.ip = "127.0.0.1"
c.ServerApp.port = 8888
c.ServerApp.port_retries = 0
```

zshで設定済みの環境変数:

```sh
export JUPYTER_CONFIG_DIR="$HOME/.config/jupyter"
export JUPYTERLAB_SETTINGS_DIR="$HOME/.config/jupyter/lab/user-settings"
export JUPYTERLAB_WORKSPACES_DIR="$HOME/.local/state/jupyterlab/workspaces"
```

通常の起動方法:

```sh
conda activate sage109
cd /path/to/notebooks    # 実際にcloneしたディレクトリに置き換える
jupyter lab
```

- JupyterLabはブラウザを自動起動しない。
- ブラウザでは `http://127.0.0.1:8888/lab` をブックマークしてアクセス。
- JupyterLabのルートは起動したディレクトリ。別途固定ルートの設定は設けていない。
- `jupyter server password` でローカルに認証パスワードを設定。認証設定を含むJSONファイルはGitへ登録しない。
- トークン認証の仕組み自体は引き続き存在する。ブラウザの認証Cookieが残っていれば再入力が省略される。
- 接続先はループバックアドレスに限定しており、ネットワーク経由での公開はしない。
- JupyterLabのブラウザ表示と `python3` / `sagemath` のカーネル登録まで確認済み。**両カーネルでのノートブック内計算の実行確認は別途行う。**

## chezmoiで管理するもの・しないもの

| 対象 | 方針 |
| --- | --- |
| `~/.config/conda/condarc` | 管理する |
| `~/.config/jupyter/jupyter_server_config.py` | 管理する |
| `~/.config/zsh/.zshrc` 相当のzsh設定 | 既存の管理対象（chezmoiソース: `linux/dot_config/zsh/dot_zshrc`） |
| `sage109` の実体、キャッシュ | 管理しない。構築手順を本メモに記録 |
| Jupyterの認証情報・パスワード設定JSON | 管理しない |
| Mozcの設定DB、fcitx5の端末依存設定 | 原則管理しない |
| Fedoraのシステム設定（`/etc`）、カーネルドライバー | 管理しない。必要な手順を本メモに記録 |

## 未確認・今後の確認

1. JupyterLabで既存のノートブックを開き、PythonとSageMathの各カーネルで実際にセルを実行する。
2. Fedoraでの設定変更を職場Ubuntuに反映する際、Wayland依存部分やパスの違いを検証する。
3. GNOMEで発生した画面横線が再発するか様子を見る。
4. パッケージの完全な再現性が必要になれば、別途conda環境のエクスポートやバージョン固定を検討する。
