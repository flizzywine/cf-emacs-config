
(defun get-file-dir-or-home ()
  "If inside a file buffer, return the directory, else return home"
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
	"~/"
    (file-name-directory filename))))

(defun iterm-goto-filedir-or-home ()
  "Go to present working dir and focus iterm"
  (interactive)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"
    (format "     write text \"cd %s\" \n" (get-file-dir-or-home))
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    ))
  )

(defun cf-run-lang (command &optional hook)
  (progn
	(save-buffer)
	(iterm-goto-filedir-or-home)
	(do-applescript 
	 (concat
	  " tell application \"iTerm2\"\n"
	  "   tell the current session of current window\n"
	  (format "   write text \"%s %s\" \n" command (file-name-nondirectory (buffer-file-name)))
	  "   end tell\n"
	  " end tell\n"
	  " do shell script \"open -a iTerm\"\n"
      ))))


(defun cf-run-command (command &optional hook)
  (progn
	(save-buffer)
	(iterm-goto-filedir-or-home)
	(do-applescript 
	 (concat
	  " tell application \"iTerm2\"\n"
	  "   tell the current session of current window\n"
	  (format "   write text \"%s \" \n" command)
	  "   end tell\n"
	  " end tell\n"
	  " do shell script \"open -a iTerm\"\n"
      ))))



(use-package web-mode
  :config
  
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.wxml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.wxss\\'" . css-mode))
  (require 'osx-browse)
  (osx-browse-mode 1)
  (define-key web-mode-map (kbd "H-r") 'run-in-browser)
  (require 'zencoding-mode)
  (add-hook 'sgml-mode-hook 'zencoding-mode)
  (define-key web-mode-map (kbd "C-i") 'zencoding-expand-yas)
  (define-key web-mode-map (kbd "C-c C-s") 'yas-expand)
  (require 'css-mode)
  
  ;; (zencoding-expand-yas)
;; Auto-start on any markup modes
)

  
(use-package company-web
  :config
  (require 'company-web-html)
  (require 'company-web-jade))


(use-package js2-mode
  :config
  (defun cf-run-nodejs ()
	(interactive)
	(cf-run-lang "node"))
  (define-key js2-mode-map (kbd "h-R") 'cf-run-nodejs)
  (defun run-in-browser ()
	(interactive)
	(progn
	  (save-buffer)
	  (xah-open-in-external-app)))
  (define-key js2-mode-map (kbd "H-r") 'run-in-browser)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js2-strict-missing-semi-warning nil)
  )



(use-package cc-mode
  :config
  (defun cf-run-cpp ()
	(interactive)
	(cf-run-lang "c++ -Wno-c++11-extensions -g -std=c++11 "))
  (defun cf-debug-cpp ()
	(interactive)
	(cf-run-command "lldb ./a.out"))
  (define-key c++-mode-map (kbd "H-r") 'cf-run-cpp)
  (define-key c++-mode-map (kbd "C-<f5>") 'cf-run-cpp)
  )


(use-package go-mode
  :config
  (defun cf-run-go ()
	(interactive)
	(cf-run-lang "go run "))
  (define-key go-mode-map (kbd "H-r") 'cf-run-go)
  )



(defun cf-run-java ()
  (interactive)
  (progn (save-buffer)
		 (iterm-goto-filedir-or-home)
		 (do-applescript
		  (concat
		   " tell application \"iTerm2\"\n"
		   "   tell the current session of current window\n"
		   
		   (format "    write text \"%s \"\n"
				   (concat "javac -g " (file-name-nondirectory (buffer-file-name))))
		   (format "   write text \"java -ea %s\" \n"
				   (substring (file-name-nondirectory (buffer-file-name))
							  0
							  (- (length (file-name-nondirectory (buffer-file-name))) 5)))
		   "   end tell\n"
		   " end tell\n"
		   " do shell script \"open -a iTerm\"\n"
		   ))
		 ))




(defun cf-run-java-package ()
  (interactive)
  (progn
	(save-buffer)
	(iterm-goto-filedir-or-home)
	(do-applescript 
	 (concat
	  " tell application \"iTerm2\"\n"
	  "   tell the current session of current window\n"

	  (format "     write text \"cd %s\" \n" (get-file-dir-or-home))
	  (format "   write text \"javac -d . -g *.java\" \n" )
	  (format "   write text \"java login.%s\" \n" 	(substring (file-name-nondirectory (buffer-file-name))
  					   0
  					   (- (length (file-name-nondirectory (buffer-file-name))) 5)))
	  "   end tell\n"
	  " end tell\n"
	  " do shell script \"open -a iTerm\"\n"
      ))))



(defun disable-breakpoint ()
  (interactive)
  (replace-regexp "import ipdb" "# import ipdb" nil (point-min) (point-max))
  (replace-regexp "ipdb.set_trace()" "# ipdb.set_trace()" nil (point-min) (point-max)))

(defun enable-breakpoint ()
  (interactive)
  (replace-regexp "# import ipdb" "import ipdb" nil (point-min) (point-max))
  (replace-regexp "# ipdb.set_trace()" "ipdb.set_trace()" nil (point-min) (point-max)))


(setq-default tab-width 4)

 (use-package elpy
   :config
   (elpy-enable)
   (setq-default tab-width 4)
   (setq-default python-indent 4)
   (setq indent-tabs-mode nil)
   (define-key python-mode-map (kbd "H-;") 'elpy-autopep8-fix-code)
   (define-key python-mode-map (kbd "C-o") 'elpy-open-and-indent-line-below)
   (define-key python-mode-map (kbd "C-S-o") 'elpy-open-and-indent-line-above)
   ;; (define-key python-mode-map (kbd "M-<return>") 'ipython-shell-send-region)
   ;; (define-key python-mode-map (kbd "M-<return>") 'ein:worksheet-execute-cell-and-goto-next)
   ;; (define-key python-mode-map (kbd "H-<return>") 'ipython-shell-send-defun)
   (defun cf-run-python ()
	 (interactive)
	 (elpy-autopep8-fix-code)
	 (cf-run-lang "ipython3 --pdb"))
   (defun cf-debug-python ()
	 (interactive)
	 (elpy-autopep8-fix-code)
	 (cf-run-lang "ipdb"))
  (define-key python-mode-map (kbd "H-r") 'cf-run-python)
  (define-key python-mode-map (kbd "H-d") 'cf-debug-python)
 
 (setq elpy-rpc-python-command "python3")

 (setenv "PYTHONPATH" (shell-command-to-string "$SHELL --login -c 'echo -n $PYTHONPATH'"))
 (set-variable 'python-indent-offset 4)
 ;; (setq python-shell-interpreter "ipython")


 ;; (require 'flycheck-mypy)
 ;; (flycheck-select-checker "python-mypy")
)



(provide 'prog-languages)
