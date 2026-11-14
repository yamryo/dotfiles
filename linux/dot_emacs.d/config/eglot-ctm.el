;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;*  Eglot の設定 (~/.emacs.d/init.el から読まれる)
;;      Time-stamp: <2024-03-07 17:39:44 (ryosuke)>
;;
(use-package eglot
  :bind (nil
         :map eglot-mode-map
         ("C-c a" . eglot-code-actions))
  :init
;  (add-hook 'TeX-mode-hook 'eglot-ensure)
  :config
  (delete (assoc `(tex-mode context-mode texinfo-mode bibtex-mode)
                 eglot-server-programs) eglot-server-programs)
  (add-to-list 'eglot-server-programs
               `((latex-mode LaTeX-mode tex-mode TeX-mode) . ("texlab")))
  )

(use-package flymake
  :ensure nil
  ;; :bind (nil
  ;;        :map flymake-mode-map
  ;;        ("C-c C-p" . flymake-goto-prev-error)
  ;;        ("C-c C-n" . flymake-goto-next-error))
  :config
  (set-face-background 'flymake-errline "red4")
  (set-face-background 'flymake-warnline "DarkOrange"))
