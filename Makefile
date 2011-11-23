CFLAGS=-Wall --std=c99

.PHONY: all
all: superc

.PHONY: check
check: all main.o
	check "t=8+4" 12
	check "t=8-4" 4
	check "t=2*3" 6
	check "t=6/2" 3
	check "t=2+8*3" 26
	check "t=(2+8)*3" 30
	check "t=2*(3+4)" 14
	check "t=((3+4)+(5-6))/(1+2)" 2
	check "t=-1" -1
	check "t=-(5-7)" 2
	check "t=a*b" 0
	check "t=a*b-b" 0
	check "t=2*f()" 202


.PHONY: clean
clean:
	-rm -f *.o superc
