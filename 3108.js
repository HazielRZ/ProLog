
/**
 * Valida que los paréntesis de una expresión estén correctamente balanceados
 * utilizando una estructura de pila (stack).
 *
 * @param {string} expresion - La cadena que contiene los paréntesis a evaluar.
 * @returns {boolean} true si los paréntesis están balanceados, false en caso contrario.
 */
function validacion(expresion) {
    const pila = [];

    for (let i = 0; i < expresion.length; i++) {
        if (expresion[i] === '(') {
            pila.push(expresion[i]);
        }

        if (expresion[i] === ')') {
            if (pila.length === 0) {
                return false; // paréntesis de cierre sin paréntesis de apertura
            }
            pila.pop();
        }
    }

    // Si la pila está vacía, la expresión es correcta
    const valida = pila.length === 0;
    if (valida) {
        return true; // correcta
    } else {
        return false; // error: quedan paréntesis de apertura sin cerrar
    }
}

// --- Programa principal ---

const expresiones = [
    "((()()",     // incorrecta — falta un cierre
    "(())()",     // correcta
    ")()",        // incorrecta — cierre antes de apertura
    "()",         // correcta
    "((()))",     // correcta
    "(()",        // incorrecta
    "",           // correcta — cadena vacía
];

expresiones.forEach(expresion => {
    const resultado = validacion(expresion);
    if (resultado === true) {
        console.log(`La expresión: "${expresion}" es correcta`);
    } else {
        console.log(`La expresión: "${expresion}" es incorrecta`);
    }
});
