%{
#include <stdio.h>
#include "grammar.tab.h"
void showError();

%}
labele ([a-zA-Z][0-9a-zA-Z]+)
sekcije ("data"|"text"|"bss")
registri   ("r"[0-7]|"sp"|"pc")
white_space (" ")
newline ([\n])
mneumonici       ("mov"|"equ"|"add"|"sub")

%%

{mneumonici}			   {sscanf(yytext, "%s", yylval.name); return (MNE);}
{registri}      {sscanf(yytext, "%s", yylval.registar); return (REGISTAR);}
{white_space} { return (WS);}
{newline} { return (NL); }
"." {return (DOT);}
{sekcije} { sscanf(yytext, "%s", yylval.sekcija); return (SEK); }
".end" { return (END); }
"EOF" { return (ENDE); }
%%


void showError(){
    printf("Other input");
}

