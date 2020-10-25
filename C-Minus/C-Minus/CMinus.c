#include <stdio.h>
#include "symbols.h"
#include <errno.h>

extern FILE* yyin;
extern int yylex(void);

const char* lexUnits[] = {
	 "END", 
 "INT",
 "LONG", 
 "DOUBLE",
 "SHORT",
 "UNSIGNED", 
 "VOID",
 "VOLATILE", 
 "WHILE",
 "FLOAT", 
 "IF",
 "ELSE",
 "RETURN",
 "CONSTANT",
 "STRING_LITERAL",
 "ASSIGN", 
 "ADD",
 "SUBSTRACT",
 "IDENTIFIER",
 "END_OF_INSTRUCTION", 
 "EQUAL",
 "NOTEQUAL", 
 "LOWER",
 "LOWEROREQUAL", 
 "GREATER",
 "GREATEROREQUAL",
 "MULTIPLY", 
 "DIVIDE",
 "LPAREN",
 "RPAREN",
 "LBRACKET",
 "RBRACKET", 
 "LBRACE",
 "RBRACE",
 "COMMA", 
 "NUM" 
};

int main()
{
	int tokenValue = 0;
	yyin = fopen("input.csrc", "rt");

	if (yyin != NULL) {
		while ((tokenValue = yylex()) != END) {
			printf(" -> TOKEN ID: %d; TOKEN VALUE: %s \n", tokenValue, lexUnits[tokenValue]);
		}
	}
	else {
		printf("Fisierul de intrare nu poate fi deschis. Erorare: %d", errno);
	}
}