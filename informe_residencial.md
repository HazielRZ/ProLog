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

## Misión 4
- Tablero final:
- Cadena de deducción (paso → pistas → hecho):
- Trampa de la casa 3:

## Misión 5
- Salida de dueno_del_pez / perfil / resumen_pez:
- Respuesta al mando:
- Hecho vs. regla:

## Misión 6
| ID | Efecto | Causa | Corrección |
|----|--------|-------|------------|
- Sabotaje más peligroso:

## Extra (si aplica)
- ¿Una sola solución?:
- Comparación buscador vs. hechos:


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

