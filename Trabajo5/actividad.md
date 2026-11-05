# Trabajo 5: Manipulación Estructural de Listas mediante Primitivas `car` y `cdr`

## 1. Representación Interna mediante Celdas `cons`

En Common Lisp, toda lista enlazada se construye a partir de pares de punteros denominados celdas `cons`. Cada celda consta de dos registros históricos derivados de la arquitectura IBM 704:
* **`car` (Contents of the Address part of Register):** Extrae la cabeza (primer elemento) de la lista.
* **`cdr` (Contents of the Decrement part of Register):** Extrae la cola (el resto de la lista tras remover el primer elemento), cuyo último puntero finaliza en el átomo `NIL`.

Cuando se operan estructuras jerárquicas o listas con múltiples niveles de anidamiento, es fundamental distinguir entre aplicar `cdr` (que devuelve una lista con los elementos restantes del nivel actual) y aplicar `car` sobre el resultado de un recorrido para ingresar a una sublista anidada. Common Lisp provee abreviaturas composicionales de hasta cuatro niveles (`cadr`, `caddr`, `caadr`, `cadadr`, etc.), donde los caracteres entre `c` y `r` se evalúan de derecha a izquierda.

## 2. Traza de Extracción sobre Listas Anidadas

Dada la estructura jerárquica:
`'((a b) (c (d e (f g))) (h i))`

Para aislar el átomo `f`:
1. `(cdr lista)` $\rightarrow$ `((c (d e (f g))) (h i))`
2. `(car (cdr lista))` $\equiv$ `(cadr lista)` $\rightarrow$ `(c (d e (f g)))`
3. `(cadr (cadr lista))` $\rightarrow$ `(d e (f g))`
4. `(caddr (cadr (cadr lista)))` $\rightarrow$ `(f g)`
5. `(car (caddr (cadr (cadr lista))))` $\rightarrow$ `F`
