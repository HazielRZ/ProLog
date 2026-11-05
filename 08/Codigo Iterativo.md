## 1. Fundamento Técnico del Control Iterativo

En el paradigma imperativo-iterativo, la repetición de instrucciones se fundamenta en la mutación controlada de variables de estado dentro de un único marco de activación en la pila de llamadas (*Call Stack*). Por consiguiente, la complejidad espacial se mantiene constante en $O(1)$, mientras que la complejidad temporal escala linealmente en $O(n)$ respecto al número de iteraciones ejecutadas.

## 2. Implementación en JavaScript (ES6+)

```javascript
const sumaIterativa = (n) => {
  let acumulador = 0;
  for (let i = 1; i <= n; i++) acumulador += i;
  return acumulador;
};

const potenciaIterativa = (base, exponente) => {
  let resultado = 1;
  for (let i = 0; i < exponente; i++) resultado *= base;
  return resultado;
};

console.log("Suma iterativa (n = 10):", sumaIterativa(10));
console.log("Potencia iterativa (2^8):", potenciaIterativa(2, 8));
```
