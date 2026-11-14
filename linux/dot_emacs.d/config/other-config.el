;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;*  いくつかの追加機能の設定 (~/.emacs.d/init.el から読まれる)
;;   Time-stamp: <2024-03-01 12:10:07 (ryosuke)>

;;----------------------------------------------
;;* スペルチェック
;;
(setq-default ispell-program-name "aspell")
(with-eval-after-load "ispell"
  (setq ispell-local-dictionary "en_US")
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))  ; 日本語をスキップ
  )
;;  Encoded-KbdマイナーモードでispellのキーバインドM-$が乗っ取られるのを防止
;;(define-key encoded-kbd-mode-map "\e" nil)
;;  スペルチェック辞書
 (setq ispell-personal-dictionary
       "~/.emacs.d/dot.my.ispell_dict")

;;----------------------------------------------
;;* Dired の設定
;;
(setq dired-recursive-copies 'always)  ; ディレクトリを再帰的にコピー可能にする
(setq dired-recursive-deletes 'top)    ; 最上位ディレクトリごとに削除の確認
(setq dired-listing-switches "-GAFlh") ; ls オプション指定
                                       ; --time-style=long-iso --group-directories-first

;;----------------------------------------------
;;* goto-chg
;;
(use-package goto-chg
  :ensure t
  :bind (([f8] . 'goto-last-change)
         ([M-f8] . 'goto-last-change-reverse))
  )

;; ;;----------------------------------------------
;; ;;* web-mode
;; ;;
;; (use-package web-mode
;;   :defer t
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;;   (defun my-web-mode-hook ()
;;     "Hooks for Web mode."
;;     ;; インデント設定
;;     (setq web-mode-markup-indent-offset 2)
;;     (setq web-mode-css-indent-offset 2)
;;     (setq web-mode-code-indent-offset 2)

;;     ;; 要素のハイライト
;;     (setq web-mode-enable-current-element-highlight t)

;;     ;; フォントの配色
;;     (set-face-attribute 'web-mode-doctype-face nil :foreground "Pink3")
;;     (set-face-attribute 'web-mode-html-tag-face nil :foreground "Green")
;;     (set-face-attribute 'web-mode-html-attr-value-face nil :foreground "Yellow")
;;     (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "#0FF")

;;     ;; タグを自動で閉じる
;;     (setq web-mode-enable-auto-pairing t)
;;     (setq web-mode-enable-auto-closing t)
;;     )
;;   (add-hook 'web-mode-hook  'my-web-mode-hook)
;;   )


;;;;;;;;;;;;;;;;;
;; End of File ;;
;;;;;;;;;;;;;;;;;
