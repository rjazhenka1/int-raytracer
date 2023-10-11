#include "fixed.h"
#include <limits.h>

fixed f_mul(fixed a, fixed b) { return (a * (b / FACTOR)); }

fixed f_div(fixed a, fixed b) {
  if (b == 0) {
    return (a >= 0) ? INT_MAX : INT_MIN;
  }
  return ((a * FACTOR) / b);
}