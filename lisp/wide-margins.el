(defun wide-margins-resize ()
  "Resize the buffer margins."
  (when wide-margins-mode
    (setq wide-margins-margin-size 
	  (/ (- (window-total-width) fill-column) 2))
    (set-window-margins nil 
			wide-margins-margin-size 
			wide-margins-margin-size)))

(define-minor-mode wide-margins-mode
  "Reduce the buffer's editing area horizontally by increasing the
margins until the working area is the width of fill-column."
  :lighter " margins"
  (progn
    (if wide-margins-mode
	(progn
	  (wide-margins-resize)
	  (add-hook 'window-configuration-change-hook 
		    'wide-margins-resize))
      (remove-hook 'window-configuration-change-hook
		   'wide-margins-resize)
      (set-window-margins nil 0 0))))
