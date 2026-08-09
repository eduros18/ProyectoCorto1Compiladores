%{
#include <stdio.h>
%}

%%

hola    { printf("Encontramos la palabra hola\n"); }
.       {}

%%

int main()
{
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}