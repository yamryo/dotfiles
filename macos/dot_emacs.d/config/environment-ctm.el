;;; environment-ctm.el --- Shell environment -*- lexical-binding: t; -*-

(use-package exec-path-from-shell
  :ensure t
  :demand t
  :config
  (exec-path-from-shell-initialize))

(provide 'environment-ctm)
;;; environment-ctm.el ends here
