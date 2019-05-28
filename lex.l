%{

#include <stdio.h>
#include <string.h>
#include "grammar.tab.h"
void showError();
%}

registri   ("r"[0-9])
white_space (" ")
mneumonici       ("mov"|"equ")

%%

{mneumonici}			   {sscanf(yytext, "%s", yylval.name); return (MNE);}
{registri}      {sscanf(yytext, "%s", yylval.name1); return (REGISTAR);}
{white_space} { return (WS);}

%%


void showError(){
    printf("Other input");
}