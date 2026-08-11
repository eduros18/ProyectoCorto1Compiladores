package lepe

import scala.io.Source
import java.io.File
import scala.util.Try

object Integrador {

  def main(args: Array[String]): Unit = {

    println("====================================")
    println(" INTEGRADOR MONGODB + PDF")
    println("====================================")

    if (args.length < 2) {
      println("Uso:")
      println("sbt \"run <lexemas.txt> <archivo.scala>\"")
      return
    }

    val rutaLexemas = args(0)
    val rutaArchivoScala = args(1)

    val archivoLexemas = new File(rutaLexemas)

    if (!archivoLexemas.exists()) {
      println(s"Error: no existe $rutaLexemas")
      return
    }

    try {

      val lineasArchivo = Source
        .fromFile(archivoLexemas, "UTF-8")
        .getLines()
        .toList

      def obtenerEstadistica(nombre: String): Int = {
        lineasArchivo
          .find(_.trim.startsWith(nombre + ":"))
          .flatMap { linea =>
            val partes = linea.split(":", 2)
            if (partes.length == 2)
              Try(partes(1).trim.toInt).toOption
            else
              None
          }
          .getOrElse(0)
      }

      val estadisticas = Estadisticas(
        lineas = obtenerEstadistica("Lineas"),
        caracteres = obtenerEstadistica("Caracteres"),
        enteros = obtenerEstadistica("Enteros"),
        flotantes = obtenerEstadistica("Flotantes"),
        identificadores = obtenerEstadistica("Identificadores"),
        booleanos = obtenerEstadistica("Booleanos"),
        operadores = obtenerEstadistica("Operadores"),
        cadenas = obtenerEstadistica("Cadenas"),
        palabrasReservadas = obtenerEstadistica("Palabras reservadas")
      )

      val tokens = lineasArchivo.flatMap(parsearToken)

      val resultado = ResultadoAnalisis(
        archivo = new File(rutaArchivoScala).getName,
        estadisticas = estadisticas,
        tokens = tokens
      )

      println()
      println("Datos recibidos del analizador:")
      println(s"Archivo: ${resultado.archivo}")
      println(s"Lineas: ${estadisticas.lineas}")
      println(s"Caracteres: ${estadisticas.caracteres}")
      println(s"Identificadores: ${estadisticas.identificadores}")
      println(s"Tokens encontrados: ${tokens.size}")

      println()
      println("Generando Reporte 1...")
      Reportes.generarReporteEstadisticas(resultado)

      println()
      println("Generando Reporte 2...")
      Reportes.generarReporteTokens(resultado)

      println()
      println("Guardando en MongoDB...")

      val guardado = MongoConexion.guardarAnalisis(resultado)

      if (guardado)
        println("Integracion completada correctamente.")
      else
        println("Los PDF fueron generados, pero MongoDB no estaba disponible.")

      println()
      println("====================================")
      println(" PROCESO FINALIZADO")
      println("====================================")

    } catch {

      case ex: Exception =>
        println("Error durante la integracion:")
        println(ex.getMessage)

    }
  }

  private def parsearToken(linea: String): Option[TokenLexico] = {

    try {

      if (linea.length < 26)
        return None

      val lexema =
        linea.substring(0, Math.min(25, linea.length)).trim

      if (linea.length <= 26)
        return None

      val finToken =
        Math.min(51, linea.length)

      val token =
        linea.substring(26, finToken).trim

      val numeroLinea =
        if (linea.length > 52)
          Try(linea.substring(52).trim.toInt).getOrElse(0)
        else
          0

      if (
        lexema.isEmpty ||
        token.isEmpty ||
        numeroLinea <= 0 ||
        lexema == "LEXEMA" ||
        lexema.startsWith("-")
      )
        None
      else
        Some(
          TokenLexico(
            lexema = lexema,
            token = token,
            linea = numeroLinea
          )
        )

    } catch {

      case _: Exception =>
        None

    }
  }
}