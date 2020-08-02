module cliente;
import cuenta;

class Cliente {
    shared Cuenta cuenta;
    this () {}



    void agregarMonto(int monto) {
        cuenta.agregarMonto(monto);
    }
    void retirarMonto(int monto) {
        cuenta.retirarMonto(monto);
    }
}
