module caja_ahorro_pesos;
import cuenta;

class CajaAhorroPesos : Cuenta {
public:
	this(int nro_cuenta, float limite_extraccion) shared @safe nothrow {
		super(nro_cuenta, limite_extraccion);
		tipoMoneda.nombre = "PESO";
		tipoMoneda.simbolo = "$";
	}
}
