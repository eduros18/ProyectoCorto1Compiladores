%{
#include <stdio.h>
#include <string.h>

int linea = 1;
int caracteres = 0;

int cont_reservadas = 0;
int cont_identificadores = 0;
int cont_enteros = 0;
int cont_flotantes = 0;
int cont_booleanos = 0;
int cont_cadenas = 0;
int cont_operadores = 0;

int pr_abstract = 0;
int pr_case = 0;
int pr_catch = 0;
int pr_class = 0;
int pr_def = 0;
int pr_do = 0;
int pr_else = 0;
int pr_enum = 0;
int pr_export = 0;
int pr_extends = 0;
int pr_final = 0;
int pr_finally = 0;
int pr_for = 0;
int pr_given = 0;
int pr_if = 0;
int pr_implicit = 0;
int pr_import = 0;
int pr_lazy = 0;
int pr_match = 0;
int pr_new = 0;
int pr_null = 0;
int pr_object = 0;
int pr_override = 0;
int pr_package = 0;
int pr_private = 0;
int pr_protected = 0;
int pr_return = 0;
int pr_sealed = 0;
int pr_super = 0;
int pr_then = 0;
int pr_this = 0;
int pr_throw = 0;
int pr_trait = 0;
int pr_try = 0;
int pr_type = 0;
int pr_val = 0;
int pr_var = 0;
int pr_while = 0;
int pr_with = 0;
int pr_yield = 0;

#define MAX_LEXEMAS 2000

char lexemas[MAX_LEXEMAS][150];
char tokens[MAX_LEXEMAS][50];
int lineasLexemas[MAX_LEXEMAS];

int cantidadLexemas = 0;

void guardarLexema(char lexema[], char token[])
{
    if (cantidadLexemas < MAX_LEXEMAS)
    {
        strcpy(lexemas[cantidadLexemas], lexema);
        strcpy(tokens[cantidadLexemas], token);
        lineasLexemas[cantidadLexemas] = linea;

        cantidadLexemas++;
    }
}

void mostrarReservadasOrdenadas()
{
    char *nombres[] = {
        "abstract", "case", "catch", "class", "def",
        "do", "else", "enum", "export", "extends",
        "final", "finally", "for", "given", "if",
        "implicit", "import", "lazy", "match", "new",
        "null", "object", "override", "package", "private",
        "protected", "return", "sealed", "super", "then",
        "this", "throw", "trait", "try", "type",
        "val", "var", "while", "with", "yield"
    };

    int cantidades[] = {
        pr_abstract, pr_case, pr_catch, pr_class, pr_def,
        pr_do, pr_else, pr_enum, pr_export, pr_extends,
        pr_final, pr_finally, pr_for, pr_given, pr_if,
        pr_implicit, pr_import, pr_lazy, pr_match, pr_new,
        pr_null, pr_object, pr_override, pr_package, pr_private,
        pr_protected, pr_return, pr_sealed, pr_super, pr_then,
        pr_this, pr_throw, pr_trait, pr_try, pr_type,
        pr_val, pr_var, pr_while, pr_with, pr_yield
    };

    int total = 40;
    int i;
    int j;
    int tempCantidad;
    char *tempNombre;

    for (i = 0; i < total - 1; i++)
    {
        for (j = 0; j < total - i - 1; j++)
        {
            if (cantidades[j] < cantidades[j + 1])
            {
                tempCantidad = cantidades[j];
                cantidades[j] = cantidades[j + 1];
                cantidades[j + 1] = tempCantidad;

                tempNombre = nombres[j];
                nombres[j] = nombres[j + 1];
                nombres[j + 1] = tempNombre;
            }
        }
    }

    printf("\n===== PALABRAS RESERVADAS =====\n");

    for (i = 0; i < total; i++)
    {
        if (cantidades[i] > 0)
        {
            printf("%s: %d\n", nombres[i], cantidades[i]);
        }
    }
}

void imprimirEncabezado(FILE *archivo, char titulo[])
{
    fprintf(archivo, "\n");
    fprintf(archivo, "============================================================\n");
    fprintf(archivo, "%s\n", titulo);
    fprintf(archivo, "============================================================\n\n");

    fprintf(
        archivo,
        "%-25s %-25s %-10s\n",
        "LEXEMA",
        "TOKEN",
        "LINEA"
    );

    fprintf(
        archivo,
        "------------------------------------------------------------\n"
    );
}

void generarArchivoLexemas()
{
    FILE *archivo;
    int i;

    archivo = fopen("lexemas.txt", "w");

    if (archivo == NULL)
    {
        printf("No se pudo crear lexemas.txt\n");
        return;
    }

    fprintf(
        archivo,
        "============================================================\n"
    );

    fprintf(
        archivo,
        "              RESULTADO DEL ANALISIS LEXICO\n"
    );

    fprintf(
        archivo,
        "============================================================\n"
    );

    fprintf(archivo, "\nRESUMEN\n");
    fprintf(archivo, "------------------------------------------------------------\n");

    fprintf(archivo, "Lineas: %d\n", linea);
    fprintf(archivo, "Caracteres: %d\n", caracteres);
    fprintf(archivo, "Palabras reservadas: %d\n", cont_reservadas);
    fprintf(archivo, "Identificadores: %d\n", cont_identificadores);
    fprintf(archivo, "Enteros: %d\n", cont_enteros);
    fprintf(archivo, "Flotantes: %d\n", cont_flotantes);
    fprintf(archivo, "Booleanos: %d\n", cont_booleanos);
    fprintf(archivo, "Cadenas: %d\n", cont_cadenas);
    fprintf(archivo, "Operadores: %d\n", cont_operadores);

    imprimirEncabezado(
        archivo,
        "PALABRAS RESERVADAS"
    );

    for (i = 0; i < cantidadLexemas; i++)
    {
        if (strncmp(tokens[i], "PR_", 3) == 0)
        {
            fprintf(
                archivo,
                "%-25s %-25s %-10d\n",
                lexemas[i],
                tokens[i],
                lineasLexemas[i]
            );
        }
    }

    imprimirEncabezado(
        archivo,
        "IDENTIFICADORES"
    );

    for (i = 0; i < cantidadLexemas; i++)
    {
        if (strcmp(tokens[i], "IDENTIFICADOR") == 0)
        {
            fprintf(
                archivo,
                "%-25s %-25s %-10d\n",
                lexemas[i],
                tokens[i],
                lineasLexemas[i]
            );
        }
    }

    imprimirEncabezado(
        archivo,
        "NUMEROS ENTEROS"
    );

    for (i = 0; i < cantidadLexemas; i++)
    {
        if (strcmp(tokens[i], "ENTERO") == 0)
        {
            fprintf(
                archivo,
                "%-25s %-25s %-10d\n",
                lexemas[i],
                tokens[i],
                lineasLexemas[i]
            );
        }
    }

    imprimirEncabezado(
        archivo,
        "NUMEROS FLOTANTES"
    );

    for (i = 0; i < cantidadLexemas; i++)
    {
        if (strcmp(tokens[i], "FLOTANTE") == 0)
        {
            fprintf(
                archivo,
                "%-25s %-25s %-10d\n",
                lexemas[i],
                tokens[i],
                lineasLexemas[i]
            );
        }
    }

    imprimirEncabezado(
        archivo,
        "VALORES BOOLEANOS"
    );

    for (i = 0; i < cantidadLexemas; i++)
    {
        if (strcmp(tokens[i], "BOOLEANO") == 0)
        {
            fprintf(
                archivo,
                "%-25s %-25s %-10d\n",
                lexemas[i],
                tokens[i],
                lineasLexemas[i]
            );
        }
    }

    imprimirEncabezado(
        archivo,
        "CADENAS"
    );

    for (i = 0; i < cantidadLexemas; i++)
    {
        if (strcmp(tokens[i], "CADENA") == 0)
        {
            fprintf(
                archivo,
                "%-25s %-25s %-10d\n",
                lexemas[i],
                tokens[i],
                lineasLexemas[i]
            );
        }
    }

    imprimirEncabezado(
        archivo,
        "OPERADORES"
    );

    for (i = 0; i < cantidadLexemas; i++)
    {
        if (strncmp(tokens[i], "OP_", 3) == 0)
        {
            fprintf(
                archivo,
                "%-25s %-25s %-10d\n",
                lexemas[i],
                tokens[i],
                lineasLexemas[i]
            );
        }
    }

    fclose(archivo);
}
%}

