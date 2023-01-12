digit    [0-9]
letter    [A-Za-z]
%{
  #include <stdio.h>
  #include <string.h>
  #include "y.tab.h"
  #include <iostream>
  #include <vector>
  using namespace std;
  int linenum=1;
  vector<string> lines;
%}

%%

"(" {yylval.str=strdup(yytext); return OP;}
")" {yylval.str=strdup(yytext); return CP;}
"int" {yylval.str=strdup(yytext); return INT;}
"," {yylval.str=strdup(yytext); return COMMA;}
";" {yylval.str=strdup(yytext); return SEMICOLON;}
"=" {yylval.str=strdup(yytext); return EQUAL;}
"+"|"-"|"/"|"*" {yylval.str=strdup(yytext); return OPERATOR;}
{digit}+ {yylval.str=strdup(yytext); return DIGIT;}
{letter}({letter}|{digit})*    {yylval.str=strdup(yytext); return IDENTIFIER;}
" "
\n {lines.push_back(yytext); linenum++;}

%%