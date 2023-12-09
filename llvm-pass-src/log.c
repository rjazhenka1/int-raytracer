#include <stdio.h>

void logInstr(const char *name) { printf("[instr] %s\n", name); }

void log2Pattern(const char *nameFrom, const char *nameTo) {
  printf("[2-pattern] %s -> %s\n", nameFrom, nameTo);
}

void log3Pattern(const char *nameFrom, const char *nameMiddle,  const char *nameTo) {
  printf("[3-pattern] %s -> %s -> %s\n", nameFrom, nameMiddle, nameTo);
}
