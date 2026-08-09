%{
#include <stdio.h>

int linea = 1;

int cont_reservadas = 0;
int cont_identificadores = 0;
int cont_enteros = 0;
int cont_flotantes = 0;
int cont_booleanos = 0;
int cont_cadenas = 0;
int cont_operadores = 0;

%}

%%

"abstract"      { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"case"          { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"catch"         { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"class"         { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"def"           { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"do"            { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"else"          { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"extends"       { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"final"         { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"finally"       { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"for"           { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"if"            { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"implicit"      { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"import"        { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"lazy"          { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"match"         { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"new"           { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"object"        { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"override"      { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"package"       { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"private"       { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"protected"     { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"return"        { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"sealed"        { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"super"         { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"this"          { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"throw"         { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"trait"         { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"try"           { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"type"          { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"val"           { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"var"           { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"while"         { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"with"          { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }
"yield"         { cont_reservadas++; printf("%s -> PALABRA RESERVADA | Linea: %d\n", yytext, linea); }

"true"|"false" {
    cont_booleanos++;
    printf("%s -> BOOLEANO | Linea: %d\n", yytext, linea);
}

[0-9]+\.[0-9]+ {
    cont_flotantes++;
    printf("%s -> FLOTANTE | Linea: %d\n", yytext, linea);
}

[0-9]+ {
    cont_enteros++;
    printf("%s -> ENTERO | Linea: %d\n", yytext, linea);
}

\"[^\"]*\" {
    cont_cadenas++;
    printf("%s -> CADENA | Linea: %d\n", yytext, linea);
}

"==" {
    cont_operadores++;
    printf("%s -> OP_IGUAL | Linea: %d\n", yytext, linea);
}

"!=" {
    cont_operadores++;
    printf("%s -> OP_DIFERENTE | Linea: %d\n", yytext, linea);
}

">=" {
    cont_operadores++;
    printf("%s -> OP_MAYOR_IGUAL | Linea: %d\n", yytext, linea);
}

"<=" {
    cont_operadores++;
    printf("%s -> OP_MENOR_IGUAL | Linea: %d\n", yytext, linea);
}

"&&" {
    cont_operadores++;
    printf("%s -> OP_AND | Linea: %d\n", yytext, linea);
}

"||" {
    cont_operadores++;
    printf("%s -> OP_OR | Linea: %d\n", yytext, linea);
}

"+" {
    cont_operadores++;
    printf("%s -> OP_SUMA | Linea: %d\n", yytext, linea);
}

"-" {
    cont_operadores++;
    printf("%s -> OP_RESTA | Linea: %d\n", yytext, linea);
}

"*" {
    cont_operadores++;
    printf("%s -> OP_MULTIPLICACION | Linea: %d\n", yytext, linea);
}

"/" {
    cont_operadores++;
    printf("%s -> OP_DIVISION | Linea: %d\n", yytext, linea);
}

"%" {
    cont_operadores++;
    printf("%s -> OP_MODULO | Linea: %d\n", yytext, linea);
}

"=" {
    cont_operadores++;
    printf("%s -> OP_ASIGNACION | Linea: %d\n", yytext, linea);
}

">" {
    cont_operadores++;
    printf("%s -> OP_MAYOR | Linea: %d\n", yytext, linea);
}

"<" {
    cont_operadores++;
    printf("%s -> OP_MENOR | Linea: %d\n", yytext, linea);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    cont_identificadores++;
    printf("%s -> IDENTIFICADOR | Linea: %d\n", yytext, linea);
}

\n {
    linea++;
}

. {
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