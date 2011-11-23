.globl foo
	.type	foo, @function
foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	movl	%eax, a
	leave
	ret
	.size	foo, .-foo
.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$8, %eax
	pushl	%eax
	movl	$9, %eax
	pushl	%eax
	call	foo
	movl	%eax, b
	movl	a, %eax
	movl	%eax, a
	leave
	ret
	.size	expression, .-expression
	.comm	a, 4,4
	.comm	b, 4,4
