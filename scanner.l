/*
Tyler Spring
3/2/23
Project 4
This is the scanner file. Here the reversed words and keys for the parser file to use to read and make the grammar for
an input file.
This file stayed the same so I did not change anything here besides changing the declarations back to just return instead of that nightmare
operator call.
*/

%{
#include <string>

using namespace std;

#include "types.h"
#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment	        \-\-.*\n
comment2 	\\\\.*\n
line		[\n]
id		[A-Za-z][A-Za-z_0-9]*
real		{digit}+\.{digit}*([Ee][+-]?{digit}+)?
bool		(true|false)
digit		[0-9]
int		{digit}+
punc		[\(\),:;]
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{comment2}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
{real}		{ECHO; return(REAL_LITERAL);}
{bool}		{ECHO; return(BOOL_LITERAL);}

"<"		{ ECHO; return(RELOP); }
">"		{ ECHO;  return(RELOP); }
"="		{ ECHO; return(RELOP); }
"/="		{ ECHO; return(RELOP); }
"<="		{ ECHO; return(RELOP); }
">="		{ ECHO; return(RELOP); }
"+"		{ ECHO; return(ADDOP); }
"-"		{ECHO; return(ADDOP);}
"/"		{ECHO; return(MULOP);}
"*"		{ ECHO; return(MULOP); }
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return(REDUCE); }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }

or		{ ECHO; return(OROP); }
case		{ ECHO; return(CASE); }
else		{ ECHO; return(ELSE); }
endcase		{ ECHO; return(ENDCASE); }
endif		{ ECHO; return(ENDIF); }
if		{ ECHO; return(IF); }
others		{ ECHO; return(OTHERS); }
real		{ ECHO; return(REAL); }
then		{ ECHO; return(THEN); }
when		{ ECHO; return(WHEN); }
rem		{ ECHO; return(REMOP); }
"**"		{ ECHO; return(EXPOP); }
"=>"		{ ECHO; return(ARROWOP); }
{id}		{ ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); strcpy(yylval.iden, yytext); return(IDENTIFIER);}
{int}		{ ECHO; yylval.type = INT_TYPE; return(INT_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }

%%
