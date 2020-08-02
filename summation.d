module summation;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
//import core.thread.osthread;
import core.thread : Thread;
import cuenta;


class Sum: Thread {
    int inicio;
    int fin;
    shared Cuenta* cuenta;

    this(int inicio_recibido, int fin_recibido, shared Cuenta* _cuenta)@safe nothrow
    {
        this.inicio = inicio_recibido;
        this.fin = fin_recibido;
        cuenta = _cuenta;
        super(&run);
    }
private:
    void run () {
        for (int p = this.inicio; p < this.fin; p++) {
            cuenta.agregarMonto(p);
        }
    }
}