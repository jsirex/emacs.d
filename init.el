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

;; I know about use-package but I prefer to control stuff by myself
;; Also it helps me a bit better understand emacs

;;; Code:
(require 'package)

(eval-and-compile
  ;; like add-to-list it is quite improper to setq a custom variable
  ;; setters must be used for custom variables, but nobody cares
  (cl-pushnew '("stable" . "https://stable.melpa.org/packages/") package-archives :test #'equal)
  (cl-pushnew '("melpa"  . "https://melpa.org/packages/")        package-archives :test #'equal)

  (setopt package-native-compile t
	  package-quickstart t
	  package-archive-priorities '(("gnu"    . 90)
				       ("nongnu" . 80)
				       ("stable" . 70)
				       ("melpa"  . 0 )))

  ;; TODO: Add the following packages to list
  ;; ?? corfu-prescient
  ;; ace-mc based on ace-jump-mode, but avy seems better...
  ;; auth-source-kwallet
  ;; enh-ruby-mode -
  ;; flymake-clippy maybe, requires extra steps
  ;; format-all - looks good for formatting everything on save
  ;; mc-extras - maybe
  ;; prescient - better sorting?
  ;; python-mode / anaconda-mode? - vs ts?
  ;; ?? enh-ruby-mode
  ;; consult-eglot-embark
  ;; gptel
  ;; maybe avy-embark-collect
  ;; phi-search learn about +mc
  (setopt package-selected-packages
          '(
            ag
            ansible
            ansible-doc
            ansible-vault
            audacious
            avy
            avy-zap
            cape
            cargo-transient
            color-theme-sanityinc-tomorrow
            consult
            consult-ag
            consult-eglot
            consult-project-extra
            corfu
            csv-mode
            diff-hl
            difftastic
            diminish
            diredfl
            docker-compose-mode
            dockerfile-mode
            editorconfig
            embark
            embark-consult
            expand-region
            fira-code-mode
            flymake-ruby
            flymake-shellcheck
            flymake-yamllint
            forge
            geiser
            geiser-guile
            gerrit
            git-modes
            git-timemachine
            gitlab-ci-mode
            guix
            magit
            magit-todos
            marginalia
            markdown-mode
            mmm-mode
            move-dup
            multiple-cursors
            nerd-icons
            nerd-icons-completion
            nerd-icons-corfu
            nerd-icons-dired
            nginx-mode
            orderless
            page-break-lines
            rainbow-delimiters
            rust-mode
            symbol-overlay
            systemd
            vertico
            wgrep
            wgrep-ag
            which-key
            yaml-mode
            yard-mode
            yasnippet
            yasnippet-capf
            yasnippet-snippets
            zoom
            ))

  (package-initialize :noactivate)

  (when (seq-remove #'package-installed-p package-selected-packages)
    (package-refresh-contents)
    (package-install-selected-packages :noconfirm))

  (package-activate-all))





