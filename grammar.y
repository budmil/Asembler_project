%{
#include <stdio.h>

int yylex();
int yyerror(char *s);
int yyin;

%}

%token MNE REGISTAR WS NL DOT SEK END ENDE

%type <name> MNE
%type <registar> REGISTAR
%type <sekcija> SEK

%union{
	  char name[20];
	  char registar[20];
	  char sekcija[20];
}



%%

prog: 
rows kraj
;

kraj:
ENDE|END {
	YYACCEPT;
}


rows:
|row rows

row:
directive | operation

directive:
space DOT space SEK space NL {
	printf("sekcija: %s\n", $4);
}

operation:
space MNE space REGISTAR space REGISTAR space NL {
	printf("Mneumonik: %s, Registar: %s\n", $2, $4);
}

space:
| WS space

;

%%



int yyerror(char *s)
{
	printf("Syntax Error on line %s\n", s);
	return 0;
}

int main()
{
	yyin=fopen("myfile.txt", "r");
	yyparse();
    return 0;
}







