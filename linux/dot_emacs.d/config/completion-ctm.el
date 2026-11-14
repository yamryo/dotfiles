;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;*  入力補完機能の設定 (~/.emacs.d/init.el から読まれる)
;;   Time-stamp: <2024-03-07 10:28:12 (ryosuke)>

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
           (corfu-preselect-first t)
           (corfu-echo-documentation t))
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

;; ;;--------------------------------------
;; ;;* tabnine
;; ;;
;; (use-package tabnine
;;   :ensure t
;;   :hook ((prog-mode . tabnine-mode)
;;          (text-mode . tabnine-mode)
;;          (kill-emacs . tabnine-kill-process))
;;   :bind (:map  tabnine-completion-map
;;                ("TAB" . nil)
;;                ("<tab>" . nil)
;;                ("C-<tab>". tabnine-accept-completion))
;;   :init
;;   ;; (tabnine-start-process)
;;   (global-tabnine-mode +1)
;;   :config
;;   ;; (setq-default tabnine-auto-complete t)
;;   (add-to-list 'kind-icon-mapping '(tabnine "ai" :icon "cloud" :face shadow) t))

;;--------------------------------------
;;* cape.el - Let your completions fly!
;;
(use-package cape
  :ensure t
  :hook (((prog-mode
           text-mode
           conf-mode
           eglot-managed-mode
           lsp-completion-mode
           latex-mode) . my/set-super-capf))
  :custom ((cape-dabbrev-check-other-buffers nil))
  :config
  (defun my/set-super-capf (&optional arg)
    (setq-local completion-at-point-functions
                (list (cape-capf-noninterruptible
                       (cape-capf-buster
                        (cape-capf-properties
                         (cape-capf-super
                          (if arg
                              arg
                            (car completion-at-point-functions))
                          ;; #'tabnine-completion-at-point
                          #'cape-dabbrev
                          #'cape-file)
                         :sort t
                         :exclusive 'no))))))
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-file)
;  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  ;; (add-to-list 'completion-at-point-functions #'tabnine-completion-at-point)
  ;; (add-to-list 'completion-at-point-functions #'cape-history)
  ;; (add-to-list 'completion-at-point-functions #'cape-sgml)
  ;; (add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;; (add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;; (add-to-list 'completion-at-point-functions #'cape-ispell)
  ;; (add-to-list 'completion-at-point-functions #'cape-dict)
  ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;; (add-to-list 'completion-at-point-functions #'cape-line)
)

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

  ;; Add hook to reset cache so the icon colors match my theme
  ;; NOTE 2022-02-05: This is a hook which resets the cache whenever I switch
  ;; the theme using my custom defined command for switching themes. If I don't
  ;; do this, then the backgound color will remain the same, meaning it will not
  ;; match the background color corresponding to the current theme. Important
  ;; since I have a light theme and dark theme I switch between. This has no
  ;; function unless you use something similar
  (add-hook 'kb/themes-hooks #'(lambda () (interactive) (kind-icon-reset-cache))))


;; ;;--------------------------------------
;; ;;* company-mode (Corfu の方を使うことにしている。[20240301])
;; ;;
;;  (use-package company
;;     :ensure t
;;     :config
;;     (global-company-mode)
;;     ;; 遅延なしにする。
;;     (setq company-idle-delay 0)
;;     ;; デフォルトの4より少ない文字数から補完が始める
;;     ;; (setq company-minimum-prefix-length 2)
;;     ;; 候補の一番下でさらに下に行こうとすると一番上に戻る。
;;     (setq company-selection-wrap-around t)
;;     ;; 番号を表示する。
;;     (setq company-show-numbers t)
;;     :bind (:map company-active-map
;;                 ("C-n" . company-select-next)
;;                 ("C-p" . company-select-previous)
;;                 ("C-s" . company-filter-candidates)
;;                 ("<tab>" . company-complete-selection))
;;     :bind (:map company-search-map
;;                 ("C-n" . company-select-next)
;;                 ("C-p" . company-select-previous)))
;;   (use-package company-tabnine
;;     :ensure t
;;     :config
;;     (add-to-list 'company-backends #'company-tabnine))
