module caja_ahorro_dolares;
import cuenta;

class CajaAhorroDolares : Cuenta {
public:
	this(int nro_cuenta, float limite_extraccion) {
		numero = nro_cuenta;
		moneda = DOLAR;
		// TODO: tomar esto de algun lado
		limiteExtraccion = limite_extraccion;
		montoActual = 0;
	}
}
