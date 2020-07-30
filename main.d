import std;
import caja_ahorro_pesos;
import caja_ahorro_dolares;

void main() {
	ejemplo1();
	ejemplo2();
}

void ejemplo1() {
	writeln("\nEjemplo 1:\n");

	int nro_cuenta = 1;
	float limite_extraccion = 10_000;

	auto cuenta = new CajaAhorroPesos(nro_cuenta++, limite_extraccion);
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

	auto cuenta = new CajaAhorroDolares(nro_cuenta++, limite_extraccion);
	writefln("Cuenta N°%s creada correctamente!", cuenta.obtenerNumeroCuenta());
	writefln("El costo mensual de la cuenta es de %s%s",
		cuenta.obtenerSimboloMoneda(), cuenta.calcularCostoMensual());
}
