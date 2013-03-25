%{
	/*definitions of manifest constants		
	LT,LE,EQ,NE,GT,GE,RELOP,
	STRUCT,RETURN,IF,ELSE,WHILE,
	ID,FLOAT,TYPE,
	SEMI,COMMA,ASSIGNOP,
	PLUS,MINUS,STAR,DIV,AND,OR,DOT,NOT,
	LP,RP,LB,RB,LC,RC */
	#define IF	1
	#define ELSE	2
	#define STRUCT	3
	#define WHILE	4
	#define RETURN	5
	#define LT	6
	#define LE	7
	#define EQ	8
	#define NE	9
	#define GT	10
	#define GE	11
	#define RELOP 	12
	#define ID	13
	#define FLOAT	14
	#define TYPE	15
	#define SEMI	16
	#define COMMA	17
	#define ASSIGNOP 18
	#define PLUS	19
	#define MINUS	20
	#define STAR 	21
	#define DIV	22
	#define AND	23
	#define OR 	24
	#define DOT	25
	#define NOT	26
	#define LP	27
	#define RP	28
	#define LB	29
	#define RB	30
	#define LC	31
	#define RC	32
%}

/*regular definitions */
delim		[ \t\n]
ws		{delim}+
letter		[A-Za-z]
digit		[0-9]
int		0|[1-9][0-9]*|0[1-7][0-7]*|0x[1-9A-Fa-f][0-9A-Fa-f]*
float		[0-9]+.[0-9]+
id		[A-Za-z_][A-Za-z0-9_]*
type		{int}|{float}

%%
{ws}		{/*no action and no return*/}
struct		{return(STRUCT);}
return		{return(RETURN);}
if		{return(IF);}
else		{return(ELSE);}
while		{return(WHILE);}
{int}		{
			printf("Integer value %d\n", atoi(yytext));
			REJECT;
		}
{float}		{	REJECT;

		}
{type}		{
		
		}
{id}		{
	
		}
";"		{return SEMI;}
","		{return COMMA;}
"="		{return ASSIGNOP;}
">"		{yylval = GT; return RELOP;}
"<"		{yylval = LT; return RELOP;}
">="		{yylval = GE; return RELOP;}
"<="		{yylval = LE; return RELOP;}
"=="		{yylval = EQ; return RELOP;}
"!="		{yylval = NE; return RELOP;}
"+"		{return PLUS;}
"-"		{return MINUS;}
"*"		{return STAR;}
"/"		{return DIV;}
"&&"		{return AND;}
"||"		{return OR;}
"."		{return DOT;}
"!"		{return NOT;}
"("		{return LP;}
")"		{return RP;}
"["		{return LB;}
"]"		{return RB;}
"{"		{return LC;}
"}"		{return RC;}
.		{printf("Error type A at line %d: Mysterious character \'%s\'\n", yylineno, yytext);}

%%