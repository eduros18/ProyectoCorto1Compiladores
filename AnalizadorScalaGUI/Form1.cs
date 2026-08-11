using System;
using System.IO;
using System.Windows.Forms;

namespace AnalizadorScalaGUI
{
    public partial class Form1 : Form
    {
// Ruta principal del proyecto
private readonly string raizProyecto =
    Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, "..", "..", "..", ".."));

// Rutas del analizador
private readonly string rutaEjecutableAnalizador;
private readonly string carpetaTrabajo;

        private readonly AnalizadorService servicio = new AnalizadorService();
        private string? rutaArchivoSeleccionado = null;

        // botones (se hizo por codigo ya que mergear por medio de toolbox da conflictos)
        private Button btnSeleccionar = null!;
        private TextBox txtRuta = null!;
        private RichTextBox rtbContenido = null!;
        private Button btnAnalizar = null!;
        private Label lblLineas = null!, lblCaracteres = null!, lblEnteros = null!, lblFlotantes = null!,
                      lblIdentificadores = null!, lblBooleanos = null!, lblCadenas = null!, lblOperadores = null!;
        private DataGridView dgvLexemas = null!;
        private Label lblEstado = null!;
public Form1()
{
    InitializeComponent();

    carpetaTrabajo = Path.Combine(
        raizProyecto,
        "Analizador"
    );

    rutaEjecutableAnalizador = Path.Combine(
        carpetaTrabajo,
        "analizador.exe"
    );

    ArmarInterfaz();
}
        private void ArmarInterfaz()
        {
            this.Text = "Analizador Léxico - Scala";
            this.Width = 1000;
            this.Height = 750;
            this.StartPosition = FormStartPosition.CenterScreen;

            // apartado seleccion de archivo
            btnSeleccionar = new Button { Text = "Seleccionar archivo", Left = 10, Top = 10, Width = 150 };
            btnSeleccionar.Click += BtnSeleccionar_Click;
            this.Controls.Add(btnSeleccionar);

            txtRuta = new TextBox { Left = 170, Top = 13, Width = 700, ReadOnly = true };
            this.Controls.Add(txtRuta);

            // apartado contenido del archivo
            var lblContenido = new Label { Text = "Contenido del archivo:", Left = 10, Top = 45, Width = 200 };
            this.Controls.Add(lblContenido);

            rtbContenido = new RichTextBox { Left = 10, Top = 65, Width = 960, Height = 180, ReadOnly = true, Font = new System.Drawing.Font("Consolas", 9) };
            this.Controls.Add(rtbContenido);

            //  apartado boton de analisis 
            btnAnalizar = new Button { Text = "Iniciar aalisis", Left = 10, Top = 255, Width = 150, Height = 30 };
            btnAnalizar.Click += BtnAnalizar_Click;
            this.Controls.Add(btnAnalizar);

            lblEstado = new Label { Left = 170, Top = 260, Width = 800, ForeColor = System.Drawing.Color.DarkRed };
            this.Controls.Add(lblEstado);
	    

            // apartado resumen de resultados
            var panelResumen = new GroupBox { Text = "Resumen general", Left = 10, Top = 295, Width = 960, Height = 90 };
            this.Controls.Add(panelResumen);

            (Label etiqueta, Label valor) CrearParEtiqueta(string texto, int left)
            {
                var et = new Label { Text = texto, Left = left, Top = 20, Width = 100 };
                var val = new Label { Text = "-", Left = left, Top = 40, Width = 100, Font = new System.Drawing.Font("Segoe UI", 10, System.Drawing.FontStyle.Bold) };
                panelResumen.Controls.Add(et);
                panelResumen.Controls.Add(val);
                return (et, val);
            }

            (_, lblLineas) = CrearParEtiqueta("Lineas", 10);
            (_, lblCaracteres) = CrearParEtiqueta("Caracteres", 120);
            (_, lblEnteros) = CrearParEtiqueta("Enteros", 230);
            (_, lblFlotantes) = CrearParEtiqueta("Flotantes", 340);
            (_, lblIdentificadores) = CrearParEtiqueta("Identificadores", 450);
            (_, lblBooleanos) = CrearParEtiqueta("Booleanos", 590);
            (_, lblCadenas) = CrearParEtiqueta("Cadenas", 700);
            (_, lblOperadores) = CrearParEtiqueta("Operadores", 810);

            // apartado tabla de lexemas del .l
            var lblTabla = new Label { Text = "Lexemas encontrados:", Left = 10, Top = 395, Width = 200 };
            this.Controls.Add(lblTabla);

            dgvLexemas = new DataGridView
            {
                Left = 10,
                Top = 415,
                Width = 960,
                Height = 280,
                ReadOnly = true,
                AllowUserToAddRows = false,
                AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill,
                Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right
            };
            this.Controls.Add(dgvLexemas);
        }

        private void BtnSeleccionar_Click(object? sender, EventArgs e)
        {
            using var ofd = new OpenFileDialog
            {
                Filter = "Archivos Scala (*.scala)|*.scala|Todos los archivos (*.*)|*.*", //nomas para indicar el tipo de archivo
                Title = "Seleccione el archivo de codigo"
            };

            if (ofd.ShowDialog() == DialogResult.OK)
            {
                rutaArchivoSeleccionado = ofd.FileName;
                txtRuta.Text = rutaArchivoSeleccionado;
                lblEstado.Text = "";

                try
                {
                    rtbContenido.Text = File.ReadAllText(rutaArchivoSeleccionado);
                }
                catch (Exception ex)
                {
                    rtbContenido.Text = "";
                    MostrarError($"No se pudo leer el archivo: {ex.Message}");
                }
            }
        }

        private void BtnAnalizar_Click(object? sender, EventArgs e)
        {
            lblEstado.Text = "";

            if (string.IsNullOrEmpty(rutaArchivoSeleccionado))
            {
                MostrarError("Primero debe seleccionar un archivo");
                return;
            }

            try
            {
                btnAnalizar.Enabled = false;
                lblEstado.ForeColor = System.Drawing.Color.DarkBlue;
                lblEstado.Text = "Analizando...";
                Application.DoEvents();

                var resultado = servicio.EjecutarAnalisis(rutaEjecutableAnalizador, rutaArchivoSeleccionado, carpetaTrabajo);

                lblLineas.Text = resultado.Lineas.ToString();
                lblCaracteres.Text = resultado.Caracteres.ToString();
                lblEnteros.Text = resultado.Enteros.ToString();
                lblFlotantes.Text = resultado.Flotantes.ToString();
                lblIdentificadores.Text = resultado.Identificadores.ToString();
                lblBooleanos.Text = resultado.Booleanos.ToString();
                lblCadenas.Text = resultado.Cadenas.ToString();
                lblOperadores.Text = resultado.Operadores.ToString();

                dgvLexemas.DataSource = resultado.Lexemas;
                if (dgvLexemas.Columns.Count >= 3)
                {
                    dgvLexemas.Columns[0].HeaderText = "Lexema";
                    dgvLexemas.Columns[1].HeaderText = "Token";
                    dgvLexemas.Columns[2].HeaderText = "Linea";
                }

                lblEstado.ForeColor = System.Drawing.Color.Green;
                lblEstado.Text = $"Analisis completo. {resultado.Lexemas.Count} lexemas encontrados.";

		EjecutarModuloLepe();

            }
            catch (ArchivoVacioException)
            {
                MostrarError("El archivo seleccionado esta vacio, no hay nada");
            }
            catch (FileNotFoundException ex)
            {
                MostrarError($"Archivo no encontrado: {ex.Message}");
            }
            catch (EjecucionAnalizadorException ex)
            {
                MostrarError($"No se pudo ejecutar el analizador: {ex.Message}");
            }
            catch (Exception ex)
            {
                MostrarError($"Error inesperado: {ex.Message}");
            }
            finally
            {
                btnAnalizar.Enabled = true;
            }
        }

