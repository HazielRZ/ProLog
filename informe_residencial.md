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
- ¿Por qué Ana ≠ ana?:

## Misión 2
- Pistas que sí son hechos directos:
- Hechos escritos:
- Por qué la pista 4 no es hecho aislado:
- Salidas:

## Misión 3
- Reglas escritas (pegar código):
- Papel de N en color_de:

## Misión 4
- Tablero final:
- Cadena de deducción (paso → pistas → hecho):
- Trampa de la casa 3:

## Misión 5
- Salida de dueno_del_pez / perfil / resumen_pez:
- Respuesta al mando:
- Hecho vs regla:

## Misión 6
| ID | Efecto | Causa | Corrección |
|----|--------|-------|------------|
- Sabotaje más peligroso:

## Extra (si aplica)
- ¿Una sola solución?:
- Comparación buscador vs hechos:


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

