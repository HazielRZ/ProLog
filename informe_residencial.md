# Operación Residencial — Informe
**Agente:** [Haziel Ruiz Z / 22121339]

## Misión 1
- Hechos de dominio (sí/no cargan):

```prolog
% Personas (persona/1)
persona(ana).
persona(beto).
persona(carla).
persona(diego).

% Colores (color/1)
color(blanca).
color(verde).
color(roja).
color(azul).

% Bebidas (bebida/1)
bebida(agua).
bebida(cafe).
bebida(leche).
bebida(te).

% Mascotas (mascota/1)
mascota(gato).
mascota(perro).
mascota(pez).
mascota(loro).
```
- Tabla átomo/variable/hecho/regla:
### Tabla átomo / variable / hecho / regla

| Expresión                    | Tipo         | Justificación técnica                                                                                                           |
|:-----------------------------|:-------------|:--------------------------------------------------------------------------------------------------------------------------------|
| `ana`                        | **Átomo**    | Constante simbólica que inicia con letra minúscula y representa una entidad fija del dominio.                                   |
| `P`                          | **Variable** | Identificador que inicia con letra mayúscula y puede unificarse con cualquier término durante una consulta o regla.             |
| `persona(carla).`            | **Hecho**    | Cláusula de Horn sin cuerpo (terminada en punto `.`) que afirma incondicionalmente que `carla` cumple el predicado `persona/1`. |
| `vive_en(ana, 1).`           | **Hecho**    | Cláusula de aridad 2 (`vive_en/2`) que relaciona de forma directa el átomo `ana` con el entero `1`.                             |
| `dueno(P) :- tiene(P, pez).` | **Regla**    | Implicación lógica compuesta por una cabeza (`dueno(P)`), el conector `:-` (si lógico) y un cuerpo (`tiene(P, pez)`).           |

- Salidas de consultas:
```prolog
?- persona(ana).
true.

?- persona(X).
X = ana ;
X = beto ;
X = carla ;
X = diego.

?- color(roja).
true.

?- bebida(jugo).
false.
```

- ¿Por qué Ana ≠ ana?: Un nombre en mayúscula en prolog se considera variable no constante, por ende al no estar definida o igualada no son el mismo valor.

## Misión 2

- ### Pistas que sí son hechos directos
De las 12 pistas interceptadas, únicamente **4 pistas** relacionan de forma directa y explícita los dos argumentos exactos de alguno de los cuatro predicados obligatorios (`vive_en(P, N)`, `color_casa(N, C)`, `bebe(P, B)`, `tiene(P, M)`) sin requerir cruces ni inferencias previas:

* **Pista 1:** *«Ana vive en la casa 1»* $\rightarrow$ Relaciona directamente Persona (`ana`) y Número de casa (`1`).
* **Pista 3:** *«Beto bebe café»* $\rightarrow$ Relaciona directamente Persona (`beto`) y Bebida (`cafe`).
* **Pista 6:** *«Carla bebe leche»* $\rightarrow$ Relaciona directamente Persona (`carla`) y Bebida (`leche`).
* **Pista 11:** *«Carla tiene el pez»* $\rightarrow$ Relaciona directamente Persona (`carla`) y Mascota (`pez`).

- ### Hechos escritos (en la fase inicial de Misión 2)

```prolog
vive_en(ana, 1).    % Pista 1
bebe(beto, cafe).   % Pista 3
bebe(carla, leche). % Pista 6
tiene(carla, pez).  % Pista 11
```
- ### Por qué la pista 4 no es hecho aislado
La **Pista 4** (*«La casa verde está inmediatamente a la izquierda de la casa roja»*) no es un hecho aislado del predicado `color_casa(N, C)` porque no asigna un número de casa concreto (`1`, `2`, `3` o `4`) ni al color `verde` ni al color `roja`. En su lugar, expresa una **relación de posición** entre dos incógnitas ($N_{\text{roja}} = N_{\text{verde}} + 1$), la cual admite inicialmente tres pares posibles de casas: $(1,2)$, $(2,3)$ o $(3,4)$.
- ### Salidas

```prolog
?- vive_en(ana, N).
N = 1.

?- bebe(beto, B).
B = cafe.
```
## Misión 3
- ### Reglas escritas (código):
```prolog
% 1. dueno_del_pez(P) — P tiene el pez.
dueno_del_pez(P) :-
tiene(P, pez).

% 2. color_de(Persona, Color) — une vive_en con color_casa.
color_de(Persona, Color) :-
vive_en(Persona, N),
color_casa(N, Color).

% 3. vecinos(P1, P2) — viven en casas cuya diferencia de número es 1.
vecinos(P1, P2) :-
vive_en(P1, N1),
vive_en(P2, N2),
abs(N1 - N2) =:= 1.

% 4. bebe_en_casa(N, B) — en la casa N se bebe B (vía la persona que vive ahí).
bebe_en_casa(N, B) :-
vive_en(P, N),
bebe(P, B).

% 5. perfil(P, N, Color, Bebida, Mascota) — los cinco datos de una persona.
perfil(P, N, Color, Bebida, Mascota) :-
persona(P),
vive_en(P, N),
color_casa(N, Color),
bebe(P, Bebida),
tiene(P, Mascota).
```

