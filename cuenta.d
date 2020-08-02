module cuenta;
import core.sync.mutex;
import std;
import tipo_moneda;

class Cuenta {
protected:
	shared Mutex mtx;
	int numero;
	tipoMoneda tipo_moneda;
	float montoActual;
	float limiteExtraccion;

public:
	this(int nro_cuenta, float limite_extraccion) shared @safe nothrow {
		mtx = new shared Mutex();
		numero = nro_cuenta;
		limiteExtraccion = limite_extraccion;
		montoActual = 0;
	}

	void agregarMonto(float monto) shared {
		mtx.lock_nothrow();
		(cast() montoActual) += monto;
		mtx.unlock_nothrow();
	}

	void retirarMonto(float monto) shared {
		mtx.lock_nothrow();
		if (montoActual < monto) {
			mtx.unlock_nothrow();
			throw new StringException( "No tienes suficiente dinero para extraer");
		}
	
		if (monto > limiteExtraccion) {
			mtx.unlock_nothrow();
			throw new StringException( "El monto indicado supera el límite de extracción");
		}

		(cast() montoActual) -= monto;
		mtx.unlock_nothrow();
	}

	int obtenerNumeroCuenta() shared {
		return numero;
	}

	float obtenerMontoActual() shared {
		mtx.lock_nothrow();
		float monto = montoActual;
		mtx.unlock_nothrow();
		return monto;
	}

	string obtenerSimboloMoneda() shared {
		return tipo_moneda.simbolo;
	}
}
