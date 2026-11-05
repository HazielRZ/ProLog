const sumaIterativa = (n) => {
  let acumulador = 0;
  for (let i = 1; i <= n; i++) acumulador += i;
  return acumulador;
};

const sumaRecursiva = (n) => (n <= 0 ? 0 : n + sumaRecursiva(n - 1));

const potenciaIterativa = (base, exp) => {
  let res = 1;
  for (let i = 0; i < exp; i++) res *= base;
  return res;
};

const potenciaRecursiva = (base, exp) =>
  exp === 0 ? 1 : base * potenciaRecursiva(base, exp - 1);

console.log("--- Pruebas Trabajo 1 ---");
console.log("Suma Iterativa (10):", sumaIterativa(10));
console.log("Suma Recursiva (10):", sumaRecursiva(10));
console.log("Potencia Iterativa (2^8):", potenciaIterativa(2, 8));
console.log("Potencia Recursiva (2^8):", potenciaRecursiva(2, 8));
