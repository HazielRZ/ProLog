const divisionRecursiva = (dividendo, divisor) => {
  if (divisor === 0) throw new Error("División por cero no definida.");
  if (dividendo < divisor) return 0;
  return 1 + divisionRecursiva(dividendo - divisor, divisor);
};

const factorial = (n) => (n <= 1 ? 1 : n * factorial(n - 1));

const factorialCola = (n, acumulador = 1) =>
  n <= 1 ? acumulador : factorialCola(n - 1, n * acumulador);

const fibonacci = (n) => {
  if (n <= 0) return 0;
  if (n === 1) return 1;
  return fibonacci(n - 1) + fibonacci(n - 2);
};

console.log("--- Pruebas Trabajo 3 ---");
console.log("División entera (27 / 4):", divisionRecursiva(27, 4));
console.log("Factorial lineal (6!):", factorial(6));
console.log("Factorial de cola (6!):", factorialCola(6));
console.log("Fibonacci F(8):", fibonacci(8));
