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
  (cl-pushnew '("stable" . "https://stable.melpa.org/packages/") package-archives :test #'equal)
  (cl-pushnew '("melpa"  . "https://melpa.org/packages/")        package-archives :test #'equal)

  (setopt package-native-compile t
          package-quickstart t
          package-archive-priorities '(("gnu"    . 90)
                                       ("nongnu" . 80)
                                       ("stable" . 70)
                                       ("melpa"  . 0 )))

  (setopt use-package-expand-minimally t
          use-package-always-defer t
          use-package-always-ensure t
          use-package-use-theme nil))

(setopt my-package-selected-packages
        '(
          ;; Finished A,B,C
          ;; ansible maybe fork it? some stange bugs and give almost nothing except font-locking
          ansible-doc
          ansible-vault               ; looks independent and just works with buffer
          ;; apache-mode
          ;; auctex for latex/tex files
          ;; maybe avy-embark-collect
          ;; bats-mode
          ;; cape
          ;; cargo-transient
          ;; blow
          ;; csv-mode

          ;; difftastic
          diredfl
          dired-subtree
          ;; docker-compose-mode
          dockerfile-mode
          expand-region
          fira-code-mode
          ;; flymake-clippy maybe, requires extra steps
          ;; flymake-ruby    ; maybe just use info from eglot
          flymake-shellcheck
          ;; flymake-yamllint
          ;; forge
          ;; format-all maybe later - looks good for formatting everything on save
          ;; geiser
          ;; geiser-guile
          ;; gerrit
          git-modes
          git-timemachine
          gitlab-ci-mode
          gptel                       ; Interfaces to LLM
          ;; go-mode
          ;; guix
          ;; json-mode
          markdown-mode
          multiple-cursors
          ;; nerd-icons
          ;; nerd-icons-completion
          ;; nerd-icons-corfu
          ;; nerd-icons-dired
          ;; nerd-icons-ibuffer
          nginx-mode
          orderless
          ;; python-mode
          ;; page-break-lines
          ;; poly-ansible
          ;; poly-ansible
          ;; poly-markdown
          ;; poly-ruby
          ;; polymode
          ;; rainbow-delimiters
          ;; realgud - debugger frontend.. idk
          ;; rust-mode
          ;; terraform-mode
          toml-mode
          systemd

          ;; yaml-mode
          ;; yard-mode
          ;; zerodark-theme -> all-the-icons -> maybe?
          ))

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

(use-package delsel :ensure nil
  :init
  (setopt delete-selection-mode t))

