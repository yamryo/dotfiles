;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;*  Org-mode の設定 (~/.emacs.d/init.el から読まれる)
;;   Time-stamp: <2024-02-08 13:47:00 (ryosuke)>

;;----------------------------------------------
;;* Org mode
;;
(use-package org
  :ensure t
  :mode (("\\.txt$" . org-mode))
  :bind (("C-c c" . org-capture)
         ("C-c l" . org-store-link)  ;; Preludeのバインドを再定義しておく
         ("C-c a" . org-agenda)
         ("C-c s" . org-super-agenda-mode)
         ("C-c b" . org-iswitchb)
        )
  :init
  ;; 保存先
  (cond
   ;;--- Linux ---
   ((string-equal "gnu/linux" (symbol-name system-type))
    (message "system-type = %s" system-type)
    (setq my-org-directory "~/org-files/"); "~/Dropbox/notes/")
    ;; Org-captureのテンプレート（メニュー）の設定
    (setq notes-file "~/org-files/notes.org"); ~/Dropbox/notes/notes.org")
    (setq org-capture-templates
          '(("n" "Note" entry
             (file+headline notes-file "Notes")
            "* %?\nEntered on %U\n %i\n %a")
          ))
    (setq org-agenda-files (list my-org-directory))
  ;; Org-refile-targets 設定
    (setq org-refile-targets '((my-org-directory :maxlevel . 3)))
    )
   ;;--- Mac OSX ---
   ((string-equal "darwin" (symbol-name system-type))
    ;(message "system-type = %s" system-type)
    (setq my-org-directory "~/org-files/"); "/Volumes/JetDrive/GoogleDrive/My\ Drive/notes/") ;"~/Dropbox/notes/");
    ;; Org-captureのテンプレート（メニュー）の設定
    (setq notes-file "~/org-files/notes.org"); "~/Dropbox/notes/notes.org")
    (setq org-capture-templates
          '(("n" "Note" entry
             (file+headline notes-file "Notes")
            "* %?\nEntered on %U\n %i\n %a")
          ))
    ;; TODO 抽出
    (setq org-agenda-files (list my-org-directory))
    (setq org-agenda-tags-column -98)
;    (setq org-agenda-block-separator "-")
    (setq org-agenda-compact-blocks t)
  ;; Org-refile-targets 設定
    (setq org-refile-targets '((my-org-directory :maxlevel . 3)))
    )
   ;;--- Windows ---
   ((string-equal "windows-nt" (symbol-name system-type))
    ;(message "system-type = %s" system-type)
    )
   )
;;  (setq org-agenda-files (list my-org-directory my-org-agenda-directory))
  :config
  ;; 基本設定
  ;; Hide the first N-1 stars in a headline : nil --> t
  (setq org-hide-leading-stars nil) ;t)
  ;; RET will follow the link : nil --> t
  (setq org-return-follows-link t)
  ;; Directory with org files : "~/org" --> my-org-directory
  (setq org-directory my-org-directory)
  ;; Default target for storing notes : "~/.notes" --> "notes.org"
  (setq org-default-notes-file "notes.org")
  ;; For Agenda View
  ;; org-agenda 表示の水平方向の冗長さを削減
  ;; (setq org-agenda-prefix-format
  ;;       '((agenda  . "%-9c| %?-12t% s")
  ;;         (todo  . " %i %-12:c")
  ;;         (tags  . " %i %-12:c")
  ;;         (search . " %i %-12:c")))
  ;; (setq org-agenda-remove-tags nil) ;t) ;
  ;; (setq org-agenda-scheduled-leaders '("[S]" "S.%2dx:\t"))
  ;; (setq org-agenda-deadline-leaders '("[D]" "In %3d d.:\t" "%2d d. ago:\t"))
  )

; Note の一覧を見るための設定。これは、org の:config の外に出しとかないと駄目かな。
(defun show-org-buffer (file)
  "Show an org-file FILE on the current buffer."
  (interactive)
  (if (get-buffer file)
      (let ((buffer (get-buffer file)))
        (switch-to-buffer buffer)
        (message "%s" file))
    (find-file (concat my-org-directory file))))

(global-set-key (kbd "C-M-n") #'(lambda () (interactive)
                                 (show-org-buffer "notes.org")))
(global-set-key (kbd "C-M-l") #'(lambda () (interactive)
                                 (show-org-buffer "lectures.org")))
(global-set-key (kbd "C-M-j") #'(lambda () (interactive)
                                 (show-org-buffer "jobs.org")))

