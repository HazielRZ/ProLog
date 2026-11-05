(defun longitud-recursiva (lista)
  (if (null lista)
      0
      (+ 1 (longitud-recursiva (cdr lista)))))

(defun longitud-cola (lista &optional (acumulador 0))
  (if (null lista)
      acumulador
      (longitud-cola (cdr lista) (+ 1 acumulador))))

(defun sumar-lista (lista &optional (acumulador 0))
  (cond
    ((null lista) acumulador)
    ((numberp (car lista)) (sumar-lista (cdr lista) (+ acumulador (car lista))))
    (t (sumar-lista (cdr lista) acumulador))))

(defun pertenece-p (elemento lista)
  (cond
    ((null lista) nil)
    ((equal elemento (car lista)) t)
    (t (pertenece-p elemento (cdr lista)))))

(defun invertir-lista (lista &optional (acumulador nil))
  (if (null lista)
      acumulador
      (invertir-lista (cdr lista) (cons (car lista) acumulador))))

(defun aplanar-lista (estructura)
  (cond
    ((null estructura) nil)
    ((atom estructura) (list estructura))
    (t (append (aplanar-lista (car estructura))
               (aplanar-lista (cdr estructura))))))

(format t "~%--- Pruebas Trabajo 9 (Recursión sobre Listas) ---~%")
(format t "Longitud lineal / cola de '(a b c d e): ~A / ~A~%"
        (longitud-recursiva '(a b c d e))
        (longitud-cola '(a b c d e)))
(format t "Suma de '(10 20 35 45): ~A~%" (sumar-lista '(10 20 35 45)))
(format t "Pertenece 'c a '(a b c): ~A~%" (pertenece-p 'c '(a b c)))
(format t "Inversión de '(1 2 3 4 5): ~A~%" (invertir-lista '(1 2 3 4 5)))
(format t "Aplanado de '((1 2) (3 (4 5)) 6): ~A~%" (aplanar-lista '((1 2) (3 (4 5)) 6)))
