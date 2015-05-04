(defun magnet (hash tracker)
  "Take a Bittorrent hash, create a magnet link and put it on the clipboard"
  (interactive "sHash: \nsTracker: ")
  (kill-new (if (string= "" tracker)
		(format "magnet:?xt=urn:btih:%s" hash)
	      (format "magnet:?xt=urn:btih:%s&tr=%s" hash tracker))))
