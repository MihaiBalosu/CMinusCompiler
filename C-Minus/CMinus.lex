ID 			[a-zA-Z]
D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
IS			(u|U|l|L)*

%{
#include <stdio.h>
#include "symbols.h"

void count();
void badChars();
%}

%%
"/*"			{ comment(); }

"else"			{ count(); return(ELSE); }
"if"			{ count(); return(IF); }
"int"			{ count(); return(INT); }
"return"		{ count(); return(RETURN); }
"void"			{ count(); return(VOID); }
"while"			{ count(); return(WHILE); }

{ID}({L}|{D})*			{ count(); return (ID); }
{D}+					{ count(); return (NUM); }

0{D}+{IS}?				{ count(); return(CONSTANT); }
{D}+{IS}?				{ count(); return(CONSTANT); }

"="			{ count(); return(ASSIGN); }
"+"			{ count(); return(ADD); }
"-"			{ count(); return(SUBSTRACT); }
";"			{ count(); return (END_OF_INSTRUCTION);}
"=="        { count(); return EQUAL;}
"!="        { count(); return NOTEQUAL;}
"<"         { count(); return LOWER;}
"<="        { count(); return LOWEROREQUAL;}
">"         { count(); return GREATER;}
">="        { count(); return GREATEROREQUAL;}
"*"         { count(); return MULTIPLY;}
"/"         { count(); return DIVIDE;}
"("         { count(); return LPAREN;}
")"         { count(); return RPAREN;}
"["         { count(); return LBRACKET;}
"]"         { count(); return RBRACKET;}
"{"         { count(); return LBRACE;}
"}"         { count(); return RBRACE;}
","         { count(); return COMMA;}

[ \t\v\n\f]		{ count(); }
.				{ badChars(); }

%%

yywrap()
{
	return(1);
}


comment()
{
	char c, c1;

loop:
	while ((c = input()) != '*' && c != 0)
		putchar(c);

	if ((c1 = input()) != '/' && c != 0)
	{
		unput(c1);
		goto loop;
	}

	if (c != 0)
		putchar(c1);
}


int column = 0;

void count()
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	ECHO;
}


int check_type()
{

	return(IDENTIFIER);
}

void badChars()
{
	printf("The string %s is not recognized" , yytext);
}