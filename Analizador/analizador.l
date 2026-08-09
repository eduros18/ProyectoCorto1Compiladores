%{
#include <stdio.h>

int linea = 1;
int caracteres = 0;

int cont_reservadas = 0;
int cont_identificadores = 0;
int cont_enteros = 0;
int cont_flotantes = 0;
int cont_booleanos = 0;
int cont_cadenas = 0;
int cont_operadores = 0;

FILE *archivo_lexemas;

void guardarLexema(char lexema[], char token[])
{
    fprintf(archivo_lexemas, "%s|%s|%d\n", lexema, token, linea);
}

%}

%%

"abstract" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_ABSTRACT");
}

"case" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_CASE");
}

"catch" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_CATCH");
}

"class" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_CLASS");
}

"def" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_DEF");
}

"do" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_DO");
}

"else" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_ELSE");
}

"extends" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_EXTENDS");
}

"final" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_FINAL");
}

"finally" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_FINALLY");
}

"for" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_FOR");
}

"if" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_IF");
}

"implicit" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_IMPLICIT");
}

"import" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_IMPORT");
}

"lazy" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_LAZY");
}

"match" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_MATCH");
}

"new" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_NEW");
}

"object" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_OBJECT");
}

"override" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_OVERRIDE");
}

"package" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_PACKAGE");
}

"private" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_PRIVATE");
}

"protected" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_PROTECTED");
}

"return" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_RETURN");
}

"sealed" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_SEALED");
}

"super" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_SUPER");
}

"this" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_THIS");
}

"throw" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_THROW");
}

"trait" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_TRAIT");
}

"try" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_TRY");
}

"type" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_TYPE");
}

"val" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_VAL");
}

"var" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_VAR");
}

"while" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_WHILE");
}

"with" {
    caracteres += yyleng;
    cont_reservadas++;
    guardarLexema(yytext, "PR_WITH");
}

"yield" {
    caracteres += yyleng;
    cont_reservadas++;
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

    archivo_lexemas = fopen("lexemas.txt", "w");

    if (archivo_lexemas == NULL)
    {
        printf("No se pudo crear lexemas.txt\n");
        return 1;
    }

    fprintf(archivo_lexemas, "LEXEMA|TOKEN|LINEA\n");

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

    fclose(yyin);
    fclose(archivo_lexemas);

    printf("\nArchivo lexemas.txt generado correctamente\n");

    return 0;
}

int yywrap()
{
    return 1;
}