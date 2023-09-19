;; paredit & eldoc
(use-package paredit
  :ensure t)

(defun my-lisp-setup ()
  (paredit-mode t)
  
  (turn-on-eldoc-mode)
  (eldoc-add-command
   'paredit-backward-delete
   'paredit-close-round))

;; https://blog.ryuslash.org/archives/2023/04/12/ielm-paredit
(defun remove-paredit-newline-keys ()
  "Disable ‘C-j’ and ‘RET’ keybindings from ‘paredit-mode’."
  (let ((oldmap (map-elt minor-mode-map-alist 'paredit-mode))
        (newmap (make-sparse-keymap)))
    (set-keymap-parent newmap oldmap)
    (define-key newmap (kbd "RET") nil)
    (define-key newmap (kbd "C-j") nil)
    (make-local-variable 'minor-mode-overriding-map-alist)
    (push `(paredit-mode . ,newmap) minor-mode-overriding-map-alist)))


(add-hook 'emacs-lisp-mode-hook                  #'my-lisp-setup)
(add-hook 'lisp-mode-hook                        #'my-lisp-setup)
(add-hook 'lisp-interaction-mode-hook            #'my-lisp-setup)
(add-hook 'scheme-mode-hook                      #'my-lisp-setup)
(add-hook 'ielm-mode-hook                        #'my-lisp-setup)
(add-hook 'ielm-mode-hook                        #'remove-paredit-newline-keys)

(add-hook 'eval-expression-minibuffer-setup-hook
          (lambda () (paredit-mode t)))
(add-hook 'eval-expression-minibuffer-setup-hook
          #'remove-paredit-newline-keys)
