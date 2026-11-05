## 1. Fundamento Técnico de la Recursión

A diferencia del enfoque iterativo, la recursión prescinde de ciclos explícitos y de mutaciones de estado, descomponiendo el problema original en subproblemas homólogos de menor dimensión. Toda definición recursiva bien formada requiere dos componentes indispensables:
1. **Caso Base (Condición de Paro):** Define el valor de retorno directo para la instancia elemental del problema, deteniendo la expansión de llamadas.
2. **Paso Inductivo (Llamada Recursiva):** Invoca a la propia función con argumentos estrictamente más próximos al caso base, apilando un nuevo marco de activación en el *Call Stack* con complejidad espacial $O(n)$.

## 2. Implementación en JavaScript

```javascript
const sumaRecursiva = (n) => (n <= 0 ? 0 : n + sumaRecursiva(n - 1));

const potenciaRecursiva = (base, exponente) =>
  exponente === 0 ? 1 : base * potenciaRecursiva(base, exponente - 1);

console.log("Suma recursiva (n = 10):", sumaRecursiva(10));
console.log("Potencia recursiva (2^8):", potenciaRecursiva(2, 8));
```
