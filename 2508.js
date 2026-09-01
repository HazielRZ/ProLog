
const CIEN = 100;
const CINCUENTA = 50;
const VEINTE = 20;
const DIEZ = 10;
const CINCO = 5;
const DOS = 2;
const UNO = 1;

const denominaciones = [CIEN, CINCUENTA, VEINTE, DIEZ, CINCO, DOS, UNO];

function encontrarCombinaciones(montoRestante, indiceActual, combinacionActual, resultados) {
    if (montoRestante === 0) {
        const desglose = [];
        for (let i = 0; i < combinacionActual.length; i++) {
            if (combinacionActual[i] > 0) {
                desglose.push(`${combinacionActual[i]} de ${denominaciones[i]}`);
            }
        }

        if (desglose.length > 0) {
            resultados.push(desglose.join(' y '));
        }
        return;
    }

    if (indiceActual >= denominaciones.length || montoRestante < 0) {
        return;
    }

    const denominacionActual = denominaciones[indiceActual];
    const maximoUnidades = Math.floor(montoRestante / denominacionActual);

    for (let cantidad = maximoUnidades; cantidad >= 0; cantidad--) {
        const nuevaCombinacion = [...combinacionActual];
        nuevaCombinacion[indiceActual] = cantidad;
        encontrarCombinaciones(
            montoRestante - (cantidad * denominacionActual),
            indiceActual + 1,
            nuevaCombinacion,
            resultados
        );
    }
}


function desglosarMonto(monto) {
    console.log(`\n--- Evaluando el espacio de soluciones para el monto: ${monto} ---`);

    const resultados = [];
    const combinacionInicial = new Array(denominaciones.length).fill(0);

    encontrarCombinaciones(monto, 0, combinacionInicial, resultados);

    resultados.forEach(resultado => {
        console.log(`${monto} = ${resultado}`);
    });

    console.log(`\nTotal de combinaciones únicas encontradas: ${resultados.length}`);
}

desglosarMonto(10);