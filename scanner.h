#pragma once

// include the FlexLexer file that defines yyFlexLexer
#if ! defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

// override the interface for yylex
#undef YY_DECL
#define YY_DECL int SE::FlexScanner::yylex()

// includei the bison generated file which includes the tokens
#include "parser.tab.hh"

namespace SE{
  class FlexScanner : public yyFlexLexer {
    public:
      // constructor
      FlexScanner(std::istream *in)
        : yyFlexLexer(in), yylval(NULL){}
      //
      int yylex(SE::BisonParser::semantic_type *lval)
      {
        yylval = lval;
        return yylex();
      }

    private:
      // scanning function created by Flex
      int yylex();
      // point to yylval
      SE::BisonParser::semantic_type *yylval;
  };
}

