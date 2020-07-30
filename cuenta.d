module cuenta;
import std;

enum PESO = "PESO", DOLAR = "DOLAR";

// TODO: agregar interfaz del costo de mantenimiento
class Cuenta {
protected:
	int numero;
	string moneda;
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
			throw new StringException("No tienes suficiente dinero para extraer\n");
	
		if (monto > limiteExtraccion)
			throw new StringException("El monto indicado supera el límite de extracción\n");

		montoActual -= monto;
	}

	float obtenerMontoActual() {
		return montoActual;
	}
}
