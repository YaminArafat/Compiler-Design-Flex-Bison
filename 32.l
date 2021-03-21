%{
    #include "32.tab.h"
    #include<stdio.h>
    #include<stdlib.h>
    #include <string.h>
    extern YYSTYPE yylval;
    int yyparse();
    int yylex();
    int yyerror();
  
    
%}



identifiers [_a-zA-Z][_a-zA-Z0-9]*
SPACE [ ]
NEWLINE [\n]
HEADER [a-zA-Z][ ]*[a-zA-Z]+[0-9]*
type "iint"|"char"|"float"







%%
"++"   		{return INC;}
NUM       {yylval = atoi(yytext);return NUM;}
"--"		{return DEC;}
SPACE       {return SPACE;}
"le"	 	{return LE;}
"ge"	  	{return GE;}
"eqeq"	  	{return EQEQ;}
"ffor" 		{return FOR;}
"wwhile" 	{return WHILE;}
"iint"		{return INT;}
"ffloat"	{return FLOAT;}
"cchar"		{return CHAR;}
"plus"		    {return PLUS;}
"minus"		    {return MINUS;}
"mult"		    {return MULT;}
"div"		    {return DIV;}
"="		{return EQUAL;}
loop_end	{return LOOP_END;}
iif		    {printf("If L\n");return IIF;}
else		{return ELSE;}
elif		{return ELIF;}
cond_end	{printf("Condition ended\n"); return COND_END;}
show		{printf("Showing L\n"); return SHOW;}
header_end	{printf("Header ended\n");return HEADER_END;}
main		{printf("Main started\n"); return MAIN;}
main_end	{printf("Main ended\n");return MAIN_END;}
{HEADER}    {printf("Header compiled successfully\n");return HEADER;}
[to]        {return TO;}
%%

	


int yywrap()
{
    return 1;
}
int main()
{

    yyin=freopen("in.txt","r",stdin);
    yyout=freopen("ou.txt","w",stdout);

    yyparse();
    exit (0);
    
}