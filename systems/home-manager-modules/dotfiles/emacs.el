(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
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


;; START ivy
(use-package ivy
  :demand
  :ensure t)
(use-package ivy-posframe
  :after (ivy)
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
(require 'ivy-posframe)
;; display at `ivy-posframe-style'
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
(ivy-posframe-mode 1)
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
(use-package eglot :ensure t)

(use-package company-shell
  :ensure t
  :hook ((sh-mode . company-mode))
  :config
  (add-to-list 'company-backends 'company-shell))

(use-package company
  :ensure t
  :delight " co"
  :hook
  (((emacs-lisp-mode go-mode) . company-mode))
  :config
  (add-to-list 'company-backends 'company-elisp)
  )

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


