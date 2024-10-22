#ifndef TOKEN
#define TOKEN(Token, ...) {##Token, __VA_ARGS__},
#endif

#ifndef TOKENALT
#define TOKENALT TOKEN
#endif

TOKEN(_register)
TOKEN(operand)
TOKEN(immediate)
TOKEN(instruction)

#undef TOKEN
