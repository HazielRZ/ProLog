# Trabajo 8: Evaluación Multirrama (`cond`) y Despacho por Clave Simbólica (`case`)


## 1. Criterios de Selección entre `cond` y `case`

En el diseño de sistemas basados en reglas dentro de Common Lisp, la ramificación múltiple se estructura mediante dos macros principales:

* **`cond`:** Evalúa secuencialmente una serie de cláusulas `((predicado-i expr-1 ... expr-k))`. En cuanto un predicado evalúa a verdadero (no `NIL`), se ejecuta su cuerpo con `progn` implícito y se descartan las cláusulas restantes. Por convención, la cláusula por defecto se encabeza con la constante `t`. Es la estructura indicada para evaluar **intervalos numéricos y predicados compuestos** (ej. sistemas de triage médico).
* **`case`:** Evalúa una expresión clave y la compara mediante `eql` contra conjuntos de constantes simbólicas o numéricas definidas estáticamente, utilizando `otherwise` o `t` como caso por defecto. Es la estructura óptima para máquinas de estados y **clasificación por categorías discretas** (ej. zonas tarifarias de paquetería).
