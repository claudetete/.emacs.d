;;; 02-mode-039-nyan.el --- configuration of nyan mode

;; Copyright (c) 2017-2019 Claude Tete
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
;; Version: 0.1
;; Created: July 2017
;; Last-Updated: March 2019

;;; Commentary:
;;
;; [SUBHEADER.add bar in modeline given position in buffer]
;; [SUBDEFAULT.nil]


;;; Code:
(when (try-require 'autoload-nyan-mode "    ")
  ;; start nyan mode
  (nyan-mode t)

  ;; to have wave in rainbow
  (setq nyan-wavy-trail 1)

  ;; to have animation
  (nyan-start-animation)
  )


(provide '02-mode-039-nyan)

;;; 02-mode-039-nyan.el ends here
