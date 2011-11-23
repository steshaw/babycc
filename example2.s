	.file	"example2.c"
.globl x
	.data
	.align 4
	.type	x, @object
	.size	x, 4
x:
	.long	100
	.align 2
	.type	y.0, @object
	.size	y.0, 2
y.0:
	.value	99
	.local	i.1
	.comm	i.1,4,4
	.text
	.p2align 4,,15
.globl main
	.type	main, @function
main:
	pushl	%ebp
	xorl	%eax, %eax
	movl	%esp, %ebp
	subl	$8, %esp
	andl	$-16, %esp
	movb	$12, ret
	movl	%ebp, %esp
	popl	%ebp
	ret
	.size	main, .-main
	.p2align 4,,15
.globl test
	.type	test, @function
test:
	pushl	%ebp
	movl	$12, %eax
	movl	%esp, %ebp
	popl	%ebp
	ret
	.size	test, .-test
	.comm	ret,1,1
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.3.3 (Debian 20040429)"
