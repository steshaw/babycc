CFLAGS=-g -Wall --std=c99

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
	check "if 1 {t=4}" 4
	check "if 1 {t=4} t=5" 5
	check "if 1 t=4 else t=5" 4
	check "t=10 while (t) { t = t - 1 }" 0
	check "t=10 do { t = t - 1 } while (t)" 0
	-check "a=1 break b=2" 2
	check "t=10 do { break } while (t)" 10
	check "t=10 do { t=8 break } while (t)" 8
	check "t=10 while t { break } " 10
	check "t=10 while t { t=8 break } " 8

# XXX - Should be able to check for erronous conditions as well as successful
#       ones.

.PHONY: clean
clean:
	-rm -f *.o superc