(use-package dired :ensure nil
  :init
  (setopt dired-auto-revert-buffer t
          dired-dwim-target t
          dired-recursive-copies 'always
          dired-recursive-deletes 'top))

(use-package compile :ensure nil
  :init
  (setopt compilation-ask-about-save nil
          compilation-always-kill t
          compilation-scroll-output 'first-error))

(use-package cus-edit :ensure nil
  :init
  (setopt custom-file (locate-user-emacs-file "ignored-custom.el")))

(use-package editorconfig :ensure nil
  :init
  (setopt editorconfig-mode t
          editorconfig-mode-lighter ""))

(use-package eglot
  :init
  (setopt eglot-autoshutdown t)
  (add-hook 'prog-mode-hook #'eglot-ensure))

(use-package files :ensure nil
  :init
  (setopt auto-save-default nil
          make-backup-files nil
          major-mode-remap-alist nil
          require-final-newline t)
  (cl-pushnew '(sh-mode . bash-ts-mode) major-mode-remap-alist :test #'equal))

(use-package hippie-exp :ensure nil
  :init
  (keymap-global-set "M-/" #'hippie-expand))

(use-package indent :ensure nil
  :init
  (setopt tab-always-indent 'complete))

(use-package minibuffer :ensure nil
  :init
  (setopt completion-cycle-threshold nil
          completion-styles '(basic partial-completion orderless)
          completion-category-overrides '((file (styles basic partial-completion)))))

(use-package paragraphs :ensure nil
  :init
  (setopt sentence-end-double-space nil))

(use-package paren :ensure nil
  :init
  (setopt show-paren-mode t))

(use-package subword :ensure nil :diminish
  :init
  (add-hook 'prog-mode-hook #'subword-mode))

(use-package recentf :ensure nil
  :init
  (setopt recentf-mode t
          recentf-max-saved-items 100
          recentf-exclude '("/tmp/" "/ssh:")))

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
  (setopt split-width-threshold 200
          split-height-threshold 100))

(use-package winner :ensure nil
  :init
  (setopt winner-mode t))


;;; -- External Packages

(use-package avy
  :init
  (setopt avy-timeout-seconds 0.3)
  (keymap-global-set "C-'" #'avy-goto-line)
  (keymap-global-set "C-;" #'avy-goto-char-timer))

(use-package avy-zap
  :init
  (keymap-global-set "M-z" #'avy-zap-up-to-char-dwim))

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

(use-package consult-ag)
(use-package consult-project-extra)

(use-package corfu
  :init
  (setopt global-corfu-mode t
          corfu-count 20
          corfu-max-width 200
          corfu-min-width 50
          corfu-popupinfo-delay '(0.5 . 0.1)
          corfu-popupinfo-mode t
          corfu-preselect 'prompt)
  :config
  (keymap-set corfu-map "M-q" #'corfu-quick-complete))

(use-package diff-hl
  :init ;; TODO: not sure this is really good aproach - mulitple deps here
  (add-hook 'dired-mode-hook #'diff-hl-dired-mode)
  (add-hook 'prog-mode-hook #'diff-hl-mode))

(use-package embark
  :init
  (keymap-global-set "C-." #'embark-act)
  (keymap-global-set "C-c C-o" #'embark-export))

(use-package embark-consult)

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
  (setopt marginalia-mode t
          marginalia-annotators '(marginalia-annotators-heavy)))

(use-package move-dup :diminish
  :init
  (setopt global-move-dup-mode t))

(use-package orderless)

(use-package symbol-overlay :diminish
  :init
  (setopt symbol-overlay-mode t)

  (add-hook 'prog-mode-hook #'symbol-overlay-mode)

  (keymap-global-set "M-i" #'symbol-overlay-put)
  (keymap-global-set "M-n" #'symbol-overlay-jump-next)
  (keymap-global-set "M-p" #'symbol-overlay-jump-prev))

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



;;(setopt
;;
;; save-place-mode t
;; savehist-additional-variables '(search-ring regexp-search-ring)
;; savehist-autosave-interval nil
;; savehist-mode t
;;)

;; TODO: read https://justinbarclay.ca/posts/from-zero-to-ide-with-emacs-and-lsp/

;; ;; ;; Settings
;; ;; (customize-set-variable 'desktop-auto-save-timeout 600 "Save desktop after 10 minutes")
;; ;; (customize-set-variable 'desktop-save-mode t)
;; ;; (customize-set-variable 'docker-image-run-arguments '("-i" "-t" "--rm"))
;; ;; (customize-set-variable 'save-place-mode t)
;; ;; (customize-set-variable 'savehist-additional-variables '(search-ring regexp-search-ring))
;; ;; (customize-set-variable 'savehist-autosave-interval nil)
;; ;; (customize-set-variable 'savehist-mode 1)


;; hooks

;; (add-hook 'package-menu-mode-hook #'hl-line-mode)
;; ;; (add-hook 'company-mode-hook #'company-box-mode)

;; ;; (add-hook 'dired-mode-hook #'diredfl-mode)
;; (add-hook 'emacs-lisp-mode-hook #'page-break-lines-mode)
;; ;; ;; (add-hook 'prog-mode-hook #'aggressive-indent-mode)

;; ;; (add-hook 'prog-mode-hook #'electric-pair-mode)
;; (add-hook 'prog-mode-hook #'fira-code-mode)
;; ;; (add-hook 'prog-mode-hook #'hl-line-mode)
;; ;; (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; ;; (add-hook 'prog-mode-hook #'yas-minor-mode)
;; ;; (add-hook 'ruby-mode-hook #'enh-ruby-mode)
;; ;; (add-hook 'scheme-mode-hook #'page-break-lines-mode)
;; ;; (add-hook 'terraform-mode-hook #'company-terraform-init)
;; ;; (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)
;; ;; (add-hook 'terraform-mode-hook #'lsp-deferred)
;; ;; (add-hook 'text-mode-hook #'hl-line-mode)

;; 

;; Key bindings


;; ;; replace with keymap-global-set / keymap-set

;; (keymap-global-set "<remap> <switch-to-buffer>" #'consult-buffer)
;; (keymap-global-set "<remap> <switch-to-buffer-other-window>" #'consult-buffer-other-window)
;; ;; (global-set-key [remap switch-to-buffer] #'consult-buffer)
;; ;; (global-set-key [remap switch-to-buffer-other-window] #'consult-buffer-other-window)
;; ;; (global-set-key [remap yank-pop] #'consult-yank-pop)
;; ;; (global-set-key [remap goto-line] #'consult-goto-line)
;; ;; (global-set-key [remap switch-to-buffer-other-frame] #'consult-buffer-other-frame)
;; ;; (define-key company-active-map (kbd "M-/") #'company-other-backend)
;; ;; (define-key company-active-map (kbd "C-n") #'company-select-next)
;; ;; (define-key company-active-map (kbd "C-p") #'company-select-previous)
;; ;; (define-key dired-mode-map (kbd "<tab>") #'dired-subtree-toggle)
;; ;; (define-key dired-mode-map (kbd "i") #'dired-subtree-insert)
;; ;; (define-key dired-mode-map (kbd ";") #'dired-subtree-remove)
;; ;; (define-key mc/keymap (kbd "C-s") #'phi-search)
;; ;; (define-key mc/keymap (kbd "C-r") #'phi-search-backward)
;; ;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; ;; (global-set-key (kbd "<f6>") 'recompile)
;; ;; (global-set-key (kbd "C-)") #'ace-mc-add-multiple-cursors)
;; ;; (global-set-key (kbd "C-<") #'mc/mark-previous-like-this)
;; ;; (global-set-key (kbd "C-=") #'er/expand-region)
;; ;; (global-set-key (kbd "C->") #'mc/mark-next-like-this)
;; ;; (global-set-key (kbd "C-S-a") #'embark-act)

;; ;; (global-set-key (kbd "C-c C-'") #'mc-hide-unmatched-lines-mode)

;; ;; (global-set-key (kbd "C-c d") #'docker)
;; ;; (global-set-key (kbd "C-c m m") #'mc/mark-all-dwim)
;; ;; (global-set-key (kbd "C-c m s") #'mc/skip-to-next-like-this)
;; ;; (global-set-key (kbd "C-s") #'consult-line)
;; ;; ;; (global-set-key (kbd "C-x 0") #'switch-window-then-delete)
;; ;; ;; (global-set-key (kbd "C-x 1") #'switch-window-then-maximize)
;; ;; ;; (global-set-key (kbd "C-x 2") #'switch-window-then-split-below)
;; ;; ;; (global-set-key (kbd "C-x 3") #'switch-window-then-split-right)
;; ;; ;; (global-set-key (kbd "C-x 4 d") #'switch-window-then-dired)
;; ;; (global-set-key (kbd "C-x C-b") #'ibuffer)
;; ;; (global-set-key (kbd "C-x o") #'switch-window)



;; Patches

;; (with-eval-after-load 'fira-code-mode (diminish 'fira-code-mode))
;; (with-eval-after-load 'move-dup (diminish 'move-dup-mode))
;; (with-eval-after-load 'symbol-overlay (diminish 'symbol-overlay-mode))
;; ;; (with-eval-after-load 'which-key (diminish 'which-key-mode))
;; (with-eval-after-load 'whitespace (diminish 'whitespace-mode))
;; (with-eval-after-load 'zoom (diminish 'zoom-mode))


(provide 'init)
;; ;;; init.el ends here
