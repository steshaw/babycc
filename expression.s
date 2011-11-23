.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	movl %eax, a
	popl	%ebp
	ret
	.size	expression, .-expression
	.comm	a,4,4
