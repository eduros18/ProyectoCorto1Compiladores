object Prueba {

  def main(args: Array[String]): Unit = {

    val nombre = "Angel"
    val edad = 20
    val promedio = 85.5
    val estudiante = true

    val numero1 = 10
    val numero2 = 5

    val suma = numero1 + numero2
    val resta = numero1 - numero2
    val multi = numero1 * numero2
    val division = numero1 / numero2
    val residuo = numero1 % numero2

    if (edad >= 18 && estudiante == true) {
      println("Mayor de edad")
    }

    if (numero1 != numero2) {
      println("Son diferentes")
    }

  }

}