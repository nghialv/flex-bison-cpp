# variables declaration
CC=g++
DEBUG=-g
CFLAGS=-c -Wall #$(DEBUG)
LFLAGS=-Wall
# filenames
SOURCES=main.cpp driver.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=demo

all: parser scanner $(SOURCES) $(EXECUTABLE)

# create executable files
$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LFLAGS) $(OBJECTS) parser.o scanner.o -o $(EXECUTABLE)

# scanner
scanner: scanner.ll
	flex -o scanner.cc $<
	$(CC) $(CFLAGS) scanner.cc -o scanner.o

# parser
parser: parser.yy
	bison $<
	$(CC) $(CFLAGS) parser.tab.cc -o parser.o

# create object files
%.o: %.cpp
	$(CC) $(CFLAGS) $< -o $@

# remove generated files
clean:
	rm -rf parser.tab.hh parser.tab.cc location.hh position.hh stack.hh
	rm -rf scanner.cc scanner.o parser.o
	rm -rf $(EXECUTABLE)
	rm -rf $(OBJECTS)
