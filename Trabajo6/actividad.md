# Trabajo 6: Constructores de Listas (`cons`, `list`, `append`) y Predicados en Common Lisp

## 1. Diferenciación Estructural de Constructores

Una de las barreras conceptuales más frecuentes al programar en Common Lisp consiste en confundir la semántica de los tres operadores de construcción de listas:

| Operador | Firma Conceptual | Comportamiento Estructural en Memoria | Ejemplo Evaluado |
| :--- | :--- | :--- | :--- |
| **`cons`** | `(cons x lista)` | Crea exactamente **una nueva celda `cons`** cuyo `car` apunta a `x` y cuyo `cdr` apunta a `lista`. Si el segundo argumento es un átomo no nulo, produce un par punteado (*dotted pair*). | `(cons 'a '(b c))` $\rightarrow$ `(A B C)`<br>`(cons 'a 'b)` $\rightarrow$ `(A . B)` |
| **`list`** | `(list x1 x2 ... xn)` | Construye una nueva cadena de $n$ celdas `cons` donde cada argumento constituye un elemento independiente de nivel superior, finalizando en `NIL`. | `(list '(a b) '(c d))` $\rightarrow$ `((A B) (C D))` |
| **`append`** | `(append l1 l2 ... ln)` | Concatena listas de nivel superior copiando superficialmente las celdas de las primeras $n-1$ listas y enlazando el último puntero `cdr` hacia la lista $l_n$. | `(append '(a b) '(c d))` $\rightarrow$ `(A B C D)` |

## 2. Predicados Fundamentales

En Common Lisp, los predicados son funciones que verifican una propiedad lógica y devuelven `NIL` para representar falsedad o `T` (o cualquier valor distinto de `NIL`) para representar verdad lógica. Destacan `atom`, `listp`, `consp`, `null`, `zerop`, `numberp`, `symbolp`, `evenp`, `oddp` y los predicados de equivalencia (`eq`, `eql`, `equal`).
