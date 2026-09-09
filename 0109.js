function factorial(n) {

    if (n === 0 || n === 1) {
        return 1;
    }
    return n * factorial(n - 1);
}
console.log(factorial(5));

function fibonacci(n){
    if (n < 2) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}
console.log(fibonacci(5));

    function division(dividendo, divisor) {
        if (divisor === 0) {
            return "No se puede dividir entre 0";
        }

        if (dividendo < divisor) {
            return { cociente: 0, residuo: dividendo };
        }

        const result = division(dividendo - divisor, divisor);

        return {
            cociente: 1 + result.cociente,
            residuo: result.residuo
        };
    }

    console.log(division(10, 3));



