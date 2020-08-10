import std;
import caja_ahorro_pesos;
import caja_ahorro_dolares;
import cuenta;
import persona_fisica;
import persona_juridica;
import sistema_bancario;
import depositante;
import core.thread : Thread;
import std.conv;
import derived_fiber;

void main() {
	writeln("\n--------------------------------------------------------\n");
	writeln("EJEMPLO 1:\n");
	ejemplo1();

	writeln("\n--------------------------------------------------------\n");
	writeln("EJEMPLO 2:\n");
	ejemplo2();

	writeln("\n--------------------------------------------------------\n");
	writeln("EJEMPLO 3:\n");
	ejemplo3();

	writeln("\n--------------------------------------------------------\n");
	writeln("EJEMPLO 4:\n");
	ejemplo4();

	writeln("\n--------------------------------------------------------\n");
	writeln("EJEMPLO 5:\n");
	ejemplo5();

	writeln("\n--------------------------------------------------------\n");
	writeln("EJEMPLO 6:\n");
	ejemplo6();

	writeln("\n--------------------------------------------------------\n");
	writeln("EJEMPLO 7:\n");
	ejemplo7();
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
	writeln( "\nEjemplo 3:\n");

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

void ejemplo4() {
	import std.algorithm;

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
    immutable pivote = 0;

    // Funcion pura
    float mySum(float a, float b) pure nothrow {
    	return (b > pivote) ? (a + b) : a;
    }

    // Closure
    auto r = suc1.chain(suc2).chain(suc3).reduce!mySum();
    writeln("Resultado: ", r);

    // Pasar un literal delegado
    r = reduce!((a, b) => (b > pivote) ? (a + b) : a)(chain(suc1, suc2, suc3));
    writeln("Resultado: ", r);
}


int read_line(){
	writef("Enter a number: ");
    auto text = readln;
    int number = to!int(text[0..1]);
	return number;
}


void ejemplo5() {
	writeln("\nEjemplo 5:\n");

	shared Cuenta[3] cuentas;
	Thread[3] depositantes;


	for (int i = 0; i < 3; i++) {
		cuentas[i] = new shared Cuenta(1, 500_000);
	}

	depositantes[0] = new Depositante(1, 10, &cuentas[0]).start();
	depositantes[1] = new Depositante(1, 10, &cuentas[1]).start();
	depositantes[2] = new Depositante(1, 10, &cuentas[2]).start();


	for (int i = 0; i < 3; i++) {
		depositantes[i].join();
	}

	for (int i = 0; i < 3; i++) {
		writefln("El monto actual de la cuenta es de %s",cuentas[i].montoActual());
	}


}

void ejemplo6() {
	import core.thread : Fiber;

	writeln("\nEjemplo 6:\n");
	shared Cuenta[3] cuentas;
	Fiber[3] depositantes;

	void say_hello() {
		writef("Enter your name: \n");
		Fiber.yield();
   		auto name = readln();
    	writef("Hello %s", name);
	}

	bool some_fiber_finish(Fiber[] depositantes) {
		for (int i = 0; i < 3; i++) {
			if (depositantes[i].state == Fiber.State.TERM){
				return true;
			}
		}
		return false;
	}
	
	auto hello = new Fiber(&say_hello);
	hello.call();

	for (int i = 0; i < 3; i++) {
		cuentas[i] = new shared Cuenta(1, 500_000);
	}

	depositantes[0] = new DerivedFiber(cuentas[0], 10);
	depositantes[1] = new DerivedFiber(cuentas[1], 10);
	depositantes[2] = new DerivedFiber(cuentas[2], 10);


	while (!some_fiber_finish(depositantes)) {
		for (int i = 0; i < 3; i++) {
			depositantes[i].call();
		}
    }

	for (int i = 0; i < 3; i++) {
		writefln("El monto actual de la cuenta es de %s",cuentas[i].montoActual());
	}
	hello.call();
}

void ejemplo7() {
	import std.algorithm;
	import core.thread : Fiber;

	// Cantidad de chars totales
	int total_char = 0;

	// Char a buscar
	char c = 'a';

	// Archivo
	int num_lineas = 10_000_000;
	string linea_str = "Hola mundo! Esto es una prueba de procesamiento en paralelo.";
	int largo_linea = cast(int) linea_str.length;

	// Procesadores
	int num_procesadores = 1_000;
	int linea_inicio = 0;
	int lineas_por_procesador = cast(int) num_lineas/num_procesadores;

	// Creo el archivo
	writefln("Creando archivo de %s lineas...\n", num_lineas);
	auto f = File("test_file.txt", "w");
	for (int i = 0; i < num_lineas; i ++)
		f.writeln(linea_str);
	f.close();
	writeln("OK!\n");

	// -------------------------- //
	// PROCESAMIENTO CON PARALLEL //
	// -------------------------- //

	writeln("Procesamiento con Parallel:");

	// Creo la clase contadora de chars
	class ContadorChar {
		int id;

		this(int id) {
			this.id = id;
		}

		int contarChar(char c, ref File f, int linea_inicio, int n) {
			f.seek(linea_inicio * largo_linea);
			string linea;
			int cant_char;

			for(int i = 0; i < n; i ++) {
				linea = f.readln();
				foreach(actual_char; linea_str)
					if (actual_char == c) cant_char ++;
			}
			return cant_char;
		}
	}

	// Creo los contadores
	ContadorChar[] contadores;
	for(int i = 0; i < num_procesadores; i ++)
		contadores ~= new ContadorChar(i + 1);

	// Abro el archivo y paralelizo el contador de chars
	f = File("test_file.txt", "r");

	auto t_inicial = MonoTime.currTime;
	writefln("- Procesando archivo con %s procesadores...", num_procesadores);

	foreach(contador; parallel(contadores)) {
		total_char += contador.contarChar(c, f, linea_inicio, lineas_por_procesador);
		linea_inicio += lineas_por_procesador;
    }
	f.close();

	auto t_final = MonoTime.currTime;
	auto t_total = t_final - t_inicial;

	writefln("- Cantidad de '%s' encontradas en el archivo: %s", c, total_char);
	writefln("- Tiempo de ejecución: %s", t_total);

	// ------------------------ //
	// PROCESAMIENTO CON FIBERS //
	// ------------------------ //

	total_char = 0;
	linea_inicio = 0;

	writeln("\nProcesamiento con Fibers:");

	// Funciones de Fibers
	void contar_char() {
		f.seek(linea_inicio * largo_linea);
		string linea;
		int cant_char;

		for(int i = 0; i < lineas_por_procesador; i ++) {
			linea = f.readln();
			foreach(actual_char; linea_str)
				if (actual_char == c) cant_char ++;
		}
		total_char += cant_char;
		Fiber.yield();
	}

	bool finalizo_algun_fiber(Fiber[] fibers) {
		for (int i = 0; i < num_procesadores; i++) {
			if (fibers[i].state == Fiber.State.TERM)
				return true;
		}
		return false;
	}

	// Abro el archivo y paralelizo el contador de chars
	f = File("test_file.txt", "r");

	t_inicial = MonoTime.currTime;
	writefln("- Procesando archivo con %s procesadores...", num_procesadores);

	Fiber[] fibers;

	for (int i = 0; i < num_procesadores; i++) {
		fibers ~= new Fiber(&contar_char);
		linea_inicio += lineas_por_procesador;
	}

	while (! finalizo_algun_fiber(fibers)) {
		for (int i = 0; i < num_procesadores; i++) {
			fibers[i].call();
		}
    }
	f.close();

	t_final = MonoTime.currTime;
	t_total = t_final - t_inicial;

	writefln("- Cantidad de '%s' encontradas en el archivo: %s", c, total_char);
	writefln("- Tiempo de ejecución: %s", t_total);
}
