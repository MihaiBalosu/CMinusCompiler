#include <stdio.h>
#include "symbols.h"
#include <errno.h>

//extern int yylex(void);
extern int yyparse(void);
extern FILE* yyin;
extern int yydebug;

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
	yyin = fopen("input.csrc", "rt");
	if (yyin != NULL)
	{
		int result = yyparse();
		switch (result)
		{
		case 0:
			printf("Parse successfull.\n");
			break;

		case 1:
			printf("Invalid input encountered\n");
			break;

		case 2:
			printf("Out of memory\n");
			break;

		default:
			break;
		}
		fclose(yyin);
	}
	else
	{
		printf("Fisier inexistent");
	}
}