(defun clasificar-triage (frecuencia-cardiaca saturacion-o2 temperatura)
  (cond
    ((or (< saturacion-o2 85) (> frecuencia-cardiaca 140) (< frecuencia-cardiaca 40))
     '(:nivel 1 :color rojo :prioridad atencion-inmediata-reanimacion))
    ((or (< saturacion-o2 90) (> frecuencia-cardiaca 120) (>= temperatura 39.5))
     '(:nivel 2 :color naranja :prioridad emergencia-muy-urgente))
    ((or (< saturacion-o2 94) (>= temperatura 38.0))
     '(:nivel 3 :color amarillo :prioridad urgencia-menor))
    ((and (>= saturacion-o2 94) (>= temperatura 36.0) (< temperatura 38.0))
     '(:nivel 4 :color verde :prioridad consulta-estandar))
    (t
     '(:nivel 5 :color azul :prioridad no-urgente))))

(defun cotizar-envio-paqueteria (zona peso-kg)
  (let ((tarifa-base-kg
          (case zona
            ((local morelia) 45.0)
            ((regional bajio occidente) 75.0)
            ((nacional norte sur) 115.0)
            ((internacional exportacion) 290.0)
            (otherwise nil))))
    (cond
      ((null tarifa-base-kg) '(:error zona-no-reconocida))
      ((<= peso-kg 0) '(:error peso-invalido))
      (t (let* ((cargo-peso (* peso-kg tarifa-base-kg))
                (sobrecargo-volumen (if (> peso-kg 20) (* cargo-peso 0.20) 0.0))
                (total (+ cargo-peso sobrecargo-volumen)))
           (list :zona zona :peso-kg peso-kg :tarifa-kg tarifa-base-kg :total total))))))

(format t "~%--- Pruebas Trabajo 8 (COND y CASE) ---~%")
(format t "Triage Paciente Crítico (FC 145, SpO2 82, 39.1°C): ~A~%"
        (clasificar-triage 145 82 39.1))
(format t "Triage Paciente Estable (FC 74, SpO2 97, 36.6°C): ~A~%"
        (clasificar-triage 74 97 36.6))
(format t "Envío Paquetería (Zona Bajío, 25 kg): ~A~%"
        (cotizar-envio-paqueteria 'bajio 25))
