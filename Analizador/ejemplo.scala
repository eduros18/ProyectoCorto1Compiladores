// Archivo de ejemplo para probar el analizador lexico
// Cubre palabras reservadas, identificadores, numeros, booleanos, cadenas y operadores

import scala.collection.mutable

object Calculadora {

  /* Clase que representa una operacion matematica simple
     con dos operandos y un resultado */
  class Operacion(val a: Int, val b: Int) {

    private val activo: Boolean = true
    val nombre: String = "suma basica"

    def sumar(): Int = {
      val resultado = a + b
      return resultado
    }

    def restar(): Int = a - b

    def multiplicar(): Int = a * b

    def dividir(): Double = {
      if (b != 0) {
        a / b
      } else {
        0.0
      }
    }
  }

  trait Validador {
    def validar(x: Int): Boolean
  }

  case class Punto(x: Double, y: Double)

  def esPositivo(numero: Int): Boolean = {
    if (numero >= 0) {
      true
    } else {
      false
    }
  }

  def clasificar(valor: Int): String = valor match {
    case 0 => "cero"
    case n if n > 0 => "positivo"
    case _ => "negativo"
  }

  def main(args: Array[String]): Unit = {
    val op = new Operacion(10, 3)
    var contador = 0
    val precioTotal = 45.75
    val tasaDescuento = 0.15
    val disponible = true
    val agotado = false
    val mensaje = "Procesando pedido"
    val error = "El valor no puede ser nulo"

    for (i <- 1 to 5) {
      contador = contador + i
    }

    while (contador < 100) {
      contador = contador * 2
    }

    try {
      val resultado = op.dividir()
      println(resultado)
    } catch {
      case e: Exception => println("Ocurrio un error")
    } finally {
      println("Fin del intento")
    }

    val punto = Punto(3.5, 7.2)
    val esValido = disponible && !agotado
    val esInvalido = disponible || agotado
    val sonIguales = contador == 10
    val sonDiferentes = contador != 10
    val cumpleMinimo = precioTotal >= 20.0
    val cumpleMaximo = precioTotal <= 100.0

    val doble: Int => Int = n => n * 2
    val cuadrado = (n: Int) => n * n

    println(mensaje)
  }
}
