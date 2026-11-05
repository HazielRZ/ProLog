
##  Implementación en JavaScript (ES6+)

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
