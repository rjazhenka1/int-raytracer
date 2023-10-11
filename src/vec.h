#pragma once

#include "fixed.h"

struct vec3 {
  fixed x, y, z;
};

struct vec3 v_add(struct vec3 a, struct vec3 b);

struct vec3 v_sub(struct vec3 a, struct vec3 b);

struct vec3 v_mul(struct vec3 a, struct vec3 b);

struct vec3 v_div(struct vec3 a, struct vec3 b);

struct vec3 v_neg(struct vec3 a);

struct vec3 v_from_scalars(fixed a, fixed b, fixed c);

struct vec3 v_from_scalar(fixed c);
