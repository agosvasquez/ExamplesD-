module sistema_bancario;
import cuenta;
import cliente;
import persona_fisica;
import persona_juridica;

class SistemaBancario {
    Cliente[string] clientes;

    this() {}

    void eliminarUsuario(string id) {
        clientes.remove(id);
    }

    void transferir(string id_origen, string id_destino, int monto) {
        clientes[id_origen].agregarMonto(monto);
        clientes[id_destino].retirarMonto(monto);
    }

    void agregarPersonaFisica(string id, shared Cuenta* cuenta) {
        Cliente cliente = new PersonaFisica(cuenta);
        clientes[id] = cliente;
    }

    void agregarPersonaJuridica(string id, shared Cuenta* cuenta) {
        Cliente cliente = new PersonaJuridica(cuenta);
        clientes[id] = cliente;
    }
}