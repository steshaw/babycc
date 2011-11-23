CFLAGS=-Wall

.PHONY: all
all: superc

.PHONY: check
check: main.o
	check "8+4" 12
	check "8-4" 4
	check "2*3" 6
	check "6/2" 3
	check "2+8*3" 26
	check "(2+8)*3" 30
	check "2*(3+4)" 14
	check "((3+4)+(5-6))/(1+2)" 2
	check "-1" -1
	check "-(5-7)" 2


.PHONY: clean
clean:
	-rm -f *.o superc
