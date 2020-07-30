module cuenta;
import std;
import tipo_moneda;

class Cuenta {
protected:
	int numero;
	tipoMoneda tipo_moneda;
	float montoActual;
	float limiteExtraccion;

public:
	this(int nro_cuenta, float limite_extraccion) {
		numero = nro_cuenta;
		limiteExtraccion = limite_extraccion;
		montoActual = 0;
	}

	void agregarMonto(float monto) {
		montoActual += monto;
	}

	void retirarMonto(float monto) {
		if (montoActual < monto)
			throw new StringException("No tienes suficiente dinero para extraer");
	
		if (monto > limiteExtraccion)
			throw new StringException("El monto indicado supera el límite de extracción");

		montoActual -= monto;
	}

	int obtenerNumeroCuenta() {
		return numero;
	}

	float obtenerMontoActual() {
		return montoActual;
	}

	string obtenerSimboloMoneda() {
		return tipo_moneda.simbolo;
	}
}
