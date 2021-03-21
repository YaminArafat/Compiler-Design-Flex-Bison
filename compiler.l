var [a-z|A-Z]
digit [0-9]

%{
int k, i,pt,v,h,p,o,c,l,f,sl,cholok;
char a[100][100];
char keyword[100][100];
char condition[100][100];
char library[100][100];
char loop[100][100];
char operator[100];
char punctuation[100];
char variablee[100];
%}


%%
"--"	{printf("single line comment found: --");sl++;}
[~]	{printf("Library found ");}
{var}+[ ]+{var}+[(]{var}*[)] 	{printf("Funtion Declared");f++;}
{var}+[(]{var}*[)] 	{printf("Funtion called");}
[#]"show"[(]{var}*[)]  {printf("Printing value");}
[$][\n]{var}+[ ]{var}+[\n][$] {printf("Main Funtion");}
"int"|"float"|"double"|"string"|"char"|"return"|"map"|"queue"|"vector"|"array"|"bool"  {printf(" Keyword found ");for(i=0; i<yyleng; i++){
keyword[k][i]=yytext[i];
};k++;}
"while"|"for" {printf(" Loop found ");for(i=0; i<yyleng; i++){
loop[l][i]=yytext[i];
};l++;}
"if"|"else"|"switch"|"elif"|"hcfhcfchc"[ ]*[(][ ]*{var}+[ ]*["=="|"<="|">="|"!="][ ]*{digit}+[ ]*[)] {printf(" Condition found ");for(i=0; i<yyleng; i++){
condition[c][i]=yytext[i];
};c++;}
{var}+[ ]+{var}+[ ]*[=][ ]*{digit}+[;]+ {printf("Variable declared and Value assigned.\n");for(i = 0;i<yyleng;i++){
if(yytext[i]!=' ')
continue;
if(yytext[i]=='=')
break;
if(yytext[i]==' ')
i++;
variablee[cholok]=yytext[i];
};cholok++;}
{var}+[ ]*[=][ ]*{digit}+[;]+ {printf("Value assigned.\n");}
{var}+[ ]+{var}+[;] {printf("Variable declared.\n");cholok++;}
{var}+[ ]*[=][ ]*[{var}+|{digit}+][ ]*["+"|"-"|"/"|"*"][ ]*[{var}+|{digit}+][;] {printf("Operation Done.\n");}
"+"|"-"|"*"|"/"|"="|"<"|"<="|">"|">="|"++"|"--"|"!"|"==" {printf(" Operator found ");for(i=0; i<yyleng; i++){
operator[o]=yytext[i];
};o++;}
"|"|","|"@"|"%"|":"|"?"|"_" {printf(" Punctuation found ");for(i=0; i<yyleng; i++){
punctuation[p]=yytext[i];
};p++;}
[;]

%%

int yywrap()
{ 
    return 1;
}

int main()
{
	yyin = freopen("input.txt", "r",stdin);
	yyout = freopen("output.txt","w", stdout);
	yylex();
	printf("Keyword : %d\n", k);
	
	for(i=0; i<k; i++){
        	printf("%d. %s\n",i+1,keyword+i);
		}
	printf("Puntuation : %d\n", p);
	for(i=0; i<p; i++){
        	printf("%d. %c\n",i+1,punctuation[i]);
		}
	printf("Operator : %d\n", o);
	for(i=0; i<o; i++){
        	printf("%d. %c\n",i+1,operator[i]);
		}
	printf("Condition : %d\n", c);
	for(i=0; i<c; i++){
        	printf("%d. %s\n",i+1,condition+i);
		}
	printf("Loop : %d\n", l);
	for(i=0; i<l; i++){
        	printf("%d. %s\n",i+1,loop+i);
		}
	printf("Total single line comments : %d\n", sl);
	printf("Total Function : %d\n", f);
	printf("Total Variable : %d\n", cholok);
	for(i=0; i<cholok; i++){
        	printf("%d. %c\n",i+1,variablee[i]);
		}
	fclose(yyin);
	fclose(yyout);
	return 0;
}