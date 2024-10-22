#include "Lexer/lexer.h"
#include <cctype>
#include <cstdio>
#include <cstdlib>

Token *tokenize(const char *const src) {

  const char *ch = src;
  char value[100] = "";
  int i = 0;
  while (*ch != '\0') {
    if (isSpace(*ch)) {
      ch++;
      continue;
    }
    value[i] = *ch;
    i++;
    ch++;
  }

  printf("%s\n", value);

  Token *token = (Token *)malloc(sizeof(*token));
  *token = {.type = _register, .value = value};
  return token;
}

static inline bool isSpace(const char ch) {
  return ch == 0x9 || ch == 0xA || ch == 0xD || ch == 0x20;
}
