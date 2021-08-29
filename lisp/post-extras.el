(defun at--get-bug-number ()
  (save-excursion
    (header-goto-subject)
    (let ((case-fold-search t)
          (subject (buffer-substring-no-properties (point) (line-end-position))))
      (string-match "bug ?#\\([[:digit:]]+\\)" subject)
      (match-string 1 subject))))

(defun at--insert-debbugs-control ()
  (let ((address "control@debbugs.gnu.org"))
    (header-goto-bcc)
    (unless (re-search-forward address (line-end-position) t)
      (insert address))))

(defun at--insert-command (command)
  (save-excursion
    (at--insert-debbugs-control)
    (post-goto-body)
    (unless (re-search-forward "^thankyou$" nil t)
      (insert "package emacs\n")
      (insert "thankyou")
      (save-excursion
        (insert "\n\n")))
    (beginning-of-line)
    (open-line 1)
    (insert command)))

(defun at--insert-usertag (bug tag)
  (interactive (list (read-string (format "Bug number (%s): " (at--get-bug-number))
                                  nil nil (at--get-bug-number))
                     (read-string (format "Tag (ns): ")
                                  nil nil "ns")))
  (at--insert-command "user emacs")
  (at--insert-command (format "usertag %s + %s" bug tag)))

(defun at--insert-merge (bug1 bug2)
  (interactive (list (read-string (format "Bug number (%s): " (at--get-bug-number))
                                  nil nil (at--get-bug-number))
                     (read-string "Merge with bug number: ")))
  (at--insert-command (format "merge %s %s" bug1 bug2)))

(global-set-key (kbd "C-c d u") #'at--insert-usertag)
(global-set-key (kbd "C-c d m") #'at--insert-merge)
