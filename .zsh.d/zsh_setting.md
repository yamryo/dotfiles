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
				|-- .zplugin/
				|-- .zsh_history
	```
## 設定
* プラグインマネージャは `zinit` を利用する。
	```zsh
	> cd ~/.zsh.d
	> git clone https://github.com/zdharma-continuum/zinit.git zinit
	```
* `dotfiles` を `github` からクローンして、`.zshenv` と `.zshrc` をコピー。

### 作業記録

#### 20220611
* プラグインマネージャを `zplugin` から `zinit` に変更した。それに伴い、このメモも編集。

#### 20190312
* プラグインマネージャを `zplug` から `zplugin` に変更した。それに伴い、このメモも編集。
