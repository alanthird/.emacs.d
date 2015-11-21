;;; unichar-mode --- Insert correct unicode characters

;;; Copyright (C) Alan Third 2015

;; Author: Alan Third <alan@idiocy.org>
;; Created: 21 Nov 2015
;; Homepage: https://gist.github.com/alanthird/b758d3fb45b0e863f8a4

;; Version: 1.0

;; Keywords: convenience, i18n, wp

;; This file is not part of GNU Emacs.

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;; Except as contained in this notice, the name(s) of the above
;; copyright holders shall not be used in advertising or otherwise to
;; promote the sale, use or other dealings in this Software without
;; prior written authorization.

;;; Commentary:

;; The purpose of this minor-mode is to help with inserting the
;; correct unicode characters, like curly-quotes and the different
;; types of dash. It is inspired by unicycle-mode by Joseph Irwin
;; (https://github.com/cordarei/UniCycle).

;; The idea is that you hit the key for, say, a quote and if it
;; inserts the wrong type of quote you just keep hitting that key
;; until you get the one you want. To aid in this it outputs the
;; Unicode character name in the modeline as you cycle through them.

;; There are a number of variables you can modify to change the exact
;; list of characters you get for each character type. For example,
;; the default is to provide single quotes, as that's the British
;; English standard, but in American English double quotes are
;; normally used, so you could set them as default like so:

;; (setq unichar-opening-quote-list '(#x201C #x2018)
;; (setq unichar-closing-quote-list '(#x201D #x2019)

;;; Code:

(defvar unichar-hyphen-list
  '(#x2010 ?- #x2011 #x2013 #x2014)
  "List of hyphens and dashes.")

(defvar unichar-apostrophe-list
  '(#x2019 ?' #x02BC)
  "List of apostrophe characters.")

(defvar unichar-opening-quote-list
  '(#x2018 #x201C)
  "List of opening quote characters.")

(defvar unichar-closing-quote-list
  '(#x2019 #x201D)
  "List of closing quote characters.")

(defvar unichar-other-quote-list
  '(?\")
  "List of extra quote characters.")

(defun unichar-insert-char (c)
  "Insert C and print out it's Unicode name."
  (insert c)
  (message (get-char-code-property c 'name)))

(defun unichar-insert-from-list (char-list)
  "Insert the next unicode glyph from CHAR-LIST."
  (let ((cur-char (member (char-before) char-list)))
    (cond ((not cur-char) (unichar-insert-char (car char-list)))
          ((not (cdr cur-char))
           (delete-char -1)
           (unichar-insert-char (car char-list)))
          (t (delete-char -1)
             (unichar-insert-char (cadr cur-char))))))

(defun unichar--apostrophe ()
  "Insert apostrophe glyph.
Apostrophes are defined by UNICHAR-APOSTROPHE-LIST."
  (interactive)
  (unichar-insert-from-list unichar-apostrophe-list))

(defun unichar--hyphen ()
  "Insert hyphen.
Hyphens are defined by UNICHAR-HYPHEN-LIST."
  (interactive)
  (unichar-insert-from-list unichar-hyphen-list))

(defun unichar--quote ()
  "Insert quote glyph.
Characters are defined in UNICHAR-OPENING-QUOTE-LIST,
UNICHAR-CLOSING-QUOTE-LIST and UNICHAR-OTHER-QUOTE-LIST. If the
previous character is a space or the beginning of a line, insert
an opening quote, otherwise start with a closing quote."
  (interactive)
  (if (or (bolp) (looking-back "[[:space:]]" 1))
      (unichar-insert-from-list unichar-opening-quote-list)
    (unichar-insert-from-list (append unichar-closing-quote-list
                                      unichar-opening-quote-list
                                      unichar-other-quote-list))))

;;;###autoload
(define-minor-mode unichar-mode
  "Insert appropriate unicode characters and let the user cycle through them."
  :lighter " uq"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "'") 'unichar--apostrophe)
            (define-key map (kbd "\"") 'unichar--quote)
            (define-key map (kbd "-") 'unichar--hyphen)
            map))

(provide 'unichar)
;;; unichar-mode.el ends here
