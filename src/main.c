#include <SDL2/SDL.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_render.h>
#include <SDL2/SDL_timer.h>
#include <SDL2/SDL_video.h>
#include <stdio.h>

#include "fixed.h"
#include "raytrace.h"
#include "screen.h"
#include "vec.h"

int main(int argc, char *argv[]) {
  struct ScreenMeta meta = make_screen();

  SDL_Event event;
  int w = 0, h = 0;
  unsigned int a, b = 0, delta;
  int quit = 0;
  while (!quit) {
    a = SDL_GetTicks();
    delta = a - b;
    if (delta > 1000 / FPS) {
      b = a;
    } else {
      SDL_Delay(1000 / FPS - delta);
    }

    while (SDL_PollEvent(&event)) {
      if (event.type == SDL_QUIT ||
          (event.type == SDL_WINDOWEVENT &&
           event.window.event == SDL_WINDOWEVENT_CLOSE)) {
        quit = 1;
      }
    }

    update_screen(&meta);
    lock_texture(&meta);
    for (int x = 0; x < meta.width; x++) {
      for (int y = 0; y < meta.height; y++) {
        unsigned int color = a + x + y;
        put_pixel(&meta, x, y,
                  get_color(v_from_scalars(a * 20, FACTOR * 20, a * 50),
                            v_from_scalars(-2 * FACTOR + 2 * x,
                                           -FACTOR / 2 + y * 2, -FACTOR)));
      }
    }

    unlock_texture(&meta);
    flush(&meta);
  }

  destroy_screen(&meta);
  SDL_Quit();
  return 0;
}