function validacion(expresion) {
    const pila = [];

    for (let i = 0; i < expresion.length; i++) {
        if (expresion[i] === '(') {
            pila.push(expresion[i]);
        } else if (expresion[i] === ')') {
            if (pila.length === 0) {
                return false;
            }
            pila.pop();
        }
    }

    return pila.length === 0;
}

const expresiones = [
    "((()()",
    "(())()",
    ")()",
    "()",
    "((()))",
    "(()",
    "",
];

expresiones.forEach(expresion => {
    const estado = validacion(expresion) ? "correcta" : "incorrecta";
    console.log(`La expresión: "${expresion}" es ${estado}`);
});
