exports.handler = async (event) => {
    const n = parseInt(event.number, 10);

    const start = new Date(); // kezdet

    const fibonacci = (n) => {
        if (n <= 0) {
            return 0;
        } else if (n === 1) {
            return 1;
        } else {
            return fibonacci(n - 1) + fibonacci(n - 2);
        }
    };

    const result = fibonacci(n);

    const end = new Date(); // vege
    const execution = (end - start) + "ms"; // milisec

    const response = {
        statusCode: 200,
        body: JSON.stringify({ result, execution }),
    };

    return response;
};
