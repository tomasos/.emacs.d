
(setenv  "PATH" (concat

                ;; "c:/Windows/System32" ";" 

                 "c:/Windows/Microsoft.NET/Framework/v4.0.30319" ";"

                 "C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319" ";"

                 ;; Unix tools 
                 "C:\\Program Files\\Git\\usr\\bin" ";"

                 (getenv "PATH")

                 ))


;; Don't need buttons in emacs! By running this early we avoid a flash
;; of buttons before they are removed.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq use-dialog-box nil)

(add-to-list 'load-path user-emacs-directory)

;;(add-to-list 'exec-path "C:/Program Files (x86)/Git/bin/")

;; set meta to alt for regular keyboard
(setq mac-option-modifier 'meta
      mac-command-modifier nil
      x-select-enable-clipboard t)

;; set meta to cmd for mac keyboard
;; (setq mac-option-modifier nil
;;      mac-command-modifier 'meta
;;    x-select-enable-clipboard t)

;; use spaces
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq js-indent-level 2)
(setq-default js2-basic-offset 2)


;; show folder name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;Save temp files in temp folder
(setq backup-directory-alist
         `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
         `((".*" ,temporary-file-directory t)))
 
;; BORING: Ensure everything is UTF-8 all the time
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
 
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(if (string-equal system-type "windows-nt")
    (set-clipboard-coding-system 'utf-16le-dos)
  (set-clipboard-coding-system 'utf-8))

;; Add the fantastic marmalade package repository to your lists to access hundreds of packages
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))

(dolist (source package-archives)
  (add-to-list 'package-archives source t))

(package-initialize)

(package-refresh-contents)

;; Automatically install a bunch of useful packages. You should look read up about these.
(setq my-packages
      '(
	angular-snippets
        auto-complete
	cider
	clojure-mode
	color-theme-solarized
        elm-mode
        emmet-mode
        exec-path-from-shell
	expand-region
        fsharp-mode
        fiplr
        flycheck
	ido
	js2-mode
        js2-refactor
	json
	magit
	markdown-mode
	multiple-cursors
        neotree
	paredit
        prettier-js
        web-mode
        tide
        tern
	undo-tree
	yasnippet
	))

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Set emacs path to shell path
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; Fire up the minor modes the theme we want going all the time everywhere
(load-theme 'zenburn t)
(global-undo-tree-mode)
(ido-mode t)


;; Settings for ido. The most important one is fuzzy matching, like Sublime Text.
(setq
 ido-case-fold t
 ido-enable-prefix nil
 ido-enable-flex-matching t
 ido-create-new-buffer 'always
 ido-use-filename-at-point nil
 ido-max-prospects 10
 yas/prompt-functions '(yas/ido-prompt)
)

(setq ido-save-directory-list-file "~/.emacs.d/ido.last")

;; setup modes
(require 'setup-yasnippet)

;; map modes
(require 'mode-mappings)

(electric-indent-mode 1)

;; Some keybindings for the extra packages and improved built-ins
(global-set-key (kbd "C-=") 'er/expand-region)
 
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "C-.") 'hippie-expand)

(global-set-key (kbd "C-c f") 'vc-git-grep)

(global-set-key (kbd "C-x f") 'fiplr-find-file)

(global-set-key (kbd "C-x t f") 'tide-fix)
(global-set-key (kbd "C-x t i") 'tide-organize-imports)

;; duplicate line
(global-set-key "\C-c\C-d" "\C-a\C- \C-e\M-w\C-m\C-y")

;; copy line
(global-set-key "\C-c\C-l" "\C-a\C- \C-e\M-w")

;; move lines
(defun move-up()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-down()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-<up>") 'move-up)
(global-set-key (kbd "M-<down>") 'move-down)

;; This one is kind of big, it reindents when hitting return. Something you usually need to do manually.
;; (global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
 
(global-set-key (kbd "C-x C-b") 'ibuffer)
 
(global-set-key "\M-s" 'other-window)

(global-set-key (kbd "C-'") 'comment-region)
(global-set-key (kbd "C-\"") 'uncomment-region)

(global-set-key (kbd "C-c C-w") 'sgml-tag)

(global-unset-key (kbd "C-x C-c"))

(js2r-add-keybindings-with-prefix "C-c C-m")

(defun replace-class()
  (interactive)
  (query-replace-regexp "class=" "className=" nil nil nil nil nil))

(global-set-key (kbd "C-x r c") 'replace-class)

;; (defun goto-def()
;;   (interactive)
;;   (find-file-other-window (thing-at-point 'word) nil))

;; (global-set-key (kbd "C-x g t") 'goto-def)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(background-color "#002b36")
 '(background-mode dark)
 '(cursor-color "#839496")
 '(custom-safe-themes
   (quote
    ("0c387e27a3dd040b33c6711ff92e13bd952369a788eee97e4e4ea2335ac5528f" "01ce486c3a7c8b37cf13f8c95ca4bb3c11413228b35676025fdf239e77019ea1" "5761d5d5f2084d6746eee15454e2b9bca9929c97571726811b58d22b78dd90d7" "0f9a2efd3212f60002bd224b430fa073845c1a5b5cc2e5be1bc93c7734a52daa" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(foreground-color "#839496")
 '(package-selected-packages
   (quote
    (tern yaml-mode tide typescript-mode undo-tree prettier-js paredit neotree markdown-mode magit js2-refactor js2-mode fiplr fsharp-mode expand-region exec-path-from-shell emmet-mode elm-mode color-theme-solarized cider auto-complete angular-snippets))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; calc hours worked
(defun time-to-decimal (time)
 (+ (floor time) (/ (* 100 (- time (floor time))) 60)))
 
(defun calc-hours-worked ()
 (interactive)
 (setq line (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
 (string-match "[0-9]\\{2\\}\.[0-9]\\{2\\}" line)
 (setq start (string-to-number (match-string 0 line)))
 (string-match "[0-9]\\{2\\}\.[0-9]\\{2\\}" line 10)
 (setq end (string-to-number (match-string 0 line)))
 (insert (format "\t-- %0.2f" (- (time-to-decimal end) (time-to-decimal  start)))))


(global-set-key (kbd "C-c C-h") 'calc-hours-worked)



(global-set-key (kbd "C-c C-t") (kbd "C-SPC C-a M-w C-e C-x * q C-y RET = C-y"))