%%

"//".* {
    caracteres += yyleng;
}

"/*"([^*]|\*+[^*/])*\*+"/" {
    int i;

    caracteres += yyleng;

    for (i = 0; i < yyleng; i++)
    {
        if (yytext[i] == '\n')
        {
            linea++;
        }
    }
}

"abstract" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_abstract++;
    guardarLexema(yytext, "PR_ABSTRACT");
}

"case" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_case++;
    guardarLexema(yytext, "PR_CASE");
}

"catch" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_catch++;
    guardarLexema(yytext, "PR_CATCH");
}

"class" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_class++;
    guardarLexema(yytext, "PR_CLASS");
}

"def" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_def++;
    guardarLexema(yytext, "PR_DEF");
}

"do" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_do++;
    guardarLexema(yytext, "PR_DO");
}

"else" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_else++;
    guardarLexema(yytext, "PR_ELSE");
}

"enum" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_enum++;
    guardarLexema(yytext, "PR_ENUM");
}

"export" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_export++;
    guardarLexema(yytext, "PR_EXPORT");
}

"extends" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_extends++;
    guardarLexema(yytext, "PR_EXTENDS");
}

"final" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_final++;
    guardarLexema(yytext, "PR_FINAL");
}

"finally" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_finally++;
    guardarLexema(yytext, "PR_FINALLY");
}

"for" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_for++;
    guardarLexema(yytext, "PR_FOR");
}

"given" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_given++;
    guardarLexema(yytext, "PR_GIVEN");
}

