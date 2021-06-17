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

(customize-set-variable 'user-full-name "Yauhen Artsiukhou")
(customize-set-variable 'user-mail-address "jsirex@gmail.com")
(customize-set-variable 'custom-file "/dev/null" "Use programming approach to customize variables")

;; Prefer UTF-8
(set-language-environment "UTF-8")



(eval-and-compile
  (require 'package)

  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org"   . "https://orgmode.org/elpa/") t)

  (customize-set-variable 'package-quickstart t "Merge all autoloads into single file")
  (customize-set-variable 'package-selected-packages '( ace-mc
                                                        ag
                                                        aggressive-indent
                                                        ansible
                                                        ansible-doc
                                                        ansible-vault
                                                        apache-mode
                                                        avy
                                                        avy-zap
                                                        bundler
                                                        color-theme-sanityinc-tomorrow
                                                        company
                                                        company-ansible
                                                        company-box
                                                        company-go
                                                        company-nginx
                                                        company-prescient
                                                        company-racer
                                                        company-shell
                                                        company-terraform
                                                        consult
                                                        diff-hl
                                                        diminish
                                                        dired-subtree
                                                        diredfl
                                                        docker
                                                        docker-compose-mode
                                                        dockerfile-mode
                                                        editorconfig
                                                        embark
                                                        enh-ruby-mode
                                                        expand-region
                                                        fira-code-mode
                                                        flycheck
                                                        flycheck-elixir
                                                        flycheck-guile
                                                        flycheck-rust
                                                        geiser
                                                        geiser-guile
                                                        git-timemachine
                                                        gitattributes-mode
                                                        gitconfig-mode
                                                        gitignore-mode
                                                        gitlab-ci-mode
                                                        gitlab-ci-mode-flycheck
                                                        go-guru
                                                        go-mode
                                                        golint
                                                        json-mode
                                                        lsp-java
                                                        lsp-ui
                                                        magit
                                                        marginalia
                                                        markdown-mode
                                                        move-dup
                                                        multiple-cursors
                                                        nginx-mode
                                                        orderless
                                                        page-break-lines
                                                        phi-search
                                                        prescient
                                                        projectile
                                                        python-mode
                                                        racer
                                                        rainbow-delimiters
                                                        rust-mode
                                                        rvm
                                                        selectrum
                                                        selectrum-prescient
                                                        slime
                                                        slime-company
                                                        switch-window
                                                        symbol-overlay
                                                        systemd
                                                        terraform-mode
                                                        toml-mode
                                                        undo-tree
                                                        unkillable-scratch
                                                        wgrep
                                                        wgrep-ag
                                                        which-key
                                                        yaml-mode
                                                        yard-mode
                                                        yari
                                                        yasnippet
                                                        yasnippet-snippets
                                                        zoom ))

  ;; Initialize, but do not load package-quickstart.el
  (package-initialize t)

  (unless (cl-every #'package-installed-p package-selected-packages)
    (package-refresh-contents))

  (dolist (pkg package-selected-packages)
    (package-install pkg t))

  ;; Load package-quickstart.el
  (package-activate-all))

(eval-when-compile
  (dolist (pkg package-selected-packages)
	(require pkg)))

;; Temporary test explicit required of all packages
(dolist (pkg package-selected-packages)
  (require pkg))

;; These must be activated on runtime
(require 'dired)
(require 'multiple-cursors)
(require 'projectile)


;; Settings
(customize-set-variable 'auto-save-default nil)
(customize-set-variable 'auto-save-list-file-name nil)
(customize-set-variable 'auto-save-list-file-prefix nil)
(customize-set-variable 'avy-timeout-seconds 0.3)
(customize-set-variable 'column-number-mode t)
(customize-set-variable 'company-box-max-candidates 20)
(customize-set-variable 'company-dabbrev-ignore-case nil)
(customize-set-variable 'company-dabbrev-other-buffers t)
(customize-set-variable 'company-echo-delay 0)
(customize-set-variable 'company-idle-delay 0.1)
(customize-set-variable 'company-tooltip-limit 20)
(customize-set-variable 'compilation-ask-about-save nil)
(customize-set-variable 'compilation-scroll-output 'first-error)
(customize-set-variable 'completion-styles '(initials partial-completion orderless))
(customize-set-variable 'consult-project-root-function #'projectile-project-root)
(customize-set-variable 'create-lockfiles nil)
(customize-set-variable 'custom-safe-themes t)
(customize-set-variable 'delete-selection-mode t)
(customize-set-variable 'desktop-auto-save-timeout 600 "Save desktop after 10 minutes")
(customize-set-variable 'desktop-save-mode t)
(customize-set-variable 'dired-auto-revert-buffer t)
(customize-set-variable 'dired-dwim-target t)
(customize-set-variable 'dired-recursive-copies 'always)
(customize-set-variable 'dired-recursive-deletes 'top)
(customize-set-variable 'disabled-command-function nil "Enable all commands")
(customize-set-variable 'docker-image-run-arguments '("-i" "-t" "--rm"))
(customize-set-variable 'editorconfig-mode t)
(customize-set-variable 'global-auto-revert-mode t)
(customize-set-variable 'global-company-mode t)
(customize-set-variable 'global-move-dup-mode t)
(customize-set-variable 'global-so-long-mode t)
(customize-set-variable 'global-undo-tree-mode t)
(customize-set-variable 'global-whitespace-mode t)
(customize-set-variable 'inhibit-startup-message t)
(customize-set-variable 'initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n"))
(customize-set-variable 'line-number-mode t)
(customize-set-variable 'make-backup-files nil)
(customize-set-variable 'marginalia-annotators '(marginalia-annotators-heavy))
(customize-set-variable 'marginalia-mode t)
(customize-set-variable 'projectile-mode t)
(customize-set-variable 'projectile-mode-line-prefix " P")
(customize-set-variable 'python-shell-interpreter "python3")
(customize-set-variable 'recentf-exclude '("/tmp/" "/ssh:"))
(customize-set-variable 'recentf-max-saved-items 50)
(customize-set-variable 'require-final-newline t)
(customize-set-variable 'save-place-mode t)
(customize-set-variable 'savehist-additional-variables '(search-ring regexp-search-ring))
(customize-set-variable 'savehist-autosave-interval nil)
(customize-set-variable 'savehist-mode 1)
(customize-set-variable 'selectrum-mode t)
;; (customize-set-variable 'selectrum-prescient-mode t)
(customize-set-variable 'show-paren-mode t)
(customize-set-variable 'split-height-threshold 100)
(customize-set-variable 'split-width-threshold 200)
(customize-set-variable 'switch-window-shortcut-style 'qwerty)
(customize-set-variable 'undo-tree-visualizer-diff t)
(customize-set-variable 'undo-tree-visualizer-relative-timestamps t)
(customize-set-variable 'undo-tree-visualizer-timestamps t)
(customize-set-variable 'unkillable-scratch t)
(customize-set-variable 'wdired-allow-to-change-permissions t)
(customize-set-variable 'wgrep-auto-save-buffer t)
(customize-set-variable 'which-key-idle-delay 0.3)
(customize-set-variable 'which-key-mode t)
(customize-set-variable 'which-key-popup-type 'side-window)
(customize-set-variable 'which-key-sort-order 'which-key-prefix-then-key-order)
(customize-set-variable 'whitespace-action '(auto-cleanup warn-read-only))
(customize-set-variable 'whitespace-style '(face trailing space-after-tab space-before-tab missing-newline-at-eof))
(customize-set-variable 'winner-mode t)
(customize-set-variable 'zoom-ignored-major-modes '(dired-mode))
(customize-set-variable 'zoom-mode t)
(customize-set-variable 'zoom-size '(0.618 . 0.618) "Golden ration")



;; Auto Completion Section

;; (add-to-list 'company-backends 'company-ansible)
;; (add-to-list 'company-backends 'company-terraform)
;; (add-to-list 'company-backends '(company-shell company-shell-env company-dabbrev))
;; (add-to-list 'company-backends 'company-racer)

;; (setenv "RUST_SRC_PATH" (expand-file-name "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"))


;; hooks

(add-hook 'company-mode-hook #'company-box-mode)
(add-hook 'conf-mode-hook #'symbol-overlay-mode)
(add-hook 'dired-mode-hook #'diff-hl-dired-mode)
(add-hook 'dired-mode-hook #'diredfl-mode)
(add-hook 'emacs-lisp-mode-hook #'page-break-lines-mode)
(add-hook 'html-mode-hook #'symbol-overlay-mode)
(add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)
(add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
(add-hook 'prog-mode-hook #'aggressive-indent-mode)
(add-hook 'prog-mode-hook #'diff-hl-mode)
(add-hook 'prog-mode-hook #'electric-pair-mode)
(add-hook 'prog-mode-hook #'fira-code-mode)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'subword-mode)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'ruby-mode-hook #'enh-ruby-mode)
(add-hook 'scheme-mode-hook #'page-break-lines-mode)
(add-hook 'terraform-mode-hook #'company-terraform-init)
(add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)
(add-hook 'text-mode-hook #'hl-line-mode)
(add-hook 'yaml-mode-hook #'symbol-overlay-mode)



;; Key bindings

(global-set-key [remap switch-to-buffer] #'consult-buffer)
(global-set-key [remap switch-to-buffer-other-window] #'consult-buffer-other-window)
(global-set-key [remap yank-pop] #'consult-yank-pop)
(global-set-key [remap goto-line] #'consult-goto-line)

(define-key company-active-map (kbd "M-/") #'company-other-backend)
(define-key company-active-map (kbd "C-n") #'company-select-next)
(define-key company-active-map (kbd "C-p") #'company-select-previous)
(define-key dired-mode-map (kbd "<tab>") #'dired-subtree-toggle)
(define-key dired-mode-map (kbd "i") #'dired-subtree-insert)
(define-key dired-mode-map (kbd ";") #'dired-subtree-remove)
(define-key mc/keymap (kbd "C-s") #'phi-search)
(define-key mc/keymap (kbd "C-r") #'phi-search-backward)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(global-set-key (kbd "<f6>") 'recompile)
(global-set-key (kbd "C-'") #'avy-goto-line)
(global-set-key (kbd "C-)") #'ace-mc-add-multiple-cursors)
(global-set-key (kbd "C-;") #'avy-goto-char-timer)
(global-set-key (kbd "C-<") #'mc/mark-previous-like-this)
(global-set-key (kbd "C-=") #'er/expand-region)
(global-set-key (kbd "C->") #'mc/mark-next-like-this)
(global-set-key (kbd "C-S-a") #'embark-act)
(global-set-key (kbd "C-c C-'") #'mc-hide-unmatched-lines-mode)
(global-set-key (kbd "C-c C-o") #'embark-export)
(global-set-key (kbd "C-c d") #'docker)
(global-set-key (kbd "C-c m m") #'mc/mark-all-dwim)
(global-set-key (kbd "C-c m s") #'mc/skip-to-next-like-this)
(global-set-key (kbd "C-s") #'consult-line)
(global-set-key (kbd "C-x 0") #'switch-window-then-delete)
(global-set-key (kbd "C-x 1") #'switch-window-then-maximize)
(global-set-key (kbd "C-x 2") #'switch-window-then-split-below)
(global-set-key (kbd "C-x 3") #'switch-window-then-split-right)
(global-set-key (kbd "C-x 4 d") #'switch-window-then-dired)
(global-set-key (kbd "C-x C-b") #'ibuffer)
(global-set-key (kbd "C-x o") #'switch-window)
(global-set-key (kbd "M-Z") #'avy-zap-up-to-char-dwim)
(global-set-key (kbd "M-i") #'symbol-overlay-put)
(global-set-key (kbd "M-n") #'symbol-overlay-jump-next)
(global-set-key (kbd "M-p") #'symbol-overlay-jump-prev)
(global-set-key (kbd "M-z") #'avy-zap-up-to-char-dwim)
(global-set-key (kbd "M-/") #'company-complete)
(global-set-key (kbd "C-M-/") #'company-other-backend) ; Hack



(with-eval-after-load 'company-box (diminish 'company-box-mode))
(with-eval-after-load 'editorconfig (diminish 'editorconfig-mode))
(with-eval-after-load 'fira-code-mode (diminish 'fira-code-mode))
(with-eval-after-load 'move-dup (diminish 'move-dup-mode))
(with-eval-after-load 'page-break-lines (diminish 'page-break-lines-mode))
(with-eval-after-load 'subword (diminish 'subword-mode))
(with-eval-after-load 'symbol-overlay (diminish 'symbol-overlay-mode))
(with-eval-after-load 'which-key (diminish 'which-key-mode))
(with-eval-after-load 'whitespace (diminish 'whitespace-mode))
(with-eval-after-load 'zoom (diminish 'zoom-mode))



(windmove-default-keybindings 'control)
(windmove-swap-states-default-keybindings '(shift control))

(load-theme 'sanityinc-tomorrow-eighties)

(provide 'init)
;;; init.el ends here
