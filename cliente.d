module cliente;
import cuenta;

class Cliente {
    shared Cuenta* cuenta;
    this (shared Cuenta* cuenta_recibida) {
        cuenta = cuenta_recibida;
    }



    void agregarMonto(int monto) {
        cuenta.agregarMonto(monto);
    }
    void retirarMonto(int monto) {
        cuenta.retirarMonto(monto);
    }
}
