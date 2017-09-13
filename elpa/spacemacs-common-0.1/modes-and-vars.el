
;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 inhibit-splash-screen t
 ring-bell-function 'ignore
 auto-save-default nil
 make-backup-file nil

 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 sentence-end-double-space nil)


(tool-bar-mode -1)
(global-linum-mode t)
(global-hl-line-mode t)
(column-number-mode 1)
(electric-indent-mode nil)

(delete-selection-mode 1)
(global-superword-mode 1)
(electric-pair-mode 1)
;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))



(defun open-init-file ()
  (interactive )
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)


(setq initial-frame-alist '((fullscreen . maximized)))
(set-face-attribute 'default nil :height 150)


(fset 'yes-or-no-p 'y-or-n-p)

(setq shell-file-name "zsh")
(setq shell-command-switch "-ic")
;; (setq scheme-program-name  "/usr/local/bin/mit-scheme-c")

;; (desktop-save-mode 1)
(setq-default cursor-type 'bar)
(show-paren-mode t)
(provide 'modes-and-vars)


