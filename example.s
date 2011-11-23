	.file	"example.c"
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
.globl Func1
	.type	Func1, @function
Func1:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	leave
	ret
	.size	Func1, .-Func1
.globl Func2
	.type	Func2, @function
Func2:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	leave
	ret
	.size	Func2, .-Func2
.globl Func3
	.type	Func3, @function
Func3:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	leave
	ret
	.size	Func3, .-Func3
.globl CallFunc1
	.type	CallFunc1, @function
CallFunc1:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$99, (%esp)
	call	Func1
	leave
	ret
	.size	CallFunc1, .-CallFunc1
.globl CallFunc2
	.type	CallFunc2, @function
CallFunc2:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$99, 4(%esp)
	movl	$98, (%esp)
	call	Func2
	leave
	ret
	.size	CallFunc2, .-CallFunc2
.globl CallFunc3
	.type	CallFunc3, @function
CallFunc3:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$99, 8(%esp)
	movl	$98, 4(%esp)
	movl	$97, (%esp)
	call	Func3
	leave
	ret
	.size	CallFunc3, .-CallFunc3
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
	jne	.L14
	cmpl	$0, 12(%ebp)
	jne	.L14
	jmp	.L13
.L14:
	movl	$1, -4(%ebp)
.L13:
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
	je	.L16
	cmpl	$0, 12(%ebp)
	je	.L16
	movl	$1, -4(%ebp)
.L16:
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
.LC1:
	.string	"a == 10\n"
.LC2:
	.string	"a != 10\n"
	.text
.globl If
	.type	If, @function
If:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$0, 8(%ebp)
	je	.L21
	movl	$.LC1, (%esp)
	call	printf
	jmp	.L20
.L21:
	movl	$.LC2, (%esp)
	call	printf
.L20:
	leave
	ret
	.size	If, .-If
	.section	.rodata
.LC3:
	.string	"Hello World!\n"
	.text
.globl Callee
	.type	Callee, @function
Callee:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$.LC3, (%esp)
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
	movl	$.LC0, (%esp)
	call	printf
	movl	$78, 4(%esp)
	movl	$88, (%esp)
	call	Or
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.3.3 (Debian 20040401)"
