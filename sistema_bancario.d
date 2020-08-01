import cuenta;
import cliente;

class SistemaBancario {
    Cliente*[string] clientes;

    this() {}
    void agregarUsuario(string id) {
        Cliente cliente = new Cliente();
        clientes[id] = &cliente;
    }
    void eliminarUsuario(string id) {
        clientes.remove(id);
    }

    void transferir(string id_origen, string id_destino, int monto) {
        clientes[id_origen].agregarMonto(monto);
        clientes[id_destino].retirarMonto(monto);
    }
}