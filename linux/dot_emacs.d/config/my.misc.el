;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;*  ryosuke の個人的設定 (~/.emacs.d/init.el から読まれる)
;;     Time-stamp: <2026-11-08 00:40:43 (ryosuke)>

;;---------------------------
;;* Global Key Bindings
;;---------------------------
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-x !") 'eval-buffer)
(global-set-key (kbd "C-c >") 'comment-region)
(global-set-key (kbd "C-c <") 'uncomment-region)
(global-set-key (kbd "<f12>") (set-cursor-color "RoyalBlue3"))
;(global-set-key (kbd "<Scroll_Lock>") 'ignore)
;(global-set-key (kbd "<C-Scroll_Lock>") 'ignore)

;;---------------------------
;;* Misc
;;---------------------------
;; emacsのオープニング画面表示
(setq inhibit-startup-message t) ; 表示しない

;;; メニューバーの非表示
(setq transient-mark-mode t)

;;; 同一ファイル名の時，ディレクトリも同時に表示
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;;; インデントで TAB ではなくスペースを挿入
(setq-default indent-tabs-mode nil)

;;; ツールバーを非表示
(tool-bar-mode 0)
;(setq tool-bar-style 'text)
;;; ツールバーを一時的に非表示
;;(require 'tool-bar+)
;;(tool-bar-pop-up-mode -1)

;;; スクロールバーの非表示
(set-scroll-bar-mode nil)

;;; visible-bell
(setq visible-bell t)

;;; 行番号を mode-line とウインドウ左端に表示する。 [default: t]
(line-number-mode t) ;0) ;
(display-line-numbers-mode t)

;;; カーソルの点滅をやめる
;;(blink-cursor-mode 0)

;;; 画像表示
;(auto-image-file-mode)

;;; 括弧をハイライトする
(show-paren-mode t) ;0) ;

;;; クリップボードを使用できるようにする
(setq x-select-enable-clipboard t)

;;; 長い行の折り返し
(setq-default truncate-lines t)                  ;; 折り返ししない
(setq-default truncate-partial-width-windows t)  ;; 折り返ししない

;;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)

;;; 一行が 100 字以上になった時には自動改行する
;; (setq fill-column 100)
;; (setq text-mode-hook 'turn-on-auto-fill)
;; (setq default-major-mode 'text-mode)

;;; 円マークキーでバックスラッシュが入力されるようにする
(define-key global-map [?¥] [?\\])

;;; 最終更新日の自動挿入
;;;   ファイルの先頭から 8 行以内に Time-stamp: <> または Time-stamp: " " と
;;;   書いてあれば、セーブ時に自動的に日付が挿入されます.
(add-hook 'before-save-hook 'time-stamp) ;;[Note: 'write-file-hooks' is obsolete since 22.1]
(setq time-stamp-format "%:y-%02m-%02d %02H:%02M:%02S (%u)")

;;; バックアップファイルを一箇所にまとめる
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;;; タッチパッドに触れる誤作動対策
(global-unset-key (kbd "C-<down-mouse-1>"))

;;
;;* End of File
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
