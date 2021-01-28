;;; early-init.el -*- lexical-binding: t; -*-

;;; Emacs HEAD (27+) introduces early-init.el, which is run before init.el.
;;; This file is loaded before the package system and GUI is initialized

(customize-set-value 'package-enable-at-startup nil "We will manually initialize packages")



;; During startup we temporary increase gc
(customize-set-variable 'gc-cons-threshold (* 256 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda () (customize-set-variable 'gc-cons-threshold (* 16 1024 1024)) (garbage-collect)))



;; Settings
(customize-set-variable 'frame-inhibit-implied-resize t "Resize can be a terribly expensive")
(customize-set-variable 'history-length 100)
(customize-set-variable 'horizontal-scroll-bar-mode nil)
(customize-set-variable 'indent-tabs-mode nil "By default do not insert tabs")
(customize-set-variable 'inhibit-compacting-font-caches t)
(customize-set-variable 'menu-bar-mode nil)
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'scroll-conservatively 101 "Set modern scrolling behavior")
(customize-set-variable 'sentence-end-double-space nil)
(customize-set-variable 'tab-width 4)
(customize-set-variable 'tool-bar-mode nil)
(customize-set-variable 'tooltip-mode nil)

;; Early set font face
(set-face-attribute 'default nil :family "FuraCode Nerd Font Mono" :height 80)



;; These so obvious so I put it there
(defalias 'yes-or-no-p 'y-or-n-p)

(provide 'early-init)
;;; early-init.el ends here
