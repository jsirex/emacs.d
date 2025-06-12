;;; init.el --- Sirex Configuration for Emacs        -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Yauhen Artsiukhou

;; Author: Yauhen Artsiukhou <jsirex@gmail.com>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(eval-and-compile
  (require 'cl-lib)
  (require 'package)
  (require 'use-package)

  ;; like add-to-list it is quite improper to setq a custom variable
  ;; setopt should be used for custom variables, but nobody cares
  (cl-pushnew '("melpa"  . "https://melpa.org/packages/")        package-archives :test #'equal)

  (setopt package-native-compile t
          package-quickstart t
          package-archive-priorities '(("gnu"    . 0)
                                       ("nongnu" . 10)
                                       ("melpa"  . 20)))

  (setopt use-package-expand-minimally t
          use-package-always-defer t
          use-package-always-ensure t
          use-package-use-theme nil))


;; C-sources Core
(use-package emacs :ensure nil
  :init
  (setopt auto-save-list-file-name nil
          create-lockfiles nil
          fill-column 80
          history-delete-duplicates t
          history-length 500
          inhibit-compacting-font-caches t
          read-process-output-max (* 1 1024 1024)
          scroll-conservatively 101
          tab-width 4
          x-stretch-cursor t
          use-short-answers t

          ;; startup
          auto-save-list-file-prefix nil
          inhibit-startup-message t
          initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n")

          ;; novice
          disabled-command-function nil

          ;; runtime Lisp native compiler
          native-comp-async-report-warnings-errors nil))


;; --- Internal Packages
(use-package autorevert :ensure nil
  :init
  (setopt global-auto-revert-mode t
          auto-revert-mode-text ""))

(use-package compile :ensure nil
  :init
  (setopt compilation-ask-about-save nil
          compilation-always-kill t
          compilation-scroll-output 'first-error))

(use-package cus-edit :ensure nil
  :init
  (setopt custom-file (locate-user-emacs-file "ignored-custom.el")))

(use-package dabbrev :ensure nil :demand t
  :init
  (setopt dabbrev-upcase-means-case-search t)
  (keymap-global-set "M-/" #'dabbrev-expand)
  (keymap-global-set "C-M-/" #'dabbrev-completion))
  ;; (add-hook 'completion-at-point-functions #'dabbrev-capf))

(use-package delsel :ensure nil
  :init
  (setopt delete-selection-mode t))

(use-package dired :ensure nil
  :init
  (setopt dired-auto-revert-buffer t
          dired-dwim-target t
          dired-recursive-copies 'always
          dired-recursive-deletes 'top))

(use-package desktop :ensure nil
  :init
  (setopt desktop-save-mode t
      desktop-save t
      desktop-auto-save-timeout 600
      desktop-restore-frames nil))

(use-package docker-ts-mode :ensure nil
  :init
  (add-to-list 'auto-mode-alist '("Containerfile" . dockerfile-ts-mode))
  (add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-ts-mode)))

(use-package editorconfig :ensure nil
  :init
  (setopt editorconfig-mode t
          editorconfig-mode-lighter ""))

(use-package eglot :ensure nil
  :init
  (setopt eglot-autoshutdown t)
  (add-hook 'prog-mode-hook #'eglot-ensure))

(use-package elec-pair :ensure nil
  :init
  (setopt electric-pair-mode t))

(use-package files :ensure nil
  :init
  (setopt auto-save-default nil
          make-backup-files nil
          require-final-newline t)

  (dolist (mode-map '((c-mode . c-ts-mode)
                      (c++-mode . c++-ts-mode)
                      (cmake-mode . cmake-ts-mode)
                      (csharp-mode . csharp-ts-mode)
                      (dockerfile-mode . dockerfile-ts-mode)
                      (python-mode . python-ts-mode)
                      (rust-mode . rust-ts-mode)
                      (sh-mode . bash-ts-mode)
                      (typescript-mode . typescript-ts-mode)
                      (yaml-mode . yaml-ts-mode)))
    (cl-pushnew mode-map major-mode-remap-alist :test #'equal)))

(use-package fira-code-mode :diminish
  :init
  (add-hook 'prog-mode-hook #'fira-code-mode))

(use-package flymake :ensure nil
  :init
  (setopt flymake-no-changes-timeout 5)
  (dolist (mode-hook '(sh-base-mode-hook
                       yaml-ts-mode-hook))
          (add-hook mode-hook #'flymake-mode)))

(use-package hl-line :ensure nil
  :init
  (setopt global-hl-line-mode t))

(use-package ibuffer :ensure nil
  :init
  (keymap-global-set "C-x C-b" #'ibuffer-jump))

(use-package indent :ensure nil
  :init
  (setopt tab-always-indent 'complete))

(use-package minibuffer :ensure nil
  :init
  (setopt completion-cycle-threshold nil
          completion-styles '(orderless partial-completion)
          completion-category-overrides '((file (styles basic partial-completion)))))
(use-package paragraphs :ensure nil
  :init
  (setopt sentence-end-double-space nil))

(use-package paren :ensure nil
  :init
  (setopt show-paren-mode t))

(use-package project :ensure nil
  :init
  (keymap-global-set "<f9>" 'project-compile)
  (keymap-global-set "C-<f9>" 'project-recompile)
  :config
  (keymap-set project-prefix-map "m" #'magit-project-status)
  (keymap-set project-prefix-map "s" #'consult-git-grep)
  (add-to-list 'project-switch-commands '(magit-project-status "Magit") t))

(use-package recentf :ensure nil
  :init
  (setopt recentf-mode t
          recentf-max-saved-items 100
          recentf-exclude '("/tmp/" "/ssh:")))

(use-package subword :ensure nil :diminish
  :init
  (add-hook 'prog-mode-hook #'subword-mode))

(use-package savehist :ensure nil
  ;; Save minibuffer history
  :init
  (setopt savehist-mode t
      savehist-autosave-interval (* 1 60 60)))

(use-package saveplace :ensure nil
  :init
  (setopt save-place-mode t))

(use-package simple :ensure nil
  :init
  (setopt column-number-mode t
          indent-tabs-mode nil
          line-number-mode t))

(use-package so-long :ensure nil
  :init
  (setopt global-so-long-mode t))

(use-package wdired :ensure nil
  :init
  (setopt wdired-allow-to-change-permissions t))

(use-package whitespace :ensure nil :diminish
  :init
  (setopt global-whitespace-mode t
          whitespace-action '(auto-cleanup warn-if-read-only)
          whitespace-style '(face trailing tabs space-after-tab space-before-tab missing-newline-at-eof)))

(use-package which-key :ensure nil :diminish
  :init
  (setopt which-key-mode t))

(use-package windmove :ensure nil
  :init
  (setopt windmove-mode t
          windmove-default-keybindings '(nil control)
          windmove-swap-states-default-keybindings '(nil control shift)))

(use-package window :ensure nil
  :init
  (setopt split-width-threshold 160
          split-height-threshold 100))

(use-package winner :ensure nil
  :init
  (setopt winner-mode t))

(use-package yaml-ts-mode :ensure nil
  :init
  (add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode)))


;;; -- External Packages

(use-package avy
  :init
  (setopt avy-timeout-seconds 0.3)
  (keymap-global-set "C-'" #'avy-goto-line)
  (keymap-global-set "C-;" #'avy-goto-char-timer))

(use-package avy-zap
  :init
  (keymap-global-set "M-z" #'avy-zap-up-to-char-dwim))

(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-file))

(use-package color-theme-sanityinc-tomorrow
  :init
  (load-theme 'sanityinc-tomorrow-eighties t))

(use-package consult
  :init
  (keymap-global-set "<remap> <isearch-forward>" #'consult-line)
  (keymap-global-set "<remap> <switch-to-buffer>" #'consult-buffer)
  (keymap-global-set "<remap> <switch-to-buffer-other-window>" #'consult-buffer-other-window)
  (keymap-global-set "<remap> <yank-pop>" #'consult-yank-pop)
  (keymap-global-set "<remap> <goto-line>" #'consult-goto-line))

;; (use-package consult-ag)
;; (use-package consult-project-extra)

(use-package corfu
  :init
  (setopt global-corfu-mode t
          corfu-count 20
          corfu-min-width 50
          corfu-max-width 200
          corfu-preview-current t
          corfu-auto t
          corfu-auto-delay 0.5
          corfu-popupinfo-delay '(0.5 . 0.1)
          corfu-popupinfo-mode t)
  :config
  (keymap-set corfu-map "M-q" #'corfu-quick-complete))

(use-package diff-hl
  :init
  (add-hook 'dired-mode-hook #'diff-hl-dired-mode)
  (add-hook 'prog-mode-hook #'diff-hl-mode))

(use-package diminish)

(use-package dired-subtree
  :init
  (setopt dired-subtree-line-prefix "    ")

  (with-eval-after-load 'dired
    (keymap-set dired-mode-map "<tab>" #'dired-subtree-toggle)
    (keymap-set dired-mode-map ";" #'dired-subtree-remove)))

(use-package diredfl
  :init
  (add-hook 'dired-mode-hook #'diredfl-mode))

(use-package docker
  :init
  (setopt docker-command "podman")
  (defalias 'podman 'docker))

(use-package embark
  :init
  (keymap-global-set "C-." #'embark-act)
  (keymap-global-set "C-c C-o" #'embark-export))

(use-package embark-consult)

(use-package expand-region
  :init
  (keymap-global-set "C-=" #'er/expand-region))

(use-package flymake-yamllint
  :init
  (add-hook 'yaml-ts-mode-hook 'flymake-yamllint-setup))

(use-package git-modes)
(use-package git-timemachine)

(use-package gptel
  :init
  (load (expand-file-name (locate-user-emacs-file ".gptel-custom-backends")) t)

  :config
  (keymap-set gptel-mode-map "C-c ." #'gptel-menu))

(use-package kubernetes
  :init
  (setopt kubernetes-poll-frequency 3600
          kubernetes-redraw-frequency 3600))

(use-package kubedoc)

(use-package magit
  :config
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

;; magit-push is part of magit package, but hook after load is different
(use-package magit-push :ensure nil
  :config
  (transient-append-suffix 'magit-push "-n"
    '("-gm" "GitLab Create Merge Request" "--push-option=merge_request.create")))

(use-package magit-todos)

(use-package marginalia
  :init
  (setopt marginalia-mode t))

(use-package markdown-mode)

(use-package move-dup :diminish
  :init
  (setopt global-move-dup-mode t))

(use-package multiple-cursors :demand t
  :init
  (keymap-global-set "C->" #'mc/mark-next-like-this)
  (keymap-global-set "C-<" #'mc/mark-previous-like-this)
  (keymap-global-set "C-c m m" #'mc/mark-all-dwim)
  (keymap-global-set "C-S-<mouse-1>" #'mc/toggle-cursor-on-click)

  :config
  ;; bug with mc/toggle-cursor-on-click
  (cl-pushnew 'mc/toggle-cursor-on-click mc--default-cmds-to-run-once)
  (keymap-set mc/keymap "M-<return>" #'mc/skip-to-next-like-this))

(use-package nerd-icons
  :config
  (cl-pushnew '("containerfile" nerd-icons-sucicon "nf-seti-docker" :face nerd-icons-cyan)
              nerd-icons-extension-icon-alist :test #'equal)
  (cl-pushnew '("^\\.?Containerfile" nerd-icons-sucicon "nf-seti-docker" :face nerd-icons-blue)
              nerd-icons-regexp-icon-alist :test #'equal))

(use-package nerd-icons-completion
  :init
  (setopt nerd-icons-completion-mode t))

(use-package nerd-icons-corfu
  :init
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :init
  (add-hook 'dired-mode-hook #'nerd-icons-dired-mode))

(use-package nginx-mode)

(use-package orderless)

(use-package phi-search
  :init
  (with-eval-after-load 'multiple-cursors
    (keymap-set mc/keymap "C-s" #'phi-search)
    (keymap-set mc/keymap "C-r" #'phi-search-backward)))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package sly
  :init
  (setopt inferior-lisp-program "sbcl --dynamic-space-size 4GB")
  :config
  ;; this to keys I use for symbol overlay
  (keymap-unset sly-editing-mode-map "M-p")
  (keymap-unset sly-editing-mode-map "M-n"))

(use-package sly-asdf)

(use-package switch-window
  :init
  (setopt switch-window-shortcut-style 'qwerty)
  (keymap-global-set "C-x o" #'switch-window)
  (keymap-global-set "C-x 0" #'switch-window-then-delete))

(use-package symbol-overlay :diminish
  :init
  (setopt symbol-overlay-mode t)

  (add-hook 'prog-mode-hook #'symbol-overlay-mode)

  (keymap-global-set "M-i" #'symbol-overlay-put)
  (keymap-global-set "M-n" #'symbol-overlay-jump-next)
  (keymap-global-set "M-p" #'symbol-overlay-jump-prev))

(use-package systemd)

;; a little buggy module
(use-package terraform-ts-mode :demand t
  :vc (:url "https://github.com/kgrotel/terraform-ts-mode.git"
            :branch "v0.6"
            :rev :newest))

(use-package treesit-auto
  :init
  (setopt treesit-auto-install 'prompt))

(use-package vertico
  :init
  (setopt vertico-mode t
          vertico-count 20)
  :config
  (keymap-set vertico-map "TAB" #'minibuffer-complete)
  (keymap-set vertico-map "M-q" #'vertico-quick-exit))

(use-package wgrep
  :init
  (setopt wgrep-too-many-file-length 20
          wgrep-auto-save-buffer t))

(use-package zoom :diminish
  :init
  (setopt zoom-mode t
          zoom-ignored-major-modes '(dired-mode)
          zoom-size '(0.618 . 0.618)))

(provide 'init)
;;; init.el ends here
