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
}

void ejemplo1() {
	writeln("\nEjemplo 1:\n");

	int nro_cuenta = 1;
	float limite_extraccion = 10_000;

	shared auto cuenta = new shared CajaAhorroPesos(nro_cuenta++, limite_extraccion);
	writefln("Cuenta N°%s creada correctamente!", cuenta.obtenerNumeroCuenta());
	writefln("El monto inicial de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.obtenerMontoActual());

	cuenta.agregarMonto(5_000.50);
	writefln("El monto actual de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.obtenerMontoActual());

	cuenta.retirarMonto(4000);
	writefln("El monto actual de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.obtenerMontoActual());

	try {
		cuenta.retirarMonto(4000);
	} catch (StringException e) {
		writeln(e.msg);
	}

	cuenta.agregarMonto(15_000);
	writefln("El monto actual de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.obtenerMontoActual());

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
	float balance = cuenta.obtenerMontoActual();
	writeln(balance);
}