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

	float monto_actual = cuenta.obtenerMontoActual();
	writeln("El monto inicial de la cuenta es %d\n", monto_actual);
}
