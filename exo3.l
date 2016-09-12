%{
  #include "list.h"
  #define DEBUG 0

  enum command { DEFAULT, ADD };
  enum command cur_command;
  char* cur_word;

  list words;
  list buf;

  void start_add(const char* word);
  void add(const char* word);
  void flush(void);
%}

%%

"adj"        start_add(yytext);
"nom"        start_add(yytext);
"verbe"      start_add(yytext);
"pronom"     start_add(yytext);
[a-z]+       add(yytext);
[ \t]*\n     flush();

%%

void start_add(const char* yytext) {
  cur_command = ADD;
  cur_word = malloc(strlen(yytext)+1);
  strcpy(cur_word, yytext);

#if DEBUG
  printf("START %s\n", cur_word);
#endif
}

void add(const char* yytext) {
  char* word = malloc(strlen(yytext)+1);
  strcpy(word, yytext);

  switch (cur_command) {
    case DEFAULT:
#if DEBUG
      printf("ADD %s TO BUF\n", word);
#endif
      list_add(&buf, word);
      break;

    case ADD:
#if DEBUG
      printf("ADD %s TO %s\n", word, cur_word);
#endif
      multimap_add(&words, cur_word, word);
      break;
  }
#if DEBUG
  printf("buf=");
  list_print(&buf);
  printf("words=");
  multimap_print(&words);
#endif
}

void flush(void) {
#if DEBUG
  printf("FLUSH\n");
#endif
  if (cur_command == DEFAULT) {
    for (node_ptr it = buf.head; it != NULL; it = it->next) {
      const char* word = it->value;
      int found = 0;

      for (node_ptr it2 = words.head; it2 != NULL; it2 = it2->next) {
        if (strcmp(word, it2->value) == 0) {
          printf("%s : %s\n", word, it2->key);
          found = 1;
          break;
        }
      }

      if (!found) {
        printf("%s : inconnu\n", word);
      }
    }

    list_clear(&buf);
  }

  cur_command = DEFAULT;
}

