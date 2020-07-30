import std;
import caja_ahorro_pesos;
import caja_ahorro_dolares;

void main() {
	ejemplo1();
}

void ejemplo1() {
	int nro_cuenta = 1;
	float limite_extraccion = 10_000;

	auto cuenta = new CajaAhorroPesos(nro_cuenta++, limite_extraccion);
	writefln("El monto inicial de la cuenta es %s", cuenta.obtenerMontoActual());

	cuenta.agregarMonto(5_000.50);
	writefln("El monto actual de la cuenta es %s", cuenta.obtenerMontoActual());

	cuenta.retirarMonto(4000);
	writefln("El monto actual de la cuenta es %s", cuenta.obtenerMontoActual());

	try {
		cuenta.retirarMonto(4000);
	} catch (StringException e) {
		writeln(e.msg);
	}

	cuenta.agregarMonto(15_000);
	writefln("El monto actual de la cuenta es %s", cuenta.obtenerMontoActual());

	try {
		cuenta.retirarMonto(12_000);
	} catch (StringException e) {
		writeln(e.msg);
	}
}
