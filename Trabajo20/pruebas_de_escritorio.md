# Pruebas de Escritorio y Trazas de Unificación en Prolog (`tamano/2` y `ultimo/2`)

## 1. Prueba de Escritorio: Predicado `tamano([a, b, c], N)`

Prolog descompone la lista mediante el operador de unificación `[Cabeza|Cola]` utilizando la variable anónima `_` para descartar la cabeza en cada llamada recursiva, posponiendo la evaluación aritmética del operador `is/2` hasta alcanzar el hecho base `tamano([], 0)`.

| Nivel de Pila | Meta Invocada (`Call`) | Unificación `[ _ \| Cola ]`         | Meta Recursiva       | Retorno (`Exit`) y Evaluación `is/2`   |
|:-------------:|:-----------------------|:------------------------------------|:---------------------|:---------------------------------------|
|     **1**     | `tamano([a, b, c], N)` | `_ = a`, `Cola = [b, c]`            | `tamano([b, c], N1)` | `N is 2 + 1` $\rightarrow$ **`N = 3`** |
|     **2**     | `tamano([b, c], N1)`   | `_ = b`, `Cola = [c]`               | `tamano([c], N2)`    | `N1 is 1 + 1` $\rightarrow$ `N1 = 2`   |
|     **3**     | `tamano([c], N2)`      | `_ = c`, `Cola = []`                | `tamano([], N3)`     | `N2 is 0 + 1` $\rightarrow$ `N2 = 1`   |
| **4 (Base)**  | `tamano([], N3)`       | Coincide con hecho `tamano([], 0).` | —                    | **`N3 = 0`**                           |

---

## 2. Prueba de Escritorio: Predicado `ultimo([10, 20, 30], X)`

A diferencia de `tamano/2`, el predicado `ultimo/2` exhibe **recursión de cola pura**, puesto que la variable lógica `X` se comparte por unificación directa desde la llamada inicial hasta el caso base `ultimo([X], X)` sin operaciones pendientes al retorno.

| Nivel de Pila | Meta Invocada (`Call`)    | Coincidencia con `ultimo([X], X)`        | Unificación en Regla Recursiva | Resultado de Unificación (`Exit`) |
|:-------------:|:--------------------------|:-----------------------------------------|:-------------------------------|:----------------------------------|
|     **1**     | `ultimo([10, 20, 30], X)` | Falla (la cola `[20, 30]` no es `[]`)    | `_ = 10`, `Cola = [20, 30]`    | Propaga **`X = 30`**              |
|     **2**     | `ultimo([20, 30], X)`     | Falla (la cola `[30]` no es `[]`)        | `_ = 20`, `Cola = [30]`        | Propaga **`X = 30`**              |
| **3 (Base)**  | `ultimo([30], X)`         | **Éxito** (`[30]` equivale a `[30\|[]]`) | —                              | Unifica **`X = 30`**              |
