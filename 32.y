%{
	#define YYSTYPE double
	#include<stdio.h>
	#include<stdlib.h>
	#include <math.h>
	#include <malloc.h>
	
	int yyparse();
    int yylex();
    int yyerror();
%}


%token NUM INC DEC SPACE NEWLINE LE GE EQEQ FOR WHILE INT FLOAT CHAR PLUS MINUS MULT DIV EQUAL LOOP_END IIF ELSE ELIF COND_END SHOW HEADER_END MAIN MAIN_END HEADER TO TYPE 

%right EQUAL
%left '<' '>' LE GE EQEQ
%left PLUS MINUS
%left MULT DIV

%start input

%%
input:	 header_start  main
		 | 
	 	 ;
header_start:  header 
			   ;
header:		 HEADER header_start

			 |HEADER
			 
			 
		 ;
		
main: 	 MAIN '\n' body '\n' MAIN_END
		|MAIN
		 ;
body:  stmnt '\n'
	;
stmnt:   
	     condition
	     |show
	     |loop
	     |assign
	     |declare
	     |
	     ;
condition: IIF '(' expr ')' '\n' body COND_END {
	printf("%d\n",(int)$3 );
			if((int)$3){
				printf("If condition compiled\n");
			}
			else {
			printf("If compilation failed.\n");
		}
}
			| IIF '(' expr ')' '\n' body ELSE '\n' body COND_END {
				printf("%d\n",(int)$3 );
		if((int)$3){
			printf("If is executed.\n");
		}
		else {
			printf("Else is executed.\n");
			 }
	}
	| IIF '(' expr ')' '\n' body ELIF '(' expr ')' '\n' body '\n' ELSE '\n' body COND_END {
		if($3){
			printf("If is executed.\n");
		}
		else if($9){printf("Else If is executed.\n");}
		else {
			printf("Else is executed.\n");
			 }
	}
			;

show:      SHOW '(' expr ')' {
			printf("Showing\n");
			printf("%f\n",$3);
}
			;
loop: 		WHILE '(' loop_condition ')' '\n' body LOOP_END {
			printf("While loop is executed.\n");
			}
			| FOR '(' loop_condition ')' '\n' body LOOP_END {
			printf("For loop is executed.\n");
			}
			;

loop_condition:
			NUM TO NUM 	{$$ = $3 - $1;}
			;
assign:     identifiers EQUAL expr {
								sym[(int)$1]=$3;
							
						}
declare:	TYPE identifiers {
				sym[(int)$2]=0;
}

expr:      NUM 				{ $$ = $1; }
		   | expr PLUS expr	{printf("Showing\n"); $$ = $1 + $3; }
           | expr MINUS expr 	{ $$ = $1 - $3; }
           | expr MULT expr	{ $$ = $1 * $3; }
           | expr DIV expr	{ $$ = $1 / $3; }
           | expr '<' expr 	{$$ = $1 < $3;}
		   | expr '>' expr 	{$$ = $1 > $3;}
		   | expr GE expr 	{$$ = $1 >= $3;}
		   | expr LE expr 	{$$ = $1 <= $3;}
		   | expr EQEQ expr 	{$$ = $1 == $3;}
		   | '(' expr ')'	{printf("Showing\n"); $$ = $2; }
		   ;
/*line:	NEWLINE
	| exp NEWLINE { printf("\t%.9g\n",$1); }
	;
exp:      NUMBER		{ $$ = $1; 	}
        | exp PLUS exp		{ $$ = $1 + $3; }
        | exp MINUS exp 	{ $$ = $1 - $3; }
        | exp ASTERISK exp	{ $$ = $1 * $3; }
        | exp SLASH exp		{ $$ = $1 / $3; }
        | LPAREN exp RPAREN	{ $$ = $2; 	}
	;*/
%%

int yyerror(char const *s)
{
	printf("%s\n",s);
	return (0);
}

