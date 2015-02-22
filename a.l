%{
#include<stdio.h>
#include<string.h>
#include "y.tab.h"
extern char* yytext;
extern FILE *yyout;	

FILE *fp ;

%}
%option noyywrap
letter [a-zA-Z]
digit [0-9]
underscore _


%%	

[\n]        { yylineno = yylineno + 1;}            
"program"	{return PROGRAM;}
";"			{ return SEMIC; }
"var" 		{ return VAR; }
"if"		{ return IF_ST; }
"while"		{ return WHILE_ST; }
"then"		{ return THEN_ST; }
"else"		{ return ELSE_ST; }
"("			{ return L_PAR; }
")"			{ return R_PAR; }
","			{ return COMMA; }
"procedure" {return PROCEDURE_ST; }
"function" 	{return FUNCTION_ST; }
":"			{ return DOUBLE_DOT; }
"integer"	{return INTEGER; }
"boolean"	{return BOOLEAN; }
"do"		{ return DO_ST; }
"begin"		{ return BEGIN_ST; }
"end" 		{ return END_ST; }
"." 		{ return DOT; }

"="			{ return EQ; }
"<>"		{ return NOT_EQ; }
"or"		{ return OR; }
"and"		{ return AND; }
"<"			{ return LESS; }
">"			{ return HIGH; }
">="		{ return HIGH_EQ; }
"<="		{ return LESS_EQ; }
"+"			{ return ADD; }
"posit"			{ return PLUS; }
"-"			{ return MINUS; }
"negativ"	{ return MINUSS; }
"*"			{ return MUL; }
"div"		{ return DIV; }
"mod"		{ return MOD; }
"not"		{ return NOT; }
":="    	{ return ASSIGN ; }
{digit}+	{ yylval = atoi(yytext); return INTCONST; }
{letter}({letter}|{digit}|{underscore})*  { return ID; }

"/*" {
		register int c;

		for ( ; ; )
		{
			while ( (c = input()) != '*' &&  c != EOF )
			;	   

			if ( c == '*' )
			{
				while ( (c = input()) == '*' )
				;
				if ( c == '/' )
				break;    
			}

			if ( c == EOF )
			{
				error( "EOF in comment" );
			}
		}
}

%%

main(int argc, char *argv[])
{
	if(argc==2)
	{
			yyin=fopen(argv[1],"r");
			
			if(!yyparse()) fprintf(stderr,"\nParsing complete\n");
			else fprintf(stderr,"\nParsing failed, error detected in line %d - %s\n\a",yylineno,yytext);
				
			fclose(yyin);
	}
	else
	{
		printf("File not found");
	}
}


yyerror(const char *s) {
	fprintf(stderr, "%s\n", s);
}



