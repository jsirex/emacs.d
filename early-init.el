;;; early-init.el -*- lexical-binding: t; -*-

;;; Emacs HEAD (27+) introduces early-init.el, which is run before init.el,
;;; before most of its package and UI initialization happens.

;; Faster to disable these here (before they've been initialized)
(setq tool-bar-mode nil
      menu-bar-mode nil
      scroll-bar-mode nil
      tooltip-mode nil
      use-file-dialog nil
      use-dialog-box nil)

(modify-all-frames-parameters '((vertical-scroll-bars)))

;; We're going to manually initialize packages
(setq package-enable-at-startup nil)

;;; early-init.el ends here
