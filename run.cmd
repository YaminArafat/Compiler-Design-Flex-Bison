bison -d 32.y
flex 32.l
gcc lex.yy.c 32.tab.c -o app
app