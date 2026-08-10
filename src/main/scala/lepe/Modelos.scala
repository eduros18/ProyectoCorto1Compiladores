package lepe

// Representa cada lexema encontrado
case class TokenLexico(
  lexema: String,
  token: String,
  linea: Int
)

// Contadores generales del analizador
case class Estadisticas(
  lineas: Int,
  caracteres: Int,
  enteros: Int,
  flotantes: Int,
  identificadores: Int,
  booleanos: Int,
  operadores: Int,
  cadenas: Int,
  palabrasReservadas: Int
)

// Resultado completo de analizar un archivo Scala
case class ResultadoAnalisis(
  archivo: String,
  estadisticas: Estadisticas,
  tokens: List[TokenLexico]
)