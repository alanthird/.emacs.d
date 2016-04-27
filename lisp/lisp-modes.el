;; paredit & eldoc
(use-package paredit
  :ensure t)

(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\"
  return.")

(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then
  open and indent an empty line between the cursor and the text.  Move the
  cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
        (save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))

(defun my-lisp-setup ()
  (paredit-mode t)
  (local-set-key (kbd "RET") 'electrify-return-if-match)
  
  (turn-on-eldoc-mode)
  (eldoc-add-command
   'paredit-backward-delete
   'paredit-close-round
   'electrify-return-if-match))

(add-hook 'emacs-lisp-mode-hook                  #'my-lisp-setup)
(add-hook 'ielm-mode-hook                        #'my-lisp-setup)
(add-hook 'lisp-mode-hook                        #'my-lisp-setup)
(add-hook 'lisp-interaction-mode-hook            #'my-lisp-setup)
(add-hook 'scheme-mode-hook                      #'my-lisp-setup)

(add-hook 'eval-expression-minibuffer-setup-hook
          (lambda () (paredit-mode t)))
