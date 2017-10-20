/****************************************************/
/* File: tiny.l                                     */
/* Lex specification for TINY                       */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

%{
#include "globals.h"
#include "util.h"
#include "scan.h"
/* lexeme of identifier or reserved word */
char tokenString[MAXTOKENLEN+1];
%}

digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
identifier  {letter}+
newline     \n
whitespace  [ \t]+

%%

"if"            {return IF;}
"int"           {return INT;}
"return"        {return RETURN;}
"else"          {return ELSE;}
":="            {return ASSIGN;}
"="             {return EQUAL;}
"<"             {return SMALLER;}
">"             {return ELARGER;}
"<="            {return ESMALLER;}
">="            {return LARGER;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"*"             {return MULT;}
"/"             {return DIVIDE;}
"("             {return LPARENT;}
")"             {return RPARENT;}
"{"             {return LBPARENT;}
"}"             {return RBPARENT;}
"["             {return LBRACKET;}  
"]"             {return RBRACKET;}
";"             {return SEMI;}
{number}        {return NUM;}
{identifier}    {return ID;}
{newline}       {lineno++;}
{whitespace}    {/* skip whitespace */}
"{"             { char c;
                  do
                  { c = input();
                    if (c == EOF) break;
                    if (c == '\n') lineno++;
                  } while (c != '}');
                }
.               {return ERROR;}

%%

TokenType getToken(void)
{ static int firstTime = TRUE;
  TokenType currentToken;
  if (firstTime)
  { firstTime = FALSE;
    lineno++;
    yyin = source;
    yyout = listing;
  }
  currentToken = yylex();
  strncpy(tokenString,yytext,MAXTOKENLEN);
  if (TraceScan) {
    fprintf(listing,"\t%d: ",lineno);
    printToken(currentToken,tokenString);
  }
  return currentToken;
}
