.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	movl	t, %eax
	popl	%ebp
	ret
	.size	expression, .-expression
	.comm	t,4,4
