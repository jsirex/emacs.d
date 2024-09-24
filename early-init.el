;;; early-init.el -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Yauhen Artsiukhou

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

;;; Emacs (27+) introduces early-init.el, which is run before init.el.
;;; This file is loaded before the package system and GUI is initialized

;;; Code:

;; Garbage collection:
;; set threshold temporary to half available memory,
;; then set it back to 4 MB
(setopt gc-cons-threshold (* 512 (car (memory-info))))
(add-hook 'emacs-startup-hook
          (lambda () (setopt gc-cons-threshold (* 4 1024 1024)) (garbage-collect)))


;; Tweak GUI before Initialization
(setopt scroll-bar-mode nil
        menu-bar-mode nil
        tool-bar-mode nil
        tooltip-mode nil
        frame-inhibit-implied-resize t)


(set-face-attribute 'default nil :family "Fira Code" :height 120 :weight 'normal :width 'normal)

(provide 'early-init)
;;; early-init.el ends here
