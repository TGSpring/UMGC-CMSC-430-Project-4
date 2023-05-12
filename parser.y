/*
Tyler Spring
3/2/23
Project 4
This is the parser file. Here the rules of how the grammar is read and analyzed is decided.
Added is the extra function, variable, and cases functions. Other existing functions were 
modified as well.
*/

%{

#include <string>
#include <vector>
#include <map>

using namespace std;

#include "types.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);

Symbols<Types> symbols;

%}

%define parse.error verbose

%union
{
	CharPtr iden;
	Types type;
}

%token <iden> IDENTIFIER
%token <type> INT_LITERAL REAL_LITERAL BOOL_LITERAL
 /*added tokens*/

%token ADDOP MULOP RELOP ANDOP REMOP OROP ARROWOP EXPOP
%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER ELSE ENDIF CASE EDNREDUCE ENDCASE
%token IS REDUCE RETURNS IF NOT OTHERS REAL THEN WHEN
/* added types for functions. Turns out it does not like being named 2expression because  */
%type <type> type statement statement_ reductions expression expression2 relation relation2 relation3 term factor primary cases case case2

%%

function:	
	function_header optional_variable body ;

/*added function header to help with reading header of files*/

function_header2:
	function_header |
	error ';' ;
	
function_header:	
	FUNCTION IDENTIFIER RETURNS type ';';

/*This is probably what I was missing from project 3. Correct implementation of parameters.*/

parameters:
	parameter2 optional_parameter ;

optional_parameter:
	',' parameter2 |
	 ;

parameter2:
	IDENTIFIER ':' type ;

/*Added variable functions for reading files with more than one variable.*/

variable2:
	variable3 optional_variable ;


variable3:
	variable optional_variable |
	error ';' ;


optional_variable:
	variable |
	;

/*findDup added.*/

variable:	
	IDENTIFIER ':' type IS statement_ 
		{checkAssignment($3, $5, "Variable Initialization");
		symbols.insert($1, $3);
		symbols.findDup($1, $3);} ;

/*REAL added*/

type:
	INTEGER {$$ = INT_TYPE;} |
	REAL {$$ = REAL_TYPE;} |
	BOOLEAN {$$ = BOOL_TYPE;} ;

body:
	BEGIN_ statement_ END ';' ;
    
statement_:
	statement ';' |
	error ';' {$$ = MISMATCH;} ;
	
statement:
	expression |
	REDUCE operator reductions ENDREDUCE {$$ = $3;} |
	IF expression THEN statement_ ELSE statement_ ENDIF {checkIf($2, $4, $6);} |
	CASE expression IS cases OTHERS ARROWOP statement_ ENDCASE {checkCases($2);} ;

operator:
	ADDOP |
	MULOP ;

reductions:
	reductions statement_ {$$ = checkArithmetic($1, $2);} |
	{$$ = INT_TYPE;} ;

cases:
	case case2 {checkCases($1, $2, "Case");};
 
/*Added case functions with ARROWOP token.*/

case:
	WHEN INT_LITERAL ARROWOP expression ';' {$$ = $4;};

case2:
	WHEN INT_LITERAL ARROWOP expression';' {$$ = $4;};
		    
expression:
	expression ANDOP relation {$$ = checkLogical($1, $3);} |
	relation ;

expression2:
	expression2 OROP relation {$$ = checkLogical($1, $3);} |
	relation ;

relation:
	relation RELOP term {$$ = checkRelational($1, $3);}|
	relation2 ;

/*Added relation function for remainder and arithmetic.*/

relation2:
	relation2 REMOP relation3 {$$ = checkRemainder($1, $3);} |
	relation3 ;
relation3:
	relation3 EXPOP term {$$ = checkArithmetic($1, $3);} |
	term ;

term:
	term ADDOP factor {$$ = checkArithmetic($1, $3);} |
	factor ;
      
factor:
	factor MULOP primary  {$$ = checkArithmetic($1, $3);} |
	primary ;
/*Probably the best primary function I have made in this class.*/
primary:
	'(' expression ')' {$$ = $2;} |
	NOT expression {$$ = $2;} |
	INT_LITERAL |
	REAL_LITERAL |
	BOOL_LITERAL |
	IDENTIFIER {if (!symbols.find($1, $$)) appendError(UNDECLARED, $1);} ;
    
%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 
