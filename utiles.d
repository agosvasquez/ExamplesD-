module utiles;
import std;
import core.thread : Fiber;
import std.conv;

/**
  Imprime una linea de saludo para el nombre ingresado.

  Es una funcion para ser usada por una fibra y la cual
  requiere dos llamados para completarse.

  Example:
  -------------------
  auto fibra_saludo = new Fiber(&saludar);
  -------------------

  License: use freely for any purpose
  Throws: throws nothing.
  Returns: no returns.
*/

void saludar(){
    writef("Ingresa tu nombre: \n\n");
    Fiber.yield();
    auto nombre = readln();
    writef("Hola %s", nombre);
}


/**
  Verifica si alguna fibra en la lista finalizo su ejecucion.

  Dada una lista de fibras por cada una verifica cual
  es su estado, en el caso en el que alguna de ellas haya concluido
  devuelve verdadero, en otro caso devuelve falso.

  Example:
  -------------------
  Fibers[10] fibras
  bool finalizo = alguna_fibra_finalizo(fibras);
  -------------------
  Params:
    fibras = lista de fibras a ser analizada.

  License: use freely for any purpose
  Throws: throws nothing.
  Returns: boleeano.
*/

bool alguna_fibra_finalizo(Fiber[] fibras) {
	for (int i = 0; i < 3; i++) {
		if (fibras[i].state == Fiber.State.TERM){
			return true;
		}
	}
	return false;
}

