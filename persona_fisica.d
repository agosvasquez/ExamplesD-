module persona_fisica;
import cliente;
import cuenta;



class PersonaFisica : Cliente {

    this(shared Cuenta* cuenta_recibida) {
        super(cuenta_recibida);
    }

    void depositarPlazoFijo(int cantidad) {

    }

}