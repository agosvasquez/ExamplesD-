module caja_ahorro_dolares;
import cuenta;

class CajaAhorroDolares : Cuenta {
public:
	this(int nro_cuenta, float limite_extraccion) {
		super(nro_cuenta, limite_extraccion);
		moneda = DOLAR;
	}
}
