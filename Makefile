CFLAGS=-Wall

.PHONY: all
all: superc

.PHONY: check
check: main.o
	check "8+4"
	check "8-4"

.PHONY: clean
clean:
	-rm -f *.o superc
