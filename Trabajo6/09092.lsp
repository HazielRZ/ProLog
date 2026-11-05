(defun comparar-constructores (elem-a lista-b)
  (list
   (cons 'resultado-cons (cons elem-a lista-b))
   (cons 'resultado-list (list elem-a lista-b))
   (cons 'resultado-append (append (if (listp elem-a) elem-a (list elem-a)) lista-b))))

(defun diagnosticar-expresion (expr)
  (list
   (cons 'es-nulo-nil (null expr))
   (cons 'es-atomo (atom expr))
   (cons 'es-lista (listp expr))
   (cons 'es-celda-cons (consp expr))
   (cons 'es-numero (numberp expr))
   (cons 'es-simbolo (symbolp expr))))

(defun insertar-inicio (elemento lista)
  (cons elemento lista))

(defun insertar-final (elemento lista)
  (append lista (list elemento)))

(format t "~%--- Pruebas Trabajo 6 (Constructores y Predicados) ---~%")
(format t "Comparativa con átomo 'X y '(Y Z): ~A~%" (comparar-constructores 'x '(y z)))
(format t "Comparativa con lista '(W X) y '(Y Z): ~A~%" (comparar-constructores '(w x) '(y z)))
(format t "Diagnóstico de NIL: ~A~%" (diagnosticar-expresion nil))
(format t "Diagnóstico de '(1 2 3): ~A~%" (diagnosticar-expresion '(1 2 3)))
