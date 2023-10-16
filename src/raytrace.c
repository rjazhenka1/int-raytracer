#include "raytrace.h"
#include "sim.h"
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_timer.h>
#include <limits.h>
#include <stdlib.h>

#define FACTOR 2048

fixed f_mul(fixed a, fixed b) { return (a * (b / FACTOR)); }

fixed f_div(fixed a, fixed b) {
  if (b == 0) {
    return (a >= 0) ? INT_MAX : INT_MIN;
  }
  return ((a * FACTOR) / b);
}

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

#define CELL_SIZE (4 * FACTOR)
// y of checkerboard := 0
unsigned int get_color(struct vec3 origin, struct vec3 dir) {
  fixed dist = -f_div(origin.y, dir.y);
  if (dist > FACTOR) {
    return ARGB(0, 127, 127);
  }
  struct vec3 hit_point = v_add(origin, v_mul(dir, v_from_scalar(dist)));
  int x_cell = abs(f_div(hit_point.x, CELL_SIZE)) % (2 * CELL_SIZE);
  int z_cell = abs(f_div(hit_point.z, CELL_SIZE)) % (2 * CELL_SIZE);

  if (((x_cell > CELL_SIZE) + (z_cell > CELL_SIZE)) % 2) {
    return ARGB(255, 255, 255);
  }

  return ARGB(0, 0, 0);
}

void app() {
  unsigned int iter = 0;
  while (!simCheckQuit()) {
    simPrepareScreen();
    for (int x = 0; x < WIDTH; x++) {
      for (int y = 0; y < HEIGHT; y++) {
        simSetPixel(
            x, y,
            get_color(v_from_scalars(iter * FACTOR, FACTOR * 20, iter * FACTOR),
                      v_from_scalars(-FACTOR / 2 + 2 * x, -FACTOR / 16 + y,
                                     -FACTOR)) -
                (iter * FACTOR / 8 | 0xFF000000));
      }
    }
    iter++;
    simFlush();
  }
}