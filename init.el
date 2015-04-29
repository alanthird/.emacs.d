(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(canlock-password "a2379396fb503ac51495f2f05bf4f59dd6104503")
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(mouse-wheel-progressive-speed nil)
 '(org-export-backends (quote (ascii html icalendar md odt groff)))
 '(quack-programs (quote ("biwas" "bigloo" "csi" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Function key bindings
(global-set-key [(f1)] (lambda ()
			 (interactive) 
			 (org-agenda "" "q")
			 (delete-other-windows)))

;; (global-set-key [(f12)] 'mode-line-other-buffer)
(global-set-key [(f12)]
		(lambda ()
		  (interactive)
		  (switch-to-buffer (other-buffer (get-buffer "*Ibuffer*"))
				    nil t)))
(global-set-key [(f5)] 'magit-status)
(setq magit-last-seen-setup-instructions "1.4.0")

(server-start)
; make 'c-x k' kill server buffers rather than 'c-x #'
(add-hook 'server-switch-hook
	  (lambda ()
	    (when (current-local-map)
	      (use-local-map (copy-keymap (current-local-map))))
	    (when server-buffer-clients
	      (local-set-key (kbd "C-x k") 'server-edit))))

; turn on parenthesis matching
(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)

(put 'set-goal-column 'disabled nil)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(put 'narrow-to-region 'disabled nil)
(setq save-interprogram-paste-before-kill t)
(setq sentence-end-double-space nil)

;; wind move
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(setq shift-select-mode nil)


(setq password-cache-expiry nil)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "powershell-mode")

(setq auto-mode-alist (cons '("\\.tr$" . nroff-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ps1$" . powershell-mode) auto-mode-alist))

(global-set-key (kbd "C-=") 'er/expand-region)

; org mode stuff
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
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
			     (require 'org-habit))))


; end of org configuration

(defun pretty-print-xml ()
  "Pretty format XML markup. You need to have nxml-mode http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do this. The function inserts linebreaks to separate tags that have nothing but whitespace between them. It then indents the markup by using nxml's indentation rules. A variant of the code found at http://blog.bookworm.at/2007/03/pretty-print-xml-with-emacs.html"
  (interactive)
  (nxml-mode)
  (goto-char (point-min))
  (while (search-forward-regexp "\>[ \\t]*\<" nil t)
    (backward-char) (insert "\n"))
  (indent-region (point-min) (point-max) nil)
  (message "Ah, much better!"))

; Lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(setq c-default-style "k&r"
  c-basic-offset 2)
(setq js-indent-level 2)
(setq indent-tabs-mode nil)

(setq initial-scratch-message "")

; package.el stuff
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; I seem to need to initialise package.el here so I can load
;; typopunct below
(setq package-enable-at-startup nil)
(package-initialize)

;; typopunct
(require 'typopunct)
(typopunct-change-language 'english t)

;; Wide-margin mode
(load "wide-margins")

(add-hook 'wide-margins-mode-hook 
	  (lambda ()
	    (if (not wide-margins-mode)
		(progn
		  (visual-line-mode -1)
		  (variable-pitch-mode -1)
		  (typopunct-mode))
	      (visual-line-mode t)
	      (variable-pitch-mode t)
	      (typopunct-mode))))

;; jump-char
(require 'jump-char)
(global-set-key [(control z)] 'jump-char-forward)
(global-set-key [(shift control z)] 'jump-char-backward)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; iBuffer configuration
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("org"   (or
			 (mode . org-mode)
			 (name . "^\\*Org .*\\*$")))
	       ;; catchall for emacs buffers
	       ("emacs" (name . "^\\*.+\\*$"))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Set character encoding to default to UTF-8 rather than Latin-1.
(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(unless (eq system-type 'windows-nt)
  (set-selection-coding-system 'utf-8))
(prefer-coding-system 'utf-8)


(setq user-full-name "Alan J Third")
(setq user-mail-address "alan@idiocy.org")
(setq ispell-dictionary "british")

;; Graphical environment only
(when (display-graphic-p)
  (progn
    (require 'cl-lib)
    (defun font-candidate (&rest fonts)
      "Return existing font which first match."
      (cl-find-if (lambda (f) (find-font (font-spec :name f))) fonts))
    
    (set-face-attribute 'default nil :font (font-candidate '"Droid Sans Mono-12" "Lucida Console-12"))
    (set-face-attribute 'variable-pitch nil :font (font-candidate '"FuturaMed-16" "PT Sans-16" "Sans Serif-16"))
    (load-theme 'wombat)))

;; System type stuff
(cond       ((string-equal system-type "gnu/linux")
	     (setq ispell-program-name "hunspell")
	     (setq browse-url-browser-function 'browse-url-generic
		   browse-url-generic-program "xdg-open"))
	    ((string-equal system-type "windows-nt")
	     ;; spell checker
	     (add-to-list 'exec-path "C:/Program Files/Aspell/bin/")
	     (setq ispell-program-name "aspell")
	     (require 'ispell))
	    ((string-equal system-type "darwin")
	     (setq default-directory (concat (getenv "HOME") "/"))
	     (setq ns-right-alternate-modifier (quote none)) ;; use right alt for # and €
	     (setq ispell-program-name "aspell")))

; System specific stuff!
(cond ((equal system-name "CSS-27317-TL")
       (setq user-mail-address "alan.third@argyll-bute.gov.uk")
       (setq org-agenda-files '("H:/org"))
       (set-face-attribute 'default nil :font "Droid Sans Mono-10")

       (set-frame-height (selected-frame) 60)
       (set-frame-position (selected-frame) 40 30)

       (setq tramp-default-method "pscp")

       (setq url-proxy-services
	     '(("http"     . "localhost:3128")
	       ("no_proxy" . "^.*\\.argyll-bute\\.gov\\.uk")))
       (setq doc-view-ghostscript-program "gswin32c"))
      ((string-prefix-p "galloway" system-name)
       (setq org-agenda-files '("/Volumes/shared/home/alan/org"))
       (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:/Users/alan/.local/bin"))
       (setq exec-path (append exec-path '("/usr/local/bin" "/Users/alan/.local/bin"))))
      (t (setq org-agenda-files '("/shared/home/alan/org"))))
