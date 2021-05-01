(use-package "lsp-mode"
  :custom
  (lsp-clients-clangd-executable "/usr/local/opt/llvm/bin/clangd")
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-enable-indentation nil)
  :hook ((c-mode cc-mode objc-mode) . lsp)
  :commands lsp)
