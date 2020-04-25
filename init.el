;;; init.el --- Sirex Configuration for Emacs        -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Yauhen Artsiukhou

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

;; Emacs Initialization

;;; Code:

(eval-and-compile
  (setq user-full-name "Yauhen Artsiukhou"
        user-mail-address "jsirex@gmail.com"

        custom-file "/dev/null")

  ;; Prefer UTF-8
  (set-language-environment "UTF-8"))



;;; Initialize package and use-package

(eval-and-compile
  (require 'package)

  ;; Merges all autoload into single package-quickstart.el
  (setq package-quickstart t)

  ;; Load package and use-package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org"   . "https://orgmode.org/elpa/") t)
  (add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/") t)

  (setq package-archive-priorities
        '(("melpa" .  3)
          ("org" . 2)
          ("gnu" . 1)))

  (package-initialize)

  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

  (require 'use-package)

  (setq use-package-always-ensure t
        use-package-always-defer t))



;;; C-Source Emacs

(setq-default indent-tabs-mode nil
              inhibit-compacting-font-caches t
              scroll-conservatively 101
              sentence-end-double-space nil
              tab-width 4)



;;; Built-in packages

(use-package autorevert :ensure nil :demand t
  :config
  (global-auto-revert-mode 1))

(use-package compile :ensure nil :demand t
  :config
  (setq compilation-ask-about-save nil
        compilation-scroll-output 'first-error))

(use-package custom :ensure nil :demand t
  :config
  (setq custom-safe-themes t))

(use-package delsel :ensure nil :demand t
  :config
  (delete-selection-mode t))

(use-package desktop :ensure nil :demand t
  :config
  (setq desktop-auto-save-timeout 600)

  (desktop-save-mode 1))

(use-package dired :ensure nil :demand t
  :config
  (setq dired-recursive-deletes 'always
        dired-recursive-copies 'always
        dired-dwim-target t
        dired-auto-revert-buffer t))

(use-package electric :ensure nil
  :hook (prog-mode . electric-pair-mode))

(use-package files :ensure nil :demand t
  :config
  (setq-default auto-save-default nil
                auto-save-list-file-prefix nil
                auto-save-list-file-name nil
                create-lockfiles nil
                make-backup-file nil
                require-final-newline t))

(use-package hippie-exp :ensure nil :demand t
  :bind ("M-/"  . hippie-expand)
  :config
  (setq hippie-expand-try-functions-list '(try-complete-file-name-partially
                                           try-complete-file-name
                                           try-expand-dabbrev
                                           try-expand-dabbrev-all-buffers
                                           try-expand-dabbrev-from-kill)))

(use-package hl-line :ensure nil :demand t
  :hook ((prog-mode text-mode) . hl-line-mode))

(use-package ibuffer :ensure nil :demand t
  :bind ("C-x C-b" . ibuffer))

(use-package novice :ensure nil :demand t
  :config
  (setq disabled-command-function nil))

(use-package paren :ensure nil :demand t
  :config
  (show-paren-mode 1))

(use-package recentf :ensure nil :demand t
  :config
  (setq recentf-exclude '("/tmp/" "/ssh:")
        recentf-max-saved-items 50))

(use-package savehist :ensure nil :demand t
  :config
  (setq history-length 1000
        savehist-additional-variables '(kill-ring search-ring regexp-search-ring)
        savehist-autosave-interval nil ; save on kill only
        savehist-save-minibuffer-history t)

  (savehist-mode 1))

(use-package saveplace :ensure nil :demand t
  :config
  (save-place-mode 1))

(use-package simple :ensure nil :demand t
  :config
  (line-number-mode 1)
  (column-number-mode 1))

(use-package so-long :ensure nil :demand t
  :config
  (global-so-long-mode 1))

(use-package startup :ensure nil :demand t :no-require t
  :config
  (setq initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n")
        inhibit-startup-message t))

(use-package subword :ensure nil :demand t :diminish
  :hook (prog-mode . subword-mode))

(use-package uniquify :ensure nil :demand t
  :config
  (setq uniquify-buffer-name-style 'reverse
        uniquify-separator " • "
        uniquify-after-kill-buffer-p t
        uniquify-ignore-buffers-re "^\\*"))

(use-package wdired :ensure nil :demand t
  :config
  (setq wdired-allow-to-change-permissions t))

(use-package whitespace :ensure nil :demand t
  :config
  (setq-default whitespace-action '(auto-cleanup warn-read-only)
                whitespace-style '(face trailing space-after-tab space-before-tab))

  (global-whitespace-mode 1))

(use-package windmove :ensure nil :demand t
  :bind (("C-S-<left>" . windmove-swap-states-left)
         ("C-S-<right>" . windmove-swap-states-right)
         ("C-S-<up>" . windmove-swap-states-up)
         ("C-S-<down>" . windmove-swap-states-down))
  :config
  (windmove-default-keybindings 'control))

(use-package window :ensure nil :demand t
  :config
  (setq split-height-threshold 100
        split-width-threshold 200))

(use-package winner :ensure nil :demand t
  :config
  (winner-mode 1))



;;; Packages

(use-package all-the-icons)
(use-package all-the-icons-dired :diminish
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package diminish :demand t)
(use-package bind-key :demand t)

(use-package company :demand t :diminish
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous))
  :config
  (setq-default company-dabbrev-ignore-case nil
                company-dabbrev-other-buffers t
                company-tooltip-align-annotations t
                company-idle-delay 0
                company-echo-delay 0
                company-minimum-prefix-length 3
                company-tooltip-limit 20)
  (global-company-mode 1))

(use-package gitconfig-mode)
(use-package gitignore-mode)
(use-package gitattributes-mode)

(use-package git-timemachine)

;; gited - dired git?

(use-package gitlab-ci-mode)
(use-package gitlab-ci-mode-flycheck)


(use-package unkillable-scratch :demand t
  :config
  (unkillable-scratch 1))

;; Consider https://editorconfig.org/.
(use-package editorconfig :demand t :diminish
  :config
  (editorconfig-mode 1))

;;   ;; Move cursor through CamelCase, snake_case through the each word.

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)


;; ;;; Automatically adjust windows sizes. This makes emacs to behave like a tiling manager

(use-package zoom :demand t :diminish
  :config
  (setq zoom-size '(0.618 . 0.618)
        zoom-ignored-major-modes '(dired-mode)) ;; golden ratio

  (zoom-mode 1))


;;

;; ;;; Themes

(use-package color-theme-sanityinc-tomorrow :demand t
  :config

  (load-theme 'sanityinc-tomorrow-eighties))


(use-package undo-tree :demand t
  :diminish undo-tree-mode
  :config
  (setq undo-tree-visualizer-diff t
        undo-tree-visualizer-timestamps t
        undo-tree-visualizer-relative-timestamps t)
  (global-undo-tree-mode 1))

;; ;;; Display ligatures for fira code font

(use-package fira-code-mode :diminish
  :hook prog-mode) ;; Enables fira-code-mode automatically for programming major modes

(use-package rainbow-delimiters
  :hook ((prog-mode) . rainbow-delimiters-mode))


;; ;;; Zap up to char: delete from current up to char

(use-package avy-zap
  :bind (("M-z" . avy-zap-up-to-char-dwim)
         ("M-Z" . avy-zap-up-to-char-dwim))

  :config
  (setq avy-zap-forward-only t))





;; ;;; This expands region: press ~C-=~ and then ~=~ to expand, ~-~ to collapse and ~0~ to reset.

(use-package expand-region
  :bind ("C-=" . er/expand-region))


(use-package multiple-cursors
  :bind (("C-<" . mc/mark-previous-like-this)
         ("C->" . mc/mark-next-like-this)
         ("C-c m m" . mc/mark-all-dwim)
         ("C-c m s" . mc/skip-to-next-like-this)
         ("C-c C-'" . mc-hide-unmatched-lines-mode)))

(use-package phi-search
  :bind (:map mc/keymap
              ("C-s" . phi-search)
              ("C-r" . phi-search-backward)))

;; ;; Mark cursors almost like avy
;; (use-package ace-mc
;;   :requires ace-jump-mode

;;   :bind (("C-)" . ace-mc-add-multiple-cursors)))

(use-package symbol-overlay :diminish
  :bind (:map symbol-overlay-mode-map
              ("M-i" . symbol-overlay-put)
              ("M-n" . symbol-overlay-jump-next)
              ("M-p" . symbol-overlay-jump-prev))

  :hook ((prog-mode html-mode yaml-mode conf-mode) . symbol-overlay-mode))



;; ;;; Writable grep buffer

(use-package wgrep :demand t
  :config
  (setq wgrep-auto-save-buffer t))

(use-package wgrep-ag :demand t)


;; ;;; Switch between windows using uniq key with ~C-x o <key>~

(use-package switch-window
  :bind (("C-x o" . switch-window)
         ("C-x 1" . switch-window-then-maximize)
         ("C-x 2" . switch-window-then-split-below)
         ("C-x 3" . switch-window-then-split-right)
         ("C-x 0" . switch-window-then-delete)
         ("C-x 4 d" . switch-window-then-dired))

  :config
  (setq switch-window-shortcut-style 'qwerty))

;; ;;; Avy helps quickly navigate you through the buffers

(use-package avy
  :bind (("C-;" . avy-goto-char-timer)
         ("C-'" . avy-goto-line))
  :config
  (setq avy-timeout-seconds 0.3))


;; (use-package enh-ruby-mode
;;   :hook ruby-mode
;;   :mode (("Gemfile\\'" . ruby-mode)
;;          ("Thorfile\\'" . ruby-mode)
;;          ("Guardfile\\'" . ruby-mode)
;;          ("Rakefile\\'" . ruby-mode)
;;          ("\\.rake\\'" . ruby-mode)
;;          ("\\.ru\\'" . ruby-mode)
;;          ("\\.gemspec\\'" . ruby-mode)
;;          ("\\.builder\\'" . ruby-mode)
;;          ("\\.god\\'" . ruby-mode)))

(use-package rspec-mode)
(use-package robe
  :config
  (push 'company-robe company-backends))
(use-package yari
  :config
  (defalias 'ri 'yari))
(use-package bundler)
(use-package yard-mode)
(use-package rvm)

(use-package go-mode)
(use-package go-guru)
(use-package company-go)
(use-package golint)

(use-package terraform-mode
  :hook (terraform-mode . terraform-format-on-save-mode))

(use-package company-terraform
  :hook (terraform-mode . company-terraform-init))

(use-package diff-hl
  :hook ((prog-mode org-mode) . diff-hl-mode))

(use-package diff-hl-dired :disabled t
  :ensure diff-hl
  :hook (dired-mode . diff-hl-dired-mode))


(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package dired-subtree
  :after dired
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)
              ("i" . dired-subtree-insert)
              (";" . dired-subtree-remove)))

;; Rename files editing their names in dired buffers


(use-package projectile :demand t
  :bind-keymap ("C-c p" . projectile-command-map)

  :config
  (setq projectile-mode-line-prefix " P"
        projectile-completion-system 'ivy)
  (projectile-mode 1))

(use-package ibuffer-projectile)

(use-package ivy :diminish :demand t
  :bind (("C-c C-r" . ivy-resume)
         :map ivy-minibuffer-map
         ("C-'" . ivy-avy))
  :config
  (setq-default ivy-use-virtual-buffers t ;; add ‘recentf-mode’ and bookmarks to ‘ivy-switch-buffer’
                ivy-height 25 ;; number of result lines to display
                ivy-initial-inputs-alist nil ;; don't add ^ by default
                projectile-completion-system 'ivy ;; use ivy for projectile
                smex-completion-method 'ivy ;;  use ivy for smex
                )

  (ivy-mode 1))

(use-package counsel
  :diminish
  :bind (("M-x" . counsel-M-x)
         ("C-x C-r" . counsel-resume)
         ("C-h v" . counsel-describe-variable)
         ("C-h f" . counsel-describe-function)
         ("C-x C-f" . counsel-find-file)
         ("C-c j" . counsel-file-jump)
         :map  minibuffer-local-map
         ("C-r" . counsel-minibuffer-history)))

(use-package counsel-projectile :demand t
  :after projectile
  :config
  (counsel-projectile-mode 1))

(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-completing-read-function 'ivy-completing-read
        magit-display-buffer-function 'magit-display-buffer-fullframe-status-topleft-v1))

(use-package magit-todos :disabled t
  :hook (magit-status-mode . magit-todos-mode))


(use-package tramp)
(use-package counsel-tramp
  :commands counsel-tramp)


(use-package swiper
  :bind (("C-s" . swiper)))

;; ;; A front-end for ag ('the silver searcher'), the C ack replacement.
(use-package ag)

(use-package move-dup
  :bind (("M-<up>" . md-move-lines-up)
         ("M-<down>" . md-move-lines-down)
         ("M-S-<up>" . md-duplicate-up)
         ("M-S-<down>" . md-duplicate-down)))

(use-package rust-mode)
(use-package racer)

(use-package which-key :defer 1 :diminish which-key-mode
  :config
  (setq-default which-key-popup-type 'side-window
                which-key-idle-delay 0.3
                which-key-sort-order 'which-key-prefix-then-key-order)

  (which-key-mode 1))


(use-package polymode)


;; ;; Polymode for Ansible: Jinja2 + Yaml
;; (use-package poly-ansible
;;   :mode ("\\.yml\\'" . poly-ansible-mode))



;; ;; Ruby ERB
;; ;; TODO: configure it
;; (use-package poly-erb
;;   :mode (("\\.coffee\\.erb\\'" . poly-coffee+erb-mode)
;;          ("\\.js\\.erb\\'" . poly-js+erb-mode))
;;          ("\\.html\\.erb\\'" . poly-html+erb-mode))



(use-package toml-mode)
(use-package yaml-mode)


(use-package aggressive-indent :demand t
  :config
  (global-aggressive-indent-mode 1))

(use-package systemd)
(use-package daemons)
(use-package json-mode)

(use-package markdown-mode)

(use-package ansible)
(use-package ansible-doc)
(use-package ansible-vault)
(use-package company-ansible)

(use-package polymode)
(use-package poly-ansible)
(use-package poly-markdown)

(use-package docker
  :bind ("C-c d" . docker)
  :custom (docker-image-run-arguments '("-i" "-t" "--rm")))

(use-package dockerfile-mode)
(use-package docker-compose-mode)
(use-package apache-mode)
(use-package nginx-mode)

;; TODO: performance
(use-package company-box :diminish
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-max-candidates 50)
  (company-box-doc-delay 0.3))

(use-package company-shell
  :after company
  :commands company-shell
  :config (add-to-list 'company-backends 'company-shell))

;; Some day I will enable this
;; (use-package tree-sitter :demand t
;;   :hook
;;   (tree-sitter-after-on . tree-sitter-hl-mode)
;;   :config
;;   (global-tree-sitter-mode 1))

;; (use-package tree-sitter-langs :after tree-sitter)

(use-package discover-my-major
  :bind ("C-h C-m" . discover-my-major))

(use-package dumb-jump
  :bind
  ;; (:map prog-mode-map
  ;;       (("C-c C-o" . dumb-jump-go-other-window)
  ;;        ("C-c C-j" . dumb-jump-go)
  ;;        ("C-c C-i" . dumb-jump-go-prompt)))
  :custom
  (dumb-jump-selector 'ivy))

(use-package format-all :disabled t)

(use-package request :defer t :disabled t)
(use-package lsp-mode :disabled t)
(use-package lsp-ui :disabled t)
(use-package dap-mode :disabled t)
(use-package lsp-java :disabled t
  :after lsp-mode
  :custom
  (lsp-java-server-install-dir (expand-file-name "~/.emacs.d/eclipse.jdt.ls/server/"))
  (lsp-java-workspace-dir (expand-file-name "~/.emacs.d/eclipse.jdt.ls/workspace/")))

(use-package python-mode
  :config
  (setq-default python-shell-interpreter "python3"))

(use-package pip-requirements)
(use-package anaconda-mode)
(use-package company-anaconda)
(use-package lsp-pyre :disabled t)

(use-package web-mode :disabled t)
(use-package emmet-mode :disabled t)
(use-package js2-mode :disabled t)
(use-package csv-mode :disabled t)

(use-package yasnippet :diminish :disabled t
  :hook (prog-mode . snippet-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snipptets :disabled t
  :after yasnippet
  :config
  (add-to-list company-backends 'company-yasnippet))

;; (use-package slim)
;; (use-package hippie-expand-slime)
;; (use-package slime-company)
;; (use-package elisp-slime-nav)

(use-package page-break-lines :diminish
  :hook (emacs-lisp-mode . page-break-lines-mode))

(use-package ipretty)
(use-package auto-compile :disabled t)

(use-package flyspell-correct-ivy
  :init
  (setq flyspell-correct-interface #'flyspell-correct-ivy))

(use-package google-translate
  :init
  (setq google-translate-default-source-language "en"
        google-translate-default-target-language "ru"))

;; Set global hotkeys

(global-set-key [f6] 'recompile)

(provide 'init)
;;; init.el ends here

