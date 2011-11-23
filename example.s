	.file	"example.c"
	.text
.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$9, -4(%ebp)
	movl	$8, -8(%ebp)
	leave
	ret
	.size	expression, .-expression
	.section	.rodata
.LC0:
	.string	"FunctionWith1Local: a = %d\n"
	.text
.globl FunctionWith1Local
	.type	FunctionWith1Local, @function
FunctionWith1Local:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	leave
	ret
	.size	FunctionWith1Local, .-FunctionWith1Local
	.section	.rodata
.LC1:
	.string	"FunctionWith2Local: a = %d\n"
.LC2:
	.string	"FunctionWith2Local: b = %d\n"
	.text
.globl FunctionWith2Local
	.type	FunctionWith2Local, @function
FunctionWith2Local:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC1, (%esp)
	call	printf
	movl	-8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	leave
	ret
	.size	FunctionWith2Local, .-FunctionWith2Local
	.section	.rodata
.LC3:
	.string	"FunctionWith3Local: a = %d\n"
.LC4:
	.string	"FunctionWith3Local: b = %d\n"
.LC5:
	.string	"FunctionWith3Local: c = %d\n"
.LC6:
	.string	"FunctionWith3Local: d = %d\n"
.LC7:
	.string	"FunctionWith3Local: e = %d\n"
	.text
.globl FunctionWithxLocals
	.type	FunctionWithxLocals, @function
FunctionWithxLocals:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$10, -4(%ebp)
	movl	$20, -8(%ebp)
	movl	$30, -12(%ebp)
	movl	$40, -16(%ebp)
	movl	$50, -20(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC3, (%esp)
	call	printf
	movl	-8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	printf
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC5, (%esp)
	call	printf
	movl	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC6, (%esp)
	call	printf
	movl	-20(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC7, (%esp)
	call	printf
	leave
	ret
	.size	FunctionWithxLocals, .-FunctionWithxLocals
	.section	.rodata
.LC8:
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
	movl	$.LC8, (%esp)
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
	movl	$.LC8, (%esp)
	call	printf
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC8, (%esp)
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
	movl	$.LC8, (%esp)
	call	printf
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC8, (%esp)
	call	printf
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC8, (%esp)
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
	jne	.L18
	cmpl	$0, 12(%ebp)
	jne	.L18
	jmp	.L17
.L18:
	movl	$1, -4(%ebp)
.L17:
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
	je	.L20
	cmpl	$0, 12(%ebp)
	je	.L20
	movl	$1, -4(%ebp)
.L20:
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
.LC9:
	.string	"a == 10\n"
.LC10:
	.string	"a != 10\n"
	.text
.globl If
	.type	If, @function
If:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$0, 8(%ebp)
	je	.L25
	movl	$.LC9, (%esp)
	call	printf
	jmp	.L24
.L25:
	movl	$.LC10, (%esp)
	call	printf
.L24:
	leave
	ret
	.size	If, .-If
	.section	.rodata
.LC11:
	.string	"Hello World!\n"
	.text
.globl Callee
	.type	Callee, @function
Callee:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$.LC11, (%esp)
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
	movl	$.LC8, (%esp)
	call	printf
	movl	$78, 4(%esp)
	movl	$88, (%esp)
	call	Or
	movl	%eax, 4(%esp)
	movl	$.LC8, (%esp)
	call	printf
	call	FunctionWith1Local
	call	FunctionWith2Local
	call	FunctionWithxLocals
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.3.3 (Debian 20040429)"
