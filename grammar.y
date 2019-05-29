%{
#include <stdio.h>
#include "symbol_table.h"

int yylex();
int yyerror(char *s);
char scope;
%}

%token OPR REGISTAR WS NL DOT SEK END ENDE COMA DOSEG LAB REGIND


%type <name> OPR
%type <name> REGISTAR
%type <name> SEK
%type <name> DOSEG
%type <name> LAB
%type <name> adresiranje
%type <name> REGIND

%union{
	  char name[10];
}



%%

prog: 
rows kraj
;

kraj:
END | ENDE {
	YYACCEPT;
}


rows:
|row rows

row:
section | operation1 | operation2 | scope

scope:
space DOT DOSEG space LAB scope1 NL{
	scope = $3; 
	printf("doseg: %s %s\n", $3, $5);
	putsym($5, scope);
}

scope1: 
|space COMA space LAB scope1 {
	printf(" %s ",$4);
	putsym($4, scope);
}

section:
space DOT space SEK space NL {

	printf("sekcija: %s\n", $4);
	putsym($4,'l');
}

adresiranje:
REGISTAR {
	if (operator1_turn) {
		operator1_type = adr_regdir;
		operator1_value = $1;
		operator1_turn = 0;
	} else {
		operator2_type = adr_regdir;
		operator2_value = $1;
		operator1_turn = 1;
	}
} | REGIND {
	
}

operation2: 
space OPR space adresiranje space COMA space adresiranje space NL {
	work_operation ($2);
	//printf("Mneumonik: %s, Registar1: %s, Registar2:%s\n", $2, $4,$8);
	rednibroj++;
}
operation1:
space OPR space adresiranje space NL {

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

int main(int argc, char* argv[])
{
	rednibroj=0;
	FILE *fp; //fileprint
	extern FILE *yyin;
	if (strcmp(argv[1],"-o")) {
		printf ("Bad input: %s\nTry following pattern: -o output.txt input.txt\n",argv[1]);
		return 1;
	}
	yyin=fopen(argv[3], "r");	
	prvi_prolaz = 1;
	yyparse();
	fp=fopen(argv[2], "w");
	printf("First parse complete.\n");
	
	//prvi_prolaz = 0;
	//yyparse();
	ispisi(fp);
	
	fclose(fp);
	fclose(yyin);
    return 0;
}







