;;; functions.el --- a config file to add some function

;; Copyright (c) 2006-2015 Claude Tete
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;

;; Keywords: config, function
;; Author: Claude Tete  <claude.tete@gmail.com>
;; Version: 6.0
;; Created: October 2006
;; Last-Updated: August 2015

;;; Commentary:
;;
;; load by `emacs.el' (where all requirements are defined)
;; REQUIREMENT: var     `section-functions'
;;
;; it need to be split...

;;; Change Log:
;; 2015-08-21 (6.0)
;;    add new web search + function to go in symref buffer
;; 2014-03-26 (5.9)
;;    add function to insert tag for reqtify in source code + remove old
;;    function of synergy
;; 2013-09-10 (5.8)
;;    add parameters and functions for synergy support
;; 2013-05-07 (5.7)
;;    condition on os detection for maximize function + do not run code for test
;; 2013-04-11 (5.6)
;;    add just-one-space-or-line function
;; 2013-03-29 (5.5)
;;    use url-hexify-string for web string + new function to indent function +
;;    add mixtab
;; 2013-02-05 (5.4)
;;    add function to get region or paragraph
;; 2012-12-27 (5.3)
;;    update dot emacs path + add bookmark in special buffer
;; 2012-11-30 (5.2)
;;    add switch to special buffer function
;; 2012-10-31 (5.1)
;;    try to use new navigate function (inconvenient)
;; 2012-10-26 (5.0)
;;    add double copy/kill (bind) will put in a register
;; 2012-10-18 (4.9)
;;    fix bug with resize window + try fix copy/kill with clipboard system
;; 2012-08-01 (4.8)
;;    add function to apply macro on region with same shortcut + add smart
;;    window resize + add change case on region with same shortcut + clean up
;; 2012-07-11 (4.7)
;;    add get line or region for interactive + split rtrt function file + try to
;;    fix annoying random behavior of completions buffer + fill region
;; 2012-07-09 (4.6)
;;    fix wait for fullscreen and add linux support + some test
;; 2012-06-26 (4.5)
;;    fix bug with mark about web search + add google
;; 2012-06-21 (4.4)
;;    add function to open web browser with text selected in Emacs + insert date
;;    + split ecb and clearcase function in new file +
;; 2012-06-14 (4.3)
;;    clean up
;; 2012-06-12 (4.2)
;;    change slick copy to more compatibility + add condition to eval some
;;    functions + remove hide/show function
;; 2012-06-08 (4.1)
;;    add slick copy (copy when not selected) + (un)comment + scroll without
;;    moving cursor + maximize function + some functions to test
;; 2012-06-05 (4.0)
;;    start to split + remove dead source code
;; 2012-05-29 (3.9)
;;    add function for integration with clearcase
;; 2012-05-14 (3.8)
;;    add function to improve tab key when hide show mode
;; 2012-05-03 (3.7)
;;    add function to checkout/diff/history file from clearcase + remove hippie
;;    expand custom
;; 2012-05-02 (3.6)
;;    add function about isearch, macro, windows swap + comment for fix
;;    fullscreen bug
;; 2012-03-29 (3.5)
;;    add function align with =
;; 2012-03-28 (3.4)
;;    translate comments in English and change old format
;; 2012-03-26 (3.3)
;;    fix bug with rtrt align
;; 2012-03-20 (3.2)
;;    add function for rtrt align and replace
;; 2012-03-12 (3.1)
;;    add conditions for each working environment
;; 2012-03-02 (3.0)
;;    add function occur-at-point
;; 2011-11-03 (2.9)
;;    add function to expand C macro per project
;; 2011-10-27 (2.8)
;;    change grep function per project to add list file
;; 2011-03-10 (2.7)
;;    add gtags function
;; 2010-12-02 (2.6)
;;    add dos2unix and unix2dos
;; 2010-11-19 (2.5)
;;    align regexp
;; 2010-11-03 (2.4)
;;    push line + search fault and tab
;; 2010-09-02 (2.3)
;;    insert tab + config
;; 2010-08-11 (2.2)
;;    select word + startup
;; 2010-07-09 (2.1)
;;    ecb
;; 2010-06-11 (2.0)
;;    grep
;; 2010-06-09 (1.6)
;;    etags
;; 2008-04-21 (1.5)
;;    insert header
;; 2008-03-10 (1.0)
;;    add printf for debug /* Kaneton :) */
;; 2006-10-13 (0.1)
;;    creation from scratch (no history since)


;;; Code:
;;;;  CONST
(defconst clt-symbol-regexp "[A-Za-z_][A-Za-z_0-9]*"
  "Regexp matching tag name.")

;;
;;;
;;;; FLAG DEBUG
;;; insert printf for debug (by Kevin Prigent)
;;   printf("\n"); //DEBUG
(defun printf-debug-shortcut ()
  "Insert a printf(\"n\"); //DEBUG."
  (interactive)
  (insert "printf(\"\\n\");//DEBUG")
  (indent-according-to-mode) (backward-char 12)
  )
;;; insert a test of macro for debug (by Kevin Prigent)
;;   #ifdef OUR_DEBUG
;;     \n
;;   #endif
(defun ifdef-debug-shortcut ()
  "Insert a #ifdef OUR_DEBUG."
  (interactive)
  (insert "#ifdef OUR_DEBUG\n"
      "\t\n"
      "#endif\n")
  (indent-according-to-mode) (backward-char 8)
  )

