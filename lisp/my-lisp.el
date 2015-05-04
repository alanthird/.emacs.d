(defun magnet (hash tracker)
  "Take a Bittorrent hash, create a magnet link and put it on the clipboard"
  (interactive "sHash: \nsTracker: ")
  (kill-new (if (string= "" tracker)
		(format "magnet:?xt=urn:btih:%s" hash)
	      (format "magnet:?xt=urn:btih:%s&tr=%s" hash tracker))))

(defun pretty-print-xml ()
  "Pretty format XML markup. You need to have nxml-mode http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do this. The function inserts linebreaks to separate tags that have nothing but whitespace between them. It then indents the markup by using nxml's indentation rules. A variant of the code found at http://blog.bookworm.at/2007/03/pretty-print-xml-with-emacs.html"
  (interactive)
  (nxml-mode)
  (goto-char (point-min))
  (while (search-forward-regexp "\>[ \\t]*\<" nil t)
    (backward-char) (insert "\n"))
  (indent-region (point-min) (point-max) nil)
  (message "Ah, much better!"))

