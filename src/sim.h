#pragma once

#define FPS 60
#define WIDTH 320
#define HEIGHT 240

int ARGB(unsigned char red, unsigned char green, unsigned char blue);

void simInit();
void simPrepareScreen();
void simSetPixel(int x, int y, int argb);
void simFlush();
int simCheckQuit();
void simClose();
