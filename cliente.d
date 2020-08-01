module cliente;
import cuenta;

class Cliente {
    Cuenta cuenta;
    this () {}



    void agregarMonto(int monto) {
        cuenta.agregarMonto(monto);
    }
    void retirarMonto(int monto) {
        cuenta.retirarMonto(monto);
    }
}
