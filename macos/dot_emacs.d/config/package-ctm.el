;;; package-ctm.el --- Package configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Package management configuration.
;;
;; Packages are managed mainly with use-package.
;; Emacs reminds me periodically to update installed packages.
;;
;;; Code:

(require 'package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Package archives

(setq package-archives
'(("gnu"    . "https://elpa.gnu.org/packages/")
("nongnu" . "https://elpa.nongnu.org/nongnu/")
("melpa"  . "https://melpa.org/packages/")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; use-package

;; Install packages automatically unless otherwise specified.
(setq use-package-always-ensure t)

;; Prefer newer source files when they are newer than compiled files.
(setq load-prefer-newer t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Automatic compilation

(use-package auto-compile
:ensure t
:config
(auto-compile-on-load-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Package update reminder

(defconst my/package-update-interval-days 14
"Number of days between package update reminders.")

(defconst my/package-update-stamp-file
(expand-file-name
"package-update-last-checked"
user-emacs-directory)
"File recording the last package update time.")

(defun my/package-last-update-time ()
"Return the last recorded package update time, or nil."
(when (file-readable-p my/package-update-stamp-file)
(with-temp-buffer
(insert-file-contents my/package-update-stamp-file)
(let ((value (string-trim (buffer-string))))
(unless (string-empty-p value)
(seconds-to-time (string-to-number value)))))))

(defun my/package-days-since-last-update ()
"Return number of days since the last recorded package update."
(when-let ((last-update (my/package-last-update-time)))
(/ (float-time
(time-subtract (current-time) last-update))
86400.0)))

(defun my/package-update-reminder ()
"Remind me when package updates have not been checked recently."
(let ((days (my/package-days-since-last-update)))
(cond
((null days)
(message
"Package update date is unknown. Run M-x my/package-upgrade-all."))
((>= days my/package-update-interval-days)
(message
"Packages have not been updated for %.0f days. Run M-x my/package-upgrade-all."
days)))))

(defun my/package-record-update-time ()
"Record the current time as the most recent package update."
(with-temp-file my/package-update-stamp-file
(insert (number-to-string (float-time)))))

(defun my/package-upgrade-all ()
"Upgrade all installed packages and record the update time."
(interactive)
(package-refresh-contents)
(package-upgrade-all)
(my/package-record-update-time)
(message "Package upgrade completed; update time recorded."))

(add-hook 'emacs-startup-hook #'my/package-update-reminder)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Provide

(provide 'package-ctm)

;;; package-ctm.el ends here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
