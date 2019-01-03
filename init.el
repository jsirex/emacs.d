;;; Package --- Sirex Configuration for Emacs -*- lexical-binding: t -*-
;;; Commentary:
;;; Emacs Snapshot Configuration File
;;; Code:

;; Let's start emacs up quietly.
(advice-add #'display-startup-echo-area-message :override #'ignore)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name
      inhibit-default-init t
      ;; initial-major-mode 'fundamental-mode
      initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n")
      mode-line-format nil)

;; These so obvious so I put it there
(defalias 'yes-or-no-p 'y-or-n-p)

;; If we have compiled file then start with it
;; else do heavy procedure of parsing/loading/compiling from org
(let ((file-name-handler-alist nil))
  (if (file-exists-p (expand-file-name "README.elc" user-emacs-directory))
      (load-file (expand-file-name "README.elc" user-emacs-directory))
    (require 'org)
    (org-babel-load-file (expand-file-name "README.org" user-emacs-directory))))

(provide 'init)
;;; init.el ends here