private void EjecutarModuloLepe()
{
    try
    {
        string rutaLexemas =
            Path.Combine(carpetaTrabajo, "lexemas.txt");

        if (!File.Exists(rutaLexemas))
        {
            MessageBox.Show(
                "No se encontro lexemas.txt para MongoDB y PDF.",
                "Advertencia",
                MessageBoxButtons.OK,
                MessageBoxIcon.Warning
            );

            return;
        }

        var psi = new System.Diagnostics.ProcessStartInfo
        {
            FileName = "cmd.exe",

            Arguments =
                $"/c sbt \"runMain lepe.Integrador \\\"{rutaLexemas}\\\" \\\"{rutaArchivoSeleccionado}\\\"\"",

            WorkingDirectory = raizProyecto,

            RedirectStandardOutput = true,
            RedirectStandardError = true,

            UseShellExecute = false,
            CreateNoWindow = true
        };

        using var proceso =
            System.Diagnostics.Process.Start(psi);

        if (proceso == null)
        {
            MessageBox.Show(
                "No se pudo iniciar el modulo de MongoDB y PDF."
            );

            return;
        }

        string salida =
            proceso.StandardOutput.ReadToEnd();

        string errores =
            proceso.StandardError.ReadToEnd();

        proceso.WaitForExit();

        if (proceso.ExitCode == 0)
        {
            MessageBox.Show(
                "Analisis guardado en MongoDB y reportes PDF generados.",
                "Proceso completado",
                MessageBoxButtons.OK,
                MessageBoxIcon.Information
            );
        }
        else
        {
            MessageBox.Show(
                "El analisis lexico termino, pero hubo un problema con MongoDB/PDF.\n\n"
                + errores,
                "Advertencia",
                MessageBoxButtons.OK,
                MessageBoxIcon.Warning
            );
        }
    }
    catch (Exception ex)
    {
        MessageBox.Show(
            "El analisis lexico termino correctamente, pero no se pudo ejecutar MongoDB/PDF.\n\n"
            + ex.Message,
            "Advertencia",
            MessageBoxButtons.OK,
            MessageBoxIcon.Warning
        );
    }
}

        private void MostrarError(string mensaje)
        {
            lblEstado.ForeColor = System.Drawing.Color.DarkRed;
            lblEstado.Text = mensaje;
            MessageBox.Show(mensaje, "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        private void InitializeComponent()
        {
            this.SuspendLayout();
            this.ResumeLayout(false);
        }
    }
}