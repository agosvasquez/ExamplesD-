import std;
import caja_ahorro_pesos;
import caja_ahorro_dolares;
import cuenta;
import summation;
import core.thread : Thread;


void main() {
	ejemplo1();
	ejemplo2();
	ejemplo3();
	ejemplo4();
}

void ejemplo1() {
	writeln("\nEjemplo 1:\n");

	int nro_cuenta = 1;
	float limite_extraccion = 10_000;

	shared auto cuenta = new shared CajaAhorroPesos(nro_cuenta++, limite_extraccion);
	writefln("Cuenta N°%s creada correctamente!", cuenta.obtenerNumeroCuenta());
	writefln("El monto inicial de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.montoActual());

	cuenta.agregarMonto(5_000.50);
	writefln("El monto actual de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.montoActual());

	cuenta.retirarMonto(4000);
	writefln("El monto actual de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.montoActual());

	try {
		cuenta.retirarMonto(4000);
	} catch (StringException e) {
		writeln(e.msg);
	}

	cuenta.agregarMonto(15_000);
	writefln("El monto actual de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.montoActual());

	try {
		cuenta.retirarMonto(12_000);
	} catch (StringException e) {
		writeln(e.msg);
	}
}

void ejemplo2() {
	writeln("\nEjemplo 2:\n");

	int nro_cuenta = 1;
	float limite_extraccion = 15_000;

	shared auto cuenta = new shared CajaAhorroDolares(nro_cuenta++, limite_extraccion);
	writefln("Cuenta N°%s creada correctamente!", cuenta.obtenerNumeroCuenta());
	writefln("El costo mensual de la cuenta es de %s%s",
		cuenta.obtenerSimboloMoneda(), cuenta.calcularCostoMensual());
}


void ejemplo3() {
	writeln("\nEjemplo 3:\n");
	shared Cuenta cuenta = new shared Cuenta(1, 500000);
	Thread[20] threads;

	for (int i = 0; i < 20; i++) {

		auto thread = new Sum(
		1,
		10,
		&cuenta).start();
		threads[i] = thread;
	}

	for (int i = 0; i < 20; i++) {
		threads[i].join();
	}

	//tiene que devolver 45*20
	writefln("El monto esperado despues que todos los threads agreguen su monto es de 900");
	writefln("El monto actual  de la cuenta es de %s",cuenta.montoActual());
}


void ejemplo4() {
	writeln("\nEjemplo 4:\n");
	import std.stdio, std.algorithm, std.range;

	shared Cuenta[7] cuentas;

	for (int i = 0; i < 7; i++) {
		shared cuenta = new shared Cuenta(1, 500000);
		cuenta.agregarMonto(100);
		cuentas[i] = cuenta;
	}

	
	float[] suc1 = [cuentas[0].montoActual(),cuentas[1].montoActual(), cuentas[4].montoActual()];
	float[] suc2 = [cuentas[2].montoActual(), cuentas[3].montoActual(), cuentas[5].montoActual()];
	float[] suc3 = [cuentas[6].montoActual()];
    // tiene que ser inmutable para permitir 
	//el acceso desde dentro de una funcion pura
    immutable pivot = 0;

    float mySum(float a, float b) pure nothrow // pure 
    {
        if (b > pivot)
            return a + b;
        else
            return a;
    }

    // passing a deleg (closure)
    auto r = suc1.chain(suc2).chain(suc3).reduce!mySum();
    writeln("Result: ", r); // Result: 15

    // passing a delegate literal
    r = reduce!((a, b) => (b > pivot) ? a + b :a)(chain(suc1, suc2, suc3));
    writeln("Result: ", r); // Result: 15
}