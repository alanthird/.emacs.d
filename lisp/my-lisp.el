(defun magnet (hash tracker)
  "Take a Bittorrent hash, create a magnet link and put it on the
clipboard"
  (interactive "sHash: \nsTracker: ")
  (kill-new (if (string= "" tracker)
		(format "magnet:?xt=urn:btih:%s" hash)
	      (format "magnet:?xt=urn:btih:%s&tr=%s" hash tracker))))

(defun pretty-print-xml ()
  "Pretty format XML markup. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this. The function inserts linebreaks to separate tags that have
nothing but whitespace between them. It then indents the markup
by using nxml's indentation rules. A variant of the code found at
http://blog.bookworm.at/2007/03/pretty-print-xml-with-emacs.html"
  (interactive)
  (nxml-mode)
  (goto-char (point-min))
  (while (search-forward-regexp "\>[ \\t]*\<" nil t)
    (backward-char) (insert "\n"))
  (indent-region (point-min) (point-max) nil)
  (message "Ah, much better!"))

(advice-add 'toggle-frame-maximized
            :before (lambda () (set-frame-parameter nil 'undecorated t)))

(defun at/start-putty ()
  "Start a PuTTY session.
If the current buffer is a remote file, try to re-use the
connection details."
  (interactive)
  (let ((connection-string
         (if (file-remote-p default-directory)
             (string-join (list (file-remote-p default-directory 'user)
                                "@"
                                (file-remote-p default-directory 'host)))
           "")))
    (start-process (string-join (list "PuTTY(" connection-string ")"))
                   nil "putty" connection-string)))

(global-set-key (kbd "C-c p") 'at/start-putty)

(defun at/start-command-prompt ()
  (interactive)
  (let ((proc (start-process "cmd" nil "cmd.exe" "/C" "start" "cmd.exe")))
    (set-process-query-on-exit-flag proc nil)))

(global-set-key (kbd "C-c s") 'at/start-command-prompt)


(defun at/start-php-server (root)
  (interactive "DServer root:")
  (start-process "php-server" "*PHP Server*"
                 "php" "-S" "localhost:8080"
                 "-t" (expand-file-name root)))

(global-set-key (kbd "C-c w") 'at/start-php-server)
