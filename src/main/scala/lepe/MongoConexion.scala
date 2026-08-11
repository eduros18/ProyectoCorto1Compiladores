package lepe

import org.mongodb.scala._
import org.mongodb.scala.bson.collection.immutable.Document

import scala.concurrent.Await
import scala.concurrent.duration._
import scala.util.{Try, Success, Failure}

object MongoConexion {

  private val uri = "mongodb://localhost:27017"

  private val nombreBaseDatos = "analizador_lexico"
  private val nombreColeccion = "analisis"

  def guardarAnalisis(resultado: ResultadoAnalisis): Boolean = {

    var cliente: MongoClient = null

    try {

      cliente = MongoClient(uri)

      val baseDatos = cliente.getDatabase(nombreBaseDatos)

      val coleccion = baseDatos.getCollection(nombreColeccion)

      // Probamos que MongoDB realmente responda
      val ping = baseDatos.runCommand(Document("ping" -> 1))

      Await.result(
        ping.toFuture(),
        5.seconds
      )

      val tokensMongo = resultado.tokens.map { token =>

        Document(
          "lexema" -> token.lexema,
          "token" -> token.token,
          "linea" -> token.linea
        )
      }

      val estadisticasMongo = Document(
        "lineas" -> resultado.estadisticas.lineas,
        "caracteres" -> resultado.estadisticas.caracteres,
        "enteros" -> resultado.estadisticas.enteros,
        "flotantes" -> resultado.estadisticas.flotantes,
        "identificadores" -> resultado.estadisticas.identificadores,
        "booleanos" -> resultado.estadisticas.booleanos,
        "operadores" -> resultado.estadisticas.operadores,
        "cadenas" -> resultado.estadisticas.cadenas,
        "palabrasReservadas" ->
          resultado.estadisticas.palabrasReservadas
      )

      val documento = Document(
        "archivo" -> resultado.archivo,
        "fecha" -> java.time.LocalDateTime.now().toString,
        "estadisticas" -> estadisticasMongo,
        "tablaSimbolos" -> tokensMongo
      )

      val insercion = coleccion.insertOne(documento)

      Await.result(
        insercion.toFuture(),
        5.seconds
      )

      println("Analisis guardado correctamente en MongoDB.")

      true

    } catch {

      case error: Exception =>

        println(
          "Advertencia: no fue posible conectar con MongoDB."
        )

        println(
          "El programa continuara funcionando sin base de datos."
        )

        println(
          "Detalle: " + error.getMessage
        )

        false
    } finally {

      if (cliente != null) {
        cliente.close()
      }
    }
  }
}