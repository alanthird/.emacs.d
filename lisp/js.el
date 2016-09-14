(use-package js2-mode
  :mode "\\.js\\'"
  :config
  (setq-default js2-show-parse-errors nil)
  (setq js2-strict-missing-semi-warning nil))
