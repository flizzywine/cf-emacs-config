
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                           ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/Library/Frameworks/Python.framework/Versions/2.7/bin")
(add-to-list 'exec-path "/Library/Frameworks/Python.framework/Versions/3.6/bin")

(require 'kbds)
(require 'modes-and-vars)
(require 'snippets)


(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-item 10)
  (global-set-key (kbd "C-H-o") 'open-recent-file-and-search))

(use-package helm
  :config
  (helm-mode 1)
  (global-set-key (kbd "M-x") 'helm-smex)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "H-b") 'helm-buffers-list)
  (global-set-key (kbd "C-x C-f") 'helm-find-files))

(use-package yasnippet
  :config
  (yas-reload-all)
  (yas-global-mode 1))


(add-hook 'after-init-hook 'global-company-mode)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(flycheck-pos-tip-mode t)

(require 'bind-key)
(bind-key* (kbd "M-.") 'jump-to-mark)

(use-package ace-jump-mode
  :config
  (add-hook 'ace-jump-mode-end-hook 'forward-char)
  (global-set-key (kbd "C-j") 'ace-jump-char-mode))

(require 'prog-languages)

(use-package iedit
  :init
  (setq iedit-toggle-key-default (kbd "H-M-e"))
  :config
  (setq tab-always-indent 'complete)
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
  (global-set-key (kbd "H-M-e") 'iedit-dwim))

(defun cf-compile-cpp ()
  (interactive)
  (save-buffer)
  (shell-command (concat "clang++ -g " (file-name-nondirectory (buffer-file-name)))))
  

(defun get-file-dir-or-home ()
  "If inside a file buffer, return the directory, else return home"
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
	"~/"
    (file-name-directory filename))))

(defun iterm-debug-lldb ()
  "Go to present working dir and focus iterm"
  (interactive)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"
    "    write text \"q\"\n"
    (format "     write text \"cd %s\" \n" (get-file-dir-or-home))
    "    write text \"clear\" \n"
    "    write text \"lldb -o run a.out\" \n"
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    ))
  )
(defun iterm-goto-filedir-or-home ()
  "Go to present working dir and focus iterm"
  (interactive)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"
    (format "     write text \"cd %s\" \n" (get-file-dir-or-home))
    "    write text \"clear\" \n"
    "    write text \"lldb -o run a.out\" \n"
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    ))
  )
(defun cf-iterm-cpp ()
  (interactive)
  (cf-compile-cpp)
  (iterm-debug-lldb))
 
(global-set-key (kbd "H-r") 'cf-iterm-cpp)
(global-set-key (kbd "H-i") 'iterm-goto-filedir-or-home)

(use-package helm-gtags
  :config
  (global-set-key (kbd "H-j") 'helm-gtags-dwim))

(require 'spacemacs-theme)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-gui-warnings-enabled nil)
 '(package-selected-packages
   (quote
    (main-line iedit flycheck-pos-tip elpy web-mode use-package undo-tree spacemacs-theme smartparens scala-mode sbt-mode request-deferred replace-symbol realgud pos-tip markdown-mode magit irony helm-smex helm-gtags helm-c-yasnippet goto-chg ggtags flycheck f ein anaphora ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-warnline ((t nil))))
