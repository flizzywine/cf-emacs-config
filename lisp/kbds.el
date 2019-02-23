(setq mac-command-modifier 'hyper)
(setq mac-option-modifier 'meta)

(global-set-key (kbd "<backspace>") 'kill-region)

(global-set-key (kbd "<tab>") 'indent-for-tab-command)

(global-set-key [(hyper x)] 'kill-region)

(global-set-key [(hyper q)] 'save-buffers-kill-terminal)
(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'clipboard-yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'copy-line)
(global-set-key [(hyper z)] 'undo)
(global-set-key [(hyper e)] 'eval-last-sexp)
(global-set-key (kbd "H-o") 'helm-find-files)
(global-set-key (kbd "H-p") 'package-list-packages)
(global-set-key (kbd "H-i") 'iterm-goto-filedir-or-home)

(global-set-key (kbd "H-f") 'helm-occur)
(global-set-key (kbd "H-F") 'helm-multi-swoop-projectile)
(global-set-key (kbd "H-k") 'save-and-kill-this-buffer)
(defun save-and-kill-this-buffer ()
  (interactive)
  (save-current-buffer)
  (kill-this-buffer))
(global-set-key (kbd "H-C-k") 'kill-all-other-buffers)



(global-set-key (kbd "C-h") 'backward-delete-char)
(global-set-key (kbd "C-a") 'my-move-beginning-of-line-before-whitespace)
(global-set-key (kbd "C-e") 'my-move-end-of-line-before-whitespace)
(global-set-key (kbd "C-L") 'kill-whole-line)
(global-set-key (kbd "C-;") 'comment-line)
(global-set-key (kbd "C-!") 'shell-command)

;; (global-set-key (kbd "C-o") 'my-newline-forward)
;; (global-set-key (kbd "C-S-O") 'my-newline-backward)

(global-set-key (kbd "C-M-SPC") 'set-mark-command)

(global-set-key (kbd "C-x e") 'call-last-kbd-macro)

(global-set-key (kbd "C-M-p") 'move-line-region-up)
(global-set-key (kbd "C-M-n") 'move-line-region-down)


(global-set-key (kbd "H-1") 'delete-other-windows)
(global-set-key (kbd "H-3") 'split-window-below)
(global-set-key (kbd "H-2") 'split-window-right)
(global-set-key (kbd "H-`") 'delete-window)

;; (global-set-key (kbd "C-S-n") 'windmove-down)
;; (global-set-key (kbd "C-S-p") 'windmove-up)
;; (global-set-key (kbd "C-S-b") 'windmove-left)
;; (global-set-key (kbd "C-S-f") 'windmove-right)

(global-set-key (kbd "H-M-g") 'goto-line)



(global-set-key (kbd "M-h") 'backward-kill-word)

(global-set-key (kbd "M-w") 'my-kill-word-at-point)

(global-set-key (kbd "H-=") 'text-scale-increase)
(global-set-key (kbd "H--") 'text-scale-decrease)
(global-set-key (kbd "<f11>") 'toggle-fullscreen)

(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

(global-set-key (kbd "H-E") 'eval-buffer)

;; (global-set-key (kbd "M-v") 'switch-to-next-buffer)
;; (global-set-key (kbd "C-V") 'switch-to-next-buffer)
(global-set-key (kbd "C-v") 'helm-buffers-list)
(global-set-key (kbd "H-E") 'eval-buffer)
(global-set-key (kbd "C-q") 'query-replace-regexp)
;; (global-set-key (kbd "C-y") 'xah-paste-or-paste-previous)
(global-set-key (kbd "M-h") 'delete-word)


(global-set-key (kbd "C-r") 'replace-symbol-in-buffer)

(global-set-key (kbd "H-l") 'crux-duplicate-current-line-or-region)
;; (global-set-key (kbd "M-l") 'avy-move-line)

;; TERMINAL MAPPINGS TO SUPPORT ITERM2 FOR MAC
	 (progn
	 (let ((map (if (boundp 'input-decode-map)
				 input-decode-map
	 function-key-map)))
	 (define-key map "\e[1;P9"  (kbd "H-a"))
	 (define-key map "\e[1;P10" (kbd "H-b"))
	 (define-key map "\e[1;P11" (kbd "H-c"))
	 (define-key map "\e[1;P12" (kbd "H-d"))
	 (define-key map "\e[1;P13" (kbd "H-e"))
	 (define-key map "\e[1;P14" (kbd "H-f"))
	 (define-key map "\e[1;P15" (kbd "H-g"))
	 (define-key map "\e[1;P16" (kbd "H-h"))
	 (define-key map "\e[1;P17" (kbd "H-i"))
	 (define-key map "\e[1;P18" (kbd "H-j"))
	 (define-key map "\e[1;P19" (kbd "H-k"))
	 (define-key map "\e[1;P20" (kbd "H-l"))
	 (define-key map "\e[1;P21" (kbd "H-m"))
	 (define-key map "\e[1;P22" (kbd "H-n"))
	 (define-key map "\e[1;P23" (kbd "H-o"))
	 (define-key map "\e[1;P24" (kbd "H-p"))
	 (define-key map "\e[1;P25" (kbd "H-q"))
	 (define-key map "\e[1;P26" (kbd "H-r"))
	 (define-key map "\e[1;P27" (kbd "H-s"))
	 (define-key map "\e[1;P28" (kbd "H-t"))
	 (define-key map "\e[1;P29" (kbd "H-u"))
	 (define-key map "\e[1;P30" (kbd "H-v"))
	 (define-key map "\e[1;P31" (kbd "H-w"))
	 (define-key map "\e[1;P32" (kbd "H-x"))
	 (define-key map "\e[1;P33" (kbd "H-y"))
	 (define-key map "\e[1;P34" (kbd "H-z"))
	 (define-key map "\e[1;P35" (kbd "H-0"))
	 (define-key map "\e[1;P36" (kbd "H-1"))
	 (define-key map "\e[1;P37" (kbd "H-2"))
	 (define-key map "\e[1;P38" (kbd "H-3"))
	 (define-key map "\e[1;P39" (kbd "H-4"))
	 (define-key map "\e[1;P40" (kbd "H-5"))
	 (define-key map "\e[1;P41" (kbd "H-6"))
	 (define-key map "\e[1;P42" (kbd "H-7"))
	 (define-key map "\e[1;P43" (kbd "H-8"))
	 (define-key map "\e[1;P44" (kbd "H-9"))
	 (define-key map "\e[1;P45" (kbd "H-<f1>"))
	 (define-key map "\e[1;P46" (kbd "H-<f2>"))
	 (define-key map "\e[1;P47" (kbd "H-<f3>"))
	 (define-key map "\e[1;P48" (kbd "H-<f4>"))
	 (define-key map "\e[1;P49" (kbd "H-<f5>"))
	 (define-key map "\e[1;P50" (kbd "H-<f6>"))
	 (define-key map "\e[1;P51" (kbd "H-<f7>"))
	 (define-key map "\e[1;P52" (kbd "H-<f8>"))
	 (define-key map "\e[1;P53" (kbd "H-<f9>"))
	 (define-key map "\e[1;P54" (kbd "H-<f10>"))
	 (define-key map "\e[1;P55" (kbd "H-<f11>"))
	 (define-key map "\e[1;P56" (kbd "H-<f12>"))
	 ))

(provide 'kbds)

























