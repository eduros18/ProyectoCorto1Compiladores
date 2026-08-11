package lepe

import org.apache.pdfbox.pdmodel._
import org.apache.pdfbox.pdmodel.font._
import org.apache.pdfbox.pdmodel.common.PDRectangle

import java.io.File
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

object Reportes {

  private val fuenteNormal =
    new PDType1Font(Standard14Fonts.FontName.HELVETICA)

  private val fuenteNegrita =
    new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD)


  private def crearCarpetaReportes(): Unit = {

    val carpeta = new File("reportes")

    if (!carpeta.exists()) {
      carpeta.mkdirs()
    }
  }


  private def escribirTexto(
      contenido: PDPageContentStream,
      texto: String,
      x: Float,
      y: Float,
      tamano: Float = 11
  ): Unit = {

    contenido.beginText()
    contenido.setFont(fuenteNormal, tamano)
    contenido.newLineAtOffset(x, y)
    contenido.showText(texto)
    contenido.endText()
  }


  private def escribirNegrita(
      contenido: PDPageContentStream,
      texto: String,
      x: Float,
      y: Float,
      tamano: Float = 11
  ): Unit = {

    contenido.beginText()
    contenido.setFont(fuenteNegrita, tamano)
    contenido.newLineAtOffset(x, y)
    contenido.showText(texto)
    contenido.endText()
  }


  // ==========================================================
  // REPORTE 1 - ESTADISTICAS GENERALES
  // ==========================================================

  def generarReporteEstadisticas(
      resultado: ResultadoAnalisis
  ): Unit = {

    crearCarpetaReportes()

    val documento = new PDDocument()

    try {

      val pagina = new PDPage(PDRectangle.LETTER)

      documento.addPage(pagina)

      val contenido =
        new PDPageContentStream(documento, pagina)

      var y = 740f

      escribirNegrita(
        contenido,
        "REPORTE DE ESTADISTICAS DEL ANALIZADOR LEXICO",
        90,
        y,
        16
      )

      y -= 35

      val fecha = LocalDateTime
        .now()
        .format(
          DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss")
        )

      escribirTexto(
        contenido,
        s"Fecha: $fecha",
        60,
        y
      )

      y -= 20

      escribirTexto(
        contenido,
        s"Archivo analizado: ${resultado.archivo}",
        60,
        y
      )

      y -= 40

      escribirNegrita(
        contenido,
        "ESTADISTICA",
        100,
        y
      )

      escribirNegrita(
        contenido,
        "CANTIDAD",
        350,
        y
      )

      y -= 25

      val e = resultado.estadisticas

      val datos = List(
        ("Lineas", e.lineas),
        ("Caracteres", e.caracteres),
        ("Enteros", e.enteros),
        ("Flotantes", e.flotantes),
        ("Identificadores", e.identificadores),
        ("Booleanos", e.booleanos),
        ("Operadores", e.operadores),
        ("Cadenas", e.cadenas),
        ("Palabras reservadas", e.palabrasReservadas)
      )

      datos.foreach { caso =>

        escribirTexto(
          contenido,
          caso._1,
          100,
          y
        )

        escribirTexto(
          contenido,
          caso._2.toString,
          370,
          y
        )

        y -= 25
      }

      escribirTexto(
        contenido,
        "Pagina 1",
        500,
        30,
        9
      )

      contenido.close()

      val ruta =
        "reportes/reporte_estadisticas.pdf"

      documento.save(ruta)

      println(
        s"Reporte de estadisticas generado: $ruta"
      )

    } finally {

      documento.close()
    }
  }


  // ==========================================================
  // REPORTE 2 - TOKENS Y TABLA DE SIMBOLOS
  // ==========================================================

  def generarReporteTokens(
      resultado: ResultadoAnalisis
  ): Unit = {

    crearCarpetaReportes()

    val documento = new PDDocument()

    try {

      var pagina =
        new PDPage(PDRectangle.LETTER)

      documento.addPage(pagina)

      var contenido =
        new PDPageContentStream(documento, pagina)

      var numeroPagina = 1

      var y = 740f


      def encabezado(): Unit = {

        escribirNegrita(
          contenido,
          "REPORTE DE TOKENS Y TABLA DE SIMBOLOS",
          110,
          y,
          16
        )

        y -= 30

        escribirTexto(
          contenido,
          s"Archivo: ${resultado.archivo}",
          50,
          y
        )

        y -= 20

        escribirNegrita(
          contenido,
          "No.",
          50,
          y
        )

        escribirNegrita(
          contenido,
          "Lexema",
          90,
          y
        )

        escribirNegrita(
          contenido,
          "Token",
          280,
          y
        )

        escribirNegrita(
          contenido,
          "Linea",
          500,
          y
        )

        y -= 22
      }


      def nuevaPagina(): Unit = {

        escribirTexto(
          contenido,
          s"Pagina $numeroPagina",
          500,
          30,
          9
        )

        contenido.close()

        numeroPagina += 1

        pagina =
          new PDPage(PDRectangle.LETTER)

        documento.addPage(pagina)

        contenido =
          new PDPageContentStream(
            documento,
            pagina
          )

        y = 740f

        encabezado()
      }


      encabezado()

      var contador = 1

      resultado.tokens.foreach { token =>

        if (y < 70) {
          nuevaPagina()
        }

        escribirTexto(
          contenido,
          contador.toString,
          50,
          y,
          9
        )

        escribirTexto(
          contenido,
          token.lexema.take(25),
          90,
          y,
          9
        )

        escribirTexto(
          contenido,
          token.token.take(30),
          280,
          y,
          9
        )

        escribirTexto(
          contenido,
          token.linea.toString,
          510,
          y,
          9
        )

        contador += 1

        y -= 18
      }


      // ------------------------------------------
      // Palabras reservadas por frecuencia
      // ------------------------------------------

      if (y < 180) {
        nuevaPagina()
      }

      y -= 30

      escribirNegrita(
        contenido,
        "PALABRAS RESERVADAS POR FRECUENCIA",
        120,
        y,
        14
      )

      y -= 30


      val reservadas =
        resultado.tokens
          .filter(
            _.token == "PALABRA_RESERVADA"
          )
          .groupBy(_.lexema)
          .map {
            case (palabra, lista) =>
              (palabra, lista.size)
          }
          .toList
          .sortBy {
            case (_, cantidad) =>
              -cantidad
          }


      escribirNegrita(
        contenido,
        "Palabra",
        150,
        y
      )

      escribirNegrita(
        contenido,
        "Frecuencia",
        350,
        y
      )

      y -= 22


      reservadas.foreach {
        case (palabra, frecuencia) =>

          if (y < 70) {
            nuevaPagina()
          }

          escribirTexto(
            contenido,
            palabra,
            150,
            y
          )

          escribirTexto(
            contenido,
            frecuencia.toString,
            380,
            y
          )

          y -= 20
      }


      escribirTexto(
        contenido,
        s"Pagina $numeroPagina",
        500,
        30,
        9
      )

      contenido.close()


      val ruta =
        "reportes/reporte_tokens.pdf"

      documento.save(ruta)

      println(
        s"Reporte de tokens generado: $ruta"
      )

    } finally {

      documento.close()
    }
  }
}