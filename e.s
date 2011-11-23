.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0                                , %esp
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L1:
	movl	-4(%ebp), %eax
	pushl	%eax
	movl	$10, %eax
	popl	%ebx
	cmpl	%eax, %ebx
	setl	%bl
	movzbl	%bl, %eax
	cmpl	$0, %eax
	je	.L2
	movl	-4(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	movl	-4(%ebp), %eax
	pushl	%eax
	movl	$1, %eax
	popl	%ebx
	addl	%ebx,%eax
	movl	%eax, -4(%ebp)
	jmp	.L1
.L2:
	leave
	ret
	.size	main, .-main
