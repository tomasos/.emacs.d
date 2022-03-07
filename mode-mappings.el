(require 'flycheck)

;; JavaScript
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(add-hook 'js2-mode-hook 'emmet-mode)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'js2-jsx-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'emmet-mode)
;; (add-hook 'typescript-mode-hook 'tern-mode)

(add-to-list 'auto-mode-alist '("\\.elm\\'" . elm-mode))
(add-hook 'elm-mode-hook #'elm-oracle-setup-ac)

(defun setup-tide-mode ()
 (interactive)
 (tide-setup)
 (flycheck-mode +1)
 (eldoc-mode +1)
 (tide-hl-identifier-mode +1)
 (company-mode +1))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-hook 'typescript-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
(flycheck-add-mode 'typescript-tslint 'typescript-mode)

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
(add-hook 'css-mode-hook 'prettier-js-mode)

;; auto-complete
(global-auto-complete-mode t)
(setq ac-modes '(css-mode js2-mode js2-jsx-mode))

;; HTML
(add-to-list 'auto-mode-alist '("\\.cshtml\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))
(add-hook 'html-mode-hook 'emmet-mode)

;; fiplr
(setq fiplr-ignored-globs '((directories (".git" ".svn" "node_modules" "env"))
                            (files ("*.*.orig"))))


(provide 'mode-mappings)

