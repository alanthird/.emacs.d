(use-package abc-mode)

(use-package gnuplot
  :defer t)
(use-package org-babel-gnuplot)

(use-package org
  :bind (;; ([f1] . (lambda ()
	 ;; 	   (interactive) 
	 ;; 	   (org-agenda "" "q")
	 ;; 	   (delete-other-windows)))
         ("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c b" . org-iswitchb))

  :config
  (setq org-log-done t)
  (setq org-enforce-todo-dependencies t)
  (setq org-agenda-dim-blocked-tasks t)
  (setq org-agenda-ndays 7)
  (setq org-deadline-warning-days 14)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-start-on-weekday nil)
  (setq org-startup-with-inline-images t)
  (setq org-export-with-sub-superscripts '{})
  (setq org-src-fontify-natively t)

  (setq org-export-backends '(ascii html md odt))

  (add-hook 'org-src-mode-hook (lambda () (setq js-indent-level 2)))

  (setq org-todo-keywords
        '((sequence "TODO" "WAITING" "|" "DONE" "CANCELED")))

  (setq org-todo-keyword-faces
        '(("WAITING" . (:foreground "yellowgreen" :weight bold))
          ("CANCELED" . (:foreground "blue" :weight bold))))

  (setq org-agenda-custom-commands
        '(("q" "Agenda and Todos"
           ((agenda "")
            (todo "TODO")))
          ("w" todo "WAITING")
          ("W" todo-tree "WAITING")))

  (defun my-org-paste-image ()
    "Take an image from the clipboard into a time stamped
unique-named file in the same directory as the org-buffer and
insert a link to this file."
    (interactive)
    (setq filename
          (concat
           (make-temp-name
            (concat (buffer-file-name)
                    "_"
                    (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
    (call-process "convert" nil nil nil "clipboard:" filename)
    (insert (concat "[[file:" filename "]]"))
    (org-display-inline-images))

  (add-hook 'org-mode-hook (progn
                             (lambda ()
                               (local-set-key "\C-ci" (lambda ()
                                                        (interactive)
                                                        (my-org-paste-image)))
                               (add-to-list 'org-modules 'org-habit)
                               (require 'org-habit)
                               ;; Enable evaluation of javascript and dot blocks
                               ;;
                               ;; (I believe I'm supposed to use
                               ;; org-babel-do-load-languages, to set this up, but
                               ;; it just doesn't seem to work for me.)
                               (require 'ob-js)
                               (require 'ob-dot)
                               (require 'ob-gnuplot)
                               
                               (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
                               (add-to-list 'org-src-lang-modes '("html" . web))))))
