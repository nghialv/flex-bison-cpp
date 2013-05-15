#include <iostream>
#include "driver.h"

int main(int argc, char **argv) {
  if(argc != 2) return EXIT_FAILURE;
  SE::Driver driver;
  driver.parse(argv[1]);
  return EXIT_SUCCESS;
}
