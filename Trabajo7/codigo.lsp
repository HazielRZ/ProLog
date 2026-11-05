(defun procesar-pedido (cantidad precio-unitario)
  (if (and (> cantidad 0) (> precio-unitario 0))
      (let* ((subtotal (* cantidad precio-unitario))
             (descuento (if (>= cantidad 12) (* subtotal 0.15) 0.0))
             (total (- subtotal descuento)))
        (list :estado 'aprobado :subtotal subtotal :descuento descuento :total total))
      (list :estado 'rechazado :motivo 'parametros-no-positivos)))

(defun verificar-alerta-temperatura (paciente temperatura)
  (when (>= temperatura 38.0)
    (let ((diferencial (- temperatura 37.0)))
      (list :alerta 'fiebre-detectada
            :paciente paciente
            :temperatura temperatura
            :exceso-grados diferencial))))

(defun dividir-seguro (numerador denominador)
  (unless (or (not (numberp denominador)) (zerop denominador))
    (float (/ numerador denominador))))

(format t "~%--- Pruebas Trabajo 7 (IF / WHEN / UNLESS) ---~%")
(format t "Pedido válido (15 pzas a $120): ~A~%" (procesar-pedido 15 120))
(format t "Pedido inválido (-3 pzas): ~A~%" (procesar-pedido -3 120))
(format t "Monitoreo térmico (38.7°C): ~A~%" (verificar-alerta-temperatura 'paciente-01 38.7))
(format t "División segura (50 / 0): ~A | (50 / 8): ~A~%"
        (dividir-seguro 50 0)
        (dividir-seguro 50 8))
