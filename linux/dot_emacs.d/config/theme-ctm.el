;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme 設定 (~/.emacs.d/init.el から読まれる)
;; Time-stamp: <2024-02-28 09:19:56 (ryosuke)>

;;--------------------------------------------
;;* theme 設定
;;--------------------------------------------

;; (define-key global-map (kbd "<f12>") #'consult-theme)

;; ;;--- gruvbox ---
;; (use-package gruvbox-theme
;;   :ensure t
;; ;  :config
;;   )

;; ;;--- doom ---
;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t  ; if nil, italics is universally disabled
;;         doom-themes-padded-modeline t)
;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   ;; (doom-themes-neotree-config)
;;   ;; ;; or for treemacs users
;;   ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   ;; (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config)
;;   )

;;--- modus ---
(setq modus-themes-bold-constructs nil
      modus-themes-italic-constructs t)
;; Maybe define some palette overrides, such as by using our presets
;; (setq modus-themes-common-palette-overrides
;;      modus-themes-preset-overrides-intense)
;; Load the theme of choice (built-in themes are always "safe" so they
;; do not need the `no-require' argument of `load-theme').


;;--------------------------------------------
;; Loading a theme
;;--------------------------------------------
(load-theme 'modus-operandi :no-confirm) ;'modus-vivendi :no-confirm) ;'doom-solarized-light :no-confirm) ;'doom-one t) ;'gruvbox-light-hard) ;
                                        ;'doom-monokai-ristretto) ;'doom-acario-dark) ;'doom-molokai) ;'doom-zenburn) ;'doom-vibrant t) ;

;;;;;;;;;;;;;;;;;
; End of File ;;;
;;;;;;;;;;;;;;;;;
