
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "elpa/use-package-2.3")
  ;;(require 'use-package))
  )

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
						   ("melpa" . "http://elpa.emacs-china.org/melpa/")
						   ;; ("melpa" .http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/
						)))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/Library/Frameworks/Python.framework/Versions/3.6/bin")


(require 'prog-languages)
(require 'kbds)
(require 'modes-and-vars)
(require 'snippets)
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;;face
;; (require 'spacemacs-theme)
(require 'doom-themes)

  ;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each
  ;; theme may have their own settings.
(load-theme 'doom-one t)


(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  )


(set-frame-font "-*-Monaco-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1")
(set-default-font "-*-Monaco-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1")
(set-frame-font "Monaco")
;;


(exec-path-from-shell-initialize)
(require 'bind-key)
(bind-key* (kbd "M-.") 'jump-to-mark)
(bind-key* (kbd "M-h") 'backward-delete-word)

(require 'helm)


(use-package helm
  :config
  (helm-mode 1)
  (global-set-key (kbd "M-x") 'helm-smex)
  (global-set-key (kbd "M-r") 'helm-recentf)
  (global-set-key (kbd "M-,") 'helm-buffers-list)
  (global-set-key (kbd "H-C-o") 'helm-buffers-list)
  (global-set-key (kbd "H-<return>") 'ace-jump-helm-line)
  (setq helm-ff-init  1)
  ;;helm-swoop
  )



(use-package ace-jump-mode
  :config
  (global-set-key (kbd "C-j") 'ace-jump-word-mode)
  (global-set-key (kbd "M-j") 'ace-jump-line-mode)
  )

(use-package helm-fuzzier
  :config
  (helm-fuzzier-mode 1))

(use-package helm-swoop
  :config
  (global-set-key (kbd "H-F") 'helm-multi-swoop-current-mode)
  (setq helm-multi-swoop-edit-save t)
  (setq helm-swoop-move-to-line-cycle t)) 

;; (use-package flymake
;;   :config
;;   (add-hook 'java-mode-hook 'flymake-mode-on))


(global-set-key (kbd "<tab>") 'indent-for-tab-command)


(use-package helm-gtags
  :config
  (global-set-key (kbd "C-.") 'helm-gtags-dwim))

(use-package yasnippet
  :config
  (yas-reload-all)
  (yas-global-mode 1)
  (global-set-key (kbd "C-<tab>") 'yas-expand))

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'company-statistics-mode)

(use-package company
  :config
  ;; (define-key c++-mode-map (kbd "C-<tab>") 'company-complete)
  ;; (add-to-list 'company-backends 'company-jedi)
  ;; (add-to-list 'company-backends 'company-dabbrev)
  
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0)
  (setq company-dabbrev-downcase nil)
  )

(use-package company-tabnine
  :ensure t
  :config
  (add-to-list 'company-backends #'company-tabnine)
  
  (setq company-frontends
        '(company-tng-frontend
          company-pseudo-tooltip-frontend
          company-echo-metadata-frontend))
  )

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  ;; (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  :config
  (require 'flycheck-pyflakes)
  ;; (setq-default flycheck-disabled-checkers '(python-pycompile))
  (flycheck-pos-tip-mode t))

(use-package flycheck-clang-analyzer
  :ensure t
  :after flycheck
  :config (flycheck-clang-analyzer-setup)
  (setq flycheck-clang-analyzer-executable "/usr/bin/clang")
  )


(use-package magit
  :config
  (global-set-key (kbd "M-g") 'magit-status))

(use-package crux
  :config
  (global-set-key (kbd "H-9") 'crux-swap-windows)
  (global-set-key (kbd "H-K") 'crux-kill-other-buffers)
  (global-set-key (kbd "C-l") 'crux-kill-whole-line)
  (global-set-key (kbd "M-r") 'crux-recentf-find-file)
  (defun open-init-file ()
	(interactive)
	(find-file user-init-file))
  (global-set-key (kbd "<f2>") 'open-init-file)
  ;; (global-set-key (kbd "<f2>") 'crux-find-user-init-file)

  (global-set-key (kbd "M-k") 'crux-kill-line-backwards)
  
  (global-set-key (kbd "C-o") 'crux-smart-open-line)
  (global-set-key (kbd "C-S-o") 'crux-smart-open-line-above)
  (global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)
  (global-set-key (kbd "C-,") 'crux-switch-to-previous-buffer)
  (global-set-key (kbd "M-k") 'crux-kill-line-backwards)
  (global-set-key (kbd "C-l") 'crux-kill-whole-line)
 )


(use-package osx-lib
  :config
  (global-set-key (kbd "H-I") 'osx-lib-reveal-in-finder)
  ;; (global-set-key (kbd "H-i") 'osx-lib-start-terminal)
  ;; (global-set-key (kbd "H-c") 'osx-lib-copy-to-clipboard)
  ;; (global-set-key (kbd "H-v") 'osx-lib-paste-from-clipboard)
  )


(defun my-delete-backward-to-ws ()
  (interactive)
  (delete-region (point) (save-excursion (skip-syntax-backward "^ ") (point))))

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

(add-hook 'c-mode-hook
		  (lambda ()(modify-syntax-entry ?_ "w")))

;; (use-package projectile
;;   :config
;;   (projectile-mode 1)
;;   (global-set-key (kbd "M-,") 'projectile-find-other-file)
;;   (global-set-key (kbd "C-'") 'projectile-find-file-dwim)
;;   (setq projectile-enable-caching t)
;;   )

(use-package real-auto-save
  :config
  (add-hook 'prog-mode-hook 'real-auto-save-mode)
  (setq real-auto-save-interval 30)) ;; in seconds

(use-package evil
  :config
  (evil-mode 1)
  (setq evil-default-state 'emacs)
  (define-key evil-emacs-state-map (kbd "C-z") 'evil-execute-in-normal-state)
  (define-key evil-emacs-state-map (kbd "H-z") 'evil-normal-state)
  (define-key evil-normal-state-map (kbd "M-z") 'evil-change-to-initial-state)
)

;; (use-package ace-jump-mode
;;   :config
;;   (global-set-key (kbd "C-j") 'ace-jump-char-mode)
;;   (global-set-key (kbd "M-j") 'ace-jump-word-mode)
;;   )

;; (use-package evil-surround
;;   :ensure t
;;   :config
;;   (global-evil-surround-mode 1))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
		(filename (buffer-file-name)))
	(if (not filename)
		(message "Buffer '%s' is not visiting a file!" name)
	  (if (get-buffer new-name)
		  (message "A buffer named '%s' already exists!" new-name)
		(progn
		  (rename-file filename new-name 1)
		  (rename-buffer new-name)
		  (set-visited-file-name new-name)
		  (set-buffer-modified-p nil))))))

(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (if (use-region-p)
	  (delete-region (region-beginning) (region-end))
	(delete-region (point) (progn (forward-word arg) (point)))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))





(defun recompile-quietly ()
  "Re-compile without changing the window configuration."
  (interactive)
  (save-window-excursion
	(recompile)))


(use-package avy
  :config
  (global-set-key (kbd "M-l") 'avy-copy-line)
  (global-set-key (kbd "C-M-l") 'avy-move-line)
  )



;; (use-package flymake-python-pyflakes
;;   :config
;;   (setq flymake-python-pyflakes-executable "flake8")
;;   (setq flymake-python-pyflakes-extra-arguments '("--ignore=W806"))
;;   (add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
;;   )
                  
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
	((company-dabbrev company-clang company-semantic company-keywords company-capf)
	 company-capf company-bbdb company-nxml company-css company-cmake company-files
	 (company-gtags company-etags)
	 company-oddmuse)))
 '(custom-safe-themes
   (quote
	("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(elpy-rpc-python-command "python3")
 '(elpy-rpc-timeout 5)
 '(elpy-syntax-check-command "/usr/local/bin/flake8")
 '(flycheck-checkers
   (quote
	(python-pycompile ada-gnat asciidoctor asciidoc c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint css-stylelint cuda-nvcc cwl d-dmd dockerfile-hadolint emacs-lisp emacs-lisp-checkdoc erlang-rebar3 erlang eruby-erubis fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck go-unconvert go-megacheck go-staticcheck groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy javascript-eslint javascript-jshint javascript-standard json-jsonlint json-python-json json-jq jsonnet less less-stylelint llvm-llc lua-luacheck lua markdown-markdownlint-cli markdown-mdl nix nix-linter opam perl perl-perlcritic php php-phpmd php-phpcs processing proselint protobuf-protoc pug puppet-parser puppet-lint python-flake8 python-pylint python-pycompile python-mypy r-lintr racket rpm-rpmlint rst-sphinx rst ruby-rubocop ruby-reek ruby-rubylint ruby ruby-jruby rust-cargo rust rust-clippy scala scala-scalastyle scheme-chicken scss-lint scss-stylelint sass/scss-sass-lint sass scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim slim-lint sql-sqlint systemd-analyze tcl-nagelfar tex-chktex tex-lacheck texinfo textlint typescript-tslint verilog-verilator vhdl-ghdl xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby clang-analyzer)))
 '(flycheck-python-flake8-executable
   "/Library/Frameworks/Python.framework/Versions/3.6/bin/flake8")
 '(flymake-gui-warnings-enabled nil)
 '(gofmt-show-errors (quote buffer))
 '(indent-tabs-mode t)
 '(jdee-jdk-registry
   (quote
	(("1.8" . "/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home"))))
 '(jdee-server-dir "/Users/chenfeng/.emacs.d/jdee-server")
 '(menu-bar-mode nil)
 '(ns-auto-hide-menu-bar nil)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (python . t))))
 '(org-export-use-babel nil)
 '(package-selected-packages
   (quote
	(company-tabnine flycheck-mypy flycheck-pyflakes ob-go ob-swift ob-ipython jupyter helm-dired-recent-dirs dired-recent org-download org-mode flycheck-irony flycheck-clang-analyzer company-lsp lsp-ui dap-mode lsp-mode realgud-ipdb realgud-jdb realgud-lldb ivy counsel-etags helm-etags-plus ox-pandoc projectile-speedbar cnfonts ipython-shell-send live-py-mode doom-themes doom-modeline simpleclip markdown-toc js-comint osx-browse zencoding-mode company-web-html company-web-jade company-web vue-mode swift3-mode helm-swoop helm-fuzzier ace-jump-helm-line helm avy ace-isearch evil-leader auctex markdown-mode+ markdown-preview-eww dash-at-point ein helm-pydoc pydoc pydoc-info flymake javadoc-lookup w3m xwidgete ace-jump-mode realgud nyan-mode elpy pylint web-mode use-package swiper-helm spacemacs-theme spacemacs-common smartparens smart-mode-line shift-text request-deferred replace-symbol real-auto-save paredit-everywhere osx-lib markdown-mode magit js2-mode irony ioccur helm-smex helm-projectile helm-gtags helm-c-yasnippet helm-c-moccur helm-ag go-mode ggtags function-args flycheck-pos-tip flx-isearch flx-ido find-file-in-project f evil-surround crux company-statistics company-c-headers bash-completion anaphora ace-window)))
 '(python-indent-offset 4)
 '(safe-local-variable-values (quote ((mangle-whitespace . t))))
 '(tab-always-indent t)
 '(tab-width 4))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-warning ((t nil))))




;; java kdbs
(define-key java-mode-map (kbd "H-r") 'iterm-java)
(define-key java-mode-map (kbd "C-c r") 'run-java-Main)

;; find and search and replace
;; (global-set-key (kbd "M-j") 'evil-find-char)
(global-set-key (kbd "C-s") 'swiper)

;;jupyter
;; (use-package ein
;;   :config
;;   (add-hook ein:notebook-multilang-mode-hook )

;; (use-package ein
;;   :config
;; (define-key ein:notebook-multilang-mode-map (kbd "<C-return>") 'ein:worksheet-execute-cell)
;; (define-key  ein:notebook-multilang-mode-map (kbd "H-s") 'ein:notebook-save-notebook-command))

;; (use-package nodejs-repl
;;   :config
;;   (add-hook 'js2-mode-hook
;;             (lambda ()
;;               (define-key js2-mode-map (kbd "H-e") 'nodejs-repl-send-last-expression)
;;               (define-key js2-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
;;               (define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
;;               (define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl))))

(use-package js-comint
  :config
  (add-hook 'js2-mode-hook
            (lambda ()
			  (define-key js2-mode-map (kbd "H-e") 'js-send-last-sexp)
			  (define-key js2-mode-map (kbd "H-E") 'js-send-region)
			  (define-key js2-mode-map (kbd "H-r") 'js-send-buffer)
  )))

(global-set-key (kbd "H-d") 'dired)




(use-package ivy
  :config
  (global-set-key (kbd "C-t") 'counsel-etags-grep))


;; (use-package company-lsp
;;     :config
;;     ;; 设置 company-lsp 为后端
;;     (push 'company-lsp company-backends))


;; (use-package lsp-ui
;;     :init
;;     ;; 启用 lsp-ui
;;     (add-hook 'lsp-mode-hook 'lsp-ui-mode)
;;     ;; 启用 flycheck
;;     (add-hook 'python-mode-hook 'flycheck-mode))


;; (lsp-register-client
;;  (make-lsp-client :new-connection (lsp-stdio-connection "pyls")
;;                   :major-modes '(python-mode)
;;                   :server-id 'pyls))


(use-package org
  :config
  (require 'ob-ipython)
  (require 'ob-go)
  (auto-image-file-mode 1)
  (defun insert-current-time () 
    "Insert the current time" 
    (interactive "*") 
    (insert (current-time-string)))
  (global-set-key (kbd "C-c i") 'insert-current-time)
  (require 'org-download)
  (setq org-startup-with-inline-images t)
  ;; (org-display-inline-image)
  (define-key org-mode-map   (kbd "C-,") 'crux-switch-to-previous-buffer)
  ;; (setq python-shell-interpreter "python")
  (org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   ;; (julia . t)
   (go . t)
   (python . t)
   (ipython . t)
   ;; (jupyter . t)))
   ))

  (setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block

;;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
  )


(require 'dired-recent)
(dired-recent-mode 1)


(global-set-key (kbd "H-k") 'kill-buffer-and-window)
(global-set-key (kbd "M-k") 'kill-this-buffer)


;; (global-set-key (kbd "<f1>-k") 'counsel-descbinds)
;; (use-package ox-ipynb)
;; (require 'ox-ipynb)
