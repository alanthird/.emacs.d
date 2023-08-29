(when (display-graphic-p)
  ;; GTK honours a weight of "light", however Windows doesn't so I
  ;; have to set the specific "light" font. "Bold", however *is*
  ;; honoured, so I have to unset it for the bold faces that I want to
  ;; display using the "regular" font.
  (set-face-attribute 'default nil :family "IBM Plex Mono light")
  (set-face-attribute 'bold nil :family "IBM Plex Mono" :weight 'normal)
  (set-face-attribute 'bold-italic nil :family "IBM Plex Mono" :weight 'normal)
  (set-face-attribute 'fixed-pitch nil :family "IBM Plex Mono light")
  (set-face-attribute 'fixed-pitch-serif nil :family "IBM Plex Mono light")

  (set-fontset-font t 'unicode "Noto Sans")
  (set-fontset-font t 'unicode "DejaVu Sans" nil 'append)
  (set-fontset-font t 'unicode "Courier New" nil 'append)
  (set-fontset-font t 'unicode "Symbola" nil 'append)

  ;; Symbols: → 🤨
  ;; I don't understand why there are two symbols fonts.
  (set-fontset-font t 'symbol "Noto Sans Symbols")
  (set-fontset-font t 'symbol "Noto Sans Symbols2" nil 'append)
  (set-fontset-font t 'symbol "Symbola" nil 'append)

  ;; Emoji: 😄, 🤦, 🏴󠁧󠁢󠁳󠁣󠁴󠁿
  (set-fontset-font t 'emoji "Noto Color Emoji")
  (set-fontset-font t 'emoji "Apple Color Emoji" nil 'append)
  (set-fontset-font t 'emoji "Segoe UI Emoji" nil 'append)
  (set-fontset-font t 'emoji "Noto Emoji" nil 'append)
  (set-fontset-font t 'emoji "EmojiSymbols" nil 'append)

  ;; Latin
  (set-fontset-font t 'latin "IBM Plex Sans")
  (set-fontset-font t 'latin "Noto Sans" nil 'append)

  ;; Europe
  (set-fontset-font t 'georgian "Noto Sans Georgian")

  ;; East Asia: 你好, 早晨, こんにちは, 안녕하세요
  (set-fontset-font t 'han "IBM Plex Sans JP light")
  (set-fontset-font t 'han "Noto Sans CJK KR Regular" nil 'append)
  (set-fontset-font t 'kana "IBM Plex Sans JP light" nil 'append)
  (set-fontset-font t 'kana "Noto Sans CJK KR Regular")
  (set-fontset-font t 'hangul "IBM Plex Sans KR light")
  (set-fontset-font t 'hangul "Noto Sans CJK KR Regular" nil 'append)
  (set-fontset-font t 'cjk-misc "IBM Plex Sans KR light")
  (set-fontset-font t 'cjk-misc "Noto Sans CJK KR Regular" nil 'append)

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
  (set-fontset-font t 'tibetan "Noto Sans Tibetan"))
(set-fontset-font t 'bengali "Noto Sans Bengali")

(set-face-attribute 'variable-pitch nil :font "IBM Plex Sans")
