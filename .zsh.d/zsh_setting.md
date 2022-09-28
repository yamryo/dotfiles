# Zsh 設定メモ

## 利用方法

* デフォルトシェルは `bash` のままに。
* `zsh` は `tmux` で使うこととする。`~/.tmux.conf` で以下の設定をする。
	```.tmux.conf
	set -g default-command /bin/zsh
	set -g default-shell /bin/zsh
	```

## インストール
* `/bin/zsh` にインストールされている。
* `~/.zshrc` を消去して、`~/.zsh.d` 内に全ての設定をまとめる。
以下のファイル構成とする。
	```
	/Users/ryosuke/
			|-- .zshenv
			|-- .zsh.d/
				|-- .zshrc
				|-- zinit/
				|-- starship.toml
				|-- zsh_settting.md
	```

## 設定
### クローン
* `dotfiles` を `github` からクローンして、`.zshenv` と `.zshrc` をコピー。
### プラグインマネージャ
* `zinit` を利用する。
	```zsh
	> cd ~/.zsh.d
	> git clone https://github.com/zdharma-continuum/zinit.git zinit
	```
### プロンプト
* `starship` を使う。
* スタイルの定義は `~/.zsh.d/starship.toml` に記述.

## 作業記録

#### 20220928
* プロンプトのスタイル設定を `spaceship` から `starship` に変更した。
(`spaceship` は zsh のプラグインだが，`starship` は別プログラム。)

#### 20220611
* プラグインマネージャを `zplugin` から `zinit` に変更した。

#### 20190312
* プラグインマネージャを `zplug` から `zplugin` に変更した。
