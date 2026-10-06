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


;;; mensaje cifrado: una sublista por palabra
(setq *interceptado*
      '((22 20 3 11 6 17 20)
        (16 11 24 7 14)
        (5 11 16 5 17)
        (8 23 7 20 3)
        (6 7)
        (15 17 20 7 14 11 3)))

(setq *bonos* '(10 0 5 20 15 0))

;;; MISION 1 - EL EXPEDIENTE DESORDENADO

(defun nombre (ag)
  "Obtiene el nombre de un agente (primer elemento)."
  (car ag))

(defun edad (ag)
  "Obtiene la edad de un agente (segundo elemento)."
  (car (cdr ag)))

(defun nivel (ag)
  "Obtiene el nivel de un agente (tercer elemento)."
  (car (cdr (cdr ag))))

(defun base (ag)
  "Obtiene la base operativa de un agente (cuarto elemento)."
  (car (cdr (cdr (cdr ag)))))

(defun puntos (ag)
  "Obtiene los puntos acumulados de un agente (quinto elemento)."
  (car (cdr (cdr (cdr (cdr ag))))))

;; Mision 2 pase de Lista
(defun pase-de-lista (&optional (agentes *agentes*))
  "Devuelve solo la lista de nombres usando mapcar con una función existente."
  (mapcar #'car agentes))

(defun nombre-y-nivel (&optional (agentes *agentes*))
  "Devuelve pares punteados (nombre . nivel) usando mapcar + lambda + cons."
  (mapcar (lambda (ag)
            (cons (nombre ag) (nivel ag)))
          agentes))

(defun cumpleanios (&optional (agentes *agentes*))
  "Devuelve pares (nombre edad+1) sin modificar la lista original."
  (mapcar (lambda (ag)
            (list (nombre ag) (1+ (edad ag))))
          agentes))

(defun aplicar-bonos (agentes bonos)
  "Suma el bono correspondiente a los puntos de cada agente usando dos listas."
  (mapcar (lambda (ag b)
            (+ (puntos ag) b))
          agentes
          bonos))