"if" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_if++;
    guardarLexema(yytext, "PR_IF");
}

"implicit" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_implicit++;
    guardarLexema(yytext, "PR_IMPLICIT");
}

"import" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_import++;
    guardarLexema(yytext, "PR_IMPORT");
}

"lazy" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_lazy++;
    guardarLexema(yytext, "PR_LAZY");
}

"match" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_match++;
    guardarLexema(yytext, "PR_MATCH");
}

"new" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_new++;
    guardarLexema(yytext, "PR_NEW");
}

"null" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_null++;
    guardarLexema(yytext, "PR_NULL");
}

"object" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_object++;
    guardarLexema(yytext, "PR_OBJECT");
}

"override" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_override++;
    guardarLexema(yytext, "PR_OVERRIDE");
}

"package" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_package++;
    guardarLexema(yytext, "PR_PACKAGE");
}

"private" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_private++;
    guardarLexema(yytext, "PR_PRIVATE");
}

"protected" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_protected++;
    guardarLexema(yytext, "PR_PROTECTED");
}

"return" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_return++;
    guardarLexema(yytext, "PR_RETURN");
}

"sealed" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_sealed++;
    guardarLexema(yytext, "PR_SEALED");
}

"super" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_super++;
    guardarLexema(yytext, "PR_SUPER");
}

"then" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_then++;
    guardarLexema(yytext, "PR_THEN");
}

"this" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_this++;
    guardarLexema(yytext, "PR_THIS");
}

"throw" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_throw++;
    guardarLexema(yytext, "PR_THROW");
}

"trait" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_trait++;
    guardarLexema(yytext, "PR_TRAIT");
}

"try" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_try++;
    guardarLexema(yytext, "PR_TRY");
}

"type" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_type++;
    guardarLexema(yytext, "PR_TYPE");
}

"val" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_val++;
    guardarLexema(yytext, "PR_VAL");
}

"var" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_var++;
    guardarLexema(yytext, "PR_VAR");
}

"while" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_while++;
    guardarLexema(yytext, "PR_WHILE");
}

"with" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_with++;
    guardarLexema(yytext, "PR_WITH");
}

"yield" {
    caracteres += yyleng;
    cont_reservadas++;
    pr_yield++;
    guardarLexema(yytext, "PR_YIELD");
}

"true"|"false" {
    caracteres += yyleng;
    cont_booleanos++;
    guardarLexema(yytext, "BOOLEANO");
}

[0-9]+\.[0-9]+ {
    caracteres += yyleng;
    cont_flotantes++;
    guardarLexema(yytext, "FLOTANTE");
}

[0-9]+ {
    caracteres += yyleng;
    cont_enteros++;
    guardarLexema(yytext, "ENTERO");
}

\"[^\"]*\" {
    caracteres += yyleng;
    cont_cadenas++;
    guardarLexema(yytext, "CADENA");
}

"==" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_IGUAL");
}

"!=" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_DIFERENTE");
}

">=" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_MAYOR_IGUAL");
}

"<=" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_MENOR_IGUAL");
}

"&&" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_AND");
}

"||" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_OR");
}

"<-" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_GENERADOR");
}

"=>" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_FLECHA");
}

"+" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_SUMA");
}

"-" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_RESTA");
}

"*" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_MULTIPLICACION");
}

"/" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_DIVISION");
}

"%" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_MODULO");
}

"=" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_ASIGNACION");
}

">" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_MAYOR");
}

"<" {
    caracteres += yyleng;
    cont_operadores++;
    guardarLexema(yytext, "OP_MENOR");
}

[a-zA-Z_][a-zA-Z0-9_]* {
    caracteres += yyleng;
    cont_identificadores++;
    guardarLexema(yytext, "IDENTIFICADOR");
}

\n {
    caracteres++;
    linea++;
}

[ \t\r]+ {
    caracteres += yyleng;
}

. {
    caracteres += yyleng;
}

%%

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf("Uso: ./analizador archivo.scala\n");
        return 1;
    }

    yyin = fopen(argv[1], "r");

    if (yyin == NULL)
    {
        printf("No se pudo abrir el archivo\n");
        return 1;
    }

    yylex();

    printf("\n========== RESULTADOS ==========\n");

    printf("Cantidad de lineas: %d\n", linea);
    printf("Cantidad de caracteres: %d\n", caracteres);
    printf("Palabras reservadas: %d\n", cont_reservadas);
    printf("Identificadores: %d\n", cont_identificadores);
    printf("Enteros: %d\n", cont_enteros);
    printf("Flotantes: %d\n", cont_flotantes);
    printf("Booleanos: %d\n", cont_booleanos);
    printf("Cadenas: %d\n", cont_cadenas);
    printf("Operadores: %d\n", cont_operadores);

    mostrarReservadasOrdenadas();

    generarArchivoLexemas();

    fclose(yyin);

    printf("\nArchivo lexemas.txt generado correctamente\n");

    return 0;
}

int yywrap()
{
    return 1;
}