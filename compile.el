(message "Compiling emacs files!")
(require 'org)
(org-babel-tangle-file "README.org")
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))
(byte-compile-file "early-init.el")
(byte-compile-file "init.el")
(byte-compile-file "README.el")

;; Add here any additional files you want to compile
