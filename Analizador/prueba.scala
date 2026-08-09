package proyecto

import scala.util.Random

object PruebaAnalizador {

  val nombrePrograma = "Analizador Scala"
  val version = 1.5
  val activo = true
  val terminado = false

  var contador = 0
  var total = 100
  var promedio = 85.75

  def sumar(a: Int, b: Int): Int = {
    val resultado = a + b
    return resultado
  }

  def restar(a: Int, b: Int): Int = {
    val resultado = a - b
    return resultado
  }

  def multiplicar(a: Int, b: Int): Int = {
    val resultado = a * b
    return resultado
  }

  def dividir(a: Int, b: Int): Int = {
    val resultado = a / b
    return resultado
  }

  def obtenerResiduo(a: Int, b: Int): Int = {
    val resultado = a % b
    return resultado
  }

  def verificarEdad(edad: Int): Boolean = {

    if (edad >= 18) {
      return true
    }
    else {
      return false
    }

  }

  def compararNumeros(numero1: Int, numero2: Int): Boolean = {

    if (numero1 == numero2) {
      return true
    }

    if (numero1 != numero2) {
      return false
    }

    return false
  }

  def verificarRango(numero: Int): Boolean = {

    if (numero > 0 && numero <= 100) {
      return true
    }

    if (numero < 0 || numero >= 200) {
      return false
    }

    return false
  }

  def mostrarMensaje(mensaje: String): Unit = {
    println(mensaje)
  }

  def calcularPromedio(nota1: Double, nota2: Double): Double = {

    val sumaNotas = nota1 + nota2
    val resultado = sumaNotas / 2.0

    return resultado
  }

  def recorrerNumeros(): Unit = {

    for (numero <- 1 to 10) {
      contador = contador + 1
      println(numero)
    }

  }

  def probarWhile(): Unit = {

    var numero = 0

    while (numero < 5) {
      numero = numero + 1
      println(numero)
    }

  }

  def main(args: Array[String]): Unit = {

    val estudiante = "Angel"
    val edad = 20
    val nota1 = 90.5
    val nota2 = 80.25
    val aprobado = true

    val suma = sumar(10, 5)
    val resta = restar(20, 8)
    val multiplicacion = multiplicar(4, 5)
    val division = dividir(20, 4)
    val residuo = obtenerResiduo(10, 3)

    val promedioFinal = calcularPromedio(nota1, nota2)

    println("Nombre del estudiante:")
    println(estudiante)

    println("Edad:")
    println(edad)

    println("Promedio:")
    println(promedioFinal)

    if (aprobado == true) {
      println("El estudiante esta aprobado")
    }
    else {
      println("El estudiante no esta aprobado")
    }

    if (edad >= 18 && aprobado == true) {
      println("Es mayor de edad y esta aprobado")
    }

    recorrerNumeros()

    probarWhile()

    mostrarMensaje("Prueba del analizador finalizada")

  }

}

/*
Este comentario tiene varias lineas.
El analizador debe ignorar todo su contenido.

val falso = 100
def funcionFalsa = 50
var prueba = "Esto no debe contarse"

Tambien debe mantener correctamente
el numero de linea despues del comentario.
*/

// Este comentario tampoco debe generar lexemas.