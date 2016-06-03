(use-package go-mode
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package go-eldoc)
