# Operación Lambda — Informe
**Agente:** Haziel / 22121339

## Misión 1
- Tabla predicción vs CLISP (a–f):

| Clave | Expresión | Predicción | CLISP |
|:---:|:---|:---:|:---:|
| **a** | `(car (cdr (car *agentes*)))` | `28` | `28` |
| **b** | `(car (car (cdr *agentes*)))` | `BETO` | `BETO` |
| **c** | `(cdr (car (cdr (cdr *agentes*))))` | `(22 1 MORELIA 45)` | `(22 1 MORELIA 45)` |
| **d** | `(car (cdr (cdr (cdr (car (cdr (cdr (cdr *agentes*))))))))` | `ZAMORA` | `ZAMORA` |
| **e** | `(caddr (cadr *agentes*))` | `5` | `5` |
| **f** | `(car (cdr (cdr (car (cdr (cdr (cdr (cdr *agentes*))))))))` | `2` | `2` |



- Puntos de Elena (expresión + salida):
  - Expresión:
    ```lisp
    (puntos (car (cdr (cdr (cdr (cdr *agentes*))))))
    ```
  - Salida: `90`

- (car (cdr '(ana))):
  - Devuelve: `NIL`
  - ¿Es un error?: No es un error en tiempo de ejecución para Common Lisp. En la especificación ANSI Common Lisp, la lista vacía `NIL` cumple que `(car nil) => NIL` y `(cdr nil) => NIL`. Al evaluar `(cdr '(ana))` se obtiene `NIL`, y el `(car nil)` subsecuente evalúa a `NIL` sin lanzar ninguna condición de error.
  - ¿Por qué es peligroso cuando un registro viene incompleto?: Porque enmascara fallas estructurales de datos. En lugar de arrojar una excepción inmediata del tipo, el programa continúa propagando `NIL`. Esto traslada el error a funciones posteriores, volviendo la depuración mucho más compleja.

## Misión 2
- Salidas de pase-de-lista, nombre-y-nivel, cumpleanios, aplicar-bonos:
  - `(pase-de-lista *agentes*)`:
    ```lisp
    (ANA BETO CARLA DIEGO ELENA FAUSTO)
    ```
  - `(nombre-y-nivel *agentes*)`:
    ```lisp
    ((ANA . 3) (BETO . 5) (CARLA . 1) (DIEGO . 4) (ELENA . 2) (FAUSTO . 5))
    ```
  - `(cumpleanios *agentes*)`:
    ```lisp
    ((ANA 29) (BETO 36) (CARLA 23) (DIEGO 42) (ELENA 31) (FAUSTO 27))
    ```
  - `(aplicar-bonos *agentes* *bonos*)`:
    ```lisp
    (130 340 50 230 105 400)
    ```