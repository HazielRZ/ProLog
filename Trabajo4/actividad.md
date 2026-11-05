# Trabajo 4: Expresiones Simbólicas (S-Expressions), Notación Prefija y Definición de Funciones en Common Lisp

## 1. Fundamento Teórico

Common Lisp es un lenguaje homoicónico donde tanto el código ejecutable como las estructuras de datos se representan mediante expresiones simbólicas (*S-expressions*), compuestas por átomos y listas delimitadas por paréntesis. A diferencia de los lenguajes imperativos con precedencia de operadores infijos, el evaluador de GNU CLISP aplica de forma uniforme la **notación polaca prefija**: en toda lista no cotizada `(operador arg1 arg2 ... argN)`, el primer símbolo se resuelve como una función, macro o forma especial, y los elementos restantes se evalúan de izquierda a derecha antes de ser pasados como argumentos.

El operador especial `quote` (`'`) inhibe la regla de evaluación funcional, devolviendo la expresión literal sin intentar invocar su cabeza como función.

## 2. Tabla de Conversión de Expresiones Infijas a Notación Prefija

| Expresión Algebraica Infija | Expresión Simbólica en Common Lisp | Valor Evaluado |
| :--- | :--- | :--- |
| $\frac{15 + 25}{4} \times 3$ | `(* (/ (+ 15 25) 4) 3)` | `30` |
| $\sqrt{a^2 + b^2}$ con $a=3, b=4$ | `(sqrt (+ (expt 3 2) (expt 4 2)))` | `5.0` |
| $\frac{-b + \sqrt{b^2 - 4ac}}{2a}$ | `(/ (+ (- b) (sqrt (- (expt b 2) (* 4 a c)))) (* 2 a))` | Raíz $x_1$ |
