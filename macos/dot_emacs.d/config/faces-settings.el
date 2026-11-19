;;; faces-settings.el --- macOS font and frame settings -*- lexical-binding: t; -*-

;; 起動時のフレームを最大化
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; 欧文フォント
(when (member "JetBrains Mono" (font-family-list))
  (set-face-attribute 'default nil
                      :family "JetBrains Mono"
                      :height 140))

;; 日本語フォント
(when (member "Hiragino Kaku Gothic ProN" (font-family-list))
  (set-fontset-font t
                    'japanese-jisx0208
                    (font-spec :family "Hiragino Kaku Gothic ProN")
                    nil
                    'prepend))

(provide 'faces-settings)
;;; faces-settings.el ends here
