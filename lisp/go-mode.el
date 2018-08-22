(use-package go-mode
  :mode "\\.go\\'")

(use-package go-eldoc
  :hook (go-mode . go-eldoc-setup))
