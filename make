bison -y -d a.y 
flex a.l
gcc -c y.tab.c lex.yy.c
gcc y.tab.o lex.yy.o -o parser