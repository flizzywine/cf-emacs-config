(setq mac-command-modifier 'hyper)
(setq mac-option-modifier 'meta)

(global-set-key (kbd "<backspace>") 'kill-region)



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
(global-set-key (kbd "H-f") 'helm-swoop-set-mark)

(global-set-key (kbd "H-k") 'kill-buffer)
(global-set-key (kbd "H-C-k") 'kill-all-other-buffers)



(global-set-key (kbd "C-v") 'switch-to-previous-buffer)
(global-set-key (kbd "C-h") 'backward-delete-char)
(global-set-key (kbd "C-a") 'my-move-beginning-of-line-before-whitespace)
(global-set-key (kbd "C-e") 'my-move-end-of-line-before-whitespace)
(global-set-key (kbd "C-L") 'kill-whole-line)
(global-set-key (kbd "C-;") 'comment-line)
(global-set-key (kbd "C-!") 'shell-command)

(global-set-key (kbd "C-o") 'my-newline-forward)
(global-set-key (kbd "C-S-O") 'my-newline-backward)

(global-set-key (kbd "C-M-SPC") 'set-mark-command)

(global-set-key (kbd "C-x e") 'call-last-kbd-macro)

(global-set-key (kbd "C-M-p") 'move-line-region-up)
(global-set-key (kbd "C-M-n") 'move-line-region-down)



(global-set-key (kbd "H-1") 'delete-other-windows)
(global-set-key (kbd "H-2") 'split-window-below)
(global-set-key (kbd "H-3") 'split-window-right)
(global-set-key (kbd "H-0") 'delete-window)
(global-set-key (kbd "H-9") 'transpose-buffers)


(global-set-key (kbd "H-M-n") 'windmove-down)
(global-set-key (kbd "H-M-p") 'windmove-up)
(global-set-key (kbd "H-M-b") 'windmove-left)
(global-set-key (kbd "H-M-f") 'windmove-right)

(global-set-key (kbd "H-M-g") 'goto-line)



(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "M-w") 'my-kill-word-at-point)

(provide 'kbds)

























