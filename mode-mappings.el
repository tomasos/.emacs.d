;; JavaScript
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))

(add-hook 'js2-mode-hook #'js2-refactor-mode)


 ;; Use lambda for anonymous functions
 (font-lock-add-keywords
  'js2-mode `(("\\(function\\) *("
               (0 (progn (compose-region (match-beginning 1)
                                         (match-end 1) "\u0192")
                         nil)))))

 ;; Use right arrow for return in one-line functions
 (font-lock-add-keywords
  'js2-mode `(("function *([^)]*) *{ *\\(return\\) "
               (0 (progn (compose-region (match-beginning 1)
                                         (match-end 1) "\u2190")
                         nil)))))

;; CSS
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.less\\'" . css-mode))

(add-hook 'css-mode-hook 'emmet-mode)

;; auto-complete
(global-auto-complete-mode t)
(setq ac-modes '(css-mode))

;; HTML
(add-to-list 'auto-mode-alist '("\\.cshtml\\'" . html-mode))
(add-hook 'html-mode-hook 'emmet-mode)

(provide 'mode-mappings)

