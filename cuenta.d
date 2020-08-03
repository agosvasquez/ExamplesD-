module cuenta;
import core.sync.mutex;
import std;
import moneda;
import core.atomic : atomicOp;

synchronized class Cuenta {
protected:
	int numero;
	moneda tipoMoneda;
	float mActual;
	float limiteExtraccion;

public:
	this(int nro_cuenta, float limite_extraccion)  @safe nothrow {
		numero = nro_cuenta;
		limiteExtraccion = limite_extraccion;
		mActual = 0;
	}

	void agregarMonto(float monto) {
		atomicOp!"+="(this.mActual, monto);
	}

	void retirarMonto(float monto){
		if (mActual < monto) {
			throw new StringException( "No tienes suficiente dinero para extraer");
		}
	
		if (monto > limiteExtraccion) {
			throw new StringException( "El monto indicado supera el límite de extracción");
		}

		atomicOp!"-="(this.mActual, monto);
	}

	int obtenerNumeroCuenta(){
		return numero;
	}

	float montoActual(){
		return mActual;
	}

	string obtenerSimboloMoneda() {
		return tipoMoneda.simbolo;
	}
}
