;;; ime-ctm.el --- Display settings -*- lexical-binding: t; -*-
;;;
;;;  Time-stamp: <2026-09-28 21:45:39 (ryosuke)>

;;-----------------------------------------------
;;* mac-ime
;;-----------------------------------------------
(use-package mac-ime
  :ensure t
  :init
  (setq default-input-method "mac-ime")
  :config
  (mac-ime-enable)

  (defvar my/mac-ime-original-cursor-color nil)

  (add-hook 'input-method-activate-hook
            (lambda ()
              (setq my/mac-ime-original-cursor-color
                    (frame-parameter nil 'cursor-color))
              (set-cursor-color "coral3"))) ;"maroon4")))  ;"coral4"))) ;

  (add-hook 'input-method-deactivate-hook
            (lambda ()
              (when my/mac-ime-original-cursor-color
                (set-cursor-color my/mac-ime-original-cursor-color))))
  )

;;; ime-ctm.el ends here
