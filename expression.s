.globl foo
	.type	foo, @function
foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$10, %eax
	movl	%eax, i
	popl	%ebp
	ret
	.size	foo, .-foo
.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	call	foo
	movl	%eax, i
	popl	%ebp
	ret
	.size	expression, .-expression
	.comm	i, 4,4
