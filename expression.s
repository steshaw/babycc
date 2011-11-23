.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$0,%eax
	push	%eax
	movl	$5, %eax
	push	%eax
	movl	$7, %eax
	popl	%ebx
	subl	%ebx,%eax
	negl	%eax
	popl	%ebx
	subl	%ebx,%eax
	negl	%eax
	pop	%ebp
	ret
