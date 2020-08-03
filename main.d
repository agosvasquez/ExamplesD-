import std;
import caja_ahorro_pesos;
import caja_ahorro_dolares;
import cuenta;
import persona_fisica;
import persona_juridica;
import sistema_bancario;
import depositante;
import core.thread : Thread;

void main() {
	ejemplo1();
	ejemplo2();
	ejemplo3();
	ejemplo4();
	ejemplo5();
	ejemplo6();
}

void ejemplo1() {
	writeln("\nEjemplo 1:\n");

	int nro_cuenta = 1;
	float limite_extraccion = 10_000;

	shared auto cuenta = new shared CajaAhorroPesos(nro_cuenta++, limite_extraccion);
	writefln("Cuenta N°%s creada correctamente!", cuenta.obtenerNumeroCuenta());
	writefln("El monto inicial de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.montoActual());

	cuenta.agregarMonto(5_000.50);
	writefln("El monto actual de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.montoActual());

	cuenta.retirarMonto(4000);
	writefln("El monto actual de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.montoActual());

	// Intento retirar una cantidad mayor a la que tengo
	try {
		cuenta.retirarMonto(4000);
	} catch (StringException e) {
		writeln(e.msg);
	}

	cuenta.agregarMonto(15_000);
	writefln("El monto actual de la cuenta es %s%s", cuenta.obtenerSimboloMoneda(),
		cuenta.montoActual());

	// Intento retirar una cantidad mayor al limite de extraccion
	try {
		cuenta.retirarMonto(12_000);
	} catch (StringException e) {
		writeln(e.msg);
	}
}

void ejemplo2() {
	writeln("\nEjemplo 2:\n");

	int nro_cuenta = 1;
	float limite_extraccion = 15_000;

	shared auto cuenta = new shared CajaAhorroDolares(nro_cuenta++, limite_extraccion);
	writefln("Cuenta N°%s creada correctamente!", cuenta.obtenerNumeroCuenta());
	writefln("El costo mensual de la cuenta es de %s%s",
		cuenta.obtenerSimboloMoneda(), cuenta.calcularCostoMensual());
}

void ejemplo3() {
	writeln("\nEjemplo 3:\n");
	shared Cuenta cuenta = new shared Cuenta(1, 500_000);
	Thread[20] depositantes;

	auto before = MonoTime.currTime;
	for (int i = 0; i < 20; i++) {
		auto depositante = new Depositante(1, 10, &cuenta).start();
		depositantes[i] = depositante;
	}

	for (int i = 0; i < 20; i++) {
		depositantes[i].join();
	}

	// Tiene que devolver 45 * 20 = 900
	writefln("El monto esperado despues que todos los depositantes agreguen su monto es de 900");
	writefln("El monto actual de la cuenta es de %s",cuenta.montoActual());
	auto after = MonoTime.currTime;
	auto timeElapsed = after - before;
	writefln("El tiempo que tardo es %s", timeElapsed);
}

void ejemplo4() {
	import std.stdio, std.algorithm, std.range;

	writeln("\nEjemplo 4:\n");

	shared Cuenta[7] cuentas;

	for (int i = 0; i < 7; i++) {
		shared cuenta = new shared Cuenta(1, 500_000);
		cuenta.agregarMonto(100);
		cuentas[i] = cuenta;
	}

	foreach (i; iota(6).parallel) {
        // El cuerpo del foreach es ejecutado en paralelo para cada i
        writefln("El monto actual de la cuenta %s es de %s", i, cuentas[i].montoActual());
    }
	
	float[] suc1 = [cuentas[0].montoActual(),cuentas[1].montoActual(), cuentas[4].montoActual()],
			suc2 = [cuentas[2].montoActual(), cuentas[3].montoActual(), cuentas[5].montoActual()],
			suc3 = [cuentas[6].montoActual()];

    // Tiene que ser inmutable para permitir el acceso desde dentro de una funcion pura
    immutable pivot = 0;

    // Funcion pura
    float mySum(float a, float b) pure nothrow {
    	return (b > pivot) ? (a + b) : a;
    }

    // Closure
    auto r = suc1.chain(suc2).chain(suc3).reduce!mySum();
    writeln("Resultado: ", r);

    // Pasar un literal delegado
    r = reduce!((a, b) => (b > pivot) ? (a + b) : a)(chain(suc1, suc2, suc3));
    writeln("Resultado: ", r);
}

void ejemplo5() {
	writeln( "\nEjemplo 5:\n");

	float limite_extraccion = 10_000;
	int nro_cuenta = 1;

	SistemaBancario banco = new SistemaBancario();

	shared Cuenta cuenta_1 = new shared CajaAhorroPesos(nro_cuenta++, limite_extraccion);
	banco.agregarPersonaFisica("Persona 1", &cuenta_1);

	shared Cuenta cuenta_2 = new shared CajaAhorroPesos(nro_cuenta++, limite_extraccion);
	banco.agregarPersonaFisica("Persona 2", &cuenta_2);

	cuenta_1.agregarMonto(1000);
	cuenta_2.agregarMonto(1000);

	banco.transferir("Persona 1", "Persona 2", 200);

	writefln("El monto actual de la cuenta 1 es de %s", cuenta_1.montoActual());
	writefln("El monto actual de la cuenta 2 es de %s", cuenta_2.montoActual());
}


void ejemplo6() {
	import core.thread : Fiber;
	writeln("\nEjemplo 6:\n");
	shared Cuenta cuenta = new shared Cuenta(1, 500_000);
	Fiber[20] depositantes;

	void depositar(){
		for (int p = 1; p <10; p++) {
        	cuenta.agregarMonto(p);
			Fiber.yield();
    	}
	}
	
	bool some_fiber_finish(Fiber[] depositantes){
		for (int i = 0; i < 20; i++) {
			if (depositantes[i].state == Fiber.State.TERM){
				return true;
			}
		}
		return false;
	}
	
	auto before = MonoTime.currTime;

	for (int i = 0; i < 20; i++) {
		auto depositante = new Fiber(&depositar);
		depositantes[i] = depositante;
	}
	while (!some_fiber_finish(depositantes))
    {
		for (int i = 0; i < 20; i++) {
			depositantes[i].call();
		}
    }
	auto after = MonoTime.currTime;
	auto timeElapsed = after - before;
	writefln("El tiempo que tardo es %s", timeElapsed);
}
