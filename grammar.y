%{
#include <stdio.h>

int yylex();
int yyerror(char *s);
int yyin;

%}

%token MNE REGISTAR WS

%type <name> MNE
%type <name1> REGISTAR

%union{
	  char name[20];
	  char name1[20];
}



%%

prog: 

MNE WS REGISTAR {
	printf("Mneumonik: %s, Registar: %s\n", $1, $3);
}



%%



int yyerror(char *s)
{
	printf("Syntax Error on line %s\n", s);
	return 0;
}

int main()
{
	yyin=fopen("myfile.txt","r");
    yyparse();
    return 0;
}






