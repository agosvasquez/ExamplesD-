module cliente;
import cuenta;

class Cliente {
private:
    shared Cuenta* cuenta;

public:
    this (shared Cuenta* cuenta) {
        this.cuenta = cuenta;
    }

    void agregarMonto(int monto) {
        cuenta.agregarMonto(monto);
    }
    void retirarMonto(int monto) {
        cuenta.retirarMonto(monto);
    }
}
