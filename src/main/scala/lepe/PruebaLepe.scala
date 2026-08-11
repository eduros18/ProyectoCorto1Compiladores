package lepe

object PruebaLepe {

  def main(args: Array[String]): Unit = {

    println("====================================")
    println(" PRUEBA DEL MODULO DE PAULO LEPE")
    println("====================================")

    // Tokens de prueba simulando la salida del analizador Flex
    val tokens = List(

      TokenLexico("object", "PALABRA_RESERVADA", 1),
      TokenLexico("Programa", "IDENTIFICADOR", 1),

      TokenLexico("def", "PALABRA_RESERVADA", 3),
      TokenLexico("main", "IDENTIFICADOR", 3),

      TokenLexico("val", "PALABRA_RESERVADA", 5),
      TokenLexico("edad", "IDENTIFICADOR", 5),
      TokenLexico("=", "OPERADOR", 5),
      TokenLexico("21", "ENTERO", 5),

      TokenLexico("var", "PALABRA_RESERVADA", 6),
      TokenLexico("precio", "IDENTIFICADOR", 6),
      TokenLexico("=", "OPERADOR", 6),
      TokenLexico("25.50", "FLOTANTE", 6),

      TokenLexico("val", "PALABRA_RESERVADA", 8),
      TokenLexico("activo", "IDENTIFICADOR", 8),
      TokenLexico("=", "OPERADOR", 8),
      TokenLexico("true", "BOOLEANO", 8),

      TokenLexico("if", "PALABRA_RESERVADA", 10),
      TokenLexico("edad", "IDENTIFICADOR", 10),
      TokenLexico(">=", "OPERADOR", 10),
      TokenLexico("18", "ENTERO", 10),

      TokenLexico(
        "\"Es mayor de edad\"",
        "CADENA",
        11
      ),

      TokenLexico("else", "PALABRA_RESERVADA", 13),

      TokenLexico(
        "\"Es menor de edad\"",
        "CADENA",
        14
      ),

      TokenLexico("val", "PALABRA_RESERVADA", 17),
      TokenLexico("resultado", "IDENTIFICADOR", 17),
      TokenLexico("=", "OPERADOR", 17),
      TokenLexico("edad", "IDENTIFICADOR", 17),
      TokenLexico("+", "OPERADOR", 17),
      TokenLexico("10", "ENTERO", 17)
    )

    val estadisticas = Estadisticas(
      lineas = 80,
      caracteres = 1543,
      enteros = 3,
      flotantes = 1,
      identificadores = 8,
      booleanos = 1,
      operadores = 6,
      cadenas = 2,
      palabrasReservadas = 8
    )

    val resultado = ResultadoAnalisis(
      archivo = "ejemplo.scala",
      estadisticas = estadisticas,
      tokens = tokens
    )

    println()
    println("Generando Reporte 1...")

    Reportes.generarReporteEstadisticas(resultado)

    println()
    println("Generando Reporte 2...")

    Reportes.generarReporteTokens(resultado)

    println()
    println("Intentando guardar en MongoDB...")

    val guardado =
      MongoConexion.guardarAnalisis(resultado)

    if (guardado) {
      println("Datos almacenados en MongoDB.")
    } else {
      println(
        "MongoDB no esta disponible, pero el programa continuo."
      )
    }

    println()
    println("====================================")
    println(" PRUEBA FINALIZADA")
    println("====================================")
  }
}