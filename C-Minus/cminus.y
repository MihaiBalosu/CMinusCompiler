%{ 
  #include <stdio.h>

  int yyerror(char * c);
  extern int yylex(void);
%}

%token END 
%token INT
%token LONG 
%token DOUBLE 
%token SHORT 
%token UNSIGNED 
%token VOID 
%token VOLATILE 
%token WHILE 
%token FLOAT 
%token IF 
%token ELSE
%token RETURN 
%token CONSTANT 
%token STRING_LITERAL 
%token ASSIGN 
%token ADD 
%token SUBSTRACT 
%token IDENTIFIER 
%token END_OF_INSTRUCTION 
%token EQUAL 
%token NOTEQUAL 
%token LOWER 
%token LOWEROREQUAL 
%token GREATER 
%token GREATEROREQUAL 
%token MULTIPLY 
%token DIVIDE 
%token LPAREN 
%token RPAREN 
%token LBRACKET 
%token RBRACKET 
%token LBRACE 
%token RBRACE 
%token COMMA 
%token NUM 
%token ID

%start program

%%

program : declaration_list
                                                                  
declaration_list : declaration_list declaration     
                 | declaration          
                 ;

declaration  : var_declaration 
	         | fun_declaration
             ;

var_declaration : type_specifier ID 
                | type_specifier ID LBRACKET NUM RBRACKET
                ;

type_specifier : INT	  
               | VOID  
	           ;

fun_declaration : type_specifier ID LPAREN params RPAREN compound_stmt  			              
                ;

params : param_list 
		| VOID ;

param_list : param_list COMMA param 
           | param 		            
	        ;

param : type_specifier ID                                               
      | type_specifier ID LBRACKET RBRACKET
      ;

compound_stmt : LBRACE local_declarations statement_list RBRACE 
              ;

local_declarations : local_declarations var_declaration
                   | ;

statement_list : statement_list statement
               | ;

statement : expression_stmt
          | compound_stmt
          | selection_stmt
          | iteration_stmt
          | return_stmt 
		  ;

expression_stmt : expression END_OF_INSTRUCTION
                | END_OF_INSTRUCTION 
				;

selection_stmt : IF  LPAREN expression RPAREN  statement        
               | IF  LPAREN expression RPAREN  statement ELSE	  
				statement					 	          
               ;

iteration_stmt : WHILE LPAREN expression RPAREN
                 statement          
                 ;
				

return_stmt : RETURN END_OF_INSTRUCTION             
            | RETURN expression END_OF_INSTRUCTION   
            ;

expression : var ASSIGN expression     
           | simple_expression      
           ;

var : ID                    
    | ID LBRACKET expression RBRACKET 
    ;

simple_expression : additive_expression relop additive_expression  
                  | additive_expression                            
                  ;

relop : LOWEROREQUAL
	  | LOWER 
	  | GREATEROREQUAL
	  | GREATER 
	  | EQUAL 
	  | NOTEQUAL
	  ;

additive_expression : additive_expression addop term    
                    | term                              
                    ;

addop : ADD 
      | SUBSTRACT 
      ;

term : term mulop factor    
     | factor              
     ;

mulop : MULTIPLY 
      | DIVIDE
      ;

factor : LPAREN expression RPAREN 
       | var                
       | call               
       | NUM                
       ;

call : ID LPAREN args RPAREN 
     ;

args : arg_list 
	 | 
	 ;

arg_list : arg_list END_OF_INSTRUCTION expression 
         | expression              
         ;

%%


