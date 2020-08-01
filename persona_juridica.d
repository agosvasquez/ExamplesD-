import cliente;
import imponible;


class PersonaJuridica : Cliente, Imponible {

    this () {

    }

    float calcularCostoMensual() {
        return 1000;
    }

}