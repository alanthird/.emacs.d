;; bind all the greek letters with the prefix C-c g. So, for example
;; C-ga inserts α and C-gOME inserts Ω

(defun at/global-bind-alist (prefix alist)
  (mapc
   (lambda (p)
     (global-set-key (kbd (concat prefix (car p))) (cdr p)))
   alist))

(at/global-bind-alist "C-c g"
                      '(("a" . "α")   ("A" . "Α")     ;; alpha
                        ("b" . "β")   ("B" . "Β")     ;; beta
                        ("g" . "γ")   ("G" . "Γ")     ;; gamma
                        ("d" . "δ")   ("D" . "Δ")     ;; delta
                        ("ep" . "ε")  ("EP" . "Ε")    ;; epsilon
                        ("z" . "ζ")   ("Z" . "Ζ")     ;; zeta
                        ("et" . "η")  ("ET" . "Η")    ;; eta
                        ("th" . "θ")  ("TH" . "Θ")    ;; theta
                        ("i" . "ι")   ("I" . "Ι")     ;; iota
                        ("k" . "κ")   ("K" . "Κ")     ;; kappa
                        ("l" . "λ")   ("L" . "Λ")     ;; lambda
                        ("m" . "μ")   ("M" . "Μ")     ;; mu
                        ("n" . "ν")   ("N" . "Ν")     ;; nu
                        ("x" . "ξ")   ("X" . "Ξ")     ;; xi
                        ("omi" . "ο") ("OMI" . "Ο")   ;; omicron
                        ("pi" . "π")  ("PI" . "Π")    ;; pi
                        ("r" . "ρ")   ("R" . "Ρ")     ;; rho
                        ("s" . "σ")   ("S" . "Σ")     ;; sigma
                        ("ta" . "τ")  ("TA" . "Τ")    ;; tau
                        ("u" . "υ")   ("U" . "Υ")     ;; upsilon
                        ("ph" . "φ")  ("PH" . "Φ")    ;; phi
                        ("c" . "χ")   ("C" . "Χ")     ;; chi
                        ("ps" . "ψ")  ("PS" . "Ψ")    ;; psi
                        ("ome" . "ω") ("OME" . "Ω"))) ;; omega

