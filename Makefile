all: lex yacc
	g++ lex.yy.c y.tab.c -ll -o ctopy

yacc: ctopy.y
	yacc -d ctopy.y

lex: ctopy.l
	lex ctopy.l
clean: 
	rm lex.yy.c y.tab.c  y.tab.h  ctopy


