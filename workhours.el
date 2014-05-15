(defun time-to-decimal (time)
  (+ (floor time) (/ (* 100 (- time (floor time))) 60)))

(defun calc-hours-worked ()
  (interactive)
  (setq line (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
  (string-match "[0-9]\\{2\\}\.[0-9]\\{2\\}" line)
  (setq start (string-to-number (match-string 0 line)))
  (string-match "[0-9]\\{2\\}\.")
  )






