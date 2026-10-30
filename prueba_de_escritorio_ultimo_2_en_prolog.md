# Prueba de Escritorio: Predicado `ultimo/2`

## 1. Definición del Algoritmo y Consulta

```
% Caso Base: El último elemento de una lista con un solo elemento es ese mismo elemento.
ultimo([X], X).

% Caso Recursivo: El último elemento de [_ | T] es el último elemento de T.
ultimo([_ | T], X) :- 
    ultimo(T, X).

```

**Consulta:**

```
?- ultimo([1, 2, 3], X).

```

## 2. Tabla de Prueba de Escritorio

| Paso  | **Nivel** |    **Meta Activa**     |                 **Caso Evaluado**                 |                      **Unificación / Sustitución**                      | **Estado / Siguiente Acción**                                         |
|:-----:|:----------|:----------------------:|:-------------------------------------------------:|:-----------------------------------------------------------------------:|:----------------------------------------------------------------------|
| **1** | 1         | `ultimo([1, 2, 3], X)` | Base: `ultimo([X_0], X_0)`  Recursivo: `ultimo([_ |                                T_1], X)`                                | Falla (`[1, 2, 3]` tiene 3 elementos)  Éxito: `_ = 1`, `T_1 = [2, 3]` | Se genera la submeta `ultimo([2, 3], X)` | 
| **2** | 2         |  `ultimo([2, 3], X)`   | Base: `ultimo([X_1], X_1)`  Recursivo: `ultimo([_ |                                T_2], X)`                                | Falla (`[2, 3]` tiene 2 elementos)  Éxito: `_ = 2`, `T_2 = [3]`       | Se genera la submeta `ultimo([3], X)` | 
| **3** | 3         |    `ultimo([3], X)`    |            Base: `ultimo([X_2], X_2)`             | Éxito: `[3] = [X_2] \implies X_2 = 3`  Por unificación directa: `X = 3` | **Éxito (Meta resuelta)**                                             | 

## 3. Árbol de Resolución SLD

```
               ?- ultimo([1, 2, 3], X).
                         |
                         | [Cabecera = 1, T = [2, 3]] (Regla 2: Recursiva)
                         v
               ?- ultimo([2, 3], X).
                         |
                         | [Cabecera = 2, T = [3]] (Regla 2: Recursiva)
                         v
               ?- ultimo([3], X).
                         |
                         | Unifica con: ultimo([X], X) donde X = 3 (Regla 1: Caso Base)
                         v
                       true
                     { X = 3 }

```

## 4. Resultado

```
X = 3.

```