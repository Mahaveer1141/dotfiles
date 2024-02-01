(setq make-backup-files nil) ; stop creating ~ files
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(global-font-lock-mode 1)

(add-to-list 'default-frame-alist '(alpha 85 85))

(set-face-attribute 'default nil :background "black"
  :foreground "white" :font "Courier" :height 180)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes '(midnight))
 '(custom-safe-themes
   '("bede4793dbcd5a4eab51ec6d23faf85c021ebcd420a485c2e1cd9b903040a7cc" "4183472e3f293413b6c97e22e0e8b4a91d08384e112cae7e36c01873c1e99083" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "7d23729342514203c5a1dc4c8f1f67d96ac65f660dd73cb8c6bfffc8eba79804" "fd2e5ccbd6a13cc87cd66fbe639dc352637df009ec505e76201c2b0ef0194703" default))
 '(display-time-mode t)
 '(fringe-mode 0 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq visible-bell t)
(setq inhibit-startup-message t)
(mouse-avoidance-mode 'animate)

(global-font-lock-mode 1)
(setq column-number-mode t)
(setq size-indication-mode t)
(setq default-fill-column 100)
(setq default-tab-width 4)
;;(setq-default indent-tabs-mode nil)

(set-face-background 'fringe "#809088")

(setq echo-keystrokes -1)

(blink-cursor-mode 0)
(tooltip-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(show-paren-mode 1)
(setq show-paren-style 'parenthese)
;; (set-face-foreground 'show-paren-match "green")
;; (set-face-foreground 'show-paren-mismatch "red")
;; (set-face-bold-p 'show-paren-match t)
;; (set-face-bold-p 'show-paren-mismatch t)
;; (set-face-background 'show-paren-match nil)
;; (set-face-background 'show-paren-mismatch nil)

(fset 'yes-or-no-p 'y-or-n-p)
(setq frame-title-format '(:eval (or (buffer-file-name) (buffer-name))))
(setq resize-mini-windows t)
(auto-image-file-mode t)

(display-time)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

(setq default-frame-alist '((height . 40) (width . 110) (font . "Monospace-13")))
(set-fontset-font "fontset-default" 'gb18030 '("Microsoft YaHei" . "unicode-bmp"))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(load-theme 'midnight)

(defun code-compile ()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
     (let ((file (file-name-nondirectory buffer-file-name)))
       (format "%s -std=c++17 -o %s %s"
           (if  (equal (file-name-extension file) "cpp") "g++" "gcc" )
           (file-name-sans-extension file)
           file)))
    (compile compile-command)))

(global-set-key [f9] 'code-compile)

(defun smart-run ()
  "Run programs according to mode."
  (interactive)
  (let* ((filename (file-name-nondirectory buffer-file-name))
         (executable (file-name-sans-extension filename))
         (runbuffer (get-buffer-create (concat "*" executable "*")))
         command args)
    (message (concat "Running " executable))
    (cond ((or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
           (setq command (concat "./" executable)))
          ((or (eq major-mode 'java-mode) (eq major-mode 'jde-mode))
           (setq command "java")
           (setq args (list executable))))
    (save-excursion
      (set-buffer runbuffer)
      (erase-buffer)
      (insert (concat "default-directory: " default-directory "\n"))
      (insert (concat "\n" command " " (mapconcat (lambda (arg) arg)
                                                  args " ") "\n\n"))
      (comint-mode))
    (comint-exec runbuffer executable command nil args)
    (pop-to-buffer runbuffer)))

(global-set-key [f10] 'smart-run)
