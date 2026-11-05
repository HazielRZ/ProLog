
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
console.log("--- Pruebas Trabajo 2 ---");
console.log("Longitud:", longitudLista(muestra));
console.log("Sumatoria:", sumarElementos(muestra));
console.log("Inversión inmutable:", invertirLista(muestra));
console.log("Múltiplos de 15:", filtrarLista(muestra, (x) => x % 15 === 0));
