CFLAGS=-g -Wall --std=c99

.PHONY: all
all: superc

example.o: example.c
	gcc -Wall --save-temps -c example.c

example.s: example.o

example: example.o

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

	@check "int a void expression(){a=0 || 0}" 0
	@check "int a void expression(){a=0 || 2}" 1
	@check "int a void expression(){a=1 || 0}" 1
	@check "int a void expression(){a=10 || 20}" 1

	@check "int a void expression(){a=0 && 0}" 0
	@check "int a void expression(){a=0 && 99}" 0
	@check "int a void expression(){a=101 && 0}" 0
	@check "int a void expression(){a=88 && 78}" 1

	@check "int a void expression(){a = !0}" 1
	@check "int a void expression(){a = !99}" 0

	@check "int ifile void expression(){ifile = 1}" 1
	@check 'int i int foo(){i=10} void expression(){i=foo()}' 10

	@check "int t int foo(){t=10} int expression(argc, argv) {t=foo()}" 10
	@check "int t int foo(a){t=10} int expression(argc, argv) {t=foo(1)}" 10

	@check "int t int foo(a){t=10}                    \
	        int expression(argc, argv) {              \
		    t=foo(1,2)                            \
		}" "Error: attempt call with incorrect number of arguments."

	@check "int a int b int foo(n) {a=n}void expression(){b = foo(9) a=a }" 9
	@check "int a                                     \
	        int b                                     \
		int foo1(n,m) {                           \
		    a = m                                 \
		}                                         \
		int foo2(n,m) {                           \
		    b=foo1(n,m)                           \
		}                                         \
		void expression() {                       \
		    b = foo1(8,9)                         \
		    b = foo2(9,8)                         \
		    a = a                                 \
		}" 8

.PHONY: clean
clean:
	-rm -f *.o superc
