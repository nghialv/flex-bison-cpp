%{
	#include <string>
	#include "scanner.h"

	// typedef BisonParser::token
	typedef SE::BisonParser::token token;
	// define yyterminate
	#define yyterminate() return(token::TK_END_OF_FILE);
%}

%option nodefault
%option yyclass="FlexScanner"
%option noyywrap
%option c++

%%
[ \t]					;
\n						{ return token::TK_NEWLINE; }
[0-9]+				{ yylval->ival = atoi(yytext); return token::TK_IVAL; }
"+"						{ return token::TK_PLUS; }
"-"						{ return token::TK_MINUS; }
"bye"					{ return token::TK_QUIT; }
%%
