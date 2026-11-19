;;; auctex-ctm.el --- AUCTeX settings -*- lexical-binding: t; -*-
;;
;;*  AUCTeX の設定 (~/.emacs.d/init.el から読まれる)
;;      Time-stamp: <2026-09-26 22:18:23 (ryosuke)>
;;
(use-package tex
  :ensure auctex
  :custom
  (TeX-engine 'luatex) ;'uptex)
  (japanese-TeX-engine-default 'luatex) ;'uptex)
  (TeX-view-program-selection '((output-pdf "Skim")))
  ;;---
  (TeX-source-correlate-mode t) ;nil) ;
  (TeX-source-correlate-method 'synctex)
  (TeX-source-correlate-start-server t)
  ;;---
  (japanese-LaTeX-default-style "ltjsarticle") ;"bxjsarticle"); "jlreq");
  (LaTeX-electric-left-right-brace t)
  (TeX-electric-math (cons "$" "$"))
  (TeX-electric-sub-and-superscript t)
  (font-latex-fontify-script nil) ;t) ;
  (font-latex-fontify-sectioning 1.0)
  (TeX-master nil)
  :bind
  ("C-c C-t j" . TeX-command-run-all)
  :config
  ;; 使用しないコマンドを選択肢から除外する
  (dolist (command '("pTeX" "pLaTeX" "pBibTeX" "jTeX" "jLaTeX" "jBibTeX" "Mendex"))
  (setq TeX-command-list
        (delq (assoc command TeX-command-list)
              TeX-command-list)))
  ;;---
  (add-hook 'LaTeX-mode-hook (lambda ()
                               (LaTeX-math-mode t)
                               (flyspell-mode t)))
  (add-hook 'LaTeX-mode-hook
            (function
             (lambda ()
               (add-to-list 'TeX-command-list
                            '("Latexmk-LuaLaTeX"
                              "latexmk -e '$lualatex=q/lualatex %%O %(file-line-error) %(extraopts) %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -norc -gg -pdflua %t"
                              TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaLaTeX"))
               ))
            )
  )


;;--------------------------------------
;;* RefTeX with AUCTeX
;;
(use-package reftex
  :ensure nil
  :custom (reftex-plug-into-AUCTeX t)
  :bind (:map reftex-mode-map
              ("C-c (" . reftex-reference)
              ;; prevent RefTeX from defining the following key-bindings
              ("C-c >" . nil)
              ("C-c <" . nil))
  :init
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  )

;;--------------------------------------
;;* Yasnippet
;;
(use-package yasnippet
  :ensure t
  :hook ((text-mode
          ;; tex-mode
          ;; Tex-mode
          ;; LaTeX-mode
          ;;latex-mode
          prog-mode) . yas-minor-mode-on)
  :bind (nil
         :map yas-keymap
         ;; ("<tab>" . nil)
         ;; ("TAB" . nil)
         ("<backtab>" . nil)
         ("S-TAB" . nil)
         ("M-]" . yas-next-field-or-maybe-expand)
         ("M-[" . yas-prev-field))
  :config
  (yas-reload-all)
  (defun yas-texmathp () (require 'texmathp) (texmathp))
  ;; (add-hook 'TeX-mode-hook #'yas-minor-mode-on)
  ;;(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  )


;; ;;--------------------------------------
;; ;;* lsp-latex
;; ;;
;; (use-package lsp-latex
;;   :custom (lsp-latex-build-on-save t)
;;   )

;; (with-eval-after-load "tex-mode"
;;   (add-hook 'tex-mode-hook 'lsp)
;;   (add-hook 'latex-mode-hook 'lsp))
;; ;; For bibtex
;; (with-eval-after-load "bibtex"
;;   (add-hook 'bibtex-mode-hook 'lsp))
