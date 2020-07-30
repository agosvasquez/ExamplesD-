module caja_ahorro_pesos;
import cuenta;

class CajaAhorroPesos : Cuenta {
public:
	this(int nro_cuenta, float limite_extraccion) {
		super(nro_cuenta, limite_extraccion);
		moneda = PESO;
	}
}
