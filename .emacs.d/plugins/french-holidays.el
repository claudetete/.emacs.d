; To show French holidays (and only those) in your Emacs calendar,
; put the following lines into your .emacs:
;   (require 'french-holidays)
;   (setq calendar-holidays holiday-french-holidays)

(eval-when-compile
  (require 'calendar)
  (require 'holidays))

(defvar holiday-french-holidays nil
  "French holidays")

(setq holiday-french-holidays
      `((holiday-fixed 1 1 "Jour de l'an")
	(holiday-fixed 1 6 "�piphanie")
	(holiday-fixed 2 2 "Chandeleur")
	(holiday-fixed 2 14 "Saint Valentin")
	(holiday-fixed 5 1 "F�te du travail")
	(holiday-fixed 5 8 "Comm�moration de la capitulation de l'Allemagne en 1945")
	(holiday-fixed 6 21 "F�te de la musique")
	(holiday-fixed 7 14 "F�te nationale - Prise de la Bastille")
	(holiday-fixed 8 15 "Assomption (Religieux)")
	(holiday-fixed 11 11 "Armistice de 1918")
	(holiday-fixed 11 1 "Toussaint")
	(holiday-fixed 11 2 "Comm�moration des fid�les d�funts")
	(holiday-fixed 12 25 "No�l")
        ;; fetes a date variable
	(holiday-easter-etc 0 "P�ques")
        (holiday-easter-etc 1 "Lundi de P�ques")
        (holiday-easter-etc 39 "Ascension")
        (holiday-easter-etc 49 "Pentec�te")
        (holiday-easter-etc -47 "Mardi gras")
	(holiday-float 5 0 4 "F�te des m�res")
	;; dernier dimanche de mai ou premier dimanche de juin si c'est le
	;; m�me jour que la pentec�te TODO
	(holiday-float 6 0 3 "F�te des p�res"))) ;; troisi�me dimanche de juin

(provide 'french-holidays)
