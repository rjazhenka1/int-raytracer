#include "screen.h"

unsigned int ARGB(unsigned char red, unsigned char green, unsigned char blue) {
  return (255 << 24) | (red << 16) | (green << 8) | blue;
}

struct ScreenMeta make_screen() {
  struct ScreenMeta meta;
  meta.window = SDL_CreateWindow("INT RT", 0, 0, START_W, START_H,
                                 SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);
  meta.renderer = SDL_CreateRenderer(meta.window, -1, 0);
  update_screen(&meta);
  return meta;
}

void update_screen(struct ScreenMeta *meta) {
  int newW, newH;

  SDL_GetWindowSize(meta->window, &newW, &newH);

  if (meta->width != newW || meta->height != newH) {
    meta->width = newW;
    meta->height = newH;
    meta->texture = SDL_CreateTexture(meta->renderer, SDL_PIXELFORMAT_ARGB8888,
                                      SDL_TEXTUREACCESS_STREAMING, meta->width,
                                      meta->height);
  }
}

void lock_texture(struct ScreenMeta *meta) {
  int pitch;
  SDL_LockTexture(meta->texture, NULL, (void **)&meta->pixelBuffer, &pitch);
}

void unlock_texture(struct ScreenMeta *meta) {
  SDL_UnlockTexture(meta->texture);
}

inline void put_pixel(struct ScreenMeta *meta, int x, int y,
                      unsigned int argb) {
  meta->pixelBuffer[x + y * meta->width] = argb;
}

void flush(struct ScreenMeta *meta) {
  SDL_RenderCopy(meta->renderer, meta->texture, NULL, NULL);
  SDL_RenderPresent(meta->renderer);
}

void destroy_screen(struct ScreenMeta *meta) {
  SDL_DestroyRenderer(meta->renderer);
  SDL_DestroyWindow(meta->window);
}