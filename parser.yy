// require bison 2.5 or later
%require "2.5"
%skeleton "lalr1.cc"

%defines
%define namespace "SE"
%define parser_class_name "BisonParser"
%parse-param  { SE::FlexScanner &scanner }
%lex-param    { SE::FlexScanner &scanner }
%parse-param  { SE::Driver &driver }
%lex-param    { SE::Driver &driver }

%code requires {
  namespace SE {
    class FlexScanner;
    class Driver;
  }
}

%code {
  #include "driver.h"
  static int yylex(SE::BisonParser::semantic_type *yylval,
                  SE::FlexScanner &scanner,
                  SE::Driver &driver);
}

%union {
  int ival;
  std::string *sval;
}

%token <ival> TK_IVAL
%token TK_PLUS
%token TK_MINUS
%token TK_NEWLINE
%token TK_QUIT
%token TK_END_OF_FILE	0	"end of file"

%type <ival> expression
%start unit

%%
unit            :
                | unit line
                ;
line            : TK_NEWLINE
                | expression TK_NEWLINE { std::cout << "Result: " << $1 << std::endl; }
                | TK_QUIT TK_NEWLINE	{ std::cout << "Bye" << std::endl; exit(0); }
                ;
expression      : TK_IVAL			{ $$ = $1; }
                | expression TK_PLUS expression	{ $$ = $1 + $3; }
                | expression TK_MINUS expression { $$ = $1 - $3; }
                ;
%%

// the error function
void SE::BisonParser::error(const SE::BisonParser::location_type &loc, const std::string &msg) {
  std::cerr << "Error: " << msg << std::endl;
}

// the yylex function
#include "scanner.h"
static int yylex(SE::BisonParser::semantic_type * yylval,
                SE::FlexScanner &scanner,
                SE::Driver &driver) {
  return scanner.yylex(yylval);
}
