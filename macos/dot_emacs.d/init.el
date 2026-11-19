;; init.el --- Emacs configuration -*- lexical-binding: t; -*-
;; -*- mode: lisp-interaction; syntax: elisp; coding: utf-8-emacs -*-
;;  Time-stamp: <2026-09-28 16:57:34 (ryosuke)>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LoadPath

(add-to-list 'load-path
             (expand-file-name "config" user-emacs-directory))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 日本語環境設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 各種設定のファイルを読み込む。(~/.emacs.d/elisp/ 以下に納められてます。)

(load "package-ctm" nil 'nomessage)       ; パッケージ管理 by package.el
(load "environment-ctm" nil 'nomessage)   ; 環境変数設定 (パッケージ管理の直後に置く)
;------------;
(load "faces-settings" nil 'nomessage)    ; フォント/カラー設定
(load "ime-ctm" nil 'nomessage)           ; 日本語入力方法の設定
(load "vertico-ctm" nil 'nomessage)       ; Vertico
(load "completion-ctm" t 'nomessage)      ; 入力補完
;------------;
;;(load "eglot-ctm.el" t nil)          ; Eglot
;;(load "lsp-mode-ctm.el" t nil)       ; lsp-mode
(load "auctex-ctm" nil 'nomessage)        ; AUCTeX
;; ;; (load "yatex-ctm.el" t nil)          ; YaTeX
;; (load "org-ctm.el" t nil)            ; Org-mode
;; (load "ruby-mode-ctm.el" t nil)      ; Ruby-mode
(load "other-config" nil 'nomessage)      ; 他の追加機能
;------------;
(load "display-ctm" nil 'nomessage)       ; 表示関連の設定
(load "theme-ctm" nil 'nomessage)         ; theme
;------------;
(load "my.misc" nil 'nomessage)           ; 細部の設定

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for customize system
;; Emacs のカスタム機能による設定は, 'custom-file' が示すファイルに記録される.
(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file nil 'nomessage))  ;; カスタム機能による設定は起動時に読みこむ.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 起動時間表示
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (emacs-init-time)
                     gcs-done)))


(provide 'init)
;;; init.el ends here

;; (add-hook 'after-init-hook
;;           (lambda ()
;;             (message "init time: %d msec"
;;                      (+ (* (- (nth 1 after-init-time) (nth 1 before-init-time)) 1000)
;;                         (/ (- (nth 2 after-init-time) (nth 2 before-init-time)) 1000)))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; このファイルに間違いがあった場合に全てを無効にします
;; (put 'eval-expression 'disabled nil)

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    '("7964b513f8a2bb14803e717e0ac0123f100fb92160dcf4a467f530868ebaae3e"
;;      "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e"
;;      default))
;;  '(package-selected-packages '(0blayout)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; end of file
;;;
