# Prueba de Escritorio: Predicado `tamano/2` en Prolog

## 1. Código del Programa

```prolog
% Caso Base:
tamano([], 0).

% Caso Recursivo:
tamano([_ | T], N) :- 
    tamano(T, N1), 
    N is N1 + 1.
```


---

##  Tabla de Seguimiento / Pila de Variables

| Nivel | Meta Actual            | Regla Usada |     Cabeza / Cola     | Variable Retorno | Operación Pendiente | Valor Calculado  |
|:-----:|:-----------------------|:-----------:|:---------------------:|:----------------:|:--------------------|:----------------:|
| **0** | `tamano([1, 2, 3], N)` |  Recursiva  | `_ = 1`, `T = [2, 3]` |       `N`        | `N is N1 + 1`       | `N = 2 + 1 = 3`  |
| **1** | `tamano([2, 3], N1)`   |  Recursiva  |  `_ = 2`, `T = [3]`   |       `N1`       | `N1 is N2 + 1`      | `N1 = 1 + 1 = 2` |
| **2** | `tamano([3], N2)`      |  Recursiva  |   `_ = 3`, `T = []`   |       `N2`       | `N2 is N3 + 1`      | `N2 = 0 + 1 = 1` |
| **3** | `tamano([], N3)`       |    Base     |         *N/A*         |       `N3`       | *(Ninguna)*         |     `N3 = 0`     |

---

## Árbol de Resolución SLD (Resumido)

```text
?- tamano([1, 2, 3], N).
       |
       |  (Regla 2: [1|[2,3]], N is N1 + 1)
       v
?- tamano([2, 3], N1), N is N1 + 1.
       |
       |  (Regla 2: [2|[3]], N1 is N2 + 1)
       v
?- tamano([3], N2), N1 is N2 + 1, N is N1 + 1.
       |
       |  (Regla 2: [3|[]], N2 is N3 + 1)
       v
?- tamano([], N3), N2 is N3 + 1, N1 is N2 + 1, N is N1 + 1.
       |
       |  (Regla 1: Base -> N3 = 0)
       v
?- N2 is 0 + 1, N1 is N2 + 1, N is N1 + 1.
       |  (N2 = 1)
       v
?- N1 is 1 + 1, N is N1 + 1.
       |  (N1 = 2)
       v
?- N is 2 + 1.
       |  (N = 3)
       v
true, N = 3.
```

---

## Conclusión

```prolog
N = 3.
```