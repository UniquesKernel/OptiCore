#pragma once

typedef enum token_type {
  none,

#define TOKEN(Token, ...) Token,
#include "Lexer/token_def.inl"
#undef TOKEN

  eof
} TokenType;

typedef struct token_t {
  TokenType type;
  char *value;
} Token;

/**
 * @brief The input character is check
 * to see if it is a space, tab or newline character
 *
 * @param[in] ch is the character to be checked
 * @return bool showing if the input is a space or not
 */
static inline bool isSpace(const char ch);

Token *tokenize(const char *const src);