- Papel de N en color_de:

### Tablero final

| Casa | Color | Persona | Bebida | Mascota |
| :---: | :--- | :--- | :--- | :--- |
| **1** | `blanca` | `ana` | `agua` | `gato` |
| **2** | `verde` | `beto` | `cafe` | `perro` |
| **3** | `roja` | `carla` | `leche` | `pez` |
| **4** | `azul` | `diego` | `te` | `loro` |

### Cadena de deducción (paso → pistas → hecho nuevo)

| Paso | Pistas utilizadas | Razonamiento deductivo | Hechos nuevos agregados a `residencial.pl` |
| :---: | :--- | :--- | :--- |
| **1** | **Pista 1** + **Pista 2** | Ana vive en la casa 1 (Pista 1) y Ana vive en la casa blanca (Pista 2). Por lo tanto, la casa 1 es blanca. | `vive_en(ana, 1).`<br>`color_casa(1, blanca).` |
| **2** | **Pista 3** + **Pista 5** | Beto bebe café (Pista 3) y quien vive en la casa verde bebe café (Pista 5). Se deduce que Beto vive en la casa verde (dato en espera de número de casa). | `bebe(beto, cafe).`<br>*(Relación retenida: Beto $\leftrightarrow$ casa verde)* |
| **3** | **Pista 12** + **Pista 10** | Quien bebe té vive en la casa 4 (Pista 12) y quien tiene el loro bebe té (Pista 10). Por tanto, en la casa 4 se bebe té y vive el dueño del loro. | *(Relación retenida: Casa 4 $\leftrightarrow$ `te` $\leftrightarrow$ `loro`)* |
| **4** | **Pista 9** + **Paso 2** + **Paso 3** + **Pista 4** | En la casa 4 se bebe `te`, por lo que no puede ser `verde` (donde se bebe `cafe`). Según la Pista 4 (la verde está inmediatamente a la izquierda de la roja), los únicos pares posibles para `(verde, roja)` entre las casas 2, 3 y 4 son `(2, 3)` o `(3, 4)`. Si fuera `(3, 4)`, la casa 2 quedaría `azul` (Diego, Pista 9), obligando a Beto (`verde`/`cafe`) o a Carla (`leche`) a vivir en la 4, lo cual contradice la Pista 12 (en la 4 se bebe `te`). Por ende, el par `(verde, roja)` es `(2, 3)`, la **casa 4 es `azul`** y **Diego vive en la casa 4**, donde bebe `te` y tiene el `loro`. | `color_casa(4, azul).`<br>`vive_en(diego, 4).`<br>`bebe(diego, te).`<br>`tiene(diego, loro).` |
| **5** | **Paso 4** + **Pista 4** + **Paso 2** | Quedan los colores `verde` y `roja` para las casas 2 y 3. Como la verde está inmediatamente a la izquierda de la roja (Pista 4), la **casa 2 es `verde`** y la **casa 3 es `roja`**. Como Beto vive en la casa verde (Paso 2), **Beto vive en la casa 2**. | `color_casa(2, verde).`<br>`color_casa(3, roja).`<br>`vive_en(beto, 2).` |
| **6** | **Pista 6** + **Pista 11** + Descarte de casas | Las casas 1 (Ana), 2 (Beto) y 4 (Diego) ya están ocupadas, así que **Carla vive en la casa 3**. Por las Pistas 6 y 11, Carla bebe leche y tiene el pez. | `vive_en(carla, 3).`<br>`bebe(carla, leche).`<br>`tiene(carla, pez).` |
| **7** | **Pista 8** + Descarte de bebidas | Ya se asignaron `cafe` (Beto), `leche` (Carla) y `te` (Diego); la única bebida restante para Ana (casa 1) es `agua`. Por la Pista 8 (*«Quien tiene el gato bebe agua»*), **Ana tiene el gato**. | `bebe(ana, agua).`<br>`tiene(ana, gato).` |
| **8** | Descarte de mascotas + **Pista 7** | Ya se asignaron `gato` (Ana), `pez` (Carla) y `loro` (Diego); la única mascota restante para Beto (casa 2) es el `perro`. **Verificación con Pista 7:** Beto (casa 2, `perro`) es vecino contiguo de Ana (casa 1, `agua`), pues $|2 - 1| = 1$. | `tiene(beto, perro).` |

