;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Alec Cox"
      user-mail-address "avlecxk@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-directory "~/org/"
      org-agenda-files "~/org/agenda.org"
      org-default-notes-file (expand-file-name "notes.org" org-directory)
      org-log-done 'time
      org-journal-dir "~/org/journal/"
      org-todo-keywords '((sequence
         "TODO(t)"
         "IN PROGRESS(p)"
         "WAIT (w)"
         "|"            ;; active above this, inactive below this
         "DONE(d)"
         "CANCELLED(c)")))

(require 'org-tempo)

(use-package org-bullets)
(add-hook 'org-mode-hook (lambda() (org-bullets-mode 1)))

(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-edit-src-content-indentation 0)

(defun enter-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen 'fullboth) ;this makes the frame go fullscreen
  (tool-bar-mode -1) ;these 3 lines turn off GUI junk
  (scroll-bar-mode -1)
  (menu-bar-mode -1))

(if (eq system-type 'darwin)
    (enter-fullscreen))

;; Tell cc to use the -isystem to find headers on MacOS

(if (eq system-type 'darwin)
  (add-hook 'c++-mode-hook (setq +cc-default-compiler-options "-isystem")))

(setq cxx_version "c++17")

(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard cxx_version)))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard   cxx_version)))

;; Keybindings to add in window switching with arrow keys.

(map! :leader
      :desc "Move to left window."
      "w <left>"
      #'evil-window-left)
(map! :leader
      :desc "Move to right window."
      "w <right>"
      #'evil-window-right)
(map! :leader
      :desc "Move to up window."
      "w <up>"
      #'evil-window-up)
(map! :leader
      :desc "Move to down window."
      "w <down>"
      #'evil-window-down)

;; Make gc pauses faster by decreasing threshold
(setq gc-cons-threshold (* 2 1000 1000))
