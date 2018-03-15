;; tt-mode
(load "/var/lib/myfrdcsa/codebases/minor/fcms/frdcsa/emacs/tt-mode/tt-mode.el")

(global-set-key "\C-cfclt" 'fcms-load-template-for-controller)

(setq auto-mode-alist (append '(("\\.tt$" . tt-mode)) auto-mode-alist ))
(setq auto-mode-alist (append '(("\\.tt2$" . tt-mode)) auto-mode-alist ))

(defun fcms-load-template-for-controller ()
 ""
 (interactive)
 (see
  (progn
   (string-match
    "^\/var\/lib\/myfrdcsa\/codebases\/minor\/fcms\/FCMS\/lib\/ShinyCMS\/Controller\/\\(.+?\\).pm$"
    buffer-file-name)
   (match-string 1 buffer-file-name))))
