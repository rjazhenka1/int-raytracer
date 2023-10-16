#include "raytrace.h"
#include "sim.h"

int main(int argc, char *argv[]) {
  simInit();
  app();
  simClose();
  return 0;
}