;; Do not show startup screen
(setq inhibit-startup-message t
      visible-bell t ) 
      
;; Basic configuration
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display line numbers
(global-display-line-numbers-mode 1)

;; Load a theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;; Higlight line
;;(hl-line-mode 1)

;; Blinking cursor
(blink-cursor-mode 1)

;; Enable transient mark mode
(transient-mark-mode 1)

;; Used for exporting to HTML
(setq org-src-fontify-natively t)
(setq org-html-htmlize-output-type 'nil)


;; Enable org mode
(require 'org)
;;(require 'helm)

(setq default-directory "~/Sync/org/")

;; Define the directory and files used
(setq org-directory "~/Sync/org/")
;;(setq org-agenda-files (list "~/Sync/org/inbox.org" "~/Sync/org/agenda.org"))
(setq org-agenda-files 
      (mapcar 'file-truename 
          (file-expand-wildcards "~/Sync/org/*.org")))


(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)


;; Define the capture template
(setq org-capture-templates
      '(
	("t" "ToDo" entry (file+headline "~/Sync/org/gtd.org" "Tasks")
	 "* TODO %?\n %i\n %a")
	("j" "Journal" entry (file+datetree "~/Sync/org/journal.org")
	 "* %?\n  Entered on %U\n %i\n %a")
	("i" "Inbox" entry (file "~/Sync/org/inbox.org")
	 "* TODO %?\n  Entered on %U\n %i\n %a")
	("m" "Meeting" entry (file+headline "~/Sync/org/agenda.org" "Future")
	 "* %? :meeting:\n <%<%Y-%m-%d %a %H:00>>" )
	("n" "Note" entry (file "~/Sync/org/notes.org")
	 "* Note (%a)\n  Entered on %U\n %?")
	)
)

;; Define the options of tasks
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)"  "IN-PROGRESS" "WAITING(w)" "DONE(d)")))

;; Record date when a task was 'activated'
(defun log-todo-next-creation-date (&rest ignore)
  "Log NEXT creation time in the property drawer under the key 'Activated'"
  (when (and (string= (org-get-todo-state) "NEXT")
	     (not (org-entry-get nil "ACTIVATED")))
    (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))
(add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)

(setq org-log-done 'time)


;; Show the agenda with a particular format
(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
	 ((agenda ""
		  ((org-agenda-skip-function
		    '(org-agenda-skip-entry-if 'deadline))
		   (org-deadline-warning-days 0)))
	  (todo "NEXT"
		((org-agenda-skip-function
		  '(org-agenda-skip-entry-if 'deadline))
		 (org-agenda-prefix-format " %i %-12:c [%e] ")
		 (org-agenda-overriding-header "\nTasks\n")
		 ))
	  (agenda nil
		  ((org-agena-entry-types '(:deadline))
		   (org-agenda-format-date "")
		   (org-deadline-warning-days 7)
		   (org-agenda-skip-function
		    '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
		   (org-agenda-overriding-header "\nDeadlines")))
	  (tags-todo "inbox"
		     ((org-agenda-prefix " %?-12t% s")
		      (org-agenda-overriding-header "\nInbox\n")))
	  (tags "CLOSED>=\"<today>\""
		((org-agenda-overriding-header "\nCompleted today\n")))
	  )
	 )
	)
)


;; Configure the refiling
;;(regexp-opt '("Tasks" "Notes"))

;; Save the corresponding buffers
(defun gtd-save-org-buffers ()
  "Save `org-agenda-files' buffers without user confirmation.
See also `org-save-all-org-buffers'"
  (interactive)
  (message "Saving org-agenda-files buffers...")
  (save-some-buffers t (lambda () 
             (when (member (buffer-file-name) org-agenda-files) 
               t)))
  (message "Saving org-agenda-files buffers... done"))


(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps t)
(setq org-refile-allow-creating-parent-nodes 'confirm)

(setq org-refile-targets
      '(("~/Sync/org/projects.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)"))
)
;;      '(("~/Sync/org/projects.org" :maxlevel . 4)))

;; Save files after refile
(advice-add 'org-refile :after
        (lambda (&rest _)
          (gtd-save-org-buffers)))




