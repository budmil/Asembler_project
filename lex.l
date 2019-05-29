%{
#include <stdio.h>
#include "grammar.tab.h"
void showError();

%}
doseg ("global"|"extern")
kraj (".end")
labele ([a-zA-Z][0-9a-zA-Z]*)
sekcije ("data"|"text"|"bss")
registri   ("r"[0-7]|"sp"|"pc")
white_space (" ")
newline ([\n])
operacija       ("mov"|"equ"|"add"|"sub")

%%

{operacija}			   {sscanf(yytext, "%s", yylval.name); return (OPR);}
{registri}      {sscanf(yytext, "%s", yylval.name); return (REGISTAR);}
{white_space} { return (WS);}
{newline} { return (NL); }
"." {return (DOT);}
"," {return (COMA);}
{sekcije} { sscanf(yytext, "%s", yylval.name); return (SEK); }
{doseg} { sscanf(yytext, "%s", yylval.name); return (DOSEG);}
{labele} { sscanf(yytext,"%s",yylval.name); return (LAB);}
{kraj} { return (END); }
<<EOF>> {return (ENDE); }
%%


void showError(){
    printf("Other input");
}

