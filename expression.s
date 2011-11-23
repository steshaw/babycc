.globl foo1
	.type	foo1, @function
foo1:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	movl	%eax, a
	leave
	ret
	.size	foo1, .-foo1
.globl foo2
	.type	foo2, @function
foo2:
	pushl	%ebp
	movl	%esp, %ebp
	movl	12(%ebp), %eax
	pushl	%eax
	movl	8(%ebp), %eax
	pushl	%eax
	call	foo1
	movl	%eax, b
	leave
	ret
	.size	foo2, .-foo2
.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$8, %eax
	pushl	%eax
	movl	$9, %eax
	pushl	%eax
	call	foo1
	movl	%eax, b
	movl	$9, %eax
	pushl	%eax
	movl	$8, %eax
	pushl	%eax
	call	foo2
	movl	%eax, b
	movl	a, %eax
	movl	%eax, a
	leave
	ret
	.size	expression, .-expression
	.comm	a, 4,4
	.comm	b, 4,4
