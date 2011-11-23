.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, %eax
	pushl	%eax
	movl	$0, %eax
	popl	%ebx
	cmpl	$0, %ebx
	je	.L1
	cmpl	$0, %eax
	je	.L1
	jmp	.L2
.L1:
	movl	$0, %eax
.L2:
	popl	%ebp
	ret
	.size	expression, .-expression
