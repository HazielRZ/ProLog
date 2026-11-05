;;; (nombre edad nivel base puntos)
(setq *agentes*
      '((ana    28 3 morelia   120)
        (beto   35 5 uruapan   340)
        (carla  22 1 morelia    45)
        (diego  41 4 zamora    210)
        (elena  30 2 patzcuaro  90)
        (fausto 26 5 morelia   400)))

(defun intervalo (a b)
  (if (> a b)
      nil
      (cons a (intervalo (+ a 1) b))))

(setq *alfabeto* '(a b c d e f g h i j k l m n o p q r s t u v w x y z))

;;; Mensaje cifrado: una sublista por palabra
(setq *interceptado*
      '((22 20 3 11 6 17 20)
        (16 11 24 7 14)
        (5 11 16 5 17)
        (8 23 7 20 3)
        (6 7)
        (15 17 20 7 14 11 3)))

(setq *bonos* '(10 0 5 20 15 0))

;;; MISIÓN 1 — EL EXPEDIENTE DESORDENADO

(defun nombre (ag) (car ag))
(defun edad (ag)   (cadr ag))
(defun nivel (ag)  (caddr ag))
(defun base (ag)   (cadddr ag))
(defun puntos (ag) (car (cddddr ag)))

;;; MISIÓN 2 — PASE DE LISTA

(defun pase-de-lista (&optional (agentes *agentes*))
  (mapcar #'car agentes))

(defun nombre-y-nivel (&optional (agentes *agentes*))
  (mapcar (lambda (ag)
            (cons (nombre ag) (nivel ag)))
          agentes))

(defun cumpleanios (&optional (agentes *agentes*))
  (mapcar (lambda (ag)
            (list (nombre ag) (1+ (edad ag))))
          agentes))

(defun aplicar-bonos (agentes bonos)
  (mapcar (lambda (ag b)
            (+ (puntos ag) b))
          agentes
          bonos))

;;; MISIÓN 3 — EL MENSAJE INTERCEPTADO

(defun descifrar-codigo (n)
  (nth (mod (- n 3) 26) *alfabeto*))

(defun descifrar-palabra (palabra)
  (mapcar #'descifrar-codigo palabra))

(defun descifrar-mensaje (mensaje)
  (mapcar #'descifrar-palabra mensaje))

(defun descifrar-mensaje-directo (mensaje)
  (mapcar (lambda (palabra)
            (mapcar (lambda (codigo)
                      (nth (mod (- codigo 3) 26) *alfabeto*))
                    palabra))
          mensaje))

;; Extra: Cifrado inverso para comprobar reciprocidad
(defun cifrar-palabra (palabra)
  (mapcar (lambda (letra)
            (mod (+ (position letra *alfabeto*) 3) 26))
          palabra))

(defun cifrar-mensaje (mensaje)
  (mapcar #'cifrar-palabra mensaje))
