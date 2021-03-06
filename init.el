;;设置toolbar为不可见

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar my/packages '(
		;; 自动完成       
		company
		;; 括号自动完成
		smartparens
		;; 删除
		hungry-delete
		;; 匹配
		swiper
		counsel
		;; js2-mode
		js2-mode
		;; themes
		solarized-theme
		;; speed-bar
		sr-speedbar
		;; 代码折叠
		hideshowvis
		;; 自动缩进
		auto-indent-mode
		;;
		protobuf-mode
		) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

;; 设置toolbar不可见
(tool-bar-mode -1)
;; 设置company为全局提示
(global-company-mode 1)
;; 设置光标为bar
(setq-default cursor-type 'bar)
;; 取消备份文件
(setq make-backup-files nil)
;; 取消启动页面
(setq inhibit-splash-screen 1)
;; 显示行号
(global-linum-mode 1)
;; 设置字体
(set-default-font "Courier 10 Pitch-12")

;; 设置最近文件
(require 'recentf)
(recentf-mode)
(setq recentf-max-menu-items 10)
;; 选择文本替换
(delete-selection-mode 1)
;; smartparens
(smartparens-global-mode 1)
;;当前行高亮
(global-hl-line-mode 1)
;; 括号匹配
(show-paren-mode 1)
;; 删除
(global-hungry-delete-mode 1)
;; 去掉滚动
(scroll-bar-mode -1)
;; 不显示菜单栏
;; (menu-bar-mode -1)
;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'hideshowvis-enable)
(hideshowvis-symbols)
;;
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; 加载主题
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'solarized-light t)
;; 按ctrl a的时候 回到有缩进的地方
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-x C-a") 'move-beginning-of-line)
;; 自动缩进
(auto-indent-global-mode)

;; 引入org mouse
(require 'org-mouse)

;; 设置org-mode自动换行
(add-hook 'org-mode-hook (lambda()(setq truncate-lines nil)))

;; org 导出md
(eval-after-load "org"
  '(require 'ox-md nil t))

;; 任务文件清单
(setq org-agenda-files (list "~/org/agenda"
                             ))
;; org-mode 添加todo关键词
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(d)" "PAUSE(p)" "|" "DONE(d)" "CANCELED(a)")
        ))

;; 定义转接 也就是将一个内容从一个文件移动到另一个文件中
(setq org-refile-targets (quote (("~/org/agenda/plan.org" :level . 1)
				 ("~/org/agenda/finish.org" :level . 1))))

;; 定义打开文件快捷键
(global-set-key (kbd "C-c i") (lambda() (interactive) (find-file "~/org/agenda/inbox.org")))
(global-set-key "\C-cp" (lambda() (interactive) (find-file "~/org/agenda/plan.org")))
(global-set-key "\C-cf" (lambda() (interactive) (find-file "~/org/agenda/finish.org")))
(global-set-key (kbd "<f5>") (lambda() (interactive) (find-file "~/.emacs.d/init.el")))

;; 设置agenda的快捷键
(global-set-key "\C-ca" 'org-agenda)

;; 在任务完成的时候 添加Closed时间
(setq org-log-done 'time)

;; org exec golang
(add-to-list 'load-path "~/.emacs.d/plugins/ob-go.el")
(require 'ob-go)

;; 设置org-table的字体 解决org-mode table中英文对不齐的问题
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-table ((t (:foreground "#6c71c4" :family "Ubuntu Mono")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" default)))
 '(org-agenda-files
   (quote
    ("~/org/note/ssl.org" "/home/danale/org/agenda/ann.org" "/home/danale/org/agenda/finish.org" "/home/danale/org/agenda/inbox.org" "/home/danale/org/agenda/plan.org")))
 '(speedbar-default-position (quote left))
 '(sr-speedbar-auto-refresh nil)
 '(sr-speedbar-right-side nil)
 '(tool-bar-mode nil))

