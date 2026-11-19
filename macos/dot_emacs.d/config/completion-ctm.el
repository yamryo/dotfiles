;;; completion-ctm.el --- Completion settings -*- lexical-binding: t; -*-
;;*  入力補完機能の設定 (~/.emacs.d/init.el から読まれる)
;;   Time-stamp: <2026-09-17 09:54:27 (ryosuke)>

;;--------------------------------------
;;* Corfu
;;
(use-package corfu
  :ensure t
  :custom ((corfu-auto t)
           (corfu-auto-delay 0.25)
           (corfu-auto-prefix 2)
           (corfu-on-exact-match nil)
           (tab-always-indent 'complete)
           (corfu-quit-at-boundary 'separator)
           (corfu-separator ?\s)
           (corfu-cycle nil)
           (corfu-preselect 'first)
           )
  :bind (nil
         :map corfu-map
         ;; ("TAB" . corfu-insert)
         ;; ("<tab>" . corfu-insert)
         ("TAB" . nil)
         ("<tab>" . nil)
         ("<backtab>" . corfu-insert)
         ("C-<tab>" . corfu-insert)
         ("S-<tab>" . corfu-insert)
         ;---
         ("RET" . nil)
         ("<return>" . nil))
  :init
  (global-corfu-mode +1)
  ;; (corfu-popupinfo-mode)
  :config
  (corfu-echo-mode 1)
  ;; ミニバッファー上でverticoによる補完が行われない場合、corfuの補完が出るようにします。
  ;; https://github.com/minad/corfu#completing-in-the-minibuffer
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active)
                (bound-and-true-p vertico--input))
      ;; (setq-local corfu-auto nil) ;; Enable/disable auto completion
      (setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
                  corfu-popupinfo-delay nil)
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)
  )

;;--------------------------------------
;;* cape.el - Let your completions fly!
;;--------------------------------------
(use-package cape
  :ensure t
  :bind (("C-c p f" . cape-file)
         ("C-c p d" . cape-dabbrev)
         ("C-c p k" . cape-keyword)
         ("C-c p t" . cape-tex))
  :custom
  ;; 単語候補は現在のバッファから探す
  (cape-dabbrev-check-other-buffers nil)
  :init
  ;; モード固有の補完を保持し、追加の補完を後ろに登録する。
  ;; 数字は実行順序。小さいものから試される。
  (add-hook 'completion-at-point-functions #'cape-file 90)
  (add-hook 'completion-at-point-functions #'cape-keyword 91)
  (add-hook 'completion-at-point-functions #'cape-dabbrev 92))


;; ;;--------------------------------------
;; ;;* Kind-icon
;; ;;
(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-use-icons t)
  (kind-icon-default-face 'corfu-default) ; Have background color be the same as `corfu' face background
  (kind-icon-blend-background nil)  ; Use midpoint color between foreground and background colors ("blended")?
  (kind-icon-blend-frac 0.08)

  ;; NOTE 2022-02-05: `kind-icon' depends `svg-lib' which creates a cache
  ;; directory that defaults to the `user-emacs-directory'. Here, I change that
  ;; directory to a location appropriate to `no-littering' conventions, a
  ;; package which moves directories of other packages to sane locations.
;  (svg-lib-icons-dir (no-littering-expand-var-file-name "svg-lib/cache/")) ; Change cache dir
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter) ; Enable `kind-icon'
  )

;; conpletion-ctm.el ends here
