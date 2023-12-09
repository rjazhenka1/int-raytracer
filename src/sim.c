#include "sim.h"

#include <SDL2/SDL.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_render.h>
#include <SDL2/SDL_timer.h>
#include <SDL2/SDL_video.h>

struct ScreenMeta {
  SDL_Window *window;
  SDL_Renderer *renderer;
  SDL_Texture *texture;
  unsigned int *pixelBuffer;
  unsigned int lastTick;
};

struct ScreenMeta meta;

int ARGB(unsigned char red, unsigned char green, unsigned char blue) {
  return (255 << 24) | (red << 16) | (green << 8) | blue;
}

void simInit() {
  meta.window =
      SDL_CreateWindow("INT RT", 0, 0, WIDTH, HEIGHT, SDL_WINDOW_SHOWN);
  meta.renderer = SDL_CreateRenderer(meta.window, -1, 0);
  simPrepareScreen();
  meta.texture = SDL_CreateTexture(meta.renderer, SDL_PIXELFORMAT_ARGB8888,
                                   SDL_TEXTUREACCESS_STREAMING, WIDTH, HEIGHT);
  simFlush();
}

void simPrepareScreen() {
  int pitch;
  SDL_LockTexture(meta.texture, NULL, (void **)&meta.pixelBuffer, &pitch);
}

void simSetPixel(int x, int y, int argb) {
  meta.pixelBuffer[x + y * WIDTH] = argb;
}

int simCheckQuit() {
  int quit = 0;
  SDL_Event event;
  while (SDL_PollEvent(&event)) {
    if (event.type == SDL_QUIT ||
        (event.type == SDL_WINDOWEVENT &&
         event.window.event == SDL_WINDOWEVENT_CLOSE)) {
      quit = 1;
    }
  }
  return quit;
}

void simFlush() {
  unsigned int ticks = SDL_GetTicks();
  unsigned int delta = ticks - meta.lastTick;
  if (delta > 1000 / FPS) {
    meta.lastTick = ticks;
  } else {
    SDL_Delay(1000 / FPS - delta);
  }

  SDL_UnlockTexture(meta.texture);
  SDL_RenderCopy(meta.renderer, meta.texture, NULL, NULL);
  SDL_RenderPresent(meta.renderer);
}

void simClose() {
  SDL_DestroyRenderer(meta.renderer);
  SDL_DestroyWindow(meta.window);
  SDL_Quit();
}