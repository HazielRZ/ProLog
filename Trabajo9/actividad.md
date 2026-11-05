# Trabajo 9: Recursión Estructural y de Cola sobre Listas en Common Lisp

## 1. Esquema General de Inducción Estructural en Listas

Dado que toda lista propia en Common Lisp se define inductivamente como la lista vacía `NIL` o bien como la celda `(cons cabeza cola)` donde `cola` es a su vez una lista, cualquier algoritmo recursivo sobre listas sigue dos reglas fundamentales:

1. **Caso Base de Terminación:** Verificado mediante `(null lista)` o `(endp lista)`, detiene la recursión cuando el puntero alcanza `NIL`, previniendo el desbordamiento de pila (`Program stack overflow`).
2. **Paso Inductivo de Reducción:** Opera sobre el elemento actual `(car lista)` y realiza la llamada recursiva pasándole estrictamente la subestructura reducida `(cdr lista)`.

Cuando la llamada recursiva constituye la última operación evaluada sin dejar cálculos pendientes en el marco de activación (apoyándose en un parámetro acumulador inicializado mediante una función auxiliar o un parámetro `&optional`), se obtiene **recursión de cola** (*Tail Recursion*), la cual permite ejecutarse en espacio constante $O(1)$.
