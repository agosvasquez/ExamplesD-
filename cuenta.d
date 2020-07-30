module cuenta;
import std;

enum PESO = "PESO", DOLAR = "DOLAR";

// TODO: agregar interfaz del costo de mantenimiento
class Cuenta {
protected:
	int numero;
	string moneda;
	int limiteExtraccion;
	float montoActual;

public:
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
}
