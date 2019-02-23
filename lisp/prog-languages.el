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



;;java
(defun cf-java-package ()
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



 (use-package elpy
   :config
   (elpy-enable)
   (setq indent-tabs-mode nil)
  (define-key python-mode-map (kbd "C-'") 'elpy-autopep8-fix-code)
  ;; (define-key python-mode-map (kbd "RET") 'cf-RET-for-python)
  (define-key python-mode-map (kbd "H-r") 'cf-run-python)
  (define-key python-mode-map (kbd "H-d") 'cf-debug-python)
  (define-key python-mode-map (kbd "H-=") 'elpy-doc)
   ;; (setq elpy-rpc-python-command "python3")
  ;; (setq python-check-command "/usr/local/bin/pyflakes")
 ;;(elpy-use-ipython "ipython3")
 (setq elpy-rpc-python-command "python3")
 ;; (define-key elpy-mode-map (kbd "H-[") 'elpy-indent-shift-left)
 ;; (define-key elpy-mode-map (kbd "H-]") 'elpy-indent-shift-right)
 ;; (define-key elpy-mode-map (kbd "H-r") 'elpy-shell-send-region-or-buffer)
 ;; 'r' can't be upcase, I don't know why
 (define-key elpy-mode-map (kbd "H-e") 'elpy-shell-send-current-statement)
 (setenv "PYTHONPATH" (shell-command-to-string "$SHELL --login -c 'echo -n $PYTHONPATH'"))
 (setq python-shell-interpreter "ipython3"
       python-shell-interpreter-args "--simple-prompt -i")
 (set-variable 'python-indent-offset 4)

;;  (defun cf-RET-for-python ()
;;    (interactive)
;;    (progn
;; 	 (newline-and-indent)
;; 	 (setq pos (point))
;; 	 (elpy-autopep8-fix-code)
;; 	 (goto-char pos)
;; 	 ))
;;  (defun cf-TAB-for-python ()
;;    (interactive)
;;    (progn
;; 	 (indent-for-tab-command)
;; 	 (elpy-autopep8-fix-code)
;; ))
 
(defun cf-run-python ()
  (interactive)
  (progn
	(elpy-autopep8-fix-code)
	(save-buffer)
	(do-applescript 
	 (concat
	  " tell application \"iTerm2\"\n"
	  "   tell the current session of current window\n"

	  (format "     write text \"cd %s\" \n" (get-file-dir-or-home))
	  (format "   write text \"ipython3 %s\" \n" (file-name-nondirectory (buffer-file-name)))
	  "   end tell\n"
	  " end tell\n"
	  " do shell script \"open -a iTerm\"\n"
      ))))

 
(defun cf-debug-python ()
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
)
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


(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode)))

(use-package js2-mode

  :config
  (defun cf-run-nodejs ()
	(interactive)
	(cf-run "node"))
  (define-key js2-mode-map (kbd "H-r") 'cf-run-nodejs)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js2-strict-missing-semi-warning nil)
  )

;;C/C++
;; (defun cf-compile-cpp ()
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



(defun iterm-java-run-Main-class ()
  "Go to present working dir and focus iterm"
  (interactive)
  (progn
	(save-buffer)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"
    "     write text \"rm *.class\" \n"
    "     write text \"javac -g *.java\" \n"
    "     write text \"java -ea Main\" \n"
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    )))
  )

(global-set-key (kbd "C-c r") 'iterm-java-run-Main-class)

(defun iterm-debug-jdb ()
  "Go to present working dir and focus iterm"
  (interactive)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"
	 (format "   write text \"rm %s.class\" \n"
			(substring (file-name-nondirectory (buffer-file-name))
					   0
					   (- (length (file-name-nondirectory (buffer-file-name))) 5)))
					
	(format "    write text \"%s \"\n"
			(concat "javac -g " (file-name-nondirectory (buffer-file-name))))
    (format "   write text \"java -ea  %s\" \n"
			(substring (file-name-nondirectory (buffer-file-name))
					   0
					   (- (length (file-name-nondirectory (buffer-file-name))) 5)))
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
(defun cf-iterm-cpp ()
  (interactive)
  (progn (save-buffer)
		 (iterm-goto-filedir-or-home)
		 (shell-command (concat "c++ -Wno-c++11-extensions -g -std=c++11 " (file-name-nondirectory (buffer-file-name))))
		 (iterm-debug-lldb)))

(define-key c++-mode-map (kbd "H-r") 'cf-iterm-cpp)



(defun cf-iterm-java ()
  (interactive)
  (progn (save-buffer)
		 (iterm-goto-filedir-or-home)
		 (iterm-debug-jdb)))
(define-key java-mode-map (kbd "H-r") 'cf-iterm-java)


(defun cf-open-finder ()
  (interactive)
  (iterm-goto-filedir-or-home)
  (do-applescript 
   (concat
    " tell application \"iTerm2\"\n"
    "   tell the current session of current window\n"
	"     write text \"open .\" \n" 
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    )))

(global-set-key (kbd "H-I") 'cf-open-finder)


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
