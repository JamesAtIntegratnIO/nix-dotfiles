(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(use-package vscode-dark-plus-theme
  :ensure t
  :config
  (load-theme 'vscode-dark-plus t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company-terraform terraform-doc terraform-mode yaml-mode rainbow-delimiters go-scratch go-guru go-rename go-impl yasnippet go-mode nix-mode all-the-icons neotree emacs-neotree vscode-dark-plus-theme dired-sidebar)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package neotree
  :ensure t
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (global-set-key [f8] 'neotree-toggle)
  )

;; Run this on a fresh install to ensure all fonts for all-the-icons are installed
;; M-x all-the-icons-install-fonts
(use-package all-the-icons :ensure t)

;; START Language Modes
;; Nixos
(use-package nix-mode :ensure t)

;; golang
(use-package go-mode
  :ensure t
  :init
  (setenv "PATH" "$GOPATH/bin:$PATH" t)
  (setenv "CDPATH" ".:$GOPATH/src/github.com/:$GOPATH/src" t)
  (add-hook 'go-mode-hook '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
  (add-hook 'go-mode-hook '(lambda () (setq tab-width 4)))
  (add-hook 'before-save-hook #'gofmt-before-save)
  :config
  (setq gofmt-command "goimports") ;; use goimports for more better gofmting
  ;; (setq gofmt-args '("-local" "github.corporate.network"))
  (put 'go-play-buffer 'disabled t)
  (put 'go-play-region 'disabled t)
  )

(use-package yasnippet :ensure t)

(use-package go-impl :ensure t :after (go-mode))

(use-package go-rename :ensure t :after (go-mode))

(use-package go-guru
  :ensure t
  :after (go-mode)
  :hook ((go-mode . go-guru-hl-identifier-mode))
  :config
  (setq go-guru-build-tags '("servicetest"))
  )

(use-package go-scratch :ensure t :after go-mode)

;; terraform
(use-package terraform-mode
  :ensure t
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)
  )

(use-package terraform-doc :ensure t)

(use-package company-terraform
  :ensure t
  :after (terraform-mode)
  :hook ((terraform-mode . company-mode))
  )

;; yaml
(use-package yaml-mode :ensure t)
;; END Language Modes

(use-package rainbow-delimiters
  :ensure t
  :hook
  (((lisp-mode emacs-lisp-mode clojure-mode common-lisp-mode go-mode) . rainbow-delimiters-mode))
  )


