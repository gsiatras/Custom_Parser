%token PROGRAM
%token SEMIC
%token VAR
%token IF_ST
%token WHILE_ST
%token THEN_ST
%token ELSE_ST
%token L_PAR
%token R_PAR
%token COMMA
%token PROCEDURE_ST
%token FUNCTION_ST
%token DOUBLE_DOT
%token INTEGER
%token BOOLEAN
%token DO_ST
%token BEGIN_ST
%token END_ST

%token ASSIGN
%token DOT
%token ID
%token INTCONST

%token EQ
%token NOT_EQ
%token OR
%token AND
%token LESS
%token HIGH
%token HIGH_EQ
%token LESS_EQ
%token ADD
%token PLUS
%token MINUS
%token MINUSS
%token MUL
%token DIV
%token MOD
%token NOT


%start program


%%


program : PROGRAM ID SEMIC block DOT
		;

block :	localdefinitions compoundstatement
		;

localdefinitions : 
				| localdefinition localdefinitions
				;

localdefinition : variabledefinition
				| proceduredefinition
				| functiondefinition
				;
					
x1 : formalparameter SEMIC
   ;

x1s : 
	| x1 x1s
	;

variabledefinition : VAR x1 x1s
     			   ;

x2 : COMMA ID
   ;

x2s :
	| x2 x2s
	;

proceduredefinition : procedureheader block SEMIC
					;

procedureheader : PROCEDURE_ST ID formalparameters SEMIC
				;

functiondefinition : functionheader block SEMIC
				   ;

functionheader : FUNCTION_ST ID formalparameters DOUBLE_DOT datatype SEMIC
			   ;

x3 : 
   | SEMIC formalparameter x3
   ;

x4 : L_PAR formalparameter x3 R_PAR
   ;

formalparameters : x4
			     ;

formalparameter : ID x2s DOUBLE_DOT datatype
				;

datatype : INTEGER
		 | BOOLEAN
		 ;

statement : 
		  | ifstatement
		  | whilestatement
		  | compoundstatement  
		  | ID sameright 
		  ;
			
sameright : ASSIGN expression
		  | L_PAR actualparameters R_PAR
		  |
		  ;

ifstatement : IF_ST expression THEN_ST statement xelse
			;

xelse : ELSE_ST statement 
	  |
	  ;

whilestatement : WHILE_ST expression DO_ST statement
			   ;
	

actualparameters : expression x6s
			     ;

x6 : COMMA expression 
   ;

x6s : 
	| x6 x6s
	;

compoundstatement :	BEGIN_ST x8 END_ST
				  | BEGIN_ST END_ST
				  ;
					
x7 : SEMIC statement 
   ;

x7s : 
	| x7 x7s 
	;

x8 : statement x7s
   ;
	
				
			
				
expression : unaryoperator expression newRule
			| L_PAR expression R_PAR newRule
			| INTCONST newRule 
			| ID x66 newRule
			;
			
			
newRule : 
		| binaryoperator expression newRule
		;
			
x66 : L_PAR actualparameters R_PAR 
	| 
	;		
			
			
			
							   
binaryoperator : EQ
				| NOT_EQ
				| OR
				| AND
				| LESS
				| HIGH
				| HIGH_EQ
				| LESS_EQ
				| ADD
				| MINUS
				| MUL
				| DIV
				| MOD
				;
					
unaryoperator :	PLUS
			  | MINUSS
			  | NOT
			  ;
				
%%

