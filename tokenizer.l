/*
Flex lexer for Zapata.
Copyright (C) 2015 Vasantha Ganesh K <t.s.vedhachala@gmail.com>
Copyright (C) 2015 Vasantha Ganesh K <vasanthaganesh.k@tuta.io>

This file is part of Zapata.

Zapata is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Zapata is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Zapata.  If not, see <http://www.gnu.org/licenses/>.
*/

%{
    #include <bits/stdc++.h>
    using namespace std;
    #include "parser.tab.h"
    extern "C" int yylex();
    int line_no = 1;
%}

%%
		/*--------Control flow--------*/
if 									return IF;


		/*--------Operators--------*/
\;									return SEMICOLON;
\{									return OCBRACE;
\}									return ECBRACE;
\( 									return OBRACE;
\)									return EBRACE;
or 									return OR;
\|\|								return OR;
and 								return AND;
\&\&								return AND;
not 								return NOT;
\!									return NOT;
\~									return BITWISEINV;
\&									return BITWISEAND;
\^									return BITWISEXOR;
\|									return BITWISEOR;
\*\*								return POWER;
\*									return STAR;
\/									return DIVISION;
\%									return REMAINDER;
\+									return PLUS;
-									return MINUS;
\<									return LESSTHAN;
\>									return GREATERTHAN;
\<\<								return LEFTSHIFT;
\>\>								return RIGHTSHIFT;
==									return DOUBLEEQUAL;
!=									return NOTEQUAL;
\<=									return LESSTHOREQ;
\>=									return GREATTHOREQ;
=									return ASSIGNMENT;
\#									return HASH;

		/*--------Keywords--------*/
auto[*]?							return TYPEAUTO;
int[*]? 							return TYPEINT;
float[*]?							return TYPEFLOAT;
char[*]?							return TYPECHAR;
string[*]?							return TYPESTRING;
void[*]?							return TYPEVOID;
return								return RETURN;
include 							return INCLUDE;


		/*--------Ignore--------*/
using								return USING;
namespace 							return NAMESPACE;
std 								return STD;

		/*--------Symbols--------*/
\,									return COMMA;


		/*--------Comment--------*/
[//][_a-zA-z0-9 ]*					;

		/*--------newline, spaces, intendation --------*/
\n 									{	++line_no;}
[ \t]+								;
[-]?[0-9]+\.[0-9]+  				{   yylval.fval = atof(yytext); return FLOAT;}
[-]?[0-9]+          				{   yylval.ival = atoi(yytext); return INT;}
\"[_a-zA-z0-9 ]*\"			        {   yylval.sval = yytext; return STRING;}
\'[_a-zA-z0-9 ]\'				    {   yylval.sval = yytext; return CHAR;}
[_a-zA-Z]?[_a-zA-z0-9]*             {   yylval.sval = yytext; return IDENTIFIER;}
.									;
%%
