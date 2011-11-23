.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$10, %eax
	movl %eax, t
.L1:
	movl	t, %eax
	je	.L2
	movl	$8, %eax
	movl %eax, t
	jmp	.L2
	jmp	.L1
.L2:
	pop	%ebp
	ret
	.size	expression, .-expression
	.comm	t,4,4
