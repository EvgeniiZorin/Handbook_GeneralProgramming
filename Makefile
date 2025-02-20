# This is a comment line
CC=g++
# CFLAGS will be the options passed to the compiler.
CFLAGS= -c -Wall
POETRY-ENV-ADD = poetry add

all: prog

prog: main.o factorial.o hello.o
	$(CC) main.o factorial.o hello.o -o prog

main.o: main.cpp
	$(CC) $(CFLAGS) main.cpp

factorial.o: factorial.cpp
	$(CC) $(CFLAGS) factorial.cpp

hello.o: hello.cpp
	$(CC) $(CFLAGS) hello.cpp

clean:
	rm -rf *.o 

# make environment in Poetry
make-poetry-env:
	poetry install

# add required library in poetry
poetry-add-library:
	$(POETRY-ENV-ADD) scikit-learn pandas seaborn matplotlib
