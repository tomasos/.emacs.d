;; Don't need buttons in emacs! By running this early we avoid a flash
;; of buttons before they are removed.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq use-dialog-box nil)
 
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
			 ("marmalade" . "http://marmalade-repo.org/packages/")))

(dolist (source package-archives)
  (add-to-list 'package-archives source t))

(package-initialize)

(package-refresh-contents)

;; Automatically install a bunch of useful packages. You should look read up about these.
(setq my-packages
      '(
	ido
	json
	magit
	js2-mode
	web-mode
	undo-tree
	expand-region
	multiple-cursors
	markdown-mode
	color-theme-solarized
	paredit
	yasnippet
	))

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))

;; Fire up the minor modes the theme we want going all the time everywhere
(load-theme 'misterioso t)
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

;; Some keybindings for the extra packages and improved built-ins
(global-set-key (kbd "C-=") 'er/expand-region)
 
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "C-.") 'hippie-expand)

(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")

;; This one is kind of big, it reindents when hitting return. Something you usually need to do manually.
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
 
(global-set-key (kbd "C-x C-b") 'ibuffer)
 
(global-set-key "\M-s" 'other-window)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(background-color "#002b36")
 '(background-mode dark)
 '(cursor-color "#839496")
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(foreground-color "#839496"))
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
  (string-match "[0-9]\\{2\\}\.[0-9]\\{2\\}" line 5)
  (setq end (string-to-number (match-string 0 line)))
  (insert (format "\t%0.2f" (- (time-to-decimal end) (time-to-decimal  start)))))

(global-set-key (kbd "C-c C-h") 'calc-hours-worked)



