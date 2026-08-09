%{
#include <stdio.h>

int linea = 1;
int cont_reservadas = 0;

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

\n              { linea++; }

.               {}

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

    printf("\nCantidad de lineas: %d\n", linea);
    printf("Cantidad de palabras reservadas: %d\n", cont_reservadas);

    fclose(yyin);

    return 0;
}

int yywrap()
{
    return 1;
}