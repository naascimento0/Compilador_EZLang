lexer grammar EZLexer;

WS : [ \t\n]+ -> skip ;

BEGIN   : 'begin' ;
BOOL    : 'bool' ;
ELSE    : 'else' ;
END     : 'end' ;
FALSE   : 'false' ;
IF      : 'if' ;
INT     : 'int' ;
PROGRAM : 'program' ;
READ    : 'read' ;
REAL    : 'real' ;
REPEAT  : 'repeat' ;
STRING  : 'string' ;
THEN    : 'then' ;
TRUE    : 'true' ;
UNTIL   : 'until' ;
VAR     : 'var' ;
WRITE   : 'write' ;

ASSIGN : ':=' ;
EQ     : '=' ;
LT     : '<' ;
MINUS  : '-' ;
OVER   : '/' ;
PLUS   : '+' ;
SEMI   : ';' ;
TIMES  : '*' ;
LPAR   : '(' ;
RPAR   : ')' ;

fragment DIGITS : [0-9]+ ;

INT_VAL  : POS_INT | NEG_INT ;
REAL_VAL : POS_REAL | NEG_REAL ;
NEG_INT  : '-' DIGITS ;
POS_INT  : DIGITS ;
NEG_REAL : '-' DIGITS '.' DIGITS ;
POS_REAL : DIGITS '.' DIGITS ;

STR_VAL : '"' ~["]* '"' ;
ID      : [a-zA-Z]+ ;
COMMENT : '{' ~[}]* '}' -> skip ;

UNKNOWN : . ;