;; ;;---------------------------------------------
;; ;;* org-super-agenda
;; ;;
;; (use-package org-super-agenda
;;   :ensure t
;;   :init
;;   (org-super-agenda-mode)
;;   :config
;; (setq org-agenda-custom-commands
;;       '(
;; 	("a" "Agenda View"
;;          ((agenda "" ((org-agenda-span 'week)
;;                       (org-super-agenda-groups
;;                        '((:name "Today"
;;                                 :scheduled today
;;                                 :order 1)
;;                          (:name "Important"
;;                                 :priority "A")
;;                          (:priority<= "B"
;;                                       :transformer (--> it
;;                                                         (propertize it 'face '(:foreground "RosyBrown1")))
;;                                       :order 9)
;;                          (:name "Overdue"
;;                                 :deadline past
;;                                 :scheduled past
;;                                 :order 0)
;;                          (:name "Due Soon"
;;                                 :deadline future
;;                                 :order 7)
;;       ;;                    (:todo "WAITING" :order 8)  ; Set order of this section
;;       ;;                    (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
;;       ;;                           :order 100)
;;                        ))
;;                       )))
;;          )
;;         ("n" "Next View"
;;          ((agenda "" ((org-agenda-span 'day)
;;                       (org-super-agenda-groups
;;                        '((:name "Today"
;;                                 :time-grid t
;;                                 :todo "TODAY"
;;                                 :scheduled today
;;                                 :order 0)
;;                          (:habit t)
;;                          (:name "Due Today"
;;                                 :deadline today
;;                                 :order 2)
;;                          (:name "Due Soon"
;;                                 :deadline future
;;                                 :order 8)
;;                          (:name "Overdue"
;;                                 :deadline past
;;                                 :order 7)
;;                          ))))
;;           (todo "" ((org-agenda-overriding-header "")
;;                     (org-super-agenda-groups
;;                      '((:name "Inbox"
;;                               :file-path "inbox"
;;                               :order 0
;;                               )
;;                        (:discard (:todo "TODO"))
;;                        (:auto-category t
;;                                        :order 9)
;;                        ))))))
;;         ("t" "Todo View"
;;          ((todo "" ((org-agenda-overriding-header "")
;;                     (org-super-agenda-groups
;;                      '((:name "Inbox"
;;                               :file-path "inbox"
;;                               :order 0
;;                               )
;;                        (:auto-category t
;;                                        :order 9)
;;                        ))))))
;; 	)
;;       )
;;   )

;; ;;----------------------------------------------
;; ;;* org-agenda-property
;; ;;
;;  (use-package org-agenda-property
;;    :ensure t
;;    :defer t
;;    :config
;;   )

;;----------------------------------------------
;;* calfw-org
;;
 ;; (use-package calfw-org
 ;;   :ensure t
 ;;   :defer t
 ;;   :config
 ;;   (setq cfw:org-overwrite-default-keybinding t)
 ;;   )


;;----------------------------------------------
;;* Org-Journal
;;
;; (use-package org-journal
;;   :ensure t
;;   :defer t
;;   :custom
;;   (org-journal-dir (concat my-org-directory "journal/"))
;;   (org-journal-date-format “%Y-%m-%d”)
;;   )


;;----------------------------------------------
;;* Deft mode
;;
(use-package deft
  :bind ("<f7>" . deft)
  :commands (deft)
  :config (setq deft-directory my-org-directory
                deft-extensions '("md" "txt" "tex" "org")
                deft-use-filename-as-title t
                deft-recursive t)
  )

;-----------------------------------------------
;;* markdown mode
;;
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :commands (markdown-mode gfm-mode)
  :config
;  (setq markdown-command "pandoc") ;-c ~/.pandoc/github.css")
  (setq markdown-command "pandoc -t html5")
  )

;; (autoload 'markdown-mode "markdown-mode"
;;    "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; (setq markdown-command "pandoc -c ~/.pandoc/github.css")
;; ;(setq markdown-css-paths nil) ;"~/.pandoc/github.css") ;

;;----------------------------------------------
;;* For exporting to PDF
;;
;; (use-package ox-latex
;;   :ensure t
;;   :config
;;   (setq org-latex-default-class "bxjsarticle") ;"jsarticle") ;
;;   ;;; ドキュメントクラスの追加
;;   (add-to-list 'org-latex-classes
;;                '("jsarticle"
;;                  "\\documentclass[dvipdfmx,12pt]{jsarticle}"
;;                  ("\\section{%s}" . "\\section*{%s}")
;;                  ("\\subsection{%s}" . "\\subsection*{%s}")
;;                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
;;                  )
;;                )
;;   (add-to-list 'org-latex-classes
;;                '("bxjsarticle"
;;                  "\\documentclass[autodetect-engine,dvi=dvipdfmx,11pt,a4paper,ja=standard]{bxjsarticle}"
;;                  ("\\section{%s}" . "\\section*{%s}")
;;                  ("\\subsection{%s}" . "\\subsection*{%s}")
;;                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
;;                )
;;   ;;; プリアンブルの追加
;;   (add-to-list 'org-latex-packages-alist '("" "hyperref") t)
;;   (add-to-list 'org-latex-packages-alist '("" "pxjahyper") t)
;;   (add-to-list 'org-latex-packages-alist '("" "amsmath") t)
;;   (add-to-list 'org-latex-packages-alist '("" "newtxtext") t)
;;   (add-to-list 'org-latex-packages-alist '("" "newtxmath") t)
;;   (add-to-list 'org-latex-packages-alist '("" "graphicx") t)
;;   ;;; その他の設定
;;   (setq org-latex-listings t)
;;   (setq org-use-sub-superscripts nil)
;;   (setq org-export-with-sub-superscripts nil)
;;   ;; (setq org-latex-pdf-process
;;   ;;       ("ptex2pdf -l -ot -synctex=1 -file-line-error")
;;   ;;       )
;;   ;;   ;(setq org-latex-pdf-process '("latexmk -e '$latex=q/uplatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
;;   ;;   ;(setq org-latex-pdf-process '("latexmk -e '$lualatex=q/lualatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -norc -gg -pdflua %f"))
;;   ;;   ;(setq org-export-in-background t)
;;   ;; (setq org-export-latex-coding-system "utf8")
;;   ;; (setq org-export-latex-date-format "%Y-%m-%d")
;;   ;; (setq org-file-apps '(("pdf" . "/usr/bin/open -a Preview.app %s")))
;;   (setq org-file-apps '(("pdf" . "open -a Skim %s")))
;;   )


;;
;;* End of File
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
