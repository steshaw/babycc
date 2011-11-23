	.file	"while.c"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$4, %esp
	andl	$-16, %esp
	movl	$0, %ebx
.L5:
	movl	%ebx, (%esp)
	call	printi
	call	println
	incl	%ebx
	cmpl	$9, %ebx
	jle	.L5
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.3.3 (Debian 20040429)"
