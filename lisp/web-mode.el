(use-package web-mode
  :mode ("\\.phtml\\'" "\\.tpl\\'" "\\.php\\'" "\\.[gj]sp\\'"
         "\\.as[cp]x\\'" "\\.erb\\'" "\\.mustache\\'" "\\.hbs\\'"
         "\\.djhtml\\'" "\\.html?\\'")
  :init (setq web-mode-enable-auto-indentation nil))
