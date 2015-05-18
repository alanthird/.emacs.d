(setq initial-major-mode 'text-mode)

(add-hook 'emacs-startup-hook
          (lambda ()
            (with-current-buffer
                (generate-new-buffer "*lisp*")
              (lisp-interaction-mode))))
