(defun xah-open-in-external-app ()
  
  "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference.
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2016-10-15"
  (interactive)
  (let* (
         ($file-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         ($do-it-p (if (<= (length $file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when $do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda ($fpath)
           (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" $fpath t t))) $file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda ($fpath)
           (shell-command
            (concat "open " (shell-quote-argument $fpath))))  $file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda ($fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" $fpath))) $file-list))))))

(defun xah-open-in-desktop ()
  
  "Show current file in desktop (OS's file manager).
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2015-11-30"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" default-directory t t)))
   ((string-equal system-type "darwin") (shell-command "open ."))
   ((string-equal system-type "gnu/linux")
    (let (
          (process-connection-type nil)
          (openFileProgram (if (file-exists-p "/usr/bin/gvfs-open")
                               "/usr/bin/gvfs-open"
                             "/usr/bin/xdg-open")))
      (start-process "" nil openFileProgram "."))
    ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. For example: with nautilus
    )))
(defun my-newline-forward  ()
  "newline."
  (interactive)
  (let ((oldpos (point)))
    (end-of-line)
    (newline-and-indent)))

(defun open-recent-file-and-search ()
  (interactive)
  (recentf-open-files)
  (isearch-forward))

(defun my-newline-backward  ()
  "newline."
  (interactive)
  (let ((oldpos (point)))
    (beginning-of-line)
    (newline-and-indent))
  (previous-line))

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
  This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-.") 'jump-to-mark)

(defun switch-to-previous-buffer ()
  "Switch to most recent buffer. Repeated calls toggle back and forth between the most recent two buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))



(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe 
     	 (lambda()
     	   (if (string= "shell-mode" major-mode)
               (progn (comint-next-prompt 25535) (yank))
             (progn (goto-char (mark)) (yank) )))))
    (if arg
        (if (= arg 1)
     		nil
          (funcall pasteMe))
      (funcall pasteMe))
    ))
(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (copy-thing 'beginning-of-line 'end-of-line arg)
  (paste-to-mark arg)
  )
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))

(defun move-line-region-up (&optional start end n)
  (interactive "r\np")
  (if (use-region-p) (move-region-up start end n) (move-line-up n)))

(defun move-line-region-down (&optional start end n)
  (interactive "r\np")
  (if (use-region-p) (move-region-down start end n) (move-line-down n)))


(defun my-move-end-of-line-before-whitespace ()
  "Move to the last non-whitespace character in the current line."
  (interactive)
  (move-end-of-line nil)
  (re-search-backward "^\\|[^[:space:]]")
  (forward-char))

(defun my-move-beginning-of-line-before-whitespace ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(defun isearch-at-point-set-mark ()
  (interactive)
  (push-mark-no-activate)
  (isearch-forward-symbol-at-point))
(global-set-key (kbd "C-H-f") 'isearch-at-point-set-mark)


(defun isearch-forward-set-mark ()
  (interactive)
  (push-mark)
  (isearch-forward))


(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))

(defun my-kill-thing-at-point (thing)
  "Kill the `thing-at-point' for the specified kind of THING."
  (let ((bounds (bounds-of-thing-at-point thing)))
    (if bounds
        (kill-region (car bounds) (cdr bounds))
      (error "No %s at point" thing))))

(defun my-kill-word-at-point ()
  "Kill the word at point."
  (interactive)
  (my-kill-thing-at-point 'word))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer 
        (delq (current-buffer) 
              (remove-if-not 'buffer-file-name (buffer-list)))))

  (defun iedit-dwim (arg)
    "Starts iedit but uses \\[narrow-to-defun] to limit its scope."
    (interactive "P")
    (if arg
    (iedit-mode)
      (save-excursion
        (save-restriction
          (widen)
          ;; this function determines the scope of `iedit-start'.
          (if iedit-mode
              (iedit-done)
            ;; `current-word' can of course be replaced by other
            ;; functions.
            (narrow-to-defun)
            (iedit-start (current-word) (point-min) (point-max)))))))


(defadvice kill-region (before unix-werase activate compile)
      "When called interactively with no active region, delete a single word
    backwards instead."
      (interactive
       (if mark-active (list (region-beginning) (region-end))
         (list (save-excursion (backward-char 1) (point)) (point)))))

(defun helm-swoop-set-mark ()
  (interactive)
  (push-mark-no-activate)
  (helm-swoop))

(defun switch-to-other-buffer (arg)
  "Switch to the previous buffer.  With a numeric arg, n, switch to the nth
most recent buffer.  With an arg of 0, buries the current buffer at the
bottom of the buffer stack."
  (interactive "p")
  (if (eq arg 0)
      (bury-buffer (current-buffer)))
  (switch-to-buffer
   (if (<= arg 1) (other-buffer (current-buffer))
     (nth (1+ arg) (buffer-list)))))


(if (not (fboundp 'next-buffer))
    (defun next-buffer ()
  "Switch to the next buffer in cyclic order."
  (interactive)
  (switch-to-other-buffer 0)))

(if (not (fboundp 'previous-buffer))
     (defun previous-buffer ()
  "Switch to the previous buffer in cyclic order."
  (interactive)
  (while (string-match "\\` "
                       (buffer-name (switch-to-other-buffer
                                     (- (length (buffer-list)) 2)))))))

(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-region (point) (progn (forward-word arg) (point)))))



(defun xah-insert-bracket-pair (@left-bracket @right-bracket &optional @wrap-method)
  "Insert brackets around selection, word, at point, and maybe move cursor in between.

 *left-bracket and *right-bracket are strings. *wrap-method must be either 'line or 'block. 'block means between empty lines.

• if there's a region, add brackets around region.
• If *wrap-method is 'line, wrap around line.
• If *wrap-method is 'block, wrap around block.
• if cursor is at beginning of line and its not empty line and contain at least 1 space, wrap around the line.
• If cursor is at end of a word or buffer, one of the following will happen:
 xyz▮ → xyz(▮)
 xyz▮ → (xyz▮)       if in one of the lisp modes.
• wrap brackets around word if any. e.g. xy▮z → (xyz▮). Or just (▮)

URL `http://ergoemacs.org/emacs/elisp_insert_brackets_by_pair.html'
Version 2017-01-17"
  (if (use-region-p)
      (progn ; there's active region
        (let (
              ($p1 (region-beginning))
              ($p2 (region-end)))
          (goto-char $p2)
          (insert @right-bracket)
          (goto-char $p1)
          (insert @left-bracket)
          (goto-char (+ $p2 2))))
    (progn ; no text selection
      (let ($p1 $p2)
        (cond
         ((eq @wrap-method 'line)
          (setq $p1 (line-beginning-position) $p2 (line-end-position))
          (goto-char $p2)
          (insert @right-bracket)
          (goto-char $p1)
          (insert @left-bracket)
          (goto-char (+ $p2 (length @left-bracket))))
         ((eq @wrap-method 'block)
          (save-excursion
            (progn
              (if (re-search-backward "\n[ \t]*\n" nil 'move)
                  (progn (re-search-forward "\n[ \t]*\n")
                         (setq $p1 (point)))
                (setq $p1 (point)))
              (if (re-search-forward "\n[ \t]*\n" nil 'move)
                  (progn (re-search-backward "\n[ \t]*\n")
                         (setq $p2 (point)))
                (setq $p2 (point))))
            (goto-char $p2)
            (insert @right-bracket)
            (goto-char $p1)
            (insert @left-bracket)
            (goto-char (+ $p2 (length @left-bracket)))))
         ( ;  do line. line must contain space
          (and
           (eq (point) (line-beginning-position))
           ;; (string-match " " (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
           (not (eq (line-beginning-position) (line-end-position))))
          (insert @left-bracket )
          (end-of-line)
          (insert  @right-bracket))
         ((and
           (or ; cursor is at end of word or buffer. i.e. xyz▮
            (looking-at "[^-_[:alnum:]]")
            (eq (point) (point-max)))
           (not (or
                 (string-equal major-mode "xah-elisp-mode")
                 (string-equal major-mode "emacs-lisp-mode")
                 (string-equal major-mode "lisp-mode")
                 (string-equal major-mode "lisp-interaction-mode")
                 (string-equal major-mode "common-lisp-mode")
                 (string-equal major-mode "clojure-mode")
                 (string-equal major-mode "xah-clojure-mode")
                 (string-equal major-mode "scheme-mode"))))
          (progn
            (setq $p1 (point) $p2 (point))
            (insert @left-bracket @right-bracket)
            (search-backward @right-bracket )))
         (t (progn
              ;; wrap around “word”. basically, want all alphanumeric, plus hyphen and underscore, but don't want space or punctuations. Also want chinese chars
              ;; 我有一帘幽梦，不知与谁能共。多少秘密在其中，欲诉无人能懂。
              (skip-chars-backward "-_[:alnum:]")
              (setq $p1 (point))
              (skip-chars-forward "-_[:alnum:]")
              (setq $p2 (point))
              (goto-char $p2)
              (insert @right-bracket)
              (goto-char $p1)
              (insert @left-bracket)
              (goto-char (+ $p2 (length @left-bracket))))))))))




(provide 'snippets)
