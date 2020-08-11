module depositante;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
import core.thread : Thread;
import cuenta;

class Depositante : Thread {
private:
    int inicio;
    int fin;
    shared Cuenta* cuenta;
    
    void run () {
        for (int p = this.inicio; p < this.fin; p++) {
            cuenta.agregarMonto(p);
        }
    }
    
public:
    this(int inicio, int fin, shared Cuenta* cuenta) @safe {
        this.inicio = inicio;
        this.fin = fin;
        this.cuenta = cuenta;
        super(&run);
    }
}
