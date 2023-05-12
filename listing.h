/*
Tyler Spring
3/2/23
Project 4
This is the listing Header file. This file stayed the same so I did not change anything here.
*/

// This file contains the function prototypes for the functions that produce the 
// compilation listing

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);

