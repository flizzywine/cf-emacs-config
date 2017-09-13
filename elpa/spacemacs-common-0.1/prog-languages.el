(elpy-enable)
(setq python-check-command nil)
(elpy-use-ipython "ipython")
(setq elpy-rpc-python-command "python3")  
(define-key elpy-mode-map (kbd "H-r") 'elpy-shell-send-region-or-buffer)
;; 'r' can't be upcase, I don't know why
(define-key elpy-mode-map (kbd "H-e") 'elpy-shell-send-current-statement)
(setenv "PYTHONPATH" (shell-command-to-string "$SHELL --login -c 'echo -n $PYTHONPATH'"))
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")


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
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode)))

(use-package js2-mode
  
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js2-strict-missing-semi-warning nil)
  ;; (define-key js2-mode-map (kbd "M-.") 'jump-to-mark))
  )

;;C/C++
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
    "    write text \"Y\"\n"
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
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n"
    ))
  )
(defun cf-iterm-cpp ()
  (interactive)
  (cf-compile-cpp)
  (iterm-debug-lldb))
 
(define-key c++-mode-map (kbd "H-r") 'cf-iterm-cpp)

(provide 'prog-languages)
