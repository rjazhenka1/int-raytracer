#include "vec.h"

struct vec3 v_add(struct vec3 a, struct vec3 b) {
  struct vec3 t = {a.x + b.x, a.y + b.y, a.z + b.z};
  return t;
}

struct vec3 v_sub(struct vec3 a, struct vec3 b) {
  struct vec3 t = {a.x - b.x, a.y - b.y, a.z - b.z};
  return t;
}

struct vec3 v_mul(struct vec3 a, struct vec3 b) {
  struct vec3 t = {f_mul(a.x, b.x), f_mul(a.y, b.y), f_mul(a.z, b.z)};
  return t;
}

struct vec3 v_div(struct vec3 a, struct vec3 b) {
  struct vec3 t = {f_div(a.x, b.x), f_div(a.y, b.y), f_div(a.z, b.z)};
  return t;
}

struct vec3 v_neg(struct vec3 a) {
  struct vec3 t = {-a.x, -a.y, -a.z};
  return t;
}

struct vec3 v_from_scalars(fixed a, fixed b, fixed c) {
  struct vec3 t = {a, b, c};
  return t;
}

struct vec3 v_from_scalar(fixed c) {
  struct vec3 t = {c, c, c};
  return t;
}