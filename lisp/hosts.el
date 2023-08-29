(if (equal (system-name) "faroe")
    (set-face-attribute 'default nil :height 140)
  (set-face-attribute 'default nil :height 120))

;; Work
(when (equal (system-name) "CSS-60501-HL")
  (setq user-mail-address "alan.third@argyll-bute.gov.uk")
  (setq org-agenda-files '("//abck-fs01/hdrives/thirda/org"))

  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  (setq gnutls-algorithm-priority "NORMAL:%COMPAT")
  (setq url-proxy-services
        '(("http"     . "localhost:3128")
          ("https"    . "localhost:3128")))
  (setq doc-view-ghostscript-program "gswin32c"))

;; OS dependent changes
(cond ((string-equal system-type "gnu/linux")
       (setq browse-url-browser-function 'browse-url-generic
             browse-url-generic-program "xdg-open"))
      ((string-equal system-type "windows-nt")
       (set-face-attribute 'default nil :height 90)
       (setenv "GIT_ASKPASS" "git-gui--askpass")
       ;; NOTE: you probably also want to run:
       ;; git config --global credential.helper wincred
       ;; on a new install.
       )
      ((string-equal system-type "darwin")
       (setq default-directory (concat (getenv "HOME") "/"))
       ;; use right alt for # and €
       (setq ns-right-alternate-modifier (quote none))))
