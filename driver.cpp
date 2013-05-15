#include <fstream>
#include <assert.h>
#include "driver.h"

SE::Driver::~Driver(){
  if(scanner) delete(scanner);
  if(parser) delete(parser);
}

void SE::Driver::parse(const char *filename) {
  assert(filename!=NULL);
  std::ifstream inFile(filename);
  if(!inFile.good()) exit(EXIT_FAILURE);
  // create scanner
  scanner = new SE::FlexScanner(&inFile);
  assert(scanner!=NULL);
  // create parser
  parser = new SE::BisonParser(*scanner,*this);
  assert(parser!=NULL);
  // parse
  if(parser->parse() == -1)	std::cerr << "Parse failed!\n";
}
