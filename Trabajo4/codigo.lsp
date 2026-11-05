(defun celsius-a-fahrenheit (grados-c)
  (+ (* grados-c (/ 9.0 5.0)) 32.0))

(defun hipotenusa (cateto-a cateto-b)
  (sqrt (+ (expt cateto-a 2) (expt cateto-b 2))))

(defun raices-cuadraticas (a b c)
  (let* ((discriminante (- (expt b 2) (* 4 a c)))
         (denominador (* 2 a)))
    (if (< discriminante 0)
        'raices-complejas
        (list (/ (+ (- b) (sqrt discriminante)) denominador)
              (/ (- (- b) (sqrt discriminante)) denominador)))))

(format t "~%--- Pruebas Trabajo 4 ---~%")
(format t "25°C en Fahrenheit: ~A~%" (celsius-a-fahrenheit 25))
(format t "Hipotenusa (3, 4): ~A~%" (hipotenusa 3 4))
(format t "Raíces de x^2 - 5x + 6 = 0: ~A~%" (raices-cuadraticas 1 -5 6))
