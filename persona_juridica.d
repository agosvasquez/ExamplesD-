module persona_juridica;
import cliente;
import imponible;
import cuenta;

class PersonaJuridica : Cliente, Imponible {
public:
    this (shared Cuenta* cuenta_recibida) {
        super(cuenta_recibida);
    }

    float calcularCostoMensual() shared {
        return 1000;
    }
}