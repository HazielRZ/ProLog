# Trabajo 3: Modelado de Recursión Lineal y Múltiple (División, Factorial y Fibonacci)

## 1. Análisis de Árboles de Expansión Recursiva

1. **División entera por restas sucesivas:** Recursión lineal donde el dividendo $a$ decrece en razón del divisor $b$ en cada paso inductivo hasta satisfacer el caso base $a < b$, retornando $0$ y acumulando $+1$ por cada sustracción efectiva.
2. **Factorial ($n!$):** Recursión lineal con multiplicación pospuesta en la pila de ejecución, definida por $0! = 1$ y $n! = n \cdot (n-1)!$ para $n \ge 1$.
3. **Sucesión de Fibonacci ($F_n$):** Recursión múltiple (binaria) de complejidad temporal $O(2^n)$ en su formulación directa, dado que cada estado no base se ramifica en dos subproblemas: $F(n-1) + F(n-2)$.

## 2. Implementación en JavaScript ([`0109_0309.js`](0109_0309.js))

```javascript
const divisionRecursiva = (dividendo, divisor) => {
  if (divisor === 0) throw new Error("División por cero no definida.");
  if (dividendo < divisor) return 0;
  return 1 + divisionRecursiva(dividendo - divisor, divisor);
};

const factorial = (n) => (n <= 1 ? 1 : n * factorial(n - 1));

const factorialCola = (n, acumulador = 1) =>
  n <= 1 ? acumulador : factorialCola(n - 1, n * acumulador);

const fibonacci = (n) => {
  if (n <= 0) return 0;
  if (n === 1) return 1;
  return fibonacci(n - 1) + fibonacci(n - 2);
};
```

## 3. Implementación Equivalente en Common Lisp ([`recursion_clasica.lsp`](recursion_clasica.lsp))

```lisp
(defun division-recursiva (dividendo divisor)
  (cond
    ((zerop divisor) (error "División por cero no definida."))
    ((< dividendo divisor) 0)
    (t (+ 1 (division-recursiva (- dividendo divisor) divisor)))))

(defun factorial (n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(defun fibonacci (n)
  (cond
    ((<= n 0) 0)
    ((= n 1) 1)
    (t (+ (fibonacci (- n 1))
          (fibonacci (- n 2))))))
```
