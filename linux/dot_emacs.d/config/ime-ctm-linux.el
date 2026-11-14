;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 日本語入力方法の設定 (./.emacs.d/elisp/ime-ctm.el から読まれる)
;;     Time-stamp: <2024-02-29 16:54:05 (ryosuke)>

(setq initial-cc "RoyalBlue3")     ;; change the color of cursor

;;----------------------------------
;; Mozc
;;----------------------------------
(use-package mozc
  :ensure t
  :bind* ("<muhenkan>" . toggle-input-method) ;(lambda () (interactive) (toggle-input-method))))
  :init
  (setq default-input-method "japanese-mozc"
        mozc-helper-program-name "mozc_emacs_helper")
  :config
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
