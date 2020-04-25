;;; early-init.el -*- lexical-binding: t; -*-

;;; Emacs HEAD (27+) introduces early-init.el, which is run before init.el,
;;; before most of its package and UI initialization happens.

(setq lexical-binding t)

;; Temporary turn off file name handlers
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum)

;; Restore garbage collection and file name handlers
(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold 134217728 ; 128 MB
                  gc-cons-percentage 0.1
                  file-name-handler-alist file-name-handler-alist-original)
            (garbage-collect)))

;; Faster to disable these here (before they've been initialized)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

;; We're going to manually initialize packages
(setq package-enable-at-startup nil)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

;; Early set font face
(add-to-list 'default-frame-alist '(font . "FuraCode Nerd Font Mono"))
(set-face-attribute 'default nil :family "FuraCode Nerd Font Mono" :height 80)

;; These so obvious so I put it there
(defalias 'yes-or-no-p 'y-or-n-p)

(provide 'early-init)
;;; early-init.el ends here
