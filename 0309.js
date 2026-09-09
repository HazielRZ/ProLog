class RecubrimientoTrominos {
    /**
     * Resuelve el recubrimiento de una matriz de 2^k x 2^k utilizando el teorema de Golomb.
     * @param {number} k - El exponente para determinar la dimensión de la matriz.
     */
    constructor(k) {
        this.n = Math.pow(2, k);
        // Inicialización segura de la matriz bidimensional con ceros
        this.matriz = Array.from({ length: this.n }, () => Array(this.n).fill(0));
        this.id_tromino = 1;
    }

    /**
     * Punto de entrada para iniciar el algoritmo.
     * @param {number} fila_vacia - Coordenada X de la celda deficiente.
     * @param {number} col_vacia - Coordenada Y de la celda deficiente.
     */
    resolver(fila_vacia, col_vacia) {
        if (fila_vacia < 0 || fila_vacia >= this.n || col_vacia < 0 || col_vacia >= this.n) {
            throw new Error("Las coordenadas de la celda vacía están fuera de los límites de la matriz.");
        }

        // Se marca la celda deficiente con -1
        this.matriz[fila_vacia][col_vacia] = -1;
        this._recubrir_recursivo(this.n, 0, 0, fila_vacia, col_vacia);
    }

    /**
     * Función recursiva central basada en el paradigma Divide y Vencerás.
     */
    _recubrir_recursivo(tamano, fila_inicio, col_inicio, fila_deficiente, col_deficiente) {
        // Caso base: Submatriz trivial de 1x1
        if (tamano === 1) {
            return;
        }

        const mitad = Math.floor(tamano / 2);
        const centro_f = fila_inicio + mitad;
        const centro_c = col_inicio + mitad;

        const tromino_actual = this.id_tromino;
        this.id_tromino++;

        // Determinar ubicación topológica de la celda deficiente
        let cuadrante_deficiente = -1;
        if (fila_deficiente < centro_f && col_deficiente < centro_c) {
            cuadrante_deficiente = 0; // Superior Izquierdo
        } else if (fila_deficiente < centro_f && col_deficiente >= centro_c) {
            cuadrante_deficiente = 1; // Superior Derecho
        } else if (fila_deficiente >= centro_f && col_deficiente < centro_c) {
            cuadrante_deficiente = 2; // Inferior Izquierdo
        } else {
            cuadrante_deficiente = 3; // Inferior Derecho
        }

        // Intervención central: posicionar el trominó en los cuadrantes no deficientes
        if (cuadrante_deficiente !== 0) this.matriz[centro_f - 1][centro_c - 1] = tromino_actual;
        if (cuadrante_deficiente !== 1) this.matriz[centro_f - 1][centro_c] = tromino_actual;
        if (cuadrante_deficiente !== 2) this.matriz[centro_f][centro_c - 1] = tromino_actual;
        if (cuadrante_deficiente !== 3) this.matriz[centro_f][centro_c] = tromino_actual;

        // Propagación recursiva hacia los cuatro cuadrantes

        // Cuadrante 0
        if (cuadrante_deficiente === 0) {
            this._recubrir_recursivo(mitad, fila_inicio, col_inicio, fila_deficiente, col_deficiente);
        } else {
            this._recubrir_recursivo(mitad, fila_inicio, col_inicio, centro_f - 1, centro_c - 1);
        }

        // Cuadrante 1
        if (cuadrante_deficiente === 1) {
            this._recubrir_recursivo(mitad, fila_inicio, centro_c, fila_deficiente, col_deficiente);
        } else {
            this._recubrir_recursivo(mitad, fila_inicio, centro_c, centro_f - 1, centro_c);
        }

        // Cuadrante 2
        if (cuadrante_deficiente === 2) {
            this._recubrir_recursivo(mitad, centro_f, col_inicio, fila_deficiente, col_deficiente);
        } else {
            this._recubrir_recursivo(mitad, centro_f, col_inicio, centro_f, centro_c - 1);
        }

        // Cuadrante 3
        if (cuadrante_deficiente === 3) {
            this._recubrir_recursivo(mitad, centro_f, centro_c, fila_deficiente, col_deficiente);
        } else {
            this._recubrir_recursivo(mitad, centro_f, centro_c, centro_f, centro_c);
        }
    }

    /**
     * Emite la matriz estándar formateada en consola.
     */
    imprimir_resultado() {
        this.matriz.forEach(fila => {
            // padStart asegura la alineación visual de los identificadores
            const filaFormateada = fila.map(celda => String(celda).padStart(3, ' ')).join(' ');
            console.log(filaFormateada);
        });
    }
}

// ==========================================
// Ejecución del módulo
// ==========================================

// k = 3 corresponde a una matriz de 8x8
// k = 3 define la matriz de 8x8
const solucionador = new RecubrimientoTrominos(3);

// Coordenadas extraídas de imagen.png (índice 0)
const celda_faltante_f = 1;
const celda_faltante_c = 6;

solucionador.resolver(celda_faltante_f, celda_faltante_c);

// La salida en consola agrupará enteros idénticos conformando las formas 'L'
// equivalentes a los bloques de color (rojo, azul, amarillo) de la imagen.
solucionador.imprimir_resultado();


// Alternativa de visualización nativa en entornos Node/Navegador:
// console.table(solucionador.matriz);