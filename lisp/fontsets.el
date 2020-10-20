(set-face-attribute 'default nil :font "Droid Sans Mono")
(set-fontset-font t 'unicode "Noto Sans")
(set-fontset-font t 'unicode "DejaVu Sans" nil 'append)
(set-fontset-font t 'unicode "Courier New" nil 'append)
(set-fontset-font t 'unicode "Symbola" nil 'append)

;; Symbols: → 🤨
;; I don't understand why there are two symbols fonts.
(set-fontset-font t 'symbol "Noto Sans Symbols")
(set-fontset-font t 'symbol "Noto Sans Symbols2" nil 'append)
(set-fontset-font t 'symbol "Noto Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)
(set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)

;; Latin
(set-fontset-font t 'latin "Noto Sans")

;; Europe
(set-fontset-font t 'georgian "Noto Sans Georgian")

;; East Asia: 你好, 早晨, こんにちは, 안녕하세요
(set-fontset-font t 'han "Noto Sans CJK KR Regular")
(set-fontset-font t 'kana "Noto Sans CJK KR Regular")
(set-fontset-font t 'hangul "Noto Sans CJK KR Regular")
(set-fontset-font t 'cjk-misc "Noto Sans CJK KR Regular")

;; South East Asia: ជំរាបសួរ, ສະບາຍດີ, မင်္ဂလာပါ, สวัสดีครับ
(set-fontset-font t 'khmer "Noto Sans Khmer")
(set-fontset-font t 'lao "Noto Sans Lao")
(set-fontset-font t 'burmese "Noto Sans Myanmar")
(set-fontset-font t 'thai "Noto Sans Thai")

;; Africa: ሠላም
(set-fontset-font t 'ethiopic "Noto Sans Ethiopic")

;; Middle/Near East: שלום, السّلام عليكم
(set-fontset-font t 'hebrew "Noto Sans Hebrew")
(set-fontset-font t 'arabic "Noto Sans Arabic")

;;  South Asia: નમસ્તે, नमस्ते, ನಮಸ್ಕಾರ, നമസ്കാരം, ଶୁଣିବେ,
;;              ආයුබෝවන්, வணக்கம், నమస్కారం, བཀྲ་ཤིས་བདེ་ལེགས༎,
;;              বাংলা
(set-fontset-font t 'gujarati "Noto Sans Gujarati")
(set-fontset-font t 'devanagari "Noto Sans Devanagari")
(set-fontset-font t 'kannada "Noto Sans Kannada")
(set-fontset-font t 'malayalam "Noto Sans Malayalam")
(set-fontset-font t 'oriya "Noto Sans Oriya")
(set-fontset-font t 'sinhala "Noto Sans Sinhala")
(set-fontset-font t 'tamil "Noto Sans Tamil")
(set-fontset-font t 'telugu "Noto Sans Telugu")
(set-fontset-font t 'tibetan "Noto Sans Tibetan")
(set-fontset-font t 'bengali "Noto Sans Bengali")

(set-face-attribute 'variable-pitch nil :font "GaramondNo8")

;; Emoji: 😄, 🤦, 🏴󠁧󠁢󠁳󠁣󠁴󠁿
(set-fontset-font t 'symbol "Apple Color Emoji")
(set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
(set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)
