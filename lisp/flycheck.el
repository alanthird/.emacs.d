(use-package flycheck
  :init
  (global-flycheck-mode)
  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook #'flycheck-objc-clang-setup))
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc perl)))
