;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; フォント/カラーの設定 (~/.emacs.d/init.el から読まれる)
;; Time-stamp: <2026-11-15 11:13:02 (ryosuke)>

;;----------------------------------------------------
;;* 起動時のウィンドウ（フレーム）のサイズ/フォント
;;----------------------------------------------------
;; 初期フレームのサイズ・位置
(setq initial-frame-alist
      '((top . 0)
        (left . 0)
        (width . 100)
        (height . 58) )
      )

(setq default-frame-alist
      '((width . 100)
        (height . 58) )
      )

;Font
(set-face-attribute 'default nil :height 140)
(when (member "Ricty Diminished" (font-family-list))
  (add-to-list 'default-frame-alist '(font . "Ricty Diminished-12"))
  )

;;;;;;;;;;;;;;;;;;;
;;; End of File ;;;
;;;;;;;;;;;;;;;;;;;
