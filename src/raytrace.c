#include "raytrace.h"
#include "fixed.h"
#include "screen.h"
#include "vec.h"
#include <SDL2/SDL_timer.h>

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
