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

## Misión 3
- Mensaje descifrado:
  - Representación en listas de símbolos:
    ```lisp
    ((T R A I D O R) (N I V E L) (C I N C O) (F U E R A) (D E) (M O R E L I A))
    ```
  - Texto continuo traducido:
    `"traidor nivel cinco fuera de morelia"`

- Versión en una sola expresión:
  ```lisp
  (mapcar (lambda (palabra)
            (mapcar (lambda (codigo)
                      (nth (mod (- codigo 3) 26) *alfabeto*))
                    palabra))
          *interceptado*)
  ```

- (Extra) comprobación de cifrado:
  - Definición de función inversa:
    ```lisp
    (defun cifrar-palabra (palabra)
      (mapcar (lambda (letra)
                (mod (+ (position letra *alfabeto*) 3) 26))
              palabra))
    ```
  - Verificación en CLISP:
    ```lisp
    (equal (mapcar #'cifrar-palabra (descifrar-mensaje *interceptado*))
           *interceptado*)
    ;; => T
    ```

## Misión 4
- Sospechoso(s):
  ```lisp
  (sospechosos *agentes*)
  ;; => (BETO)
  ```
  El traidor identificado es **BETO**.

- Total de puntos de los leales:
  ```lisp
  (total-puntos (leales *agentes* 'beto))
  ;; => 865
  ```
  (Suma de puntos: Ana 120 + Carla 45 + Diego 210 + Elena 90 + Fausto 400 = 865).

- Promedio de edad (racional y decimal):
  - Racional devuelto por CLISP:
    ```lisp
    (promedio-edad (leales *agentes* 'beto))
    ;; => 147/5
    ```
  - Tipo de número: En Common Lisp es un número de tipo **RATIO** (un número racional fraccionario exacto irreducible).
  - Versión decimal: Se obtiene forzando la conversión a punto flotante mediante la función `float` o dividiendo con un operando flotante (`5.0`):
    ```lisp
    (float (promedio-edad (leales *agentes* 'beto)))
    ;; => 29.4
    ```

- Deducción de los dos nivel 5:
  En el expediente existen dos agentes con nivel 5: Beto (base Uruapan) y Fausto (base Morelia).
  La cláusula descifrada *"fuera de morelia"* es el criterio determinante que descarta a Fausto, ya que su base operativa es precisamente Morelia. Por descarte lógico estricto, el único agente que cumple simultáneamente ambas condiciones (nivel 5 y base distinta de Morelia) es Beto.
  Si el filtro solo revisara el nivel, la expresión devolvería `(BETO FAUSTO)`, generando un falso positivo que acusaría erróneamente a un elemento leal e impediría una acción quirúrgica del mando.

## Misión 5
| ID | ¿Truena? | Mensaje / resultado | Causa | Corrección |
|:---:|:---:|:---|:---|:---|
| **S1** | **SÍ** | `EVAL: variable CAR has no value` | En Common Lisp (Lisp-2) las funciones pasadas como argumentos deben llevar el operador `#'`. Sin él, Lisp intenta evaluar `car` como una variable ordinaria no ligada. | `(mapcar #'car *agentes*)` |
| **S2** | **SÍ** | `SYSTEM::CHECK-LAMBDA-LIST: ag is not a list` | La lista de parámetros formales de una forma `lambda` debe ser obligatoriamente una lista delimitada entre paréntesis `(ag)`, no un símbolo atómico. | `(mapcar (lambda (ag) (nombre ag)) *agentes*)` |
| **S3** | **SÍ** | `SYSTEM::LAMBDA-CLOSURE: execution requires 1 argument, not 2` | `mapcar` recibe dos listas (`*agentes*` y `*bonos*`), por lo que suministra 2 argumentos en cada invocación, pero la función lambda solo declaró 1 parámetro formal `(ag)`. | `(mapcar (lambda (ag) (puntos ag)) *agentes*)` o `(mapcar (lambda (ag b) (+ (puntos ag) b)) *agentes* *bonos*)` |
| **S4** | **NO** | `(130 340 50)` | **Sabotaje silencioso.** La segunda lista `'(10 0 5)` contiene solo 3 elementos. `mapcar` finaliza silenciosamente cuando la lista más corta se agota, truncando el procesamiento. | `(mapcar (lambda (ag b) (+ (puntos ag) b)) *agentes* *bonos*)` |
| **S5** | **SÍ** | `EVAL: (LAMBDA (AG) (NOMBRE AG)) is not a function name` | Se utilizó una lista citada con `'` (`quote`). Una lista citada es una estructura de datos literal, no un objeto funcional ejecutable ni una función de primer orden válida. | `(mapcar (lambda (ag) (nombre ag)) *agentes*)` |

- Sabotaje silencioso y regla de mapcar:
  El sabotaje silencioso corresponde a **S4**. No genera ninguna condición de error en el intérprete ni emite advertencias, pero produce una lista incompleta con únicamente 3 resultados en lugar de 6.
  La regla de `mapcar` establece que cuando se proporcionan dos o más listas como entrada, **la iteración se detiene en cuanto se agota la lista más corta**. Dado que la lista explícita `'(10 0 5)` solo posee 3 elementos, `mapcar` procesa únicamente a Ana, Beto y Carla, descartando de manera silenciosa a Diego, Elena y Fausto.

## Misión 6
- Salidas de los tres filtros:
  - Agentes de nivel 4 o más (`(aplicar-filtro (filtro-nivel 4) *agentes*)`):
    ```lisp
    ((BETO 35 5 URUAPAN 340) (DIEGO 41 4 ZAMORA 210) (FAUSTO 26 5 MORELIA 400))
    ```
  - Agentes de Morelia (`(aplicar-filtro (filtro-base 'morelia) *agentes*)`):
    ```lisp
    ((ANA 28 3 MORELIA 120) (CARLA 22 1 MORELIA 45) (FAUSTO 26 5 MORELIA 400))
    ```
  - Agentes de Morelia y nivel 3 o más (`(aplicar-filtro (y-filtros (filtro-base 'morelia) (filtro-nivel 3)) *agentes*)`):
    ```lisp
    ((ANA 28 3 MORELIA 120) (FAUSTO 26 5 MORELIA 400))
    ```

- Salida del ensamble final:
  Expresión:
  ```lisp
  (informe (aplicar-filtro (filtro-nivel 3)
                           (leales *agentes* (car (sospechosos *agentes*)))))
  ```
  Salida impresa en consola:
  ```text
  ANA (MORELIA) nivel 3 -> 120 pts
  DIEGO (ZAMORA) nivel 4 -> 210 pts
  FAUSTO (MORELIA) nivel 5 -> 400 pts
  ```
  Valor retornado: `3`

- Ventaja de la fábrica:
  `filtro-nivel` es una fábrica de clausuras léxicas (*closures* / funciones de orden superior). La principal ventaja es la **reusabilidad y parametrización dinámica**: en vez de tener que definir, nombrar y compilar funciones rígidas e individuales para cada requerimiento (`nivel-2-o-mas`, `nivel-3-o-mas`, `nivel-4-o-mas`, `nivel-5-o-mas`), una única función generadora produce al vuelo cualquier predicado necesario reteniendo el parámetro `minimo` en su entorno léxico. Esto respeta el principio DRY (*Don't Repeat Yourself*), permite la composición modular con combinadores como `y-filtros` y otorga adaptabilidad ante requerimientos arbitrarios en tiempo de ejecución.
