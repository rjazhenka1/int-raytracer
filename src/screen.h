#pragma once

#include <SDL2/SDL.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_render.h>
#include <SDL2/SDL_timer.h>
#include <SDL2/SDL_video.h>

#define FPS 60
#define START_W 640
#define START_H 480

struct ScreenMeta {
  SDL_Window *window;
  SDL_Renderer *renderer;
  SDL_Texture *texture;
  unsigned int *pixelBuffer;
  int height, width;
};

unsigned int ARGB(unsigned char red, unsigned char green, unsigned char blue);

struct ScreenMeta make_screen();
void update_screen(struct ScreenMeta *meta);
void lock_texture(struct ScreenMeta *meta);
void put_pixel(struct ScreenMeta *meta, int x, int y, unsigned int argb);
void unlock_texture(struct ScreenMeta *meta);
void flush(struct ScreenMeta *meta);
void destroy_screen(struct ScreenMeta *meta);