(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(when (display-graphic-p)
  (progn
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (set-frame-font "Monaco 14")
    (toggle-frame-maximized)))

(setq inhibit-startup-screen t)

(fset 'yes-or-no-p 'y-or-n-p)

(global-linum-mode 1)
(setq linum-format "%3d ")

(setq column-number-mode t)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-day t))

(use-package paredit
  :ensure t
  :hook ((clojure-mode cider-repl-mode) . paredit-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook (clojure-mode . rainbow-delimiters-mode))

(use-package clojure-mode
  :ensure t)

(use-package cider
  :ensure t)

(use-package clj-refactor
  :ensure t
  :hook (clojure-mode . clj-refactor-mode))

(use-package yasnippet
  :hook (clojure-mode . yas-minor-mode))

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  :config
  (global-company-mode))
