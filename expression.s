.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, %eax
	movl	%eax, ifile
	popl	%ebp
	ret
	.size	expression, .-expression
	.comm	ifile,4,4
