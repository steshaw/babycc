CFLAGS=-g -Wall --std=c99

.PHONY: all
all: superc

example.s: example.c
	gcc -Wall --save-temps -c example.c

.PHONY: check
check: all main.o
	@check "int a void main(){a}" "Error: '=' expected."
	@check "int n void expression(){n=8+4}" 12
	@check "int n void expression(){n=8-4}" 4
	@check "int n void expression(){n=2*3}" 6
	@check "int n void expression(){n=6/2}" 3
	@check "int n void expression(){n=2+8*3}" 26
	@check "int n void expression(){n=(2+8)*3}" 30
	@check "int n void expression(){n=2*(3+4)}" 14
	@check "int n void expression(){n=((3+4)+(5-6))/(1+2)}" 2
	@check "int n void expression(){n=-1}" -1
	@check "int n void expression(){n=-(5-7)}" 2
	@check "int n int a int b void expression(){n=a*b}" 0
	@check "int n int a int b void expression(){n=a*b-b}" 0
	@check "int n void f(){n=101} void expression(){n=2*f()}" 202
	@check "int n void expression(){if 1 {n=4}}" 4
	@check "int n void expression(){if 1 {n=4} n=5}" 5
	@check "int n void expression(){if 1 n=4 else n=5}" 4
	@check "int n void expression(){n=10 while (n) { n = n - 1 }}" 0
	@check "int n void expression(){n=10 do { n = n - 1 } while (n)}" 0
	@check "int a int b void expression(){a=1 break b=2}" "Error: break statement not within loop."
	@check "int n void expression(){n=10 do { break } while (n)}" 10
	@check "int n void expression(){n=10 do { n=8 break } while (n)}" 8
	@check "int n void expression(){n=10 while n { break } }" 10
	@check "int n void expression(){n=10 while n { n=8 break } }" 8

	@check "int a int b void expression(){a=5 b=-a}" -5
	@check "int n void expression(){n=-10}" -10
	@check "int a int n void expression(){a=10 n = 5 - -a}" 15
	@check "int a int n void expression(){a=10 n = -5 - -a}" 5

	@check "int a void expression(){a=false || false}" 0
	@check "int a void expression(){a=false || true}" 1
	@check "int a void expression(){a=true || false}" 1
	@check "int a void expression(){a=true || true}" 1

	@check "int a void expression(){a=false && false}" 0
	@check "int a void expression(){a=false && true}" 0
	@check "int a void expression(){a=true && false}" 0
	@check "int a void expression(){a=true && true}" 1

	@check "int a void expression(){a = !false}" 1
	@check "int a void expression(){a = !true}" 0

	@check "int ifile void expression(){ifile = 1}" 1

.PHONY: clean
clean:
	-rm -f *.o superc
