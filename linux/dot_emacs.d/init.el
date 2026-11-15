;;;; -*- mode: lisp-interaction; syntax: elisp; coding: utf-8-emacs -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Emacs 初期設定ファイル   ~/.emacs.d/init.el
;;  Time-stamp: <2026-11-15 15:08:12 (ryosuke)>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LoadPath

;;load-pathの再帰的な追加。
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "config")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Set up Emacs' exec-path
;; (defun set-exec-path-from-shell-PATH ()
;;   (interactive)
;;   (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))

;; ;; (if (string-equal "darwin" (symbol-name system-type))
;; ;;     (set-exec-path-from-shell-PATH))
;; (set-exec-path-from-shell-PATH)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 日本語環境設定
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 各種設定のファイルを読み込む。(~/.emacs.d/elisp/ 以下に納められてます。)

(load "package-ctm.el" t nil)         ; パッケージ管理 by package.el
;;(load "elpaca-ctm.el" t nil)         ; パッケージ管理 by Elpaca の設定
;; ;------------;
(load "faces-settings.el" t nil)     ; フォント/カラー設定
(load "ime-ctm.el" t nil)            ; 日本語入力方法の設定
(load "vertico-ctm.el" t nil)        ; Vertico
(load "completion-ctm.el" t nil)     ; 入力補完
;------------;
;;(load "eglot-ctm.el" t nil)          ; Eglot
;;(load "lsp-mode-ctm.el" t nil)       ; lsp-mode
(load "auctex-ctm.el" t nil)         ; AUCTeX
;; ;; (load "yatex-ctm.el" t nil)          ; YaTeX
;; (load "org-ctm.el" t nil)            ; Org-mode
;; (load "ruby-mode-ctm.el" t nil)      ; Ruby-mode
(load "other-config.el" t nil)       ; 他の追加機能
;; ;------------;
(load "display-ctm.el" t nil)        ; 表示関連の設定
(load "theme-ctm.el" t nil)          ; theme
;; ;------------;
(load "my.misc.el" t nil)            ; 細部の設定

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for customize system
;; Emacs のカスタム機能による設定は, 'custom-file' が示すファイルに記録される.
;(setq custom-file "~/.emacs.d/custom.el")
;(load custom-file) ;; カスタム機能による設定は起動時に読みこむ.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 起動時のエラー表示対策
(setq bn "*Compile-Log*")
(when (get-buffer bn)
  (progn
    (delete-windows-on bn)
    (message "Close a window for the buffer *Compile-Log*")
    ) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 起動時間表示
(add-hook 'after-init-hook
          (lambda ()
            (message "init time: %d msec"
                     (+ (* (- (nth 1 after-init-time) (nth 1 before-init-time)) 1000)
                        (/ (- (nth 2 after-init-time) (nth 2 before-init-time)) 1000)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; このファイルに間違いがあった場合に全てを無効にします
(put 'eval-expression 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7964b513f8a2bb14803e717e0ac0123f100fb92160dcf4a467f530868ebaae3e"
     "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e"
     default))
 '(package-selected-packages '(0blayout)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; end of file
;;;
