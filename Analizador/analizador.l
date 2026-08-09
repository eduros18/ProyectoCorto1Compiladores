%{
#include <stdio.h>

int linea = 1;
%}

%%

\n      { linea++; }

.       {}

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

    printf("Cantidad de lineas: %d\n", linea);

    fclose(yyin);

    return 0;
}

int yywrap()
{
    return 1;
}