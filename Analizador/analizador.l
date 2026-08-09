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

%}

%%

"abstract" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"case" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"catch" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"class" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"def" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"do" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"else" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"extends" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"final" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"finally" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"for" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"if" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"implicit" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"import" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"lazy" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"match" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"new" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"object" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"override" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"package" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"private" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"protected" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"return" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"sealed" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"super" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"this" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"throw" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"trait" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"try" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"type" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"val" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"var" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"while" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"with" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}

"yield" {
    caracteres += yyleng;
    cont_reservadas++;
    printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea);
}


"true"|"false" {
    caracteres += yyleng;
    cont_booleanos++;
    printf("%s -> BOOLEANO | Linea: %d\n", yytext, linea);
}


[0-9]+\.[0-9]+ {
    caracteres += yyleng;
    cont_flotantes++;
    printf("%s -> FLOTANTE | Linea: %d\n", yytext, linea);
}


[0-9]+ {
    caracteres += yyleng;
    cont_enteros++;
    printf("%s -> ENTERO | Linea: %d\n", yytext, linea);
}


\"[^\"]*\" {
    caracteres += yyleng;
    cont_cadenas++;
    printf("%s -> CADENA | Linea: %d\n", yytext, linea);
}


"==" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_IGUAL | Linea: %d\n", yytext, linea);
}

"!=" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_DIFERENTE | Linea: %d\n", yytext, linea);
}

">=" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_MAYOR_IGUAL | Linea: %d\n", yytext, linea);
}

"<=" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_MENOR_IGUAL | Linea: %d\n", yytext, linea);
}

"&&" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_AND | Linea: %d\n", yytext, linea);
}

"||" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_OR | Linea: %d\n", yytext, linea);
}

"+" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_SUMA | Linea: %d\n", yytext, linea);
}

"-" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_RESTA | Linea: %d\n", yytext, linea);
}

"*" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_MULTIPLICACION | Linea: %d\n", yytext, linea);
}

"/" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_DIVISION | Linea: %d\n", yytext, linea);
}

"%" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_MODULO | Linea: %d\n", yytext, linea);
}

"=" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_ASIGNACION | Linea: %d\n", yytext, linea);
}

">" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_MAYOR | Linea: %d\n", yytext, linea);
}

"<" {
    caracteres += yyleng;
    cont_operadores++;
    printf("%s -> OP_MENOR | Linea: %d\n", yytext, linea);
}


[a-zA-Z_][a-zA-Z0-9_]* {
    caracteres += yyleng;
    cont_identificadores++;
    printf("%s -> IDENTIFICADOR | Linea: %d\n", yytext, linea);
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

    fclose(yyin);

    return 0;
}


int yywrap()
{
    return 1;
}