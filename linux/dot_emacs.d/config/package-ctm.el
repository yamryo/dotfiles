;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  package 管理の設定 (~/.emacs.d/init.el から読まれる)
;;  Time-stamp: <2023-05-21 23:10:49 (ryosuke)>

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("gnu" . "https://elpa.gnu.org/packages/")))

;; use-packageがインストールされていなかったらuse-packageをインストール
(dolist (package '(use-package))
   (unless (package-installed-p package)
       (package-install package)))

(require 'use-package)
(use-package auto-compile
  :ensure t
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

;;-----------------------------------
;; パッケージの更新
;;-----------------------------------
;パッケージの更新時に以下のファイルを上書き保存することとする
(setq recfile "~/.emacs.d/update_record")
;ファイルの最終更新日時取得
(setq last-update (if (file-exists-p recfile)
                      (nth 5 (file-attributes recfile)) ; 記録ファイルがあるなら，その更新日時を
                    (encode-time 0 0 0 1 1 2001) ; そうでないなら，2001/01/01 00:00:00 をセット
                    ))
;最終更新日時からの経過日数
(setq elapsed-days (- (time-to-days (current-time)) (time-to-days last-update)))

;最終更新日時からの経過日数が15日以上であれば，パッケージの更新を実行するかどうか聞く
(if (and
     (>  elapsed-days 14)
     (y-or-n-p "Do you want to update packages? ['Ux' updates packages in the package.el UI.]")
     )
    (progn
      (with-temp-buffer
        ; temp buffer に時刻を記入
        (insert (concat (current-time-string) "\n"))
        ; ファイルに保存 (ファイルが無い場合は，作成して保存してくれる．)
        (append-to-file (point-min) (point-max) recfile)
        )
      (package-list-packages)
      )
  )

;; End of File
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
