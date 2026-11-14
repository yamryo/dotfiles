;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 日本語入力方法の設定 (./.emacs.d/init.el から読まれる)
;;     Time-stamp: <2026-11-08 10:06:53 (ryosuke)>


(global-set-key "\C-xj" 'toggle-input-method) ;'skk-mode)
(global-unset-key "\C-j")
(global-unset-key "\C-\\")

(setq initial-cc "RoyalBlue3")     ;; change the color of cursor

;; ----------------------------------------
;; Japanese Input: Mozc
;; ----------------------------------------
(use-package mozc
  :ensure nil
  :demand t
  :init
  (setq default-input-method "japanese-mozc")
  :config
  (setq mozc-helper-program-name "/usr/bin/mozc_emacs_helper"
        mozc-candidate-style 'echo-area)

  ;; 無変換キーによる日本語入力のトグル
  (global-set-key (kbd "<Hangul_Hanja>") #'toggle-input-method)

  (add-hook 'input-method-activate-hook
            (lambda ()
               (set-cursor-color "coral4")))
  (add-hook 'input-method-deactivate-hook
            (lambda ()
               (set-cursor-color initial-cc)))
  )

;; others
(defadvice mozc-handle-event (around intercept-keys (event))
  "Intercept keys muhenkan and zenkaku-hankaku, before passing keys to mozc-server (which the function mozc-handle-event does), to properly disable mozc-mode."
  (if (member event (list 'zenkaku-hankaku 'muhenkan))
      (progn (mozc-clean-up-session)
             (toggle-input-method))
    (progn ;(message "%s" event) ;debug
      ad-do-it)))
(ad-activate 'mozc-handle-event)

;;;
;;; End of File
;;;
