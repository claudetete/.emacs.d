;;; 02-mode-038-powerline.el --- configuration of powerline mode

;; Copyright (c) 2017 Claude Tete
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
;; Version: 0.2
;; Created: July 2017
;; Last-Updated: September 2017

;;; Commentary:
;;
;; [SUBHEADER.fancy modeline]
;; [SUBDEFAULT.t]

;;; Change Log:
;; 2017-09-11 (0.2)
;;    try to fix wrong separator color + all the icons integration
;; 2017-07-24 (0.1)
;;    creation from split of old mode.el (see 02-mode.el for history)


;;; Code:
(when tqnr-running-on-emacs-23
  ;; in Emacs 23 it was not define
  (defun get-scroll-bar-mode () scroll-bar-mode)
  (defsetf get-scroll-bar-mode set-scroll-bar-mode))

;; new in emacs 24, using sRGB colorspace by default, powerline does not like it
;; see https://github.com/milkypostman/powerline/issues/54
(when (or tqnr-running-on-emacs-24 tqnr-running-on-emacs-25)
  (setq ns-use-srgb-colorspace nil))

;; use new powerline mode
;; see
(when (try-require 'powerline "    ")
  (defun powerline-my-theme ()
    "Setup a mode-line."
    (interactive)
    (setq-default mode-line-format
      '("%e"
         (:eval
           (let* ((active (powerline-selected-window-active))
                   ;; face for right and left
                   (mode-line (if active 'mode-line 'mode-line-inactive))
                   ;; face for between right and left and middle
                   (face-between (if active 'powerline-active1
                                   'powerline-inactive1))
                   ;; face for middle
                   (face-middle (if active 'powerline-active2
                                  'powerline-inactive2))
                   ;; face for highlight
                   (face-warning 'font-lock-warning-face)
                   (separator-left
                     (intern (format "powerline-%s-%s"
                               powerline-default-separator
                               (car powerline-default-separator-dir))))
                   (separator-right
                     (intern (format "powerline-%s-%s"
                               powerline-default-separator
                               (cdr powerline-default-separator-dir))))
                   (lhs (list
                          ;;
                          ;; LEFT
                          ;; display [RO] when visited a read-only file
                          (when (and buffer-read-only buffer-file-name)
                            (if tqnr-section-mode-all-the-icons
                              (concat
                                (powerline-raw " ")
                                (all-the-icons-octicon "lock" :face 'font-lock-warning-face :v-adjust 0.05))
                              (powerline-raw "[RO]" face-warning)))
                          ;; buffername
                          (powerline-buffer-id nil 'l)
                          ;; display * at end of buffer name when buffer was modified
                          (when (and (buffer-modified-p) buffer-file-name)
                            (powerline-raw "*" face-warning 'l))

                          ;; first separator
                          (powerline-raw " ")
                          (funcall separator-left mode-line face-between)

                          ;;
                          ;; LEFT MIDDLE
                          ;; major mode
                          (if tqnr-section-mode-all-the-icons
                            (concat (powerline-raw " " face-between)
                              (if active
                                (all-the-icons-icon-for-mode major-mode :face 'powerline-active1 :v-adjust 0.05)
                                (all-the-icons-icon-for-mode major-mode :face 'powerline-inactive1 :v-adjust 0.05)))
                            (powerline-major-mode face-between 'l))
                          ;; process
                          (powerline-process face-between)
                          ;; minor mode
                          (powerline-minor-modes face-between 'l)
                          ;; narrow mode
                          (powerline-narrow face-between 'l)

                          ;; second separator
                          (powerline-raw " " face-between)
                          (funcall separator-left face-between face-middle)

                          ;;
                          ;; MIDDLE
                          ;; version control
                          (powerline-vc face-middle 'r)))
                   (rhs (list

                          ;; third separator
                          (powerline-raw global-mode-string face-middle 'r)
                          (funcall separator-right face-middle face-between)

                          ;;
                          ;; RIGHT MIDDLE
                          ;; line number
                          (powerline-raw "%2l" face-between 'l)
                          ;; :
                          (powerline-raw ":" face-between 'l)
                          ;; column number
                          (powerline-raw "%2c" face-between 'r)

                          ;; fourth separator
                          (funcall separator-right face-between mode-line)
                          (powerline-raw " ")

                          ;;
                          ;; RIGHT
                          ;; encoding and eol indicator
                          (when buffer-file-coding-system
                            (powerline-raw (symbol-name buffer-file-coding-system))
                            (powerline-raw " " nil 'l)
                            (powerline-raw
                              (let* ((eol (coding-system-eol-type buffer-file-coding-system)))
                                (cond
                                  ((eq eol 0) "(Unix)")
                                  ((eq eol 1) "(Dos)")
                                  ((eq eol 2) "(Mac)")
                                  (t ""))))
                            ;;(powerline-raw mode-line-mule-info nil 'l)
                            (powerline-raw " " nil 'r))
                          ;; position indicator
                          (powerline-raw "%6p" nil 'r)

                          )))
             ;;(message "%s %s" separator-left (funcall 'powerline-wave-left mode-line face1))
             (concat
               (powerline-render lhs)
               (powerline-fill face-middle (powerline-width rhs))
               (powerline-render rhs)))))))
  ;; set arrow fade as separator
  (setq powerline-default-separator 'arrow-fade)
  (when tqnr-section-mode-all-the-icons
    (setq powerline-height 22))
  (powerline-my-theme)
  )


(provide '02-mode-038-powerline)

;;; 02-mode-038-powerline.el ends here