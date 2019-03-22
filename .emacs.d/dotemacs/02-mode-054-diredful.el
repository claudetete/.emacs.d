;;; 02-mode-054-diredful.el --- configuration of diredful mode

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
;; [SUBHEADER.color dired buffer]
;; [SUBDEFAULT.nil]


;;; Code:
;; set file conf path must be set before load diredful
(custom-set-variables
  '(diredful-init-file (concat (file-name-as-directory tqnr-dotemacs-path) "dotemacs/diredful-conf.el")))
(try-require 'diredful "    ")


(provide '02-mode-054-diredful)

;;; 02-mode-054-diredful.el ends here
