%{
	#include<stdio.h>
%}

/*declared types*/
%union{
	int type_int;
	float type_float;
	double type_double;
}
/*declared tokens*/
%token <type_int>INT
%token <type_float>FLOAT
%token <type_double>TYPE	/*?*/
%token LT,LE,EQ,NE,GT,GE,RELOP,
%token STRUCT,RETURN,IF,ELSE,WHILE
%token SEMI,COMMA,ASSIGNOP
%token PLUS,MINUS,STAR,DIV,AND,OR,DOT,NOT,
%token LP,RP,LB,RB,LC,RC 
/*declared non-terminals*/
%type <type_double>Program ExtDefList ExtDef ExtDecList
%type <type_double>Specifier StructSpecifier OptTag Tag
%type <type_double>VarDec FunDec VarList ParamDec
%type <type_double>CompSt StmtList Stmt
%type <type_double>DefList Def DecList Dec
%type <type_double>Exp Args 

%%
Program		:	ExtDefList
		;
ExtDefList	:	ExtDef ExtDefList
		|	/*empty*/
		;
ExtDef		:	Specifier ExtDecList SEMI
		|	Specifier SEMI
		|	Specifier FunDec CompSt
		;
ExtDecList	:	VarDec
		|	VarDec COMMA ExtDecList
		;

Specifier	:	TYPE
		|	StructSpecifier
		;
StructSpecifier	:	STRUCT Opt Tag LC DefList RC
		|	STRUCT Tag
		;
OptTag		:	ID
		|	/*empty*/
		;
Tag		:	ID
		;

VarDec		:	ID
		|	VarDec LB INT RB
		;
FunDec		:	ID LP VarList RP
		|	ID LP RP
		;
VarList		:	ParamDec COMMA VarList
		|	ParamDec
		;
ParamDec	:	Specifier VarDec
		;

CompSt		:	LC DefList StmtList RC
		;
StmtList	:	Stmt StmtList
		|	/*empty*/
		;
Stmt		:	Exp SEMI
		|	CompSt
		|	RETURN Exp SEMI
		|	IF LP Exp RP Stmt ELSE Stmt
		|	WHILE LP Exp RP Stmt
		;

DefList		:	DefDefList
		|	/*empty*/
		;
Def		:	Specifier DecList SEMI
		;
DecList		:	Dec
		|	Dec COMMA DecList
		;
Dec		:	VarDec
		|	VarDec ASSIGNOP	Exp
		;

Exp		:	Exp ASSIGNOP Exp
		|	Exp AND Exp
		|	Exp OR Exp
		|	Exp RELOP Exp
		|	Exp PLUS Exp
		|	Exp MINUS Exp
		|	Exp STAR Exp
		|	Exp DIV Exp
		|	LP Exp RP
		|	MINUS Exp
		|	NOT Exp
		|	ID LP Args RP
		|	ID LP RP
		|	Exp LB Exp RB
		|	Exp DOT ID
		|	ID
		|	INT
		|	FLOAT
		;
Args		:	Exp COMMA Args
		|	Exp
		;

%%
#include "lex.yy.c"
int main(){
	yyparse();
}

yyerror(char* msg){
	fprintf(stderr,"error:%s\n",msg);
}