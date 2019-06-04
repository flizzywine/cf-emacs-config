(defun cf-run (name)
  (interactive)
  (progn
	(save-buffer)
	(iterm-goto-filedir-or-home)
	(do-applescript 
	 (concat
	  " tell application \"iTerm2\"\n"
	  "   tell the current session of current window\n"

	  (format "     write text \"cd %s\" \n" (get-file-dir-or-home))
	  (format "   write text \"%s %s\" \n" name (file-name-nondirectory (buffer-file-name)))
	  "   end tell\n"
	  " end tell\n"
	  " do shell script \"open -a iTerm\"\n"
      ))))



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

;;(define-key java-mode-map (kbd "H-r") 'cf-run-java)


(defun iterm-java ()
  (interactive)
  (progn (save-buffer)
		 (iterm-goto-filedir-or-home)
		 (run-java)))




(defun run-java-Main ()
  "Go to present working dir and focus iterm"
  (interactive)
  (progn
	(save-buffer)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"
    "     write text \"rm bin/*.class\" \n"
    "     write text \"javac -g -d bin *.java\" \n"
    "     write text \"java -ea -cp bin Main\" \n"
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    )))
  )



(defun java-package ()
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


(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position))
  (exchange-point-and-mark)
  )
(global-set-key (kbd "M-H-l") 'select-current-line)


 (use-package elpy
   :config
   (elpy-enable)
   (setq indent-tabs-mode nil)
   (define-key python-mode-map (kbd "H-;") 'elpy-autopep8-fix-code)
   (define-key python-mode-map (kbd "C-o") 'elpy-open-and-indent-line-below)
   (define-key python-mode-map (kbd "C-S-o") 'elpy-open-and-indent-line-above)
   (define-key python-mode-map (kbd "M-<return>") 'ipython-shell-send-region)
   
   (define-key python-mode-map (kbd "H-<return>") 'ipython-shell-send-defun)
  ;; (define-key python-mode-map (kbd "RET") 'RET-for-python)
  (define-key python-mode-map (kbd "H-r") 'cf-run-python)
  (define-key python-mode-map (kbd "H-d") 'debug-python)
 
 (setq elpy-rpc-python-command "python3")

 (setenv "PYTHONPATH" (shell-command-to-string "$SHELL --login -c 'echo -n $PYTHONPATH'"))
 (set-variable 'python-indent-offset 4)
 (setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
              "jupyter")
)

(defun live-py3-mode ()
  (interactive)
  (live-py-set-version "python3")
  (live-py-mode))


 
(defun cf-run-python ()
  (interactive)
  (progn
	(elpy-autopep8-fix-code)
	(save-buffer)
	(iterm-goto-filedir-or-home)
	(do-applescript 
	 (concat
	  " tell application \"iTerm2\"\n"
	  "   tell the current session of current window\n"
	  (format "   write text \"ipython3 %s\" \n" (file-name-nondirectory (buffer-file-name)))
	  "   end tell\n"
	  " end tell\n"
	  " do shell script \"open -a iTerm\"\n"
      ))))




(defun debug-python ()
  (interactive)
  (progn
	(elpy-autopep8-fix-code)
	(save-buffer)
	(do-applescript 
	 (concat
	  " tell application \"iTerm2\"\n"
	  "   tell the current session of current window\n"

	  (format "     write text \"cd %s\" \n" (get-file-dir-or-home))
	  (format "   write text \"ipdb %s\" \n" (file-name-nondirectory (buffer-file-name)))
	  "   end tell\n"
	  " end tell\n"
	  " do shell script \"open -a iTerm\"\n"
      ))))

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode t)
        (setq-default tab-width 4)
        (setq-default python-indent 4)))


;;elpy ends here
(require 'cmuscheme)
(defun kh/get-scheme-proc-create ()
  "Create one scheme process if no one is created."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name))))

(defun kh/scheme-send-last-sexp ()
  "A replacement of original `scheme-send-last-sexp':
1. check if scheme process exists, otherwise create one
2. make sure the frame is splitted into two windows, current one is the scheme
   source code window, the other one is the scheme process window
3. run `scheme-send-last-sexp'

PS: this function is inspired by Wang Yin."
  (interactive)
  (kh/get-scheme-proc-create)
  (cond ((= 2 (count-windows))
         (other-window 1)
         (unless (string= (buffer-name)
                          scheme-buffer)
           (switch-to-buffer scheme-buffer))
         (other-window 1))
        (t
         (delete-other-windows)
         (split-window-vertically (floor (* 0.68 (window-height))))
         (other-window 1)
         (switch-to-buffer scheme-buffer)
         (other-window 1)))
  (scheme-send-last-sexp))
(defun scheme-local-key-binds ()
  (local-set-key (kbd "H-e") 'kh/scheme-send-last-sexp)
  (local-set-key (kbd "H-r") 'scheme-send-region))
(add-hook 'scheme-mode-hook
          'scheme-local-key-binds)


(defun run-js ()
  (interactive)
  (progn
	(save-buffer)
	(xah-open-in-external-app)))



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
 
  (require 'osx-browse)
  (osx-browse-mode 1)
  (define-key web-mode-map (kbd "H-r") 'run-js)
  (require 'zencoding-mode)
  (add-hook 'sgml-mode-hook 'zencoding-mode)
  (define-key web-mode-map (kbd "C-i") 'zencoding-expand-yas)
  (define-key web-mode-map (kbd "C-c C-s") 'yas-expand)
  (require 'css-mode)
  (add-to-list 'auto-mode-alist '("\\.wxss\\'" . css-mode))
  ;; (zencoding-expand-yas)
;; Auto-start on any markup modes
)

 ;; (add-to-list 'auto-mode-alist '("\\.wxss\\'" . web-mode))
  
(use-package company-web
  :config
  (require 'company-web-html)
  (require 'company-web-jade))



(use-package js2-mode

  :config
  (defun run-nodejs ()
	(interactive)
	(cf-run "node"))
  (define-key js2-mode-map (kbd "H-r") 'run-nodejs)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js2-strict-missing-semi-warning nil)
  )

;;C/C++
;; (defun compile-cpp ()
;;   (interactive)
;;   (save-buffer)
;;   (recompile-quietly))
  
;; (buffer-file-name)
;; (buffer-name)
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


(defun iterm-debug-lldb ()
  "Go to present working dir and focus iterm"
  (interactive)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"

    ;; (format "     write text \"cd %s\" \n" (get-file-dir-or-home))
    "   write text \"./a.out\" \n"
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    ))
  )
(defun iterm-cpp ()
  (interactive)
  (progn (save-buffer)
		 (iterm-goto-filedir-or-home)
		 (shell-command (concat "c++ -Wno-c++11-extensions -g -std=c++11 " (file-name-nondirectory (buffer-file-name))))
		 (iterm-debug-lldb)))

(define-key c++-mode-map (kbd "H-r") 'iterm-cpp)




(defun cf-make ()
  (interactive)
  (save-buffer)
  (do-applescript 
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"
	"     write text \"make \" \n" 
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    )))
(global-set-key (kbd "H-m") 'cf-make)


(provide 'prog-languages)
