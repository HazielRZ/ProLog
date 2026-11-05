# Trabajo 4: Expresiones , Notación Prefija y Definición de Funciones en Common Lisp



El operador especial `quote` (`'`) inhibe la regla de evaluación funcional, devolviendo la expresión literal sin intentar invocar su cabeza como función.

## . Tabla de Conversión de Expresiones Infijas a Notación Prefija

| Expresión Algebraica Infija | Expresión Simbólica en Common Lisp | Valor Evaluado |
| :--- | :--- | :--- |
| $\frac{15 + 25}{4} \times 3$ | `(* (/ (+ 15 25) 4) 3)` | `30` |
| $\sqrt{a^2 + b^2}$ con $a=3, b=4$ | `(sqrt (+ (expt 3 2) (expt 4 2)))` | `5.0` |
| $\frac{-b + \sqrt{b^2 - 4ac}}{2a}$ | `(/ (+ (- b) (sqrt (- (expt b 2) (* 4 a c)))) (* 2 a))` | Raíz $x_1$ |
