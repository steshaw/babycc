.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$2, %eax
	push	%eax
	call	f
	popl	%ebx
	imul	%ebx,%eax
	movl %eax, t
	pop	%ebp
	ret
	.size	expression, .-expression
	.comm	t,4,4