;; (pack-install 'foo)
;; (weal 'foo (code))

;; (u-p 'foo :config (code))

;; Customize each package only after it has been loaded
;; weal pkg1 -> code
;; concerns: big after-load-alist of code. However long lists are ok (for example package-archive-contents)

;; explicit call for some packages with (require pk1)
;; no concerns

;; Global Keymaps
;; bind every key
;; if bind to unknown function - then it hasn't loaded and hasn't autoloaded. so bug


;; Another strategy
;; require all / how?
;; plain big setopt
;; plain big remap
;; plain big keymap
;; plain call to functions

;; idea: (eval-when-compile install-all-pkgs-here). no code on run


;; no compile, use package:
;; require package
;; tune package opts
;; require use-package
;; tune use-package opts

;; use-package emacs embedded into emacs settings
;; use-package built-in-pkg :demand t
;; use-package statements with init/config/binds, etc..


;; core defined variables
(setopt auto-save-list-file-name nil
	history-length 500
	indent-tabs-mode nil
	inhibit-compacting-font-caches t
	inhibit-startup-message t
	initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n")
	process-adaptive-read-buffering nil
	read-process-output-max (* 1 1024 1024)
	scroll-conservatively 101
	sentence-end-double-space nil
	tab-always-indent 'complete
	tab-width 4
	use-short-answers t)


(with-eval-after-load 'dired
  (setopt dired-dwim-target t))

(when (require 'custom)
  (setopt custom-file (locate-user-emacs-file "ignored-custom.el")))

(when (require 'project)
  ())

(when (require 'wdired)
  (setopt wdired-allow-to-change-permissions t))

(when (require 'hippie-exp)
  (keymap-global-set "M-/" #'hippie-expand))

(when (require 'files)
  (setopt auto-save-default nil)
  (setopt auto-save-list-file-prefix nil)
  (setopt require-final-newline t))


;; Demand installed packages

(when (require 'color-theme-sanityinc-tomorrow)
  (load-theme 'sanityinc-tomorrow-eighties t))

(require 'vertico)
(setopt vertico-mode t)
(setopt vertico-count 20)

(require 'vertico-quick)
(keymap-set vertico-map "M-q" #'vertico-quick-exit)

(when (require 'marginalia)
  (setopt marginalia-mode t))

(require 'corfu)
(progn
  (setopt global-corfu-mode t)
  (setopt corfu-count 20)
  (setopt corfu-max-width 200)
  (setopt corfu-min-width 50)
  (setopt corfu-preselect 'prompt))

(when (require 'corfu-popupinfo)
  (setopt corfu-popupinfo-mode t)
  (setopt corfu-popupinfo-delay '(0.5 . 0.1)))

(when (require 'corfu-quick)
  (keymap-set corfu-map "M-q" #'corfu-quick-complete))


;; Defer section
(with-eval-after-load 'eglot
  (setopt eglot-autoshutdown t))

;; set theme erlier
(with-eval-after-load 'magit
  (transient-append-suffix 'magit-push "-n"
    '("-gm" "GitLab Create Merge Request" "--push-option=merge_request.create")))


;; completion
;; (setopt completion-cycle-threshold 5)
(setopt completion-styles '(basic partial-completion orderless))
;; TODO: completion-overrides by type

;; cycling? probably
;; (keymap-set vertico-map "TAB" #'minibuffer-complete)
;; avy style to select candidate




;; (require 'dired)
;; (require 'multiple-cursors)
;; (require 'projectile)



;; ;; Settings
;; (customize-set-variable 'avy-timeout-seconds 0.3)
;; (customize-set-variable 'column-number-mode t)
;; (customize-set-variable 'company-box-max-candidates 20)
;; (customize-set-variable 'company-dabbrev-ignore-case t)
;; (customize-set-variable 'company-dabbrev-downcase nil)
;; (customize-set-variable 'company-dabbrev-other-buffers t)
;; (customize-set-variable 'company-echo-delay 0)
;; (customize-set-variable 'company-idle-delay 0.1)
;; (customize-set-variable 'company-tooltip-limit 20)
;; (customize-set-variable 'company-minimum-prefix-length 2)
;; (customize-set-variable 'company-show-quick-access t)
;; (customize-set-variable 'compilation-ask-about-save nil)
;; (customize-set-variable 'compilation-scroll-output 'first-error)
;; (customize-set-variable 'consult-project-function #'project-root)
;; (customize-set-variable 'create-lockfiles nil)
;; (customize-set-variable 'custom-safe-themes t)
;; (customize-set-variable 'delete-selection-mode t)
;; (customize-set-variable 'desktop-auto-save-timeout 600 "Save desktop after 10 minutes")
;; (customize-set-variable 'desktop-save-mode t)
;; (customize-set-variable 'dired-auto-revert-buffer t)
;; (customize-set-variable 'dired-recursive-copies 'always)
;; (customize-set-variable 'dired-recursive-deletes 'top)
;; (customize-set-variable 'disabled-command-function nil "Enable all commands")
;; (customize-set-variable 'docker-image-run-arguments '("-i" "-t" "--rm"))
;; (customize-set-variable 'editorconfig-mode t)
;; (customize-set-variable 'global-auto-revert-mode t)
;; (customize-set-variable 'global-company-mode t)
;; (customize-set-variable 'global-move-dup-mode t)
;; (customize-set-variable 'global-so-long-mode t)
;; ;; (customize-set-variable 'global-undo-tree-mode t) - slows down. TODO: fix
;; (customize-set-variable 'global-whitespace-mode t)
;; (customize-set-variable 'inhibit-startup-message t)

;; (customize-set-variable 'line-number-mode t)
;; (customize-set-variable 'make-backup-files nil)
;; (customize-set-variable 'marginalia-annotators '(marginalia-annotators-heavy))
;; (customize-set-variable 'marginalia-mode t)
;; (customize-set-variable 'projectile-mode t)
;; (customize-set-variable 'projectile-mode-line-prefix " P")
;; (customize-set-variable 'python-shell-interpreter "python3")
;; (customize-set-variable 'recentf-exclude '("/tmp/" "/ssh:"))
;; (customize-set-variable 'recentf-max-saved-items 50)
;; (customize-set-variable 'require-final-newline t)
;; (customize-set-variable 'save-place-mode t)
;; (customize-set-variable 'savehist-additional-variables '(search-ring regexp-search-ring))
;; (customize-set-variable 'savehist-autosave-interval nil)
;; (customize-set-variable 'savehist-mode 1)
;; (customize-set-variable 'show-paren-mode t)
;; (customize-set-variable 'split-height-threshold 100)
;; (customize-set-variable 'split-width-threshold 200)
;; (customize-set-variable 'switch-window-shortcut-style 'qwerty)
;; (customize-set-variable 'wgrep-auto-save-buffer t)
;; (customize-set-variable 'which-key-idle-delay 0.3)
;; (customize-set-variable 'which-key-mode t)
;; (customize-set-variable 'which-key-popup-type 'side-window)
;; (customize-set-variable 'which-key-sort-order 'which-key-prefix-then-key-order)
;; (customize-set-variable 'whitespace-action '(auto-cleanup warn-read-only))
;; (customize-set-variable 'whitespace-style '(face trailing space-after-tab space-before-tab missing-newline-at-eof))
;; (customize-set-variable 'winner-mode t)
;; (customize-set-variable 'vertico-mode t)
;; (customize-set-variable 'zoom-ignored-major-modes '(dired-mode))
;; (customize-set-variable 'zoom-mode t)
;; (customize-set-variable 'zoom-size '(0.618 . 0.618) "Golden ration")

;; 

;; ;; Auto Completion Section

;; ;; (add-to-list 'company-backends 'company-ansible)
;; ;; (add-to-list 'company-backends 'company-terraform)
;; ;; (add-to-list 'company-backends '(company-shell company-shell-env company-dabbrev))
;; ;; (add-to-list 'company-backends 'company-racer)
;; (add-to-list 'company-backends 'company-dabbrev)
;; (add-to-list 'company-backends 'company-capf)

;; ;; (setenv "RUST_SRC_PATH" (expand-file-name "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"))

;; 
;; ;; hooks

(add-hook 'package-menu-mode-hook #'hl-line-mode)
;; (add-hook 'company-mode-hook #'company-box-mode)
;; (add-hook 'conf-mode-hook #'symbol-overlay-mode)
;; (add-hook 'dired-mode-hook #'diff-hl-dired-mode)
;; (add-hook 'dired-mode-hook #'diredfl-mode)
(add-hook 'emacs-lisp-mode-hook #'page-break-lines-mode)
;; (add-hook 'html-mode-hook #'symbol-overlay-mode)
;; (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)
;; (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
;; ;; (add-hook 'prog-mode-hook #'aggressive-indent-mode)
;; (add-hook 'prog-mode-hook #'diff-hl-mode)
;; (add-hook 'prog-mode-hook #'electric-pair-mode)
(add-hook 'prog-mode-hook #'fira-code-mode)
;; (add-hook 'prog-mode-hook #'hl-line-mode)
;; (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; (add-hook 'prog-mode-hook #'subword-mode)
;; (add-hook 'prog-mode-hook #'symbol-overlay-mode)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)
;; (add-hook 'ruby-mode-hook #'enh-ruby-mode)
;; (add-hook 'scheme-mode-hook #'page-break-lines-mode)
;; (add-hook 'terraform-mode-hook #'company-terraform-init)
;; (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)
;; (add-hook 'terraform-mode-hook #'lsp-deferred)
;; (add-hook 'text-mode-hook #'hl-line-mode)
;; (add-hook 'yaml-mode-hook #'symbol-overlay-mode)



;; ;; Key bindings

;; replace with keymap-global-set / keymap-set
;; (global-set-key [remap switch-to-buffer] #'consult-buffer)
;; (global-set-key [remap switch-to-buffer-other-window] #'consult-buffer-other-window)
;; (global-set-key [remap yank-pop] #'consult-yank-pop)
;; (global-set-key [remap goto-line] #'consult-goto-line)
;; (global-set-key [remap switch-to-buffer-other-frame] #'consult-buffer-other-frame)
;; (define-key company-active-map (kbd "M-/") #'company-other-backend)
;; (define-key company-active-map (kbd "C-n") #'company-select-next)
;; (define-key company-active-map (kbd "C-p") #'company-select-previous)
;; (define-key dired-mode-map (kbd "<tab>") #'dired-subtree-toggle)
;; (define-key dired-mode-map (kbd "i") #'dired-subtree-insert)
;; (define-key dired-mode-map (kbd ";") #'dired-subtree-remove)
;; (define-key mc/keymap (kbd "C-s") #'phi-search)
;; (define-key mc/keymap (kbd "C-r") #'phi-search-backward)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; (global-set-key (kbd "<f6>") 'recompile)
;; (global-set-key (kbd "C-'") #'avy-goto-line)
;; (global-set-key (kbd "C-)") #'ace-mc-add-multiple-cursors)
;; (global-set-key (kbd "C-;") #'avy-goto-char-timer)
;; (global-set-key (kbd "C-<") #'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-=") #'er/expand-region)
;; (global-set-key (kbd "C->") #'mc/mark-next-like-this)
;; (global-set-key (kbd "C-S-a") #'embark-act)
;; (global-set-key (kbd "C-c C-'") #'mc-hide-unmatched-lines-mode)
;; (global-set-key (kbd "C-c C-o") #'embark-export)
;; (global-set-key (kbd "C-c d") #'docker)
;; (global-set-key (kbd "C-c m m") #'mc/mark-all-dwim)
;; (global-set-key (kbd "C-c m s") #'mc/skip-to-next-like-this)
;; (global-set-key (kbd "C-s") #'consult-line)
;; ;; (global-set-key (kbd "C-x 0") #'switch-window-then-delete)
;; ;; (global-set-key (kbd "C-x 1") #'switch-window-then-maximize)
;; ;; (global-set-key (kbd "C-x 2") #'switch-window-then-split-below)
;; ;; (global-set-key (kbd "C-x 3") #'switch-window-then-split-right)
;; ;; (global-set-key (kbd "C-x 4 d") #'switch-window-then-dired)
;; (global-set-key (kbd "C-x C-b") #'ibuffer)
;; (global-set-key (kbd "C-x o") #'switch-window)
;; (global-set-key (kbd "M-Z") #'avy-zap-up-to-char-dwim)
;; (global-set-key (kbd "M-i") #'symbol-overlay-put)
;; (global-set-key (kbd "M-n") #'symbol-overlay-jump-next)
;; (global-set-key (kbd "M-p") #'symbol-overlay-jump-prev)
;; (global-set-key (kbd "M-z") #'avy-zap-up-to-char-dwim)



;; 
;; (with-eval-after-load 'company-box (diminish 'company-box-mode))
;; (with-eval-after-load 'editorconfig (diminish 'editorconfig-mode))
;; (with-eval-after-load 'fira-code-mode (diminish 'fira-code-mode))
;; (with-eval-after-load 'move-dup (diminish 'move-dup-mode))
;; (with-eval-after-load 'page-break-lines (diminish 'page-break-lines-mode))
;; (with-eval-after-load 'subword (diminish 'subword-mode))
;; (with-eval-after-load 'symbol-overlay (diminish 'symbol-overlay-mode))
;; (with-eval-after-load 'which-key (diminish 'which-key-mode))
;; (with-eval-after-load 'whitespace (diminish 'whitespace-mode))
;; (with-eval-after-load 'zoom (diminish 'zoom-mode))

;; 

(windmove-default-keybindings 'control)
(windmove-swap-states-default-keybindings '(shift control))

(provide 'init)
;; ;;; init.el ends here
