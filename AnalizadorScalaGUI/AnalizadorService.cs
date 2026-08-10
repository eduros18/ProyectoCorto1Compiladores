using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace AnalizadorScalaGUI
{
    public class Lexema
    {
        public string Valor { get; set; } = "";
        public string Token { get; set; } = "";
        public int Linea { get; set; }
    }

    public class ResultadoAnalisis
    {
        public int Lineas { get; set; }
        public int Caracteres { get; set; }
        public int Reservadas { get; set; }
        public int Identificadores { get; set; }
        public int Enteros { get; set; }
        public int Flotantes { get; set; }
        public int Booleanos { get; set; }
        public int Cadenas { get; set; }
        public int Operadores { get; set; }
        public List<Lexema> Lexemas { get; set; } = new List<Lexema>();
    }

    // excepciones especificas para q el programa muestre el mensaje correcto
    public class ArchivoVacioException : Exception { }
    public class EjecucionAnalizadorException : Exception
    {
        public EjecucionAnalizadorException(string mensaje, Exception? inner = null) : base(mensaje, inner) { }
    }

    public class AnalizadorService
    {
        private static readonly string[] TitulosSeccion = new[]
        {
            "PALABRAS RESERVADAS", "IDENTIFICADORES", "NUMEROS ENTEROS",
            "NUMEROS FLOTANTES", "VALORES BOOLEANOS", "CADENAS", "OPERADORES"
        };

        /// <summary>
        /// eejecuta el .exe del analizador sobre rutaArchivoFuente y lee linea por linea lexemas.txt para pasarlo a texto de c# (parsear basicamente).
        /// carpetaTrabajo debe ser una carpeta donde el exe pueda escribir lexemas.txt
        /// </summary>
        public ResultadoAnalisis EjecutarAnalisis(string rutaEjecutable, string rutaArchivoFuente, string carpetaTrabajo)
        {
            if (!File.Exists(rutaArchivoFuente))
                throw new FileNotFoundException("No se encontro el archivo de codigo fuente", rutaArchivoFuente);

            if (new FileInfo(rutaArchivoFuente).Length == 0)
                throw new ArchivoVacioException();

            if (!File.Exists(rutaEjecutable))
                throw new EjecucionAnalizadorException($"No se encontro el analizador en: {rutaEjecutable}");

            Directory.CreateDirectory(carpetaTrabajo);

            var rutaSalida = Path.Combine(carpetaTrabajo, "lexemas.txt");
            if (File.Exists(rutaSalida)) File.Delete(rutaSalida); // evitar leer un resultado viejo si el exe falla

            var psi = new ProcessStartInfo
            {
                FileName = rutaEjecutable,
                Arguments = $"\"{rutaArchivoFuente}\"",
                WorkingDirectory = carpetaTrabajo,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = false,
                CreateNoWindow = true
            };

            try
            {
                using var proceso = Process.Start(psi)
                    ?? throw new EjecucionAnalizadorException("No se pudo iniciar el proceso del analizador");

                string stdout = proceso.StandardOutput.ReadToEnd();
                string stderr = proceso.StandardError.ReadToEnd();
                proceso.WaitForExit();

                if (proceso.ExitCode != 0)
                    throw new EjecucionAnalizadorException($"El analizador termino con error (codigo {proceso.ExitCode}). {stderr}");
            }
            catch (Exception ex) when (!(ex is EjecucionAnalizadorException))
            {
                throw new EjecucionAnalizadorException("Error al ejecutar el analizador Flex", ex);
            }

            if (!File.Exists(rutaSalida))
                throw new EjecucionAnalizadorException("El analizador no genero lexemas.txt");

            return ParsearLexemasTxt(rutaSalida);
        }

        private ResultadoAnalisis ParsearLexemasTxt(string rutaSalida)
        {
            var resultado = new ResultadoAnalisis();
            var lineas = File.ReadAllLines(rutaSalida);

            string? seccionActual = null;
            bool dentroDeTabla = false;

            for (int i = 0; i < lineas.Length; i++)
            {
                var linea = lineas[i];

                // resumen
                if (linea.Contains(':') && !dentroDeTabla)
                {
                    var partes = linea.Split(':', 2);
                    var campo = partes[0].Trim();
                    var valorStr = partes.Length > 1 ? partes[1].Trim() : "";
                    if (int.TryParse(valorStr, out int valor))
                    {
                        switch (campo)
                        {
                            case "Lineas": resultado.Lineas = valor; break;
                            case "Caracteres": resultado.Caracteres = valor; break;
                            case "Palabras reservadas": resultado.Reservadas = valor; break;
                            case "Identificadores": resultado.Identificadores = valor; break;
                            case "Enteros": resultado.Enteros = valor; break;
                            case "Flotantes": resultado.Flotantes = valor; break;
                            case "Booleanos": resultado.Booleanos = valor; break;
                            case "Cadenas": resultado.Cadenas = valor; break;
                            case "Operadores": resultado.Operadores = valor; break;
                        }
                    }
                }

                // deetectar titulo de seccion de entrada
                if (TitulosSeccion.Contains(linea.Trim()))
                {
                    seccionActual = linea.Trim();
                    dentroDeTabla = false; // pq falta encabezado LEXEMA/TOKEN/LINEA y la linea de guiones
                    continue;
                }

                // linea de encabezado de columnas, la siguiente es de guiones, luego empiezan los datos
                if (linea.TrimStart().StartsWith("LEXEMA") && seccionActual != null)
                {
                    dentroDeTabla = true;
                    i++; // se salta la linea de guiones
                    continue;
                }

                if (dentroDeTabla)
                {
                    if (string.IsNullOrWhiteSpace(linea))
                    {
                        dentroDeTabla = false;
                        seccionActual = null;
                        continue;
                    }

                    var lex = ParsearFilaLexema(linea);
                    if (lex != null) resultado.Lexemas.Add(lex);
                }
            }

            return resultado;
        }

        // forma en la q se va a mostra el texto
        private Lexema? ParsearFilaLexema(string linea)
        {
            try
            {
                if (linea.Length < 26) return null;

                string valor = linea.Substring(0, 25).Trim();
                int finToken = Math.Min(51, linea.Length);
                string token = linea.Substring(26, Math.Max(0, finToken - 26)).Trim();
                string lineaNumStr = linea.Length > 52 ? linea.Substring(52).Trim() : "";

                int.TryParse(lineaNumStr, out int numLinea);

                if (string.IsNullOrEmpty(valor) || string.IsNullOrEmpty(token)) return null;

                return new Lexema { Valor = valor, Token = token, Linea = numLinea };
            }
            catch
            {
                return null; // fila corrupta, se ignora en vez de tronar toda la interfaz
            }
        }
    }
}
