/*
Tyler Spring
3/2/23
Project 4
This is the types file. Here are the added ifs, check case functions, check remainder, and modifications mades to 
exisiting functions.
*/

// This file contains the bodies of the type checking functions

#include <string>
#include <vector>

using namespace std;

#include "types.h"
#include "listing.h"

/*Added if statements to check booleans, integer, reals, and mismatching.*/

void checkAssignment(Types lValue, Types rValue, string message)
{
	if(lValue != MISMATCH && rValue != MISMATCH)
{
	if (lValue != MISMATCH && rValue != MISMATCH && lValue != rValue)
		appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message);
	if (lValue == REAL_TYPE && rValue == BOOL_TYPE)
		appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message);
	if (lValue == BOOL_TYPE && rValue == INT_TYPE)
		appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message);
	if (lValue == BOOL_TYPE && rValue == REAL_TYPE)
		appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message);
}
}

void checkIf(Types ifCheck, Types word1, Types word2)
{
	if (ifCheck != BOOL_TYPE)
	    appendError(GENERAL_SEMANTIC, "Boolean needed.");
	if (word1 != word2)
	    appendError(GENERAL_SEMANTIC, "Mismatch with Then statements.");
}
/*Added case check functions. Checks to make sure they are valid and matching.*/
void checkCases(Types cCase)
{
	if (cCase != INT_TYPE)
	   appendError(GENERAL_SEMANTIC, "Case must be int.");
}

void checkCases(Types lValue, Types rValue, string message)
{
	if (lValue != rValue)
	    appendError(GENERAL_SEMANTIC, "Cases need to match");
}
/*Checks for a remainder by checking for mismatch then checking for integer types.*/
Types checkRemainder(Types left, Types right)
{
	if (left == MISMATCH || right == MISMATCH)
	    return MISMATCH;
	if (left != INT_TYPE || right != INT_TYPE)
{
		appendError(GENERAL_SEMANTIC, "Int type required");
	    return MISMATCH;
}
	return INT_TYPE;
}

Types checkArithmetic(Types left, Types right)
{
	if (left == MISMATCH || right == MISMATCH)
		return MISMATCH;
	if (left == BOOL_TYPE || right == BOOL_TYPE)
	{
		appendError(GENERAL_SEMANTIC, "Integer Type Required");
		return MISMATCH;
	}

	if (left == INT_TYPE || right == INT_TYPE)
		return INT_TYPE;
	return INT_TYPE;
}


Types checkLogical(Types left, Types right)
{
	if (left == MISMATCH || right == MISMATCH)
		return MISMATCH;
	if (left != BOOL_TYPE || right != BOOL_TYPE)
	{
		appendError(GENERAL_SEMANTIC, "Boolean Type Required");
		return MISMATCH;
	}	
		return BOOL_TYPE;
	return MISMATCH;
}

Types checkRelational(Types left, Types right)
{
	if (checkArithmetic(left, right) == MISMATCH)
		return MISMATCH;
	return BOOL_TYPE;
}
