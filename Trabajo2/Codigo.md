## 1. Transición del Estilo Imperativo al Declarativo en JavaScript

Como preámbulo al uso de expresiones simbólicas en Common Lisp, es posible modelar funciones puras y recorrido recursivo de colecciones en JavaScript

## 2. Implementación Ejecutable ([`3108.js`](3108.js))

```javascript
const longitudLista = ([cabeza, ...cola]) =>
  cabeza === undefined ? 0 : 1 + longitudLista(cola);

const sumarElementos = ([cabeza, ...cola]) =>
  cabeza === undefined ? 0 : cabeza + sumarElementos(cola);

const invertirLista = ([cabeza, ...cola]) =>
  cabeza === undefined ? [] : [...invertirLista(cola), cabeza];

const filtrarLista = ([cabeza, ...cola], predicado) => {
  if (cabeza === undefined) return [];
  return predicado(cabeza)
    ? [cabeza, ...filtrarLista(cola, predicado)]
    : filtrarLista(cola, predicado);
};

const muestra = [10, 25, 30, 45, 60];
console.log("Longitud:", longitudLista(muestra));
console.log("Sumatoria:", sumarElementos(muestra));
console.log("Inversión inmutable:", invertirLista(muestra));
console.log("Múltiplos de 15:", filtrarLista(muestra, (x) => x % 15 === 0));
```
