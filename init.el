(setq custom-file "~/.emacs.d/lisp/custom.el")

;; package.el stuff
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ;;("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-verbose t)
(require 'use-package)
(setq load-prefer-newer t)

(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-progressive-speed nil)

(setq inhibit-startup-screen +1)
(setq make-backup-files nil)
(setq column-number-mode t)
(setq shift-select-mode nil)
(setq password-cache-expiry nil)
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(setq save-interprogram-paste-before-kill t)
(setq sentence-end-double-space nil)
(fset 'yes-or-no-p 'y-or-n-p)

(when (display-graphic-p)
  (scroll-bar-mode -1)
  (tool-bar-mode -1))
(load-theme 'wombat)

;; The cursor in wombat is too dark and is hard to see sometimes.
(custom-theme-set-faces
 'wombat
 '(cursor ((t (:background "#F29112")))))
(custom-theme-recalc-face 'cursor)

(when (not (string-equal system-type "darwin"))
  (menu-bar-mode -1))

;; Setup each frame when it's created according to how it's displayed.
(defun my--setup-frame (&rest frame)
  (when (not (and (string-equal system-type "darwin") (display-graphic-p)))
    (set-frame-parameter nil 'menu-bar-lines 0)))
(add-hook 'server-after-make-frame-hook 'my--setup-frame t)

;; We have to run this manually as it doesn't run for the original
;; frame.
(my--setup-frame)


;; Function key bindings
;; (global-set-key [(f12)] 'mode-line-other-buffer)
(global-set-key [(f12)]
		(lambda ()
		  (interactive)
		  (switch-to-buffer (other-buffer (get-buffer "*Ibuffer*"))
				    nil t)))

;; Unbind cmd-Q and cmd-W because they quit on macOS and I keep
;; hitting them by accident.
(global-unset-key (kbd "s-q"))
(global-unset-key (kbd "s-w"))

(use-package magit
  :ensure t
  :init
  (setq magit-last-seen-setup-instructions "1.4.0")
  :bind ([f5] . magit-status))

(use-package paren
  :init
  (setq show-paren-style 'parenthesis)
  :config
  (show-paren-mode +1))

(use-package rainbow-mode
  :defer t
  :ensure t)

(use-package csv-mode
  :mode "\\.csv\\'"
  :ensure t)

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package debbugs
  :defer t)

(use-package iedit
  :ensure t)

(use-package markdown-mode
  :init
  (setq markdown-command "pandoc --from markdown_github -t html5 --highlight-style pygments --standalone"))

(use-package dumb-jump
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(add-to-list 'auto-mode-alist '("\\.vcl\\'" . c-mode))

;; Use cperl-mode instead of the default perl-mode
(defalias 'perl-mode 'cperl-mode)

(server-start)
; make 'c-x k' kill server buffers rather than 'c-x #'
(add-hook 'server-switch-hook
	  (lambda ()
	    (when (current-local-map)
	      (use-local-map (copy-keymap (current-local-map))))
	    (when server-buffer-clients
	      (local-set-key (kbd "C-x k") 'server-edit))))


;; wind move
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)


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

(setq c-default-style "k&r"
      c-basic-offset 2)
(setq-default indent-tabs-mode nil)

(add-hook 'post-mode-hook
          (lambda ()
            (flyspell-mode t)
            (define-key flyspell-mode-map (kbd "C-c $")
              'flyspell-check-previous-highlighted-word)))

;; Wide-margin mode
(add-hook 'wide-margins-mode-hook 
	  (lambda ()
	    (if (not wide-margins-mode)
		(progn
		  (visual-line-mode -1)
		  (variable-pitch-mode -1)
		  (unichar-mode))
              (text-mode)
	      (visual-line-mode t)
	      (variable-pitch-mode t)
	      (unichar-mode))))


;; iBuffer configuration
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq user-full-name "Alan Third")
(setq user-mail-address "alan@idiocy.org")

(require 'sendmail)
