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

int pr_abstract = 0;
int pr_case = 0;
int pr_catch = 0;
int pr_class = 0;
int pr_def = 0;
int pr_do = 0;
int pr_else = 0;
int pr_extends = 0;
int pr_final = 0;
int pr_finally = 0;
int pr_for = 0;
int pr_if = 0;
int pr_implicit = 0;
int pr_import = 0;
int pr_lazy = 0;
int pr_match = 0;
int pr_new = 0;
int pr_object = 0;
int pr_override = 0;
int pr_package = 0;
int pr_private = 0;
int pr_protected = 0;
int pr_return = 0;
int pr_sealed = 0;
int pr_super = 0;
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

FILE *archivo_lexemas;

void guardarLexema(char lexema[], char token[])
{
    fprintf(archivo_lexemas, "%s|%s|%d\n", lexema, token, linea);
}
%}

%%

"//".* {
    caracteres += yyleng;
}

"/*"([^*]|\*+[^*/])*\*+"/" {
    caracteres += yyleng;
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
        fclose(yyin);
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

    printf("\n===== PALABRAS RESERVADAS =====\n");

    if (pr_abstract > 0) printf("abstract: %d\n", pr_abstract);
    if (pr_case > 0) printf("case: %d\n", pr_case);
    if (pr_catch > 0) printf("catch: %d\n", pr_catch);
    if (pr_class > 0) printf("class: %d\n", pr_class);
    if (pr_def > 0) printf("def: %d\n", pr_def);
    if (pr_do > 0) printf("do: %d\n", pr_do);
    if (pr_else > 0) printf("else: %d\n", pr_else);
    if (pr_extends > 0) printf("extends: %d\n", pr_extends);
    if (pr_final > 0) printf("final: %d\n", pr_final);
    if (pr_finally > 0) printf("finally: %d\n", pr_finally);
    if (pr_for > 0) printf("for: %d\n", pr_for);
    if (pr_if > 0) printf("if: %d\n", pr_if);
    if (pr_implicit > 0) printf("implicit: %d\n", pr_implicit);
    if (pr_import > 0) printf("import: %d\n", pr_import);
    if (pr_lazy > 0) printf("lazy: %d\n", pr_lazy);
    if (pr_match > 0) printf("match: %d\n", pr_match);
    if (pr_new > 0) printf("new: %d\n", pr_new);
    if (pr_object > 0) printf("object: %d\n", pr_object);
    if (pr_override > 0) printf("override: %d\n", pr_override);
    if (pr_package > 0) printf("package: %d\n", pr_package);
    if (pr_private > 0) printf("private: %d\n", pr_private);
    if (pr_protected > 0) printf("protected: %d\n", pr_protected);
    if (pr_return > 0) printf("return: %d\n", pr_return);
    if (pr_sealed > 0) printf("sealed: %d\n", pr_sealed);
    if (pr_super > 0) printf("super: %d\n", pr_super);
    if (pr_this > 0) printf("this: %d\n", pr_this);
    if (pr_throw > 0) printf("throw: %d\n", pr_throw);
    if (pr_trait > 0) printf("trait: %d\n", pr_trait);
    if (pr_try > 0) printf("try: %d\n", pr_try);
    if (pr_type > 0) printf("type: %d\n", pr_type);
    if (pr_val > 0) printf("val: %d\n", pr_val);
    if (pr_var > 0) printf("var: %d\n", pr_var);
    if (pr_while > 0) printf("while: %d\n", pr_while);
    if (pr_with > 0) printf("with: %d\n", pr_with);
    if (pr_yield > 0) printf("yield: %d\n", pr_yield);

    fclose(yyin);
    fclose(archivo_lexemas);

    printf("\nArchivo lexemas.txt generado correctamente\n");

    return 0;
}

int yywrap()
{
    return 1;
}