.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0                                , %esp
	movl	$.LC0, %eax
	pushl	%eax
	call	prints
	movl	$0, %eax
	movl	%eax, -4(%ebp)
.L1:
	movl	-4(%ebp), %eax
	pushl	%eax
	movl	$2, %eax
	popl	%ebx
	cmpl	%eax, %ebx
	setl	%bl
	movzbl	%bl, %eax
	cmpl	$0, %eax
	je	.L2
	movl	$1, %eax
	movl	%eax, -8(%ebp)
.L3:
	movl	-8(%ebp), %eax
	pushl	%eax
	movl	$11, %eax
	popl	%ebx
	cmpl	%eax, %ebx
	setl	%bl
	movzbl	%bl, %eax
	cmpl	$0, %eax
	je	.L4
	movl	-8(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	movl	-8(%ebp), %eax
	pushl	%eax
	movl	$1, %eax
	popl	%ebx
	addl	%ebx,%eax
	movl	%eax, -8(%ebp)
	jmp	.L3
.L4:
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
	.section	.rodata
.LC0:
	.string	"before\n"
