	.file	"example.c"
	.text
.globl Equals
	.type	Equals, @function
Equals:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	sete	%al
	movzbl	%al, %eax
	popl	%ebp
	ret
	.size	Equals, .-Equals
.globl NotEquals
	.type	NotEquals, @function
NotEquals:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	setne	%al
	movzbl	%al, %eax
	popl	%ebp
	ret
	.size	NotEquals, .-NotEquals
.globl LessThan
	.type	LessThan, @function
LessThan:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	setl	%al
	movzbl	%al, %eax
	popl	%ebp
	ret
	.size	LessThan, .-LessThan
.globl GreaterThan
	.type	GreaterThan, @function
GreaterThan:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	setg	%al
	movzbl	%al, %eax
	popl	%ebp
	ret
	.size	GreaterThan, .-GreaterThan
.globl Not
	.type	Not, @function
Not:
	pushl	%ebp
	movl	%esp, %ebp
	cmpl	$0, 8(%ebp)
	sete	%al
	movzbl	%al, %eax
	popl	%ebp
	ret
	.size	Not, .-Not
.globl Or
	.type	Or, @function
Or:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	$0, -4(%ebp)
	cmpl	$0, 8(%ebp)
	jne	.L8
	cmpl	$0, 12(%ebp)
	jne	.L8
	jmp	.L7
.L8:
	movl	$1, -4(%ebp)
.L7:
	movl	-4(%ebp), %eax
	leave
	ret
	.size	Or, .-Or
.globl And
	.type	And, @function
And:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	$0, -4(%ebp)
	cmpl	$0, 8(%ebp)
	je	.L10
	cmpl	$0, 12(%ebp)
	je	.L10
	movl	$1, -4(%ebp)
.L10:
	movl	-4(%ebp), %eax
	leave
	ret
	.size	And, .-And
.globl Add
	.type	Add, @function
Add:
	pushl	%ebp
	movl	%esp, %ebp
	movl	12(%ebp), %eax
	addl	8(%ebp), %eax
	popl	%ebp
	ret
	.size	Add, .-Add
.globl Sub
	.type	Sub, @function
Sub:
	pushl	%ebp
	movl	%esp, %ebp
	movl	12(%ebp), %edx
	movl	8(%ebp), %eax
	subl	%edx, %eax
	popl	%ebp
	ret
	.size	Sub, .-Sub
.globl Negate
	.type	Negate, @function
Negate:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	negl	%eax
	popl	%ebp
	ret
	.size	Negate, .-Negate
	.section	.rodata
.LC0:
	.string	"a == 10\n"
.LC1:
	.string	"a != 10\n"
	.text
.globl If
	.type	If, @function
If:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$0, 8(%ebp)
	je	.L15
	movl	$.LC0, (%esp)
	call	printf
	jmp	.L14
.L15:
	movl	$.LC1, (%esp)
	call	printf
.L14:
	leave
	ret
	.size	If, .-If
	.section	.rodata
.LC2:
	.string	"Hello World!\n"
	.text
.globl Callee
	.type	Callee, @function
Callee:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$.LC2, (%esp)
	call	printf
	leave
	ret
	.size	Callee, .-Callee
.globl Call
	.type	Call, @function
Call:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	call	Callee
	leave
	ret
	.size	Call, .-Call
	.section	.rodata
.LC3:
	.string	"%d\n"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	andl	$-16, %esp
	movl	$0, %eax
	subl	%eax, %esp
	movl	$1, 4(%esp)
	movl	$.LC3, (%esp)
	call	printf
	movl	$78, 4(%esp)
	movl	$88, (%esp)
	call	Or
	movl	%eax, 4(%esp)
	movl	$.LC3, (%esp)
	call	printf
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.3.3 (Debian 20040401)"
