module caja_ahorro_pesos;
import cuenta;

class CajaAhorroPesos : Cuenta {
public:
	this() {
		// TODO: tener un contador tipo id_manager
		numero = 1;
		moneda = PESO;
		// TODO: tomar esto de algun lado
		limiteExtraccion = 10_000;
		montoActual = 0;
	}
}
