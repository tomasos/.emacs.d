(require 'yasnippet)

;; use own snippets
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

(yas-global-mode 1)

;; include other snippets
;; (require 'angular-snippets)

(setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))

(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

(provide 'setup-yasnippet)
