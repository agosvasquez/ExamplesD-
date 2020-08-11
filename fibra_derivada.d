module fibra_derivada;
import core.thread : Fiber;
import cuenta;

class FibraDerivada : Fiber
{
	shared Cuenta cuenta;
	int numero;
	this(shared Cuenta cuenta, int numero)
	{
		this.cuenta = cuenta;
		this.numero = numero;
		super( &run );
	}

private :
	void run()
	{
		for (int p = 1; p <numero; p++) {
			cuenta.agregarMonto(p);
			Fiber.yield();
		}
	
	}
}