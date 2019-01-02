(set-face-attribute 'default nil :font "Droid Sans Mono")
(set-fontset-font t 'unicode "Noto Sans" nil 'prepend)
(set-fontset-font t 'unicode "DejaVu Sans" nil 'append)
(set-fontset-font t 'unicode "Courier New" nil 'append)
(set-fontset-font t 'unicode "Symbola" nil 'append)

;; East Asia: 你好, 早晨, こんにちは, 안녕하세요
(set-fontset-font t 'han "Noto Sans CJK KR Regular")
(set-fontset-font t 'kana "Noto Sans CJK KR Regular")
(set-fontset-font t 'hangul "Noto Sans CJK KR Regular")
(set-fontset-font t 'cjk-misc "Noto Sans CJK KR Regular")

(set-face-attribute 'variable-pitch nil :font "GaramondNo8")