;;; insert a C comment to add tag for coverage
(defun tag-insert-shortcut ()
  "Insert a tag for coverage."
  (interactive)
  (let (my-module (my-buffer buffer-file-name))
    (when (string-match "/\\(...\\)[^/]*$" my-buffer)
      (setq my-module (upcase (match-string 1 my-buffer)))
      (beginning-of-line)
      (insert " /* -------------------------- */")
      (indent-according-to-mode)
      (insert "\n /* [COV.TAMBORIM_SDD_" my-module "_] */")
      (indent-according-to-mode)
      (insert "\n /* -------------------------- */")
      (indent-according-to-mode)
      (insert "\n")
      (search-backward my-module)
      (forward-char 4)
      )))

;;
;;;
;;;; SELECT WORD/REGION
;;; match a string (by Claude TETE)
(defun clt-match-string (n)
  "Match a string (N)."
  (buffer-substring (match-beginning n) (match-end n)))
;;; select the word at point (by Claude TETE)
(defun clt-select-word ()
  "Select the word under cursor."
  (cond
    ((looking-at "[0-9A-Za-z_]")
      (while (and (not (bolp)) (looking-at "[0-9A-Za-z_]"))
        (forward-char -1))
      (if (not (looking-at "[0-9A-Za-z_]")) (forward-char 1)))
    (t
      (while (looking-at "[ \t]")
        (forward-char 1))))
  (if (looking-at clt-symbol-regexp)
    (clt-match-string 0) nil)
  )
;;; interactive select word at point (by Claude TETE)
(defun select-word-under ()
  "Select the word under cursor."
  (interactive)
  (let (pt)
    (when (boundp 'auto-highlight-symbol-mode)
      (ahs-clear))
    (skip-chars-backward "-_A-Za-z0-9")
    (setq pt (point))
    (skip-chars-forward "-_A-Za-z0-9")
    (set-mark pt)
    )
  )
;;; get the string from word at point or region
(defun clt-get-string-position ()
  (let ()
    (if (use-region-p)
      (list (region-beginning) (region-end))
      (list (car (bounds-of-thing-at-point 'word)) (cdr (bounds-of-thing-at-point 'word)))
      )
    )
  )
;;; get the string from line at point or region
(defun clt-get-line-position ()
  (let ()
    (if (use-region-p)
      (list (region-beginning) (region-end))
      (list (line-beginning-position) (line-beginning-position 2))
      )
    )
  )
;;; get the string from line at point or region
(defun clt-get-paragraph-position ()
  (let ()
    (if (use-region-p)
      (list (region-beginning) (region-end))
      (let ((bds (bounds-of-thing-at-point 'paragraph)) )
        (list (car bds) (cdr bds)))
      )
    )
  )

;;
;;;
;;;; INDENT
;;; indent the whole function (thanks to http://emacsredux.com/blog/2013/03/28/indent-defun/)
(defun indent-defun ()
  "Indent the current defun."
  (interactive)
  (save-excursion
    (mark-defun)
    (indent-region (region-beginning) (region-end))))

;;
;;;
;;;; COPY/CUT
;;; Change cutting behavior (from http://emacswiki.org/emacs/WholeLineOrRegion):
(put 'kill-ring-save 'interactive-form
  '(interactive
     (if (use-region-p)
       (list (region-beginning) (region-end))
       (list (line-beginning-position) (line-beginning-position 2)))))
(put 'kill-region 'interactive-form
  '(interactive
     (if (use-region-p)
       (list (region-beginning) (region-end))
       (list (line-beginning-position) (line-beginning-position 2)))))
;;; Copy entire line in kill ring (without Home C-k C-y) (by Claude TETE)
(defun push-line ()
  "Select current line, push onto kill ring."
  (interactive)
  (save-excursion
    (copy-region-as-kill (re-search-backward "^") (re-search-forward "$"))
    )
  )
;;; from http://www.emacswiki.org/emacs/UnifyKillringAndRegister
;; [2006/02/10] kill-ring / register
(defun kill-ring-save-x (s e)
  (interactive "r")
  (if (eq last-command 'kill-ring-save-x)
      (call-interactively 'copy-to-register)
    (call-interactively 'kill-ring-save)))
(define-key esc-map "w" 'kill-ring-save-x)
;;;; [2006/02/25] kill-region / register
;;(defun kill-region-x (s e)
;; (interactive "r")
;;  (if (eq last-command 'kill-region)    ;kill-region-x ?
;;      (call-interactively 'my-kill-ring-to-register)
;;    (call-interactively 'kill-region)))
;;(defun my-kill-ring-to-register (register)
;;  (interactive "cCopy to register: ")
;;  (set-register register (car kill-ring)))
;;(define-key global-map "\C-w" 'kill-region-x)

;;
;;;
;;;; FILL
;; Change filling behavior
(put 'fill-region 'interactive-form
  '(interactive
     (if (use-region-p)
       (list (region-beginning) (region-end))
       (list (line-beginning-position) (line-beginning-position 2)))))

;;
;;;
;;;; SEARCH
;;; search the word at the point for the whole buffer (by Claude TETE
(defun occur-word-at-point ()
  "Search the word under cursor in the current buffer."
  (interactive)
  (let (word prompt input)
    (setq word (clt-select-word))
    (if word
      (setq prompt (concat "List lines matching regexp (default " word "): "))
      (setq prompt "List lines matching regexp: "))
    (setq input (completing-read prompt 'try-completion nil nil nil nil))
    (if (not (equal "" input))
      (setq word input))
    (occur word)
    )
  )
;;
;;; occur when incremental search (by Fabrice Niessen)
(defun isearch-occur ()
  "Invoke `occur' from within isearch."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))
;;
;;; incremental search the word at the point (from www.emacswiki.org)
;; I-search with initial contents
(defvar isearch-initial-string nil)
(defun isearch-set-initial-string ()
  "Set initialization of isearch."
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update)
  )
(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point (optional REGEXP-P and NO-RECURSIVE-EDIT)."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
            (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
        (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)
        )
      )
    )
  )
;; ---------------- matching word pairs ------------------
;; The idea here is that while emacs has built-in support for matching
;; things like parentheses, I work with a variety of syntaxes that use
;; balanced keyword pairs, such as "begin" and "end", or "#if" and
;; "#endif".  So this mechanism searches for the balanced element
;; of such ad-hoc constructions. (by Scott McPeak)
;;
;; TODO: Currently, there is no support for skipping things that are
;; in string literals, comments, etc.  I think that would be possible
;; just by having appropriate regexs for them and skipping them when
;; they occur, but I haven't tried yet.
(defun find-matching-element (search-func offset open-regex close-regex)
  "Search forwards or backwards (depending on `search-func') to find
   the matching pair identified by `open-regex' and `close-regex'."
  (let ((nesting 1)                ; number of pairs we are inside
        (orig-point (point))       ; original cursor loc
        (orig-case-fold-search case-fold-search))
    (setq case-fold-search nil)        ; case-sensitive search
    (goto-char (+ (point) offset))     ; skip the `open-regex' at cursor
    (while (and (> nesting 0)
                (funcall search-func
                  (concat "\\(" open-regex "\\)\\|\\(" close-regex "\\)") nil t))
      (if (string-match open-regex (match-string 0))
        (setq nesting (+ nesting 1))
        (setq nesting (- nesting 1))
      ))
    (setq case-fold-search orig-case-fold-search)
    (if (eq nesting 0)
      ; found the matching word, move cursor to the beginning of the match
      (goto-char (match-beginning 0))
      ; did not find the matching word, report the nesting depth at EOF
      (progn
        (goto-char orig-point)
        (error (format "Did not find match; nesting at file end is %d" nesting))
      )
    )))
;;; find the matching word/character /* it's a pain to point the word begining */
;; This is what I bind to C-left and C-right with some mode. (inspired by Scott McPeak)
(defun find-matching-keyword ()
  "Find the matching keyword of a balanced pair."
  (interactive)
  (cond
    ;; these first two come from lisp/emulation/vi.el
    ((looking-at "[[({]") (forward-sexp 1) (backward-char 1))
    ((looking-at "[])}]") (forward-char 1) (backward-sexp 1))
    ;;
    ;; rtp file from RTRT
    ((looking-at "<unit_testing>")
      (when (eq major-mode 'nxml-mode)
        (find-matching-element 're-search-forward 14 "<unit_testing>" "</unit_testing>")))
    ((looking-at "</unit_testing>")
      (when (eq major-mode 'nxml-mode)
        (find-matching-element 're-search-backward 0 "</unit_testing>" "<unit_testing>")))
    ;;
    ;; RTRT script .ptu
    ;; "\\b": word boundary assertion, needed because one delimiter is
    ;; a substring of the other
    ;; ELEMENT
    ((looking-at "SERVICE")
      (when (eq major-mode 'rtrt-script-mode)
        (find-matching-element 're-search-forward 7 "\\bSERVICE\\b" "END SERVICE")))
    ((looking-at "END SERVICE")
      (when (eq major-mode 'rtrt-script-mode)
        (find-matching-element 're-search-backward 0 "END SERVICE" "\\bSERVICE\\b")))
    ;; TEST
    ((looking-at "TEST")
      (when (eq major-mode 'rtrt-script-mode)
        (find-matching-element 're-search-forward 5 "\\bTEST\\b" "END TEST")))
    ((looking-at "END TEST")
      (when (eq major-mode 'rtrt-script-mode)
        (find-matching-element 're-search-backward 0 "END TEST" "\\bTEST\\b")))
    ;; ELEMENT
    ((looking-at "ELEMENT")
      (when (eq major-mode 'rtrt-script-mode)
        (find-matching-element 're-search-forward 7 "\\bELEMENT\\b" "END ELEMENT")))
    ((looking-at "END ELEMENT")
      (when (eq major-mode 'rtrt-script-mode)
        (find-matching-element 're-search-backward 0 "END ELEMENT" "\\bELEMENT\\b")))
    ;;
    ;; C/C++
    ((looking-at "#if")
      (when (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
        (find-matching-element 're-search-forward 3 "#if" "#endif")))
    ((looking-at "#endif")
      (when (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
        (find-matching-element 're-search-backward 0 "#endif" "#if")))
    ;;
    ;;(t (error "Cursor is not on ASSERT nor RETRACT"))
    (t t))
  )

;;
;;;
;;;; MACRO
;;; toggle macro recording on/off (by Fabrice Niessen)
(defun toggle-kbd-macro-recording-on ()
  "Start recording a keyboard macro and toggle functionality of key binding."
  (interactive)
  (global-set-key (kbd "<S-f8>") 'toggle-kbd-macro-recording-off)
  (start-kbd-macro nil))
;;; toggle macro recording on/off (by Fabrice Niessen)
(defun toggle-kbd-macro-recording-off ()
  "Stop recording a keyboard macro and toggle functionality of key binding."
  (interactive)
  (global-set-key (kbd "<S-f8>") 'toggle-kbd-macro-recording-on)
  (end-kbd-macro))
;;; when region is selected call last macro on region else call last macro (by
;;; Claude TETE)
(defun call-last-kbd-macro-region ()
  (interactive)
  (if (use-region-p)
    (apply-macro-to-region-lines (region-beginning) (region-end))
    (call-last-kbd-macro)
    )
  )
;; shortcuts are put in shortcut-function.el

;;
;;;
;;;; SEMANTIC
(when section-mode-cedet-semantic
 (defvar semantic-tags-location-ring (make-ring 20))
  ;;
  ;;; got to the definition and put it in a memory ring (by Roberto E. Vargas Caballero)
  (defun semantic-goto-definition (point)
    "Goto definition using semantic-ia-fast-jump
   save the pointer marker if tag is found"
    (interactive "d")
    (condition-case err
      (progn
        (ring-insert semantic-tags-location-ring (point-marker))
        (let* ((ctxt (semantic-analyze-current-context point))
                (pf (and ctxt (reverse (oref ctxt prefix))))
                (first (car pf)))
          (if (semantic-tag-p first)
            (semantic-ia--fast-jump-helper first)
            (semantic-complete-jump))))
      (error
        ;;if not found remove the tag saved in the ring
        (set-marker (ring-remove semantic-tags-location-ring 0) nil nil)
        (signal (car err) (cdr err)))))
  ;;
  ;;; go back with memory ring  (by Roberto E. Vargas Caballero)
  (defun semantic-pop-tag-mark ()
    "popup the tag save by semantic-goto-definition"
    (interactive)
    (if (ring-empty-p semantic-tags-location-ring)
      (message "%s" "No more tags available")
      (let* ((marker (ring-remove semantic-tags-location-ring 0))
              (buff (marker-buffer marker))
              (pos (marker-position marker)))
        (if (not buff)
          (message "Buffer has been deleted")
          (switch-to-buffer buff)
          (goto-char pos)))))
  ) ; (when section-mode-cedet-semantic

;;
;;;
;;;; BUFFER CYCLE
;;; browse in buffers without name start with * (by Claude TETE)
;; I don't use it
(defun next-user-buffer ()
  "Switch to the next user buffer in cyclic order.  User buffers are those not starting with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "\\(^\\*\\|TAGS\\)" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))
;;; browse in buffers without name start with * (by Claude TETE)
;; I don't use it
(defun previous-user-buffer ()
  "Switch to the previous user buffer in cyclic order.  User buffers are those not starting with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "\\(^\\*\\|TAGS\\)" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

;;
;;;
;;;; START UP
;;; run everything needed after start (needed with Emacs on MS Windows with
;;; maximize bug (by Claude TETE)
;; not used anymore (bug fixed)
(defun mystart-up ()
  "Start all mode necessary to work."
  (interactive)
  ;; to wait the maximize of the main window
  (custom-set-variables
   '(ecb-compile-window-height 0.25)
   '(ecb-windows-width 0.1))
  (ecb-activate)
  )
;;; run muse mode (by Claude TETE)
(defun mymuse-mode ()
  "Start muse mode."
  (interactive)
  (add-to-list 'load-path  (concat (file-name-as-directory dotemacs-path) "plugins/muse-3.20/bin"))
  (try-require 'muse-mode "    ")     ; load authoring mode
  (try-require 'muse-html "    ")     ; load publishing styles I use
  (try-require 'muse-latex "    ")
  ;;
  (muse-derive-style "my-slides-pdf" "slides-pdf"
    :header (concat (file-name-as-directory dotemacs-path) "plugins/themes/muse/header.tex")
    :footer  (concat (file-name-as-directory dotemacs-path) "plugins/themes/muse/footer.tex")
    )
;  (muse-mode t)
  )

;;
;;;
;;;; CONFIG
;;; load config for awful people who cannot read code source on dark
;;; background and tiny font (by Claude TETE) deprecated
(defun cfg-noob ()
  "Configure GNU/Emacs for whose seem to want work."
  (interactive)
  ;; deprecated
  (load-file (concat (file-name-as-directory dotemacs-path) "dotemacs/noob.el"))
  )
;;; load config for me after cfg-noob (by Claude TETE)
;; it do not revert all some bug...
(defun cfg-classic ()
  "Configure GNU/Emacs for whose want work."
  (interactive)
  (load-file (concat (file-name-as-directory dotemacs-path) "emacs.el"))
  )

;;
;;;
;;;; SEARCH ERROR
;;; search a tab in buffer (by Claude TETE)
(defun search-tab ()
  "Search a tab in the current buffer."
  (interactive)
  (occur "[\t\v]")
)
;;; search a fault size in buffer (by Claude TETE)
(when (string= profile "Alstom Transport")
  (defun search-fault-size ()
    "Search a sizing fault in the current buffer."
    (interactive)
    ;; line more than 80 column
    (occur ".\\{81,\\}")
    )
  ) ; (when (string= profile "Alstom Transport")

;;
;;;
;;;; END OF LINE
;;; convert MS-DOS format \r\n to Unix format \n (by ??)
(defun dos2unix ()
  "Transform a DOS file to a Unix file."
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t)
    (replace-match "")
  )
)
;;; convert Unix format \n to MS-DOS format \r\n (by ??)
(defun unix2dos ()
  "Transform a Unix file to a DOS file."
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t)
    (replace-match "\r\n")
  )
)

;;
;;;
;;;; TRANSPARENCY
;;; toggle the window transparency to alpha 100->85->100... (by Claude TETE)
(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  "Toggle the transparency of whole Emacs window."
  (interactive)
  (if (/=
        (cadr (frame-parameter nil 'alpha))
        100)
    (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(85 50))))
;;(global-set-key (kbd "C-c t") 'toggle-transparency)

;;
;;;
;;;; SWAP/SPLIT WINDOWS
;;; swap 2 windows (by Fabrice Niessen)
(defun my-swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((not (= (count-windows) 2))
          (message "You need exactly 2 windows to do this."))
    (t
      (let* ((w1 (first (window-list)))
              (w2 (second (window-list)))
              (b1 (window-buffer w1))
              (b2 (window-buffer w2))
              (s1 (window-start w1))
              (s2 (window-start w2)))
        (set-window-buffer w1 b2)
        (set-window-buffer w2 b1)
        (set-window-start w1 s2)
        (set-window-start w2 s1)
        )
      )
    )
  )
;;; toggle between horizontal and vertical split for 2 windows (by Fabrice
;;; Niessen)
(defun my-toggle-window-split ()
  "Vertical split shows more of each line, horizontal split shows
more lines. This code toggles between them. It only works for
frames with exactly two windows."
  (interactive)
  (if (= (count-windows) 2)
    (let* ((this-win-buffer (window-buffer))
            (next-win-buffer (window-buffer (next-window)))
            (this-win-edges (window-edges (selected-window)))
            (next-win-edges (window-edges (next-window)))
            (this-win-2nd (not (and (<= (car this-win-edges)
                                      (car next-win-edges))
                                 (<= (cadr this-win-edges)
                                   (cadr next-win-edges)))))
            (splitter
	      (if (= (car this-win-edges)
                    (car (window-edges (next-window))))
                'split-window-horizontally
		'split-window-vertically)
              )
            )
      (delete-other-windows)
      (let ((first-win (selected-window)))
        (funcall splitter)
        (if this-win-2nd (other-window 1))
        (set-window-buffer (selected-window) this-win-buffer)
        (set-window-buffer (next-window) next-win-buffer)
        (select-window first-win)
        (if this-win-2nd (other-window 1)))
      )
    )
  )

;;
;;;
;;;; RESIZE WINDOW
;;; where is the window vertically by Sergey Ovechkin (pomeo)
(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the
middle"
  (let* ((win-edges (window-edges))
          (this-window-y-min (nth 1 win-edges))
          (this-window-y-max (nth 3 win-edges))
          (fr-height (frame-height)))
    (cond
      ((eq 0 this-window-y-min) "top")
      ((eq (- fr-height 1) this-window-y-max) "bot")
      (t "mid"))))
;;; where is the window horizontally by Sergey Ovechkin (pomeo)
(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the
middle"
  (let* ((win-edges (window-edges))
          (this-window-x-min (nth 0 win-edges))
          (this-window-x-max (nth 2 win-edges))
          (fr-width (frame-width)))
    (cond
      ((eq 0 this-window-x-min) "left")
      ((eq (+ fr-width 2) this-window-x-max) "right") ; why 4 ? 2 works for me
      (t "mid"))))
;;; what to do when I want to push split line to the top (by Claude TETE)
(defun win-resize-top ()
  (interactive)
  (let ((win-pos (win-resize-top-or-bot)))
    (cond
      ((equal "top" win-pos) (shrink-window 1))
      ((equal "mid" win-pos) (shrink-window 1))
      ((equal "bot" win-pos) (enlarge-window 1))
      )
    )
  )
;;; what to do when I want to push split line to the bottom  (by Claude TETE)
(defun win-resize-bottom ()
  (interactive)
  (let ((win-pos (win-resize-top-or-bot)))
    (cond
      ((equal "top" win-pos) (enlarge-window 1))
      ((equal "mid" win-pos) (enlarge-window 1))
      ((equal "bot" win-pos) (shrink-window 1))
      )
    )
  )
;;; what to do when I want to push split line to the left (by Claude TETE)
(defun win-resize-left ()
  (interactive)
  (let ((win-pos (win-resize-left-or-right)))
    (cond
      ((equal "left"  win-pos) (shrink-window-horizontally 1))
      ((equal "mid"   win-pos) (shrink-window-horizontally 1))
      ((equal "right" win-pos) (enlarge-window-horizontally 1))
      )
    )
  )
;;; what to do when I want to push split line to the right (by Claude TETE)
(defun win-resize-right ()
  (interactive)
  (let ((win-pos (win-resize-left-or-right)))
    (cond
      ((equal "left"  win-pos) (enlarge-window-horizontally 1))
      ((equal "mid"   win-pos) (enlarge-window-horizontally 1))
      ((equal "right" win-pos) (shrink-window-horizontally 1))
      )
    )
  )

;;
;;;
;;;; SWITCH BUFFER
;;; Switching Between Two Recently Used Buffers (by Mathias Dahl)
;; like Alt+Tab in Windows Managers
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1))
  )

;;
;;;
;;;; (UN)COMMENT LINE
;;; (un)comment line if no region is marked
;; inspire from slick-copy
(defadvice comment-or-uncomment-region (before slick-copy activate compile)
  "When called interactively with no active region, (un)comment a single
line instead."
  (interactive
    (if mark-active
      (list (region-beginning) (region-end))
      (list (line-beginning-position)
               (line-beginning-position 2)))))

;;
;;;
;;;; SCROLL WITH KEEPING CURSOR
;;; Scroll the text one line down while keeping the cursor (by Geotechnical
;;; Software Services)
(defun scroll-down-keep-cursor ()
  (interactive)
  (scroll-down 1))
;;; Scroll the text one line up while keeping the cursor (by Geotechnical
;;; Software Services)
(defun scroll-up-keep-cursor ()
  (interactive)
  (scroll-up 1))

;;
;;;
;;;; MAXIMIZE
;;; maximize the current frame (the whole Emacs window) (by Claude TETE)
(defun frame-maximizer ()
  "Maximize the current frame"
  (interactive)
  (when (and running-in-graphical section-environment-os-recognition)
    (when running-on-ms-windows
      (w32-send-sys-command 61488)
      (sit-for 0)
      )
    (when running-on-gnu-linux
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
      )
    )
  )

;;
;;;
;;;; TIME/DATE
;;; insert current date/time (by Scott McPeak)
;; ----------------- insertion macros --------------------
;; insert current date/time
;;   %m   month in [01..12]
;;   %-m  month in [1..12]
;;   %d   day in [01..31]
;;   %y   year in [00..99]
;;   %Y   full year
;;   %H   hour in [00..23]
;;   %M   minute in [00..59]
;; see format-time-string for more info on formatting options
(defun my-date-string ()
  (format-time-string "%Y-%m-%d"))
(defun insert-date ()
  "Insert time and date at cursor."
  (interactive)
  (insert (my-date-string)))

;;
;;;
;;;; WEB SEARCH
;;; translate from French to English in generic browser
(defun translate-fren (beg end)
  "Translate the word at point using WordReference or Google Translate when a region is selected."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (if (use-region-p)
        (browse-url-generic
          (concat "http://translate.google.fr/?hl=&ie=UTF-8&text=&sl=fr&tl=en#fr|en|"
            (url-hexify-string string)))
        (browse-url-generic
          (concat "http://www.wordreference.com/fren/"
            (url-hexify-string string)))))))
;;; translate from English to French in generic browser
(defun translate-enfr (beg end)
  "Translate the word at point using WordReference or Google Translate when a region is selected."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (if (use-region-p)
        (browse-url-generic
          (concat "http://translate.google.fr/?hl=&ie=UTF-8&text=&sl=en&tl=fr#en|fr|"
            (url-hexify-string string)))
        (browse-url-generic
          (concat "http://www.wordreference.com/enfr/"
            (url-hexify-string string)))
        )
      (message "No word at point or no mark set"))))
;;; search in French Wikipedia
(defun wikipedia-fr (beg end)
  "Search the word at point or selected region using Wikipedia."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (browse-url-generic
        (concat "http://fr.wikipedia.org/wiki/Special:Search?search=" (url-hexify-string string)))
      (message "No word at point or no mark set"))))
;;
;;; search in English Wikipedia
(defun wikipedia-en (beg end)
  "Search the word at point or selected region using Wikipedia in English."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (browse-url-generic
        (concat "http://en.wikipedia.org/wiki/Special:Search?search=" (url-hexify-string string)))
      (message "No word at point or no mark set"))))
;;
;;; search synonym in French
(defun synonym-fr (beg end)
  "Search the word at point or selected region using Synonymes.com."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (browse-url-generic
        (concat "http://www.synonymes.com/synonyme.php?mot=" (url-hexify-string string) "&x=0&y=0"))
      (message "No word at point or no mark set"))))
;;; search synonym in English
(defun synonym-en (beg end)
  "Search the word at point or selected region using Synonym.com."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (browse-url-generic
        (concat "http://http://www.synonym.com/synonyms/" (url-hexify-string string) "&x=0&y=0"))
      (message "No word at point or no mark set"))))
;;
;;; search grammatical conjugation in French
(defun conjugation-fr (beg end)
  "Search the word at point or selected region using leconjugueur.com."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (browse-url-generic
        (concat "http://www.leconjugueur.com/php5/index.php?v=" (url-hexify-string string)))
      (message "No word at point or no mark set"))))
;;; search grammatical conjugation in English
(defun conjugation-en (beg end)
  "Search the word at point or selected region using theconjugator.com."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (browse-url-generic
        (concat "http://www.theconjugator.com/php5/index.php?verbe=" (url-hexify-string string)))
      (message "No word at point or no mark set"))))
;;
;;; search in French Google
(defun google-fr (beg end)
  "Search the word at point or selected region using google.fr."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (browse-url-generic
        (concat "http://www.google.fr/search?hl=fr&hs=0HH&q=" (url-hexify-string string)
          "&btnG=Rechercher&meta=&num=100&as_qdr=a&as_occt=any"))
      (message "No word at point or no mark set"))))
;;; search in English Google
(defun google-en (beg end)
  "Search the word at point or selected region using google.com."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (browse-url-generic
        (concat "http://www.google.fr/search?hl=en&hs=0HH&q=" (url-hexify-string string)
          "&btnG=Rechercher&meta=&num=100&as_qdr=a&as_occt=any"))
      (message "No word at point or no mark set"))))
;;
;;; search in DuckDuckGo
(defun duckduckgo (beg end)
  "Search the word at point or selected region using duckduckgo.com."
  (interactive (clt-get-string-position))
  (let ((string (buffer-substring beg end)))
    (if string
      (browse-url-generic
        (concat "https://duckduckgo.com/?q=" (url-hexify-string string)))
      (message "No word at point or no mark set"))))

;;
;;;
;;;; CASE
;;; uppercase the region or the following word
(defun case-up ()
  (interactive)
  (if (use-region-p)
    (upcase-region (region-beginning) (region-end))
    (upcase-word 1)
    )
  )
;;; downcase the region or the following word
(defun case-down ()
  (interactive)
  (if (use-region-p)
    (downcase-region (region-beginning) (region-end))
    (downcase-word 1)
    )
  )
;;; uppercase the first character and down the rest of the region or the following word
(defun case-capitalize ()
  (interactive)
  (if (use-region-p)
    (capitalize-region (region-beginning) (region-end))
    (capitalize-word 1)
    )
  )

;;
;;;
;;;; SWITCH BUFFER
(defun switch-to-special-buffer (buffer)
  "Switch to BUFFER in a special window like ecb compile window."
  (let ((buf (buffer-name)))
    ;; when the buffer is the same as the current buffer
    (if (string= buf buffer)
      ;; when ecb is active toggle the compile window
      (if section-mode-cedet-ecb
        (ecb-toggle-compile)
        ;; else go the previous buffer
        (switch-to-prev-buffer))
      (if (get-buffer buffer)
        (progn
          ;; when ecb is used display in compile window
          (when section-mode-cedet-ecb
            (ecb-goto-window-compilation))
          (switch-to-buffer buffer))
        (message (concat "Do not switch, " buffer " does not exist.")))
      )
    )
  )
;;; go to the grep or ack buffer in special window
(defun switch-to-grep-ack-buffer ()
  "Switch to the grep or ack buffer."
  (interactive)
  ;; when ack mode and buffer exist
  (if (and section-mode-ack-emacs (get-buffer "*ack*"))
    (switch-to-special-buffer "*ack*")
    (switch-to-special-buffer "*grep*"))
  )
;;; go to the compilation buffer in special window
(defun switch-to-compilation-buffer ()
  "Switch to the compilation buffer."
  (interactive)
  (switch-to-special-buffer "*compilation*")
  )
;;; go to the vc or vc diff buffer in special window
(defun switch-to-vc-buffer ()
  "Switch to the vc or vc diff buffer."
  (interactive)
  ;; when vc diff buffer already exist
  (if (get-buffer "*vc-diff*")
    (switch-to-special-buffer "*vc-diff*")
    (switch-to-special-buffer "*vc*"))
  )
;;; go to the occur buffer in special window
(defun switch-to-occur-buffer ()
  "Switch to the occur buffer."
  (interactive)
  (switch-to-special-buffer "*Occur*")
  )
;;; go to the help buffer in special window
(defun switch-to-help-buffer ()
  "Switch to the help buffer."
  (interactive)
  (switch-to-special-buffer "*Help*")
  )
;;; go to the help buffer in special window
(defun switch-to-bookmark-buffer ()
  "Switch to the bookmark buffer."
  (interactive)
  (if (get-buffer "*Bookmark List*")
    (switch-to-special-buffer "*Bookmark List*")
    (bookmark-bmenu-list))
  )
;;; go to the symbol reference buffer in special window
(defun switch-to-symref-buffer ()
  "Switch to the Symref buffer."
  (interactive)
  (switch-to-special-buffer "*Sy*")
  )

;;
;;;
;;;; AUCTEX
(when section-mode-auctex
  ;;; save the current buffer/document and compile it in auctex
  (defun auctex-save-and-compile ()
    (interactive)
    (save-buffer)
    (TeX-save-document "")
    (TeX-command "LaTeX" 'TeX-active-master 0))
  )

;;
;;;
;;;; MIXTAB
;; mix between smart tab and tabkey2 to have tab key OK and double tab key to
;; fold (some code from smart-tab.el and pc-keys.el)
(when section-mode-fold-dwim
  (defun mixtab-indent ()
    "Indent region if mark is active, or current line otherwise."
    (interactive)
    (if smart-tab-debug
      (message "default"))
    (if (use-region-p)
      (indent-region (region-beginning)
        (region-end))
      (indent-for-tab-command)))
  ;; bind to tab key
  (defun mixtab ()
    "First hitting key indent even if selection, second in a row fold the source
at the point."
    (interactive)
    (let* ((keys (recent-keys))
            (len (length keys))
            (key1 (if (> len 0) (elt keys (- len 1)) nil))
            (key2 (if (> len 1) (elt keys (- len 2)) nil))
            (key-equal-1 (equal key1 key2)))
      (if (and section-mode-fold-dwim key-equal-1)
        (fold-dwim-toggle)
        (tab-indent))))
  ) ; (when section-mode-fold-dwim

;;
;;;
;;;; FILE
;;; rename the current file
(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
         (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
      (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
          (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
            name (file-name-nondirectory new-name)))))))
;;; delete the current file
(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
         (buffer (current-buffer))
         (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
      (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

;;; replace tab with space + replace '+- non unicode
(defun clean-at ()
  "Clean files from AT."
  (interactive)
  (save-excursion
    (untabify (point-min) (point-max))
    (goto-char (point-min))
    (while (search-forward "�" nil t)
      (replace-match "'"))
    (while (search-forward "�" nil t)
      (replace-match "+"))
    (while (search-forward "�" nil t)
      (replace-match "-"))
    )
  )

;;
;;;
;;;; DELETE
(defun just-one-space-or-line ()
  "Delete spaces exept one if there is a print character on the line otherwise
delete blank lines"
  (interactive)
  (save-excursion
    (let ((start (point))
           (end)
           (line-start (line-beginning-position))
           (line-end (line-beginning-position 2)))
      ;; get end of line or start of next word
      (skip-chars-forward " \t")
      (when (looking-at "\r")
        (forward-char))
      (when (looking-at "\n")
        (forward-char))
      (setq end (point))
      ;; go back
      (goto-char start)
      ;; get start of line or end of previous word
      (skip-chars-backward " \t")
      (setq start (point))
      (if (and (eq start line-start) (eq end line-end))
        (progn
          (just-one-space 0)
          (delete-blank-lines))
        (just-one-space)))))

;; google code wiki to tex
(defun wiki2tex ()
  (interactive)
  (save-excursion
    (let ((start (point-min)) (end (point-max)))
      ;; table to item
      (replace-regexp "^||\\s-+" "\\\\cm{" nil start end)
      (replace-regexp "\\s-+|| " "}{" nil start end)
      (replace-regexp "\\s-+||$" "}" nil start end)
      ;; chapter to section
      (replace-regexp "^= " "\\\\section{" nil start end)
      (replace-regexp " =$" "}" nil start end)
      ;; title to section
      (replace-regexp "^=== " "\\\\subsection{" nil start end)
      (replace-regexp " ===$" "}" nil start end)
      ;; subtitle to subsection
      (replace-regexp "^===== " "\\\\subsubsection{" nil start end)
      (replace-regexp " =====$" "}" nil start end)
      ;; remove separator line
      (replace-regexp "^\\s-*----\\s-*$" "" nil start end)
      ))
  )


;;
;;;
;;;; MAGNETI MARELLI
(when section-function-mm
  (try-require 'function-mm "    ")
  ) ; (when section-function-mm

;;
;;;
;;;; ECB
(when section-mode-cedet-ecb
  (try-require 'function-ecb "    ")
  ) ; (when section-mode-cedet-ecb

;;
;;;
;;;; CLEARCASE
(when (or section-mode-clearcase section-mode-vc-clearcase)
  (try-require 'function-clearcase "    ")
  ) ; (when (or section-mode-clearcase section-mode-vc-clearcase)

;;
;;;
;;;; RTRT SCRIPT
(when section-mode-rtrt-script
  (try-require 'function-rtrt "    ")
  ) ; (when section-mode-rtrt-script

;;
;;;
;;;; TEST (all after is for testing
(when nil
(defun clt-test ()
  "Plein de test."
  (interactive)
  (message (thing-at-point 'word))
)

(setq semantic-c-takeover-hideif t)


;; start browser at url (by antonj from github)
(defun google-region (beg end)
  "Google the selected region."
  (interactive "r")
  (browse-url-generic (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" (buffer-substring beg end))))




;; cannot use:
;; setq: Symbol's function definition is void: ti::file-chmod-w-toggle
(defun tinymy-buffer-file-chmod ()
  "Toggle current buffer's Read-Write permission permanently on disk. VERB.
Does nothing if buffer is not visiting a file or file is not owned by us."
  (interactive)
  (let* ((file  (buffer-file-name))
          stat)
    (when (and file (file-modes file))  ;File modes is nil in Ange-ftp
      (setq stat (ti::file-chmod-w-toggle file))
      (when verb
        (cond
          ((eq stat 'w+)
            (message "TinyMy: chmod w+")
            (setq buffer-read-only nil))
          ((eq stat 'w-)
            (message "TinyMy: chmod w-")
            (setq buffer-read-only t))
          (t
          (message "TinyMy: couldn't chmod")))
        (ti::compat-modeline-update)))))


;; Stefan Monnier . It is the opposite of fill-paragraph
;; Takes a multi-line paragraph and makes it into a single line of text.
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))


;;; toggle fill-paragraph and "unfill" (by Xah Lee)
;; do not work
(defun compact-uncompact-block ()
  "Remove or add line ending chars on current paragraph.
This command is similar to a toggle of `fill-paragraph'.
When there is a text selection, act on the region."
  (interactive)

  ;; This command symbol has a property "stateIsCompact-p".
  (let (currentStateIsCompact (bigFillColumnVal 4333999) (deactivate-mark nil))

    (save-excursion
      ;; Determine whether the text is currently compact.
      (setq currentStateIsCompact
        (if (eq last-command this-command)
          (get this-command 'stateIsCompact-p)
          (if (> (- (line-end-position) (line-beginning-position)) fill-column) t nil) ) )

      (if (region-active-p)
        (if currentStateIsCompact
          (fill-region (region-beginning) (region-end))
          (let ((fill-column bigFillColumnVal))
            (fill-region (region-beginning) (region-end))) )
        (if currentStateIsCompact
          (let ((fill-column bigFillColumnVal))
          (fill-paragraph nil)
            (fill-paragraph nil)) ) )

      (put this-command 'stateIsCompact-p (if currentStateIsCompact nil t)) ) ) )

;; From http://stackoverflow.com/questions/848936/how-to-preserve-clipboard-content-in-emacs-on-windows
(defadvice kill-new (before kill-new-push-xselection-on-kill-ring activate)
  "Before putting new kill onto the kill-ring, add the clipboard/external selection to the kill ring"
  (let ((have-paste (and interprogram-paste-function
                         (funcall interprogram-paste-function))))
    (when have-paste (push have-paste kill-ring))))

;;list-colors-display to display all color

;; in elisp call function like interactive with this:
;; (call-interactively 'function)
) ; (when nil


(provide 'functions)

;;; functions.el ends here
