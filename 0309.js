class RecubrimientoTrominos {
    /**
     * Resuelve el recubrimiento de una matriz de 2^k x 2^k utilizando el teorema de Golomb.
     * @param {number} k - Exponente para determinar la dimensión 2^k de la matriz.
     */
    constructor(k) {
        this.n = Math.pow(2, k);
        this.matriz = Array.from({ length: this.n }, () => Array(this.n).fill(0));
        this.id_tromino = 1;
    }

    resolver(fila_vacia, col_vacia) {
        if (fila_vacia < 0 || fila_vacia >= this.n || col_vacia < 0 || col_vacia >= this.n) {
            throw new Error("Las coordenadas de la celda vacía están fuera de los límites de la matriz.");
        }

        this.matriz[fila_vacia][col_vacia] = -1;
        this._recubrir_recursivo(this.n, 0, 0, fila_vacia, col_vacia);
    }

    _recubrir_recursivo(tamano, fila_inicio, col_inicio, fila_deficiente, col_deficiente) {
        if (tamano === 1) return;

        const mitad = Math.floor(tamano / 2);
        const centro_f = fila_inicio + mitad;
        const centro_c = col_inicio + mitad;
        const tromino_actual = this.id_tromino++;

        const cuadrantes = [
            { f0: fila_inicio, c0: col_inicio, cf: centro_f - 1, cc: centro_c - 1 },
            { f0: fila_inicio, c0: centro_c,   cf: centro_f - 1, cc: centro_c },
            { f0: centro_f,    c0: col_inicio, cf: centro_f,     cc: centro_c - 1 },
            { f0: centro_f,    c0: centro_c,   cf: centro_f,     cc: centro_c }
        ];

        const cuadrante_deficiente =
            (fila_deficiente >= centro_f ? 2 : 0) + (col_deficiente >= centro_c ? 1 : 0);

        cuadrantes.forEach(({ f0, c0, cf, cc }, i) => {
            if (i !== cuadrante_deficiente) {
                this.matriz[cf][cc] = tromino_actual;
            }
            const df = i === cuadrante_deficiente ? fila_deficiente : cf;
            const dc = i === cuadrante_deficiente ? col_deficiente : cc;
            this._recubrir_recursivo(mitad, f0, c0, df, dc);
        });
    }

    imprimir_resultado() {
        this.matriz.forEach(fila => {
            console.log(fila.map(celda => String(celda).padStart(3, ' ')).join(' '));
        });
    }
}

// k = 3 define una matriz de 8x8
const solucionador = new RecubrimientoTrominos(3);
solucionador.resolver(1, 6);
solucionador.imprimir_resultado();
