module caja_ahorro_dolares;
import cuenta;

class CajaAhorroDolares : Cuenta {
public:
	this() {
		// TODO: tener un contador tipo id_manager
		numero = 1;
		moneda = DOLAR;
		// TODO: tomar esto de algun lado
		limiteExtraccion = 10_000;
		montoActual = 0;
	}
}
