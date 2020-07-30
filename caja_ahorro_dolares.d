module caja_ahorro_dolares;
import cuenta;
import imponible;

class CajaAhorroDolares : Cuenta, Imponible {
public:
	this(int nro_cuenta, float limite_extraccion) {
		super(nro_cuenta, limite_extraccion);
		tipo_moneda.moneda = "DOLAR";
		tipo_moneda.simbolo = "USD";
	}

	float calcularCostoMensual() {
		return 0.1 * limiteExtraccion;
	}
}
