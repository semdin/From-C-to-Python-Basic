%{
    #include <stdio.h>
    #include <iostream>
    #include <string>
    #include <vector>
    #include <string.h>
    using namespace std;
    #include "y.tab.h"
    extern FILE *yyin;
    extern int yylex();
    extern int linenum;
    void yyerror(string s);
	extern vector<string> lines;
	
    struct STRUCT {    
        string name;
        bool initialize;
		int value;
    };
    
    
	

%}

%union
{
    int value;
    char * str;
}


%token <str> DIGIT INT IDENTIFIER COMMA SEMICOLON EQUAL OPERATOR OP CP
%type<str> assignment initialize statement assign
%%

print:
	statement print
	|
	statement
	;

statement:
	initialize
	|
	IDENTIFIER EQUAL assign SEMICOLON
	{
		cout<<$1<<" "<<$2<<" "<<$3<<endl;
	}
	;

initialize:
	INT assignment SEMICOLON{
	}
	;

assignment:
	IDENTIFIER{
	}
	|
	IDENTIFIER EQUAL DIGIT{
		cout<<$1<<" = "<<$3<<endl;
	}
	|
	IDENTIFIER EQUAL IDENTIFIER
	|
	COMMA assignment
	|
	assignment assignment{
	}
	;

assign:
	IDENTIFIER{
		$$ = strdup($1);
	}
	|
	DIGIT{
		$$ = strdup($1);
	}
	|
	assign OPERATOR assign{
		string combined = string($1) + string($2) + string($3);
		$$ = strdup(combined.c_str());
	}
	|
	OP assign CP{
		string combined = string($1) + string($2) + string($3);
		$$ = strdup(combined.c_str());
	}
	;


%%
void yyerror(string s){
    cerr<<"Error..."<<endl;
}
int yywrap(){
    return 1;
}
int main(int argc, char *argv[])
{

    /* Call the lexer, then quit. */
    yyin=fopen(argv[1],"r");
    yyparse();

    fclose(yyin);
    return 0;
}