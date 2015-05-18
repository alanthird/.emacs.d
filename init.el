(setq custom-file "~/.emacs.d/lisp/custom.el")

(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-progressive-speed nil)

(setq inhibit-startup-screen +1)
(setq make-backup-files nil)
(setq column-number-mode t)

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

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
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

(defun my-load-all-in-directory (dir)
  "`load' all elisp libraries in directory DIR which are not already loaded."
  (interactive "D")
  (let ((libraries-loaded (mapcar #'file-name-sans-extension
                                  (delq nil (mapcar #'car load-history)))))
    (dolist (file (directory-files dir t ".+\\.elc?$"))
      (let ((library (file-name-sans-extension file)))
        (unless (member library libraries-loaded)
          (load library nil t)
          (push library libraries-loaded))))))

(my-load-all-in-directory "~/.emacs.d/lisp/")

(setq auto-mode-alist (cons '("\\.tr$" . nroff-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ps1$" . powershell-mode) auto-mode-alist))

(global-set-key (kbd "C-=") 'er/expand-region)

(setq c-default-style "k&r"
  c-basic-offset 2)
(setq js-indent-level 2)
(setq-default indent-tabs-mode nil)

(setq initial-scratch-message "")

; package.el stuff
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; I seem to need to initialise package.el here so I can load
;; other things below
(setq package-enable-at-startup nil)
(package-initialize)

;; Wide-margin mode
(add-hook 'wide-margins-mode-hook 
	  (lambda ()
	    (if (not wide-margins-mode)
		(progn
		  (visual-line-mode -1)
		  (variable-pitch-mode -1)
		  (unicycle-mode))
              (text-mode)
	      (visual-line-mode t)
	      (variable-pitch-mode t)
	      (unicycle-mode))))

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
