;; Allows various things
(server-start)

;; This is only needed once, near the top of the file
;; REALLY IMPORTANT DO NOT CHANGE
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)
;; REALLY IMPORTANT DO NOT CHANGE

;; Appearance
(set-face-attribute 'default nil :font "Fira Code Retina" :height 120)

;; Customization
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" default))
 '(exwm-floating-border-color "#504945")
 '(fci-rule-color "#7c6f64")
 '(highlight-tail-colors ((("#363627" "#363627") . 0) (("#323730" "#323730") . 20)))
 '(indent-tabs-mode nil)
 '(ispell-dictionary nil)
 '(jdee-db-active-breakpoint-face-colors (cons "#0d1011" "#fabd2f"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d1011" "#b8bb26"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d1011" "#928374"))
 '(objed-cursor-color "#fb4934")
 '(package-selected-packages
   '(lsp-ui rustic exec-path-from-shell lsp-mode tree-sitter-langs tree-sitter rust-mode doom-themes counsel ivy-rich which-key doom-modeline command-log-mode doom-line doom-mode-line ivy no-littering helpful use-package))
 '(pdf-view-midnight-colors (cons "#ebdbb2" "#282828"))
 '(rustic-ansi-faces
   ["#282828" "#fb4934" "#b8bb26" "#fabd2f" "#83a598" "#cc241d" "#8ec07c" "#ebdbb2"])
 '(vc-annotate-background "#282828")
 '(vc-annotate-color-map
   (list
    (cons 20 "#b8bb26")
    (cons 40 "#cebb29")
    (cons 60 "#e3bc2c")
    (cons 80 "#fabd2f")
    (cons 100 "#fba827")
    (cons 120 "#fc9420")
    (cons 140 "#fe8019")
    (cons 160 "#ed611a")
    (cons 180 "#dc421b")
    (cons 200 "#cc241d")
    (cons 220 "#db3024")
    (cons 240 "#eb3c2c")
    (cons 260 "#fb4934")
    (cons 280 "#e05744")
    (cons 300 "#c66554")
    (cons 320 "#ac7464")
    (cons 340 "#7c6f64")
    (cons 360 "#7c6f64")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Clean up interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)

;; Tabs
(setq tab-always-indent 'complete)
(setq align-to-tab-stop nil)

;; Bind escape to quit
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;; Packages
(use-package helpful)
(use-package no-littering)
(use-package command-log-mode)
(use-package swiper)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package doom-themes)

;; IDE stuff
(use-package exec-path-from-shell)
(add-to-list 'exec-path "~/.cargo/bin/")

;; LSP mode
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

;; Alternative LSP mode
;; (use-package lsp-mode)
;; (add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))

;; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Enrich the M-x menu and describe commands
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; Alternative to built-in emacs help commands
(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Theme
(load-theme 'doom-gruvbox)

;; Rust support
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

;; Alternative Rust support
;; (use-package rust-mode)
;; (add-hook 'rust-mode-hook ; Always use spaces for indentation in Rust code
;;           (lambda () (setq indent-tabs-mode nil)))
;; (setq rust-format-on-save t) ; Automatic formatting on save
;; (add-hook 'rust-mode-hook 'eglot-ensure) ; eglot hook
;; (add-hook 'rust-mode-hook #'lsp) ; lsp hook

;; Syntax highlighting
(use-package tree-sitter
  :config
  (use-package tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
