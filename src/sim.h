#pragma once

#define FPS 60
#define WIDTH 1024
#define HEIGHT 768

int ARGB(unsigned char red, unsigned char green, unsigned char blue);

void simInit();
void simPrepareScreen();
void simSetPixel(int x, int y, int argb);
void simFlush();
int simCheckQuit();
void simClose();