### Salidas de las consultas de verificación (Misión 4)

```prolog
?- color_de(ana, C).
C = blanca.

?- vecinos(beto, ana).
true.

?- bebe_en_casa(4, B).
B = te.
```

### Trampa de la casa 3
**No es coherente.** Si Beto viviera en la casa 3, por las pistas 3 y 5 la casa 3 sería **verde**, y por la pista 4 la casa inmediatamente a su derecha (casa 4) tendría que ser **roja**. Pero en la casa 4 se bebe té (pista 12), mientras que Carla bebe leche (pista 6) y Diego vive en la casa azul (pista 9); esto dejaría a Diego sin ninguna casa azul disponible (pues la 1 es blanca, la 3 verde y la 4 roja), generando una contradicción.

---

## Misión 5 — El Expediente Completo

### Salida de `dueno_del_pez` / `perfil` / `resumen_pez` y demás consultas de comprobación

```prolog
?- dueno_del_pez(P).
P = carla.

?- perfil(P, N, Color, Bebida, Mascota).
P = ana,   N = 1, Color = blanca, Bebida = agua,  Mascota = gato ;
P = beto,  N = 2, Color = verde,  Bebida = cafe,  Mascota = perro ;
P = carla, N = 3, Color = roja,   Bebida = leche, Mascota = pez ;
P = diego, N = 4, Color = azul,   Bebida = te,    Mascota = loro.

?- vecinos(X, diego).
X = carla ;
false.

?- color_de(beto, C).
C = verde.

?- bebe(ana, B), tiene(ana, M).
B = agua,
M = gato.
```

#### Código y salida de la nueva regla `resumen_pez/4`

```prolog
resumen_pez(P, N, Color, Bebida) :-
    dueno_del_pez(P),
    vive_en(P, N),
    color_casa(N, Color),
    bebe(P, Bebida).
```

```prolog
?- resumen_pez(P, N, Color, Bebida).
P = carla,
N = 3,
Color = roja,
Bebida = leche.
```

### Respuesta al mando
**Carla tiene el pez, vive en la casa 3 (de color roja) y bebe leche.**

### Hecho vs regla
Afirmar `tiene(carla, pez).` como hecho solo almacena un dato aislado en la base de conocimientos sin validar si el resto del vecindario es consistente ni conectar ese dato con otros atributos. En cambio, consultar `?- dueno_del_pez(P).` y `?- resumen_pez(P, N, Color, Bebida).` demuestra que comprendimos la diferencia entre **hechos** (conocimiento extensional básico) y **reglas** (conocimiento intensional que encadena múltiples predicados mediante variables compartidas para inferir información compuesta).

---

## Misión 6 — Código Saboteado

| ID | Fragmento saboteado | Efecto | Causa | Corrección |
| :-: | :--- | :--- | :--- | :--- |
| **S1** | `vive_en(Ana, 1).` | **“Funciona” mentira** *(más una advertencia `Singleton variables: [Ana]` al cargar)* | `Ana` empieza con mayúscula, por lo que Prolog la interpreta como una variable universalmente cuantificada ($\forall X, \text{vive\_en}(X, 1)$), haciendo creer que **cualquier persona** vive en la casa 1. | `vive_en(ana, 1).` |
| **S2** | `color_casa(2, Verde).` | **“Funciona” mentira** *(más advertencia `Singleton variables: [Verde]` al cargar)* | `Verde` inicia con mayúscula (es una variable libre), lo que afirma que la casa 2 tiene **cualquier color posible** y unifica con cualquier átomo consultado. | `color_casa(2, verde).` |
| **S3** | `bebe(beto, cafe)` | **Falla al cargar** (`Syntax error: Operator expected` / falta de fin de cláusula) | En Prolog toda cláusula (hecho o regla) debe terminar obligatoriamente con un punto final (`.`). | `bebe(beto, cafe).` |
| **S4** | `vecinos(P1, P2) :- vive_en(P1, N), vive_en(P2, N).` | **“Funciona” mentira** *(o falla al buscar vecinos reales como `vecinos(ana, beto)`)* | Usa la misma variable `N` para ambas personas, exigiendo que vivan en la **misma casa** ($N_1 = N_2$, por lo que toda persona resulta vecina de sí misma) en lugar de casas contiguas ($|N_1 - N_2| = 1$). | `vecinos(P1, P2) :- vive_en(P1, N1), vive_en(P2, N2), abs(N1 - N2) =:= 1.` |
| **S5** | `tiene(carla, pez).` y además `tiene(diego, pez).` | **“Funciona” mentira** | Rompe la restricción de **unicidad (biyección)** del dominio al asignar la misma mascota (`pez`) a dos personas distintas, haciendo que `dueno_del_pez(P)` devuelva dos respuestas contradictorias (`P = carla ; P = diego`). | Mantener solo `tiene(carla, pez).` y corregir el hecho de Diego a `tiene(diego, loro).` |

### Sabotaje más peligroso
El sabotaje más peligroso para el mando es **S5** (seguido de cerca por **S1/S2** si se ignoran los *warnings*), porque **no produce ningún error de sintaxis ni advertencia de variables solitarias (`Singleton variables`) al cargar el archivo con `swipl`**. Al estar escrito con átomos válidos en minúsculas y puntos finales correctos, pasa completamente desapercibido para el compilador y corrompe silenciosamente la consulta crítica del cuartel (`?- dueno_del_pez(P).`), infiltrando un falso sospechoso (`diego`) junto con la respuesta real (`carla`).

---

## Extra ★ — El Buscador (Opcional)

### Código del buscador con listas y `member/2` (incluido en `residencial.pl`)

```prolog
% izquierda(CasaIzq, CasaDer, Casas)
izquierda(A, B, [A, B | _]).
izquierda(A, B, [_ | Resto]) :-
    izquierda(A, B, Resto).

% vecino(Casa1, Casa2, Casas)
vecino(A, B, Casas) :-
    izquierda(A, B, Casas).
vecino(A, B, Casas) :-
    izquierda(B, A, Casas).

% buscar(Casas)
buscar(Casas) :-
    Casas = [
        casa(1, _, _, _, _),
        casa(2, _, _, _, _),
        casa(3, _, _, _, _),
        casa(4, _, _, _, _)
    ],
    member(casa(1, _, ana, _, _), Casas),
    member(casa(_, blanca, ana, _, _), Casas),
    member(casa(_, _, beto, cafe, _), Casas),
    izquierda(casa(_, verde, _, _, _), casa(_, roja, _, _, _), Casas),
    member(casa(_, verde, _, cafe, _), Casas),
    member(casa(_, _, carla, leche, _), Casas),
    vecino(casa(_, _, _, _, perro), casa(_, _, _, agua, _), Casas),
    member(casa(_, _, _, agua, gato), Casas),
    member(casa(_, azul, diego, _, _), Casas),
    member(casa(_, _, _, te, loro), Casas),
    member(casa(_, _, carla, _, pez), Casas),
    member(casa(4, _, _, te, _), Casas).
```

### ¿Una sola solución? (Consultas y salidas)

```prolog
?- buscar(Casas).
Casas = [
    casa(1, blanca, ana, agua, gato),
    casa(2, verde, beto, cafe, perro),
    casa(3, roja, carla, leche, pez),
    casa(4, azul, diego, te, loro)
] ;
false.

?- findall(Casas, buscar(Casas), Soluciones), length(Soluciones, Total).
Soluciones = [[casa(1, blanca, ana, agua, gato), casa(2, verde, beto, cafe, perro), casa(3, roja, carla, leche, pez), casa(4, azul, diego, te, loro)]],
Total = 1.
```

**SÍ, existe exactamente una única solución (`Total = 1`)** que satisface simultáneamente las doce pistas.

### Comparación: buscador vs hechos sueltos
* **Ventaja del buscador (`buscar/1` con `member/2`):** Delega todo el esfuerzo combinatorio al motor de **unificación y *backtracking* (retroceso)** de Prolog. El programador solo declara las 12 restricciones del problema tal como llegaron en las pistas, sin tener que deducir el tablero a mano ni correr el riesgo de cometer errores humanos de descarte; además, permite comprobar automáticamente si la solución es única (`findall/3`).
* **Ventaja de la versión con hechos sueltos y reglas (`vive_en/2`, `color_de/2`, `perfil/5`):** Ofrece una base de conocimientos modular, explícita y directamente consultable por atributo o por relación (`?- color_de(beto, C).`, `?- vecinos(X, diego).`, `?- resumen_pez(P, N, Color, Bebida).`), sin necesidad de recorrer ni descomponer una estructura de lista anidada cada vez que el mando solicita un dato puntual.

---


## Datos:
**Pistas:**

    Ana vive en la casa 1.
    Ana vive en la casa blanca.
    Beto bebe café.
    La casa verde está inmediatamente a la izquierda de la casa roja.
    Quien vive en la casa verde bebe café.
    Carla bebe leche.
    Quien tiene el perro vive junto a quien bebe agua.
    Quien tiene el gato bebe agua.
    Diego vive en la casa azul.
    Quien tiene el loro bebe té.
    Carla tiene el pez.
    Quien bebe té vive en la casa 4.

**Material interceptado — Las doce pistas**

