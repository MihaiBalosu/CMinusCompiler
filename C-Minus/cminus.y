%{ 
  #include <stdio.h>
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
                | type_specifier ID '[' NUM ']'
                ;

type_specifier : INT	  
               | VOID  
	           ;

fun_declaration : type_specifier ID '('params ')' compound_stmt  			              
                ;

params : param_list 
		| VOID ;

param_list : param_list ',' param 
           | param 		            
	        ;

param : type_specifier ID                                               
      | type_specifier ID '[' ']'
      ;

compound_stmt : '{' local_declarations statement_list '}'  
              ;

local_declarations : local_declarations var_declaration
                   | /* empty */ ;

statement_list : statement_list statement
               | /* empty */ ;

statement : expression_stmt
          | compound_stmt
          | selection_stmt
          | iteration_stmt
          | return_stmt 
		  ;

expression_stmt : expression ';'
                | ';' 
				;

selection_stmt : IF  '(' expression ')'  statement        
               | IF  '(' expression ')'  statement ELSE	  
				statement					 	          
               ;

iteration_stmt : WHILE '(' expression ')' 
                 statement          
                 ;
				

return_stmt : RETURN ';'              
            | RETURN expression ';'   
            ;

expression : var '=' expression     
           | simple_expression      
           ;

var : ID                    
    | ID '[' expression ']' 
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

factor : '(' expression ')' 
       | var                
       | call               
       | NUM                
       ;

call : ID '(' args ')'  
     ;

args : arg_list 
	 | /* empty */ 
	 ;

arg_list : arg_list ',' expression 
         | expression              
         ;

%%


