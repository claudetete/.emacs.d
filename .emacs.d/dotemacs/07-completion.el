;;; 07-completion.el --- a config file for completion settings

;; Copyright (c) 2006-2017 Claude Tete
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

;; Author: Claude Tete  <claude.tete@gmail.com>
;; Version: 1.6
;; Created: October 2006
;; Last-Updated: July 2017

;;; Commentary:
;;
;; [HEADER.enable letter case completion + dynamic completion]
;; [DEFAULT.t]

;;; Change Log:
;; 2017-07-25 (1.6)
;;    update to new conf format
;; 2012-07-11 (1.5)
;;    setting of hippie expand by reading the manual...
;; 2012-06-26 (1.4)
;;    try again hippie
;; 2012-05-10 (1.3)
;;    fix bug with CUA rectangle selection by disable dynamic completion +
;;    remove hippie do not work properly
;; 2012-05-04 (1.2)
;;    add configuration for hippie expand
;; 2012-03-28 (1.1)
;;    translate comments in English
;; 2011-03-10 (1.0)
;;    split .emacs file
;; 2006-10-13 (0.1)
;;    creation from scratch



;;; Code:
;; completion is case sensitive
(defvar dabbrev-case-replace nil)

;;;; enable dynamic word completion (never used)
;;;; from grandm_y
;;;; Interfere with CUA selection mode (insert only null character)
;;(dynamic-completion-mode)

;; try
;; coupled with modified smart-tab mode to have:
;; Tab key once will indent like always
;; Tab key twice will try to expand the current 'expression'
(setq hippie-expand-try-functions-list
  '(
     try-complete-file-name-partially
     try-complete-file-name
     try-expand-all-abbrevs
     try-expand-list
;;     try-expand-line
     try-expand-dabbrev
     try-expand-dabbrev-all-buffers
     try-expand-dabbrev-from-kill
     try-complete-lisp-symbol-partially
     try-complete-lisp-symbol
     ))

(provide '07-completion)

;;; 07-completion.el ends here