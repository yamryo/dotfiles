# MacBook Air の dotfiles / chezmoi 管理設定

更新日：2026-11-19  
リポジトリ：[yamryo/dotfiles](https://github.com/yamryo/dotfiles)

## 1. 運用方針

MacBook Air（Apple Silicon / macOS）の個人設定を chezmoi で管理する。Linux と同じ Git リポジトリを使用するが、各 OS で管理ソースを分離する。

- `linux/`：Linux 用の設定。共通設定の基準環境は職場の Ubuntu。
- `macos/`：MacBook Air 用の設定。Linux 側へは自動的に適用しない。
- 可能な範囲で XDG Base Directory に沿って `~/.config/` に設定を集約する。ただし Emacs は `~/.emacs.d/` に置く。
- 設定ファイルの管理には chezmoi、バージョン管理には Git を使う。実ファイルを変更したら chezmoi の管理ソースへ反映する。
- 履歴、キャッシュ、外部プラグイン本体、自動生成ファイル、認証情報の実体は原則として管理しない。

このメモでは dotfiles の**構成・管理範囲・運用方法**を記録し、GitHub への認証方法や通信設定の手順は扱わない。

## 2. ディレクトリ構成

```text
~/.local/share/chezmoi/                 # Git リポジトリのルート
├── .git/
├── README.md
├── bootstrap/
├── linux/                              # Linux 用 chezmoi ソース
├── macos/                              # Mac 用 chezmoi ソース
│   ├── dot_zshenv                      # ~/.zshenv
│   ├── dot_emacs.d/
│   │   ├── init.el
│   │   ├── config/
│   │   ├── snippets/
│   │   └── dot.my.ispell_dict
│   └── private_dot_config/
│       ├── git/
│       ├── tmux/
│       ├── vim/
│       └── zsh/
└── memos/
```

| 項目 | 設定 |
| --- | --- |
| リポジトリ | `~/.local/share/chezmoi` |
| macOS の `sourceDir` | `~/.local/share/chezmoi/macos` |
| Linux の `sourceDir` | `~/.local/share/chezmoi/linux` |
| Mac の chezmoi 設定 | `~/.config/chezmoi/chezmoi.toml` |
| Git ブランチ / upstream | `main` / `origin/main` |

MacBook Air の `~/.config/chezmoi/chezmoi.toml`：

```toml
sourceDir = "/Users/ryosuke/.local/share/chezmoi/macos"
workingTree = "/Users/ryosuke/.local/share/chezmoi"
```

`sourceDir` は OS ごとの設定ファイル群、`workingTree` は両 OS の設定を含む Git リポジトリ全体を示す。この `chezmoi.toml` 自体は、管理対象に含めず各マシンで用意する。

`~/.config` の権限は `700`。chezmoi ソースの `private_dot_config` という名称は、そのディレクトリ権限を再現するためのもの。**暗号化や GitHub 上での非公開化を意味しない。**

## 3. 管理対象

### 3.1 zsh / Starship

`~/.zshenv` は chezmoi で管理する。zsh が起動時に参照するホーム直下のファイルで、`ZDOTDIR=~/.config/zsh` を設定するブートストラップとして利用する。

`~/.config/zsh/` 以下で管理するファイル：

- `.zprofile`、`.zshenv`、`.zshrc`
- `aliases.zsh`、`homebrew-ctm.zsh`
- `mamba.zsh`（保存するが、現在のシェル起動設定からは読み込まない）
- `starship.toml`、`zsh_setting.md`

管理しないもの：`.zcompcache/`、`.zsh_sessions/`、`.zcompdump`、`.zsh_history` など。

`~/.config/zsh/starship.toml` のディレクトリ表示設定：

```toml
[directory]
truncation_length = 4
truncation_symbol = "…/"
truncate_to_repo = false
```

### 3.2 tmux

管理対象：`~/.config/tmux/tmux.conf`。

- prefix は `Ctrl-U`。
- macOS のクリップボードへのコピーに `pbcopy` を使用。
- TPM のパスは `~/.config/tmux/plugins/tpm/tpm`。
- TPM、tmux-resurrect、tmux-continuum を設定ファイルで宣言。
- `tmux.conf.old` と `plugins/` 内のプラグイン本体は管理しない。
- 確認時点で `tpm/` と `tmux-resurrect/` は存在。`tmux-continuum/` のインストールは未確認。

プラグインの再導入例：

```sh
git clone https://github.com/tmux-plugins/tpm \
  "$HOME/.config/tmux/plugins/tpm"
```

その後、tmux 内で TPM の通常のプラグインインストール操作（prefix + `I`）を実行する。

### 3.3 Git の設定ファイル

管理対象：`~/.config/git/config`。

Git の一般設定やエイリアスなどを共有する。**認証情報の実体は chezmoi に含めない。**

### 3.4 Vim

管理対象：

- `~/.config/vim/vimrc`
- `~/.config/vim/lightline-ctm.vim`

Vim 標準の `pack/plugins/start/` を利用する。プラグイン本体は別途導入するため、`pack/` 以下を chezmoi に含めない。`viminfo`、`.netrwhist` などの履歴も除外する。

lightline.vim の再導入例：

```sh
git clone https://github.com/itchyny/lightline.vim \
  "$HOME/.config/vim/pack/plugins/start/lightline"
```

### 3.5 Emacs

Emacs の設定配置先は `~/.emacs.d/` を維持する。

管理対象：

- `init.el`
- `config/` 直下の `.el` 設定ファイル14個
- `snippets/` 以下の LaTeX 用 Yasnippet 群（確認時372項目。不要な `lecture_text_template` は含まない）
- `dot.my.ispell_dict`（個人辞書）

管理しないもの：

- `custom.el`：Emacs Customize が更新するローカル設定として保持する。
- `elpa/`、`eln-cache/`、`.cache/`、`auto-save-list/`、`backups/`、`transient/` などの生成・状態データ。
- `history`、`recentf.eld` などの履歴。
- `config/obsolute_configs/` などの旧設定。

Emacs のバージョン管理は、この dotfiles リポジトリに統一している。以前の独立した Git リポジトリのメタデータは `~/.local/share/emacs-git-backup` に退避済み。

## 4. 日常の管理手順

### 実ファイルを変更したとき

対象ファイルを chezmoi に取り込み、差分を確認して Git に記録する。

```sh
chezmoi add ~/.config/zsh/.zshrc    # 例：変更したファイルを取り込む
chezmoi status

cd ~/.local/share/chezmoi
git status -sb
git diff -- macos/
git add -A -- macos/
git diff --cached --stat
git diff --cached --check
git diff --cached
git commit -m "Update macOS dotfiles"
git push
```

複数の管理済みファイルをまとめて取り込みたい場合は `chezmoi re-add` も利用できる。新規ファイルは必要なものを選別して `chezmoi add` する。

`git diff --cached --check` では既存のスニペット等の行末空白が警告される場合がある。空白に意味がある可能性を考え、一括で機械的に修正しない。

### 不要になったファイルを管理から外すとき

実ファイルを削除した後、必要に応じて次を実行する。

```sh
chezmoi forget /path/to/deleted/file
cd ~/.local/share/chezmoi
git add -A -- macos/
git status -sb
```

`chezmoi forget` は chezmoi の管理から外す操作であり、実ファイルを削除するためのコマンドではない。

### 状態の確認

```sh
chezmoi source-path
chezmoi managed
chezmoi status
git -C ~/.local/share/chezmoi status -sb
```

- `chezmoi source-path` は macOS のソースディレクトリを指す。
- `chezmoi status` が空なら、管理ソースと現在の実ファイルに差分がない。
- Git の作業ツリーがクリーンで upstream と同期していれば、`git status -sb` は通常 `## main...origin/main` と表示される。
- リポジトリへ保存する前に、秘密情報や不要な個人データが含まれていないか確認する。

## 5. 新しい Mac への導入

`chezmoi` と Git が利用できる状態で、リポジトリを取得し、chezmoi の設定を作成する。

```sh
brew install chezmoi
mkdir -p "$HOME/.local/share" "$HOME/.config/chezmoi"
git clone https://github.com/yamryo/dotfiles.git "$HOME/.local/share/chezmoi"

cat > "$HOME/.config/chezmoi/chezmoi.toml" <<EOF_TOML
sourceDir = "$HOME/.local/share/chezmoi/macos"
workingTree = "$HOME/.local/share/chezmoi"
EOF_TOML

chezmoi source-path
chezmoi diff
```

差分を確認して問題がない場合に限り、次を実行する。

```sh
chezmoi apply
chezmoi status
```

`~/.zshenv` も `macos/dot_zshenv` から復元されるため、`ZDOTDIR` のブートストラップを別途手動作成する必要はない。ただし、すでに `~/.zshenv` がある環境では **上書きされる内容を `chezmoi diff` で確認**する。

`chezmoi.toml` の作成、Homebrew のパッケージ、Emacs のパッケージ、Vim・tmux のプラグインなどの導入は、現時点では一括自動化していない。chezmoi が復元するのは、原則として管理対象の設定ファイルである。
