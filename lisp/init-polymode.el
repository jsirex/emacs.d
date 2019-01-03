
;; Polymode allows us to have multiple major modes in same buffer

(use-package polymode)

(use-package poly-markdown
  :mode ("\\.md\\'" . poly-markdown-mode))

(use-package poly-org
  :disabled t
  :mode ("\\.org\\'" . poly-org-mode))


;; Polymode for Ansible: Jinja2 + Yaml
(use-package poly-ansible
  :mode ("\\.yml\\'" . poly-ansible-mode))


;; Ruby ERB
;; TODO: configure it
(use-package poly-erb
  :mode (("\\.coffee\\.erb\\'" . poly-coffee+erb-mode)
         ("\\.js\\.erb\\'" . poly-js+erb-mode))
         ("\\.html\\.erb\\'" . poly-html+erb-mode))


(provide 'init-polymode)
