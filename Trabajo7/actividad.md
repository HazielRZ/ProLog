# Trabajo 7: Estructuras Condicionales (`if`, `when`, `unless`) y Agrupación Secuencial (`progn`)

## 1. Análisis Sintáctico y Semántico de Formas Especiales de Control

En Common Lisp, las estructuras de decisión no son sentencias vacías como en los lenguajes imperativos, sino **expresiones que siempre evalúan y retornan un valor**:

1. **`(if condicion rama-verdadera [rama-falsa])`:** Forma especial estricta que admite únicamente una S-expression para la rama consecuente y una para la rama alternativa. Si se requiere evaluar múltiples expresiones secuenciales dentro de una rama (por ejemplo, emitir un registro en salida estándar y retornar un cálculo), es obligatorio envolverlas en la forma especial **`(progn expr1 expr2 ... exprN)`**, la cual evalúa todas las expresiones en orden y devuelve el valor de `exprN`.
2. **`(when condicion expr1 expr2 ... exprN)`:** Macro unidireccional diseñada para casos donde solo existe rama verdadera. Incluye un `progn` implícito, evaluando todas las expresiones subsecuentes si `condicion` es verdadera, o retornando `NIL` en caso contrario.
3. **`(unless condicion expr1 expr2 ... exprN)`:** Macro complementaria de `when` que incluye igualmente un `progn` implícito; ejecuta su cuerpo únicamente cuando `condicion` evalúa a `NIL` (falso), resultando idónea para cláusulas de guarda y validación de precondiciones.
