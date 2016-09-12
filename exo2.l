%%

[A-Z][a-z]*  printf("IDENT : %s\n", yytext);
\'.*\'   printf("CHAINE : %s\n", yytext);
:=           printf("AFFECTATION\n");
\;           printf("SEPARATEUR\n");
.            /* ignore le reste */
