/*
Tyler Spring
3/2/23
Project 4
This is the types header file. Not much changed besides adding the functions created in types.cc.
*/
// This file contains type definitions and the function
// prototypes for the type checking functions

typedef char* CharPtr;

enum Types {MISMATCH, INT_TYPE, BOOL_TYPE, REAL_TYPE};





void checkIf(Types ifCheck, Types word1, Types word2);
void checkCases(Types cCase);
void checkCases(Types lValue, Types rValue, string message);
void checkAssignment(Types lValue, Types rValue, string message);
Types checkRemainder(Types left, Types right);
Types checkArithmetic(Types left, Types right);
Types checkLogical(Types left, Types right);
Types checkRelational(Types left, Types right);
