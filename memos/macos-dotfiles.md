# MacBook Air の dotfiles / chezmoi 管理設定

更新日：2026-11-19  
リポジトリ：[yamryo/dotfiles](https://github.com/yamryo/dotfiles)

## 1. 基本方針

MacBook Air（Apple Silicon / macOS）の個人設定を、Linux と共通の Git リポジトリで、chezmoi の管理ソースを分けて運用する。

- `linux/` は Linux 用。共通設定の基準環境は職場の Ubuntu。
- `macos/` は MacBook Air 用。Linux 用の設定は今回変更しない。
- 設定は極力 `~/.config/` に置くが、Emacs は `~/.emacs.d/` を維持する。
- GitHub との通信は **HTTPS + GitHub CLI (`gh`)** を使用する。
- 設定ファイルを chezmoi に登録し、Git の commit/push はリポジトリで実行する。
- キャッシュ、履歴、プラグイン本体、認証情報などは原則 Git に格納しない。

## 2. リポジトリと chezmoi の設定

```text
~/.local/share/chezmoi/               # Git リポジトリのルート
├── .git/
├── README.md
├── bootstrap/
├── linux/                            # Linux 用 chezmoi ソース
├── macos/                            # Mac 用 chezmoi ソース
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

- GitHub リモート：`https://github.com/yamryo/dotfiles.git`
- ローカルブランチ：`main`、upstream：`origin/main`
- リポジトリルート：`~/.local/share/chezmoi`
- Mac の sourceDir：`~/.local/share/chezmoi/macos`
- Linux の sourceDir：`~/.local/share/chezmoi/linux`

Mac 側の `~/.config/chezmoi/chezmoi.toml`：

```toml
sourceDir = "/Users/ryosuke/.local/share/chezmoi/macos"
workingTree = "/Users/ryosuke/.local/share/chezmoi"
```

確認コマンド：

```sh
chezmoi source-path
chezmoi git -- status -sb
chezmoi status
```

`chezmoi source-path` は `/Users/ryosuke/.local/share/chezmoi/macos` を返し、`chezmoi status` は差分なしを確認した。

`~/.config` の実際の権限は `700` であり、chezmoi が `private_dot_config` という管理名に変換した。これはディレクトリのアクセス制限を再現する指定で、GitHub 上で内容を非公開化したり暗号化したりするものではない。権限は変更していない。

### 新規 Mac での配置例

```sh
brew install chezmoi gh
mkdir -p "$HOME/.local/share" "$HOME/.config/chezmoi"
git clone https://github.com/yamryo/dotfiles.git "$HOME/.local/share/chezmoi"

cat > "$HOME/.config/chezmoi/chezmoi.toml" <<EOF_TOML
sourceDir = "$HOME/.local/share/chezmoi/macos"
workingTree = "$HOME/.local/share/chezmoi"
EOF_TOML

chezmoi source-path
chezmoi diff
```

新規環境への `chezmoi apply` は、既存ファイルとの競合や変更内容を `chezmoi diff` で確認してから実行する。**`~/.config/chezmoi/chezmoi.toml` は今回の管理対象外**なので新規環境では作成が必要。

また、`ZDOTDIR=~/.config/zsh` を設定するホーム直下の `~/.zshenv` は、今回登録された一覧にない。再構築時には既存の起動設定を確認し、必要なら別途用意する。Homebrew や Emacs パッケージ等のインストールは chezmoi だけでは完結しない。

## 3. GitHub の HTTPS 認証を gh に移行

導入確認時の GitHub CLI は `gh 2.105.0`。作業内容：

```sh
brew install gh
gh --version
gh auth login --hostname github.com --git-protocol https --web
gh auth status
gh auth setup-git
git config --show-origin --get-regexp '^credential(\..*)?\.helper$'
```

`gh auth setup-git` により、`~/.config/git/config` に URL 別の helper を設定：

```gitconfig
[credential "https://github.com"]
    helper =
    helper = !/opt/homebrew/bin/gh auth git-credential
[credential "https://gist.github.com"]
    helper =
    helper = !/opt/homebrew/bin/gh auth git-credential
```

macOS の Git はシステム側で `credential.helper=osxkeychain` を持つが、GitHub に対する空の `helper =` が上位 helper をリセットするため競合しない。GitHub 以外では `osxkeychain` を引き続き利用できる。`gh` のトークン本体を dotfiles に含めない。`/opt/homebrew/bin/gh` はこの Mac での実際のバイナリパス。

確認：

```sh
git remote -v          # HTTPS URL か確認
git fetch              # 実際に通信できるか確認
```

今回ローカルの旧 `master` を `main` に改名後、GitHub 側に `main` のみ存在することを確認し、以下で追跡先を修正した：

```sh
git branch -m master main  # master から変更する場合のみ
git fetch origin --prune
git branch --set-upstream-to=origin/main main
git status -sb
```

表示 `## main...origin/main` を確認。なお、旧 `origin/master` と比べた `ahead 9` は、最新 `origin/main` より9コミット進んでいることを意味するものではなかった。

## 4. chezmoi へ登録したファイル

### zsh と Starship

管理対象（`~/.config/zsh/`）：

- `.zprofile`、`.zshenv`、`.zshrc`
- `aliases.zsh`、`homebrew-ctm.zsh`
- `mamba.zsh`（保管しているが、現在は起動設定から読み込まない）
- `starship.toml`、`zsh_setting.md`

除外：`.zcompcache/`、`.zsh_sessions/`、`.zcompdump`、`.zsh_history`。

Starship の設定パスは `~/.config/zsh/starship.toml`（`$ZDOTDIR/starship.toml`）。長いパスは4階層までを表示する設定に変更した：

```toml
[directory]
truncation_length = 4
truncation_symbol = "…/"
truncate_to_repo = false
```

Git リポジトリ内でもリポジトリルートより上のパスを必要に応じて表示する。設定変更後に期待どおりの表示を確認した。

### tmux

- 管理対象：`~/.config/tmux/tmux.conf`
- 除外：`~/.config/tmux/tmux.conf.old`、`~/.config/tmux/plugins/`
- prefix：`Ctrl-U`。macOS のコピー先に `pbcopy` を使用。
- TPM のパス：`~/.config/tmux/plugins/tpm/tpm`
- 設定上のプラグイン：TPM、tmux-resurrect、tmux-continuum。
- 実際に存在することを確認したのは `tpm/` と `tmux-resurrect/`。`tmux-continuum` のインストール状態は未確認。

再構築時の TPM 導入例：

```sh
git clone https://github.com/tmux-plugins/tpm \
  "$HOME/.config/tmux/plugins/tpm"
```

tmux を起動し、TPM の通常のプラグインインストール操作（prefix + `I`）を行う。プラグイン本体は Git に登録していない。

### Git

管理対象：`~/.config/git/config`。`gh` を使う credential helper の**設定**だけを記録し、認証トークン自体は記録しない。

### Vim

管理対象（`~/.config/vim/`）：`vimrc`、`lightline-ctm.vim`。

- 不要になった `my-plugins.vim` は削除。
- 除外：`viminfo`、`.netrwhist`、`pack/` 以下のプラグイン本体。
- プラグインは Vim 標準の `pack/plugins/start/` を使用。確認された外部プラグインは lightline.vim のみで、ローカルに変更なし。

再構築時：

```sh
git clone https://github.com/itchyny/lightline.vim \
  "$HOME/.config/vim/pack/plugins/start/lightline"
```

### Emacs

Emacs は `~/.emacs.d/` のままで運用する。

管理対象：

- `init.el`
- `config/` 直下の `.el` ファイル（14ファイル）
- `snippets/` 以下の LaTeX 用 Yasnippet 群（確認時372項目）
- `dot.my.ispell_dict`（スペルチェック個人辞書）

管理対象外：

- `custom.el`：Emacs の Customize による自動更新をローカルで扱う。`package-selected-packages` の履歴や `TeX-master` の許可値を Git で共有する必要はないとの判断。
- `elpa/`、`eln-cache/`、`.cache/`、`auto-save-list/`、`backups/`、`transient/`、`history`、`recentf.eld` 等。
- 旧設定の `config/obsolute_configs/`。

不要な `snippets/latex-mode/lecture_text_template` を削除し、`chezmoi forget` と `git add -A` で管理・ステージングの両方から外した。

旧 Emacs リポジトリの `~/.emacs.d/.git/` は、新しい dotfiles を GitHub へ push したことを確認後、`~/.local/share/emacs-git-backup` に退避。Emacs の Git 管理を dotfiles に一本化した。過去の履歴はこの退避先に残っている。

## 5. 日常の更新手順

実ファイルを編集した後、管理元へ取り込む：

```sh
chezmoi add ~/.config/zsh/.zshrc  # 変更した対象の一例
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

管理済みファイルをまとめて取り込むには `chezmoi re-add` も利用できる。`chezmoi status` に出力がなければ、管理ソースと実ファイルの差分はない。

削除済みのファイルを chezmoi 管理から外す場合：

```sh
chezmoi forget ~/.emacs.d/snippets/latex-mode/lecture_text_template
cd ~/.local/share/chezmoi
git add -A -- macos/
git status -sb
```

`git diff --cached --check` では過去のスニペットなどに行末空白の警告が出ることがある。空白がテンプレートの動作に関係する可能性もあるため、一括修正はしない。

push 前には、トークン・鍵・パスワード・個人データが含まれていないか確認する。今回の簡易的な秘密情報のパターン検索は空だったが、すべての秘密情報が不存在という保証ではない。

## 6. 今回の作業履歴（2026-11-18〜19）

1. Homebrew で `gh` をインストール。GitHub にログインし、`gh auth setup-git` で HTTPS 認証を `gh` に移行。
2. ローカル `master` を `main` に改名。削除済み `origin/master` の追跡情報を整理し、`origin/main` を upstream に設定。不要な旧 `.vim/` を削除。
3. 既存の `dotfiles` クローンを `~/.local/share/chezmoi` に移動。`macos/` を sourceDir にして Linux と分離。
4. zsh・Starship・tmux・Git・Vim・Emacs の必要なファイルを選別して chezmoi に取り込み、履歴・キャッシュ・プラグイン本体を除外。
5. `chezmoi status`、ステージング内容、簡易秘密情報検索を確認。`macos/` を commit/push し、GitHub の `main` との同期を確認。
6. 独立していた Emacs の `.git/` を退避し、Git 管理を dotfiles に統合。

## 7. 今後の課題

- Homebrew のパッケージ、Emacs のパッケージ、tmux/Vim のプラグインを新しい Mac へ**完全自動**で復元する仕組みは未整備。
- `~/.config/chezmoi/chezmoi.toml` とホーム直下の `~/.zshenv` の初期導入は別途必要。
- 既存の `README.md` には `macos/` が未導入という古い記述があるため、必要に応じて更新する。
