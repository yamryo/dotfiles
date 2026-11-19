;;; display-ctm.el --- Display settings -*- lexical-binding: t; -*-
;;;
;;;  Time-stamp: <2026-09-15 17:57:20 (ryosuke)>
;;;  Since 060210

;;-----------------------------------------------
;;* whitespace mode
;;-----------------------------------------------
(use-package whitespace
  :ensure nil
  :init
  (setq whitespace-style '(face           ; faceで可視化
                           trailing       ; 行末
                           tabs           ; タブ
                           spaces         ; スペース
                           empty          ; 先頭/末尾の空行
                           space-mark     ; 表示のマッピング
                           tab-mark) )
  (setq whitespace-display-mappings
        '((space-mark ?\u3000 [?\u25a1])
          (tab-mark ?\t [?\u00BB])))

  (setq
   whitespace-space-regexp "\\(\u3000+\\)"  ;; スペースは全角のみを可視化
   whitespace-action '(auto-cleanup)        ;; 保存前に自動でクリーンアップ
   )
  (global-whitespace-mode 1)
  :config
  (defvar my/whitespace-bg-color "#faebd7") ;"#232323")
  (set-face-attribute 'whitespace-trailing nil
                      :background my/whitespace-bg-color
                      :foreground "DeepPink"
                      :underline t)
  (set-face-attribute 'whitespace-tab nil
                      :background nil ;my/whitespace-bg-color
                      :foreground my/whitespace-bg-color ;"LightSkyBlue"
                      :underline t)
  (set-face-attribute 'whitespace-space nil
                      :background my/whitespace-bg-color
                      :foreground "GreenYellow"
                      :weight 'bold)
  (set-face-attribute 'whitespace-empty nil
                      :background my/whitespace-bg-color)
  )

;;-----------------------------------------------
;;* For mouse-avoidance-mode
;;-----------------------------------------------
;; Move mouse pointer away from the text cursor.
(when window-system
  (mouse-avoidance-mode 'exile))

;; Allow commands to use the mark even when it is inactive.
(setq mark-even-if-inactive t)

;;-----------------------------------------------
;;* rainbow-delimiters
;;-----------------------------------------------
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode)
  )

;;-----------------------------------------------
;;* doom-modeline
;;-----------------------------------------------
(use-package doom-modeline
  :ensure t
  ;;  :init (doom-modeline-mode 1))
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 25)
  (doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-state-icon t)
  (doom-modeline-buffer-modification-icon t)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-time nil)
  )

;;; display-ctm.el ends here
