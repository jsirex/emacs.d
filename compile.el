(require 'bytecomp)

(message "Compiling emacs files...")

(byte-recompile-file "early-init.el" nil 0)
(byte-recompile-file "init.el" nil 0)

(message "Done!")
