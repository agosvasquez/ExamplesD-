import cliente;
import imponible;


class PersonaJuridica : Cliente, Imponible {

    this () {

    }

    float calcularCostoMensual() shared {
        return 1000;
    }

}