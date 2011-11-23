	.file	"foo.c"
	.text
.globl AddInt
	.type	AddInt, @function
AddInt:
	pushl	%ebp
	movl	%esp, %ebp
	movl	12(%ebp), %eax
	addl	8(%ebp), %eax
	popl	%ebp
	ret
	.size	AddInt, .-AddInt
.globl foo
	.type	foo, @function
foo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$12, 4(%esp)
	movl	$10, (%esp)
	call	AddInt
	movl	$12, 4(%esp)
	movl	$10, (%esp)
	call	AddInt
	leave
	ret
	.size	foo, .-foo
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	andl	$-16, %esp
	movl	$0, %eax
	subl	%eax, %esp
	call	foo
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.3.3 (Debian 20040429)"
