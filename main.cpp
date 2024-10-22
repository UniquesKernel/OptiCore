#include "Lexer/lexer.h"
#include <cstdlib>

int main(int argc, char *argv[]) {
  char *src = (char *)"ses \t\r\n sse\0";
  Token *token = tokenize(src);

  free(token);
  return 0;
}
