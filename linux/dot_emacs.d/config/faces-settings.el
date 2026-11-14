;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; フォント/カラーの設定 (~/.emacs.d/init.el から読まれる)
;; Time-stamp: <2026-11-08 10:08:57 (ryosuke)>

;;----------------------------------------------------
;;* 起動時のウィンドウ（フレーム）のサイズ/フォント
;;----------------------------------------------------
;; 初期フレームのサイズ・位置
(setq initial-frame-alist
      '((top . 0)
        (left . 0)
        (width . 90)
        (height . 70) )
      )

(setq default-frame-alist
      '((width . 90)
        (height . 70) )
      )

;Font
(set-face-attribute 'default nil :height 120)
(when (member "Ricty Diminished" (font-family-list))
  (add-to-list 'default-frame-alist '(font . "Ricty Diminished-12"))
  )

;;;;;;;;;;;;;;;;;;;
;;; End of File ;;;
;;;;;;;;;;;;;;;;;;;
