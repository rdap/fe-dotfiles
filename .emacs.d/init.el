(xterm-mouse-mode)
(mouse-wheel-mode)
(menu-bar-mode -1)

(require 'doom-modeline)
(doom-modeline-mode 1)

;(require 'evil)
;(evil-mode 1)

(setq inferior-lisp-program "sbcl")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(set-face-foreground 'vertical-border
                     (face-background 'vertical-border nil t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil slime doom-modeline))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "white" :foreground "black" :inverse-video t))))
 '(vertical-border ((t (:background "black" :inherit mode-line-inactive)))))
