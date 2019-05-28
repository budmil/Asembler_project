all:prog
grammar.tab.h grammar.tab.c: grammar.y
	bison -d grammar.y
lex.yy.c:grammar.tab.h lex.l
	flex lex.l
prog: symbol_table.h lex.yy.c grammar.tab.c 
	gcc -o prog symbol_table.h lex.yy.c grammar.tab.c -lfl
