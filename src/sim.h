#pragma once

#define FPS 60
#define WIDTH 1024
#define HEIGHT 768

extern int ARGB(unsigned char red, unsigned char green, unsigned char blue);

extern void simInit();
extern void simPrepareScreen();
extern void simSetPixel(int x, int y, int argb);
extern void simFlush();
extern int simCheckQuit();
extern void simClose();