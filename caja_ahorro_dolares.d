module caja_ahorro_dolares;
import cuenta;
import imponible;

class CajaAhorroDolares : Cuenta, Imponible {
private:
	float constanteMensual;

public:
	this(int nro_cuenta, float limite_extraccion) shared @safe nothrow {
		super(nro_cuenta, limite_extraccion);
		tipo_moneda.moneda = "DOLAR";
		tipo_moneda.simbolo = "USD";
		constanteMensual = 0.1;
	}

	float calcularCostoMensual() shared {
		return constanteMensual * limiteExtraccion;
	}
}
