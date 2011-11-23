.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	$0, %eax
	pushl	%eax
	movl	$10, %eax
	popl	%ebx
	cmpl	%ebx, %eax
	setl	%al
	movzbl	%al, %eax
	movl	%eax, -4(%ebp)
	leave
	ret
	.size	expression, .-expression
