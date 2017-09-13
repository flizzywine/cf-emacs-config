
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/Library/Frameworks/Python.framework/Versions/2.7/bin")
(add-to-list 'exec-path "/Library/Frameworks/Python.framework/Versions/3.6/bin")

(require 'prog-languages)
(require 'kbds)
(require 'modes-and-vars)
(require 'snippets)
(require 'spacemacs-theme)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'bind-key)
(bind-key* (kbd "M-.") 'jump-to-mark)
(bind-key* (kbd "M-h") 'backward-kill-word)
(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-item 10)
  (global-set-key (kbd "H-O") 'open-recent-file-and-search))

(use-package helm
  :config
  (helm-mode 1)
  (global-set-key (kbd "C-c o r") 'helm-recentf)
  (global-set-key (kbd "M-x") 'helm-smex)
  (global-set-key (kbd "H-b") 'helm-buffers-list))

(use-package helm-swoop
  :config
  (global-set-key (kbd "H-f") 'helm-swoop-set-mark))
(use-package helm-gtags
  :config
  (global-set-key (kbd "H-j") 'helm-gtags-dwim))

(use-package yasnippet
  :config
  (yas-reload-all)
  (yas-global-mode 1)
  (global-set-key (kbd "H-/") 'yas-expand)
  (global-set-key (kbd "C-c y n") 'yas-new-snippet)
  (global-set-key (kbd "C-c y v") 'yas-visit-snippet-file))

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'company-statistics-mode)

(use-package company
  :init
 
  :config
  (define-key c++-mode-map (kbd "M-<tab>") 'company-complete)
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0))



(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (flycheck-pos-tip-mode t))



(use-package ace-jump-mode
  :config
  (add-hook 'ace-jump-mode-end-hook 'forward-char)
  (global-set-key (kbd "C-j") 'ace-jump-char-mode)
  ;; (global-set-key (kbd "C-l") 'ace-jump-line-mode))
)

(use-package iedit
  :config
  (setq tab-always-indent 'complete)
  (global-set-key (kbd "H-M-e") 'iedit-dwim))

(use-package magit
  :config
  (global-set-key (kbd "M-g") 'magit-status))

(use-package crux
  :config
  (global-set-key (kbd "H-9") 'crux-swap-windows)
  (global-set-key (kbd "H-K") 'crux-kill-other-buffers)
  (global-set-key (kbd "C-l") 'crux-kill-whole-line)
  (global-set-key (kbd "C-o") 'crux-smart-open-line)
  (global-set-key (kbd "C-S-o") 'crux-smart-open-line-above)
  (global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)
  (global-set-key (kbd "H-l") 'crux-duplicate-current-line-or-region)
  
  
  )



(use-package smart-mode-line
  :config
  (setq sml/no-confirm-load-theme t)
  ;; delegate theming to the currently active theme
  (setq sml/theme nil)
  (add-hook 'after-init-hook #'sml/setup)
  )

(use-package which-key
  :config
  (which-key-mode +1)
  )

(use-package shift-text
  :config
  (global-set-key (kbd "C-M-n") 'shift-text-down)
  (global-set-key (kbd "C-M-p") 'shift-text-up)
  (global-set-key (kbd "H-]") 'shift-text-right)
  (global-set-key (kbd "H-[") 'shift-text-left)
  )

(use-package cedit
  :config
  (define-key c++-mode-map (kbd "C-H-k") 'cedit-raise)
  (define-key c++-mode-map (kbd "C-H-[") 'cedit-wrap-bracket)
  (global-set-key (kbd "C-H-9") 'cedit-wrap-paren)
  (define-key c++-mode-map (kbd "C-H-f") 'cedit-down-block)
  (define-key c++-mode-map (kbd "C-H-b") 'cedit-up-block-backward)
  (define-key c++-mode-map (kbd "C-H-M-p") 'cedit-up-block-forward)
  (define-key c++-mode-map (kbd "C-H-p") 'cedit-beginning-of-statement)
  (define-key c++-mode-map (kbd "C-H-n") 'cedit-end-of-statement)
  )



(use-package zop-to-char
  :config
  (global-set-key (kbd "C-z") 'zop-up-to-char)
  (global-set-key (kbd "C-Z") 'zop-to-char))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    ((company-dabbrev company-clang company-semantic company-keywords company-capf)
     company-capf company-bbdb company-nxml company-css company-eclim company-cmake company-files
     (company-gtags company-etags)
     company-oddmuse company-dabbrev)))
 '(flymake-gui-warnings-enabled nil)
 '(package-selected-packages
   (quote
    (osx-lib osx-browse osx-dictionary osx-clipboard projectile company-jedi helm-ispell flyspell-popup shift-text company-c-headers which-key smart-mode-line spacemacs-common crux zop-to-char company-statistics paredit-everywhere paredit-mode helm-swoop paredit cedit main-line iedit flycheck-pos-tip elpy web-mode use-package undo-tree spacemacs-theme smartparens scala-mode sbt-mode request-deferred replace-symbol realgud pos-tip markdown-mode magit irony helm-smex helm-gtags helm-c-yasnippet goto-chg ggtags flycheck f ein anaphora ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-warnline ((t nil))))

(defun select-at-point  ()
  (interactive)
  (beginning-of-sexp)
  (mark-sexp)
  (kill-ring-save))
(global-set-key (kbd "C-M-m") 'select-at-point)

(require 'smartparens)
(defun prelude-wrap-with (s)
  "Create a wrapper function for smartparens using S."
  `(lambda (&optional arg)
     (interactive "P")
     (sp-wrap-with-pair ,s)))

(define-key scheme-mode-map (kbd "M-(") (prelude-wrap-with "("))
(define-key emacs-lisp-mode-map (kbd "M-(") (prelude-wrap-with "("))
(if (not (fboundp 'switch-to-other-buffer))
;; Code stolen Xemacs' files.el
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
)

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
(global-set-key (kbd "C-v") 'switch-to-prev-buffer)
(global-set-key (kbd "M-v") 'switch-to-next-buffer)

(global-set-key (kbd "H-E") 'eval-buffer)
(defun copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
    (interactive "p")
    (let ((beg (line-beginning-position))
          (end (line-end-position arg)))
      (when mark-active
        (if (> (point) (mark))
            (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
          (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
      (if (eq last-command 'copy-line)
          (kill-append (buffer-substring beg end) (< end beg))
        (kill-ring-save beg end)))
    (kill-append "\n" nil)
    (beginning-of-line (or (and arg (1+ arg)) 2))
    (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))
(global-set-key (kbd "H-l") 'copy-line)
(global-set-key (kbd "M-<tab>") 'company-clang)

;; (global-set-key (kbd "C-q") 'query-replace)
(global-set-key (kbd "C-q") 'query-replace-regexp)

;;;DEL by pair
(defun xah-delete-backward-char-or-bracket-text ()
  "Delete backward 1 character, but if it's a \"quote\" or bracket ()[]{}【】「」 etc, delete bracket and the inner text, push the deleted text to `kill-ring'.

What char is considered bracket or quote is determined by current syntax table.

If `universal-argument' is called first, do not delete inner text.

URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
Version 2017-07-02"
  (interactive)
  (if (and delete-selection-mode (region-active-p))
      (delete-region (region-beginning) (region-end))
    (cond
     ((looking-back "\\s)" 1)
      (if current-prefix-arg
          (xah-delete-backward-bracket-pair)
        (xah-delete-backward-bracket-text)))
     ((looking-back "\\s(" 1)
      (progn
        (backward-char)
        (forward-sexp)
        (if current-prefix-arg
            (xah-delete-backward-bracket-pair)
          (xah-delete-backward-bracket-text))))
     ((looking-back "\\s\"" 1)
      (if (nth 3 (syntax-ppss))
          (progn
            (backward-char )
            (xah-delete-forward-bracket-pairs (not current-prefix-arg)))
        (if current-prefix-arg
            (xah-delete-backward-bracket-pair)
          (xah-delete-backward-bracket-text))))
     (t
      (delete-char -1)))))

(defun xah-delete-backward-bracket-text ()
  "Delete the matching brackets/quotes to the left of `point', including the inner text.

This command assumes the left of point is a right bracket, and there's a matching one before it.

What char is considered bracket or quote is determined by current syntax table.

URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
Version 2017-07-02"
  (interactive)
  (progn
    (forward-sexp -1)
    (mark-sexp)
    (kill-region (region-beginning) (region-end))))

(defun xah-delete-backward-bracket-pair ()
  "Delete the matching brackets/quotes to the left of `point'.

After the command, mark is set at the left matching bracket position, so you can `exchange-point-and-mark' to select it.

This command assumes the left of point is a right bracket, and there's a matching one before it.

What char is considered bracket or quote is determined by current syntax table.

URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
Version 2017-07-02"
  (interactive)
  (let (( $p0 (point)) $p1)
    (forward-sexp -1)
    (setq $p1 (point))
    (goto-char $p0)
    (delete-char -1)
    (goto-char $p1)
    (delete-char 1)
    (push-mark (point) t)
    (goto-char (- $p0 2))))

(defun xah-delete-forward-bracket-pairs ( &optional @delete-inner-text-p)
  "Delete the matching brackets/quotes to the right of `point'.
If *delete-inner-text-p is true, also delete the inner text.

After the command, mark is set at the left matching bracket position, so you can `exchange-point-and-mark' to select it.

This command assumes the char to the right of point is a left bracket or quote, and have a matching one after.

What char is considered bracket or quote is determined by current syntax table.

URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
Version 2017-07-02"
  (interactive)
  (if @delete-inner-text-p
      (progn
        (mark-sexp)
        (kill-region (region-beginning) (region-end)))
    (let (($pt (point)))
      (forward-sexp)
      (delete-char -1)
      (push-mark (point) t)
      (goto-char $pt)
      (delete-char 1))))

(global-set-key (kbd "<backspace>") 'xah-delete-backward-char-or-bracket-text)


(defun xah-select-text-in-quote ()
  "Select text between the nearest left and right delimiters.
Delimiters here includes the following chars: \"<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕（）
This command select between any bracket chars, not the inner text of a bracket. For example, if text is

 (a(b)c▮)

 the selected char is “c”, not “a(b)c”.

URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2016-12-18"
  (interactive)
  (let (
        ($skipChars
         (if (boundp 'xah-brackets)
             (concat "^\"" xah-brackets)
           "^\"<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕（）"))
        $pos
        )
    (skip-chars-backward $skipChars)
    (setq $pos (point))
    (skip-chars-forward $skipChars)
    (set-mark $pos)))

(defun xah-forward-block (&optional n)
  "Move cursor beginning of next text block.
A text block is separated by blank lines.
This command similar to `forward-paragraph', but this command's behavior is the same regardless of syntax table.
URL `http://ergoemacs.org/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" n)))

(defun xah-paste-or-paste-previous ()
  "Paste. When called repeatedly, paste previous.
This command calls `yank', and if repeated, call `yank-pop'.

When `universal-argument' is called first with a number arg, paste that many times.

URL `http://ergoemacs.org/emacs/emacs_paste_or_paste_previous.html'
Version 2017-07-25"
  (interactive)
  (progn
    (when (and delete-selection-mode (region-active-p))
      (delete-region (region-beginning) (region-end)))
    (if current-prefix-arg
        (progn
          (dotimes ($i (prefix-numeric-value current-prefix-arg))
            (yank)))
      (if (eq real-last-command this-command)
          (yank-pop 1)
        (yank)))))
(global-set-key (kbd "C-y") 'xah-paste-or-paste-previous)

(defun xah-delete-current-text-block ()
  "Delete the current text block or selection, and copy to `kill-ring'.
A “block” is text between blank lines.

URL `http://ergoemacs.org/emacs/emacs_delete_block.html'
Version 2017-07-09"
  (interactive)
  (let ($p1 $p2)
    (if (use-region-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (progn
        (if (re-search-backward "\n[ \t]*\n+" nil "move")
            (progn (re-search-forward "\n[ \t]*\n+")
                   (setq $p1 (point)))
          (setq $p1 (point)))
        (re-search-forward "\n[ \t]*\n" nil "move")
        (setq $p2 (point))))
    (kill-region $p1 $p2)))

(global-set-key (kbd "H-<backspace>") 'xah-delete-current-text-block)

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

(defun xah-insert-paren ()
  (interactive)
  (xah-insert-bracket-pair "(" ")") )

(defun xah-insert-bracket ()
  (interactive)
  (xah-insert-bracket-pair "[" "]") )

(defun xah-insert-brace ()
  (interactive)
  (xah-insert-bracket-pair "{" "}") )

(global-set-key (kbd "{") 'xah-insert-brace) ; {}


(global-set-key (kbd "(") 'xah-insert-paren) ; ()
(global-set-key (kbd "[") 'xah-insert-bracket) ; []


(use-package osx-lib
  :config
  ;; (Osx-Clipboard-Mode +1)
  (global-set-key (kbd "H-I") 'osx-lib-reveal-in-finder)
  (global-set-key (kbd "H-O") 'osx-lib-find-file-in-finder)
  ;; (global-set-key (kbd "H-i") 'osx-lib-start-terminal)
  ;; (global-set-key (kbd "H-c") 'osx-lib-copy-to-clipboard)
  ;; (global-set-key (kbd "H-v") 'osx-lib-paste-from-clipboard)
  )


;; (require 'osx-browse)
;; (osx-browse-mode 1)
