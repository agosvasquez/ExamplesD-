module caja_ahorro_pesos;
import cuenta;

class CajaAhorroPesos : Cuenta {
public:
	this(int nro_cuenta, float limite_extraccion) {
		numero = nro_cuenta;
		moneda = PESO;
		limiteExtraccion = limite_extraccion;
		montoActual = 0;
	}
}
