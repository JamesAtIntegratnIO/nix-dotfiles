(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(package-install 'use-package)
(require 'use-package)

;; customizations are now session-local
(setq custom-file (make-temp-file "emacs-custom"))

;; START org-mode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; babel config

;; active Babel languages
(org-babel-do-load-languages
'org-babel-load-languages
'((shell . t)))
;; END org-mode

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
;; START treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)
;; END treemacs

(use-package direnv
  :ensure t
  :hook
  ((prog-mode) . direnv-update-environment)
  :config (direnv-mode t)
  )

;; START ivy
(use-package ivy
  :demand
  :ensure t)

(use-package swiper
  :ensure t
  :after ivy)
(use-package counsel
  :after ivy
  :ensure t
  :config (counsel-mode 1))

(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
;; END ivy

(use-package multiple-cursors :ensure t)
;; use C-space or C-@ to set a good mark
;; use one of the below commands to create multiple cursors
;; C-g to unset mark
;; begin typing
;; C-j to create new line (RET will exit multi-cursor)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Run this on a fresh install to ensure all fonts for all-the-icons are installed
;; M-x all-the-icons-install-fonts
(use-package all-the-icons :ensure t)
(use-package magit :ensure t)

;; set the backup directory somewhere sane
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))
;; Set longer retention of backups now that they have a good home
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
;; put autosaves in a sane directory
(setq auto-save-file-name-transforms
  `((".*" ,(concat user-emacs-directory "autosaves"))))

;; START Language Modes
;; Eglot
;;(use-package eglot
;;  :ensure t
;;  :config
;}  (add-hook 'rust-mode-hook 'eglot-ensure)
;;  (add-hook 'go-mode-hook 'eglot-ensure)
;;  )

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

(electric-pair-mode 1)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-flake8-error-level-alist
	(quote (("^E9.*$" . error)
		("^F82.*$" . error)
		("^F83.*$" . error)
		("^D.*$" . info)
		("^N.*$" . info)
		("^E501$" . info))))
  (setq flycheck-flake8rc ".flake8")
  (setq flycheck-flake8-maximum-complexity 10)
  (setq flycheck-flake8-maximum-line-length 120)
  (add-hook 'python-mode-hook 'flycheck-mode)
  (add-hook 'rust-mode-hook 'flycheck-mode)
  (add-to-list 'flycheck-disabled-checkers 'python-flake8)
  (add-to-list 'flycheck-disabled-checkers 'python-pylint)
  )

(use-package rust-mode
  :ensure t
  :config
  (add-hook 'rust-mode-hook #'rust-enable-format-on-save)
  (add-hook 'rust-mode-hook
            (lambda () (setq indent-tabs-mode nil)))
  (add-hook 'rust-mode-hook
            (lambda () (prettify-symbols-mode)))
  (setq rust-format-on-save t))

(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

(use-package rust-playground
  :ensure t
  :after (rust-mode))

;;(use-package flycheck-rust
;;  :ensure t
;;  :after (rust-mode flycheck)
;;  :config
;;  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
;;  (add-hook 'rust-mode-hook #'flycheck-mode))

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last))
  (:map company-mode-map
	("<tab>". tab-indent-or-complete)
	("TAB". tab-indent-or-complete)))

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

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

(use-package go-complete
  :ensure t
  :init
  (add-hook 'completion-at-point-functions 'go-complete-atpoint))



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
  (((lisp-mode emacs-lisp-mode clojure-mode common-lisp-mode go-mode rust-mode) . rainbow-delimiters-mode))
  )


