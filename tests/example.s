.globl expression
	.type	expression, @function
expression:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$9, %eax
	movl	%eax, -4(%ebp)
	movl	$8, %eax
	movl	%eax, -8(%ebp)
	leave
	ret
	.size	expression, .-expression
.globl FunctionWith1Local
	.type	FunctionWith1Local, @function
FunctionWith1Local:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	-4(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	leave
	ret
	.size	FunctionWith1Local, .-FunctionWith1Local
.globl FunctionWith2Local
	.type	FunctionWith2Local, @function
FunctionWith2Local:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	-4(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	leave
	ret
	.size	FunctionWith2Local, .-FunctionWith2Local
	movl	$10, %eax
	movl	%eax, -4(%ebp)
	movl	$20, %eax
	movl	%eax, -8(%ebp)
	movl	$30, %eax
	movl	%eax, -12(%ebp)
	movl	$40, %eax
	movl	%eax, -16(%ebp)
	movl	$50, %eax
	movl	%eax, -20(%ebp)
.globl FunctionWithxLocals
	.type	FunctionWithxLocals, @function
FunctionWithxLocals:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	movl	-4(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	movl	-8(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	movl	-12(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	movl	-16(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	movl	-20(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	leave
	ret
	.size	FunctionWithxLocals, .-FunctionWithxLocals
.globl Func1
	.type	Func1, @function
Func1:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	8(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	leave
	ret
	.size	Func1, .-Func1
.globl Func2
	.type	Func2, @function
Func2:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	12(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	movl	8(%ebp), %eax
	pushl	%eax
	call	printi
	movl	12(%ebp), %eax
	pushl	%eax
	call	printi
	leave
	ret
	.size	Func2, .-Func2
.globl Func3
	.type	Func3, @function
Func3:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	16(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	movl	12(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	movl	8(%ebp), %eax
	pushl	%eax
	call	printi
	call	println
	leave
	ret
	.size	Func3, .-Func3
.globl CallFunc1
	.type	CallFunc1, @function
CallFunc1:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	$99, %eax
	pushl	%eax
	call	Func1
	leave
	ret
	.size	CallFunc1, .-CallFunc1
.globl CallFunc2
	.type	CallFunc2, @function
CallFunc2:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	$98, %eax
	pushl	%eax
	movl	$99, %eax
	pushl	%eax
	call	Func2
	leave
	ret
	.size	CallFunc2, .-CallFunc2
.globl CallFunc3
	.type	CallFunc3, @function
CallFunc3:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	$97, %eax
	pushl	%eax
	movl	$98, %eax
	pushl	%eax
	movl	$99, %eax
	pushl	%eax
	call	Func3
	leave
	ret
	.size	CallFunc3, .-CallFunc3
.globl Equals
	.type	Equals, @function
Equals:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	12(%ebp), %eax
	pushl	%eax
	movl	8(%ebp), %eax
	popl	%ebx
	cmpl	%ebx, %eax
	sete	%al
	movzbl	%al, %eax
	leave
	ret
	leave
	ret
	.size	Equals, .-Equals
.globl NotEquals
	.type	NotEquals, @function
NotEquals:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	12(%ebp), %eax
	pushl	%eax
	movl	8(%ebp), %eax
	popl	%ebx
	cmpl	%ebx, %eax
	setne	%al
	movzbl	%al, %eax
	leave
	ret
	leave
	ret
	.size	NotEquals, .-NotEquals
.globl LessThan
	.type	LessThan, @function
LessThan:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	12(%ebp), %eax
	pushl	%eax
	movl	8(%ebp), %eax
	popl	%ebx
	cmpl	%ebx, %eax
	setl	%al
	movzbl	%al, %eax
	leave
	ret
	leave
	ret
	.size	LessThan, .-LessThan
.globl GreaterThan
	.type	GreaterThan, @function
GreaterThan:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	12(%ebp), %eax
	pushl	%eax
	movl	8(%ebp), %eax
	popl	%ebx
	cmpl	%ebx, %eax
	setg	%al
	movzbl	%al, %eax
	leave
	ret
	leave
	ret
	.size	GreaterThan, .-GreaterThan
.globl Not
	.type	Not, @function
Not:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	sete	%al
	movzbl	%al, %eax
	leave
	ret
	leave
	ret
	.size	Not, .-Not
.globl Or
	.type	Or, @function
Or:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	12(%ebp), %eax
	pushl	%eax
	movl	8(%ebp), %eax
	popl	%ebx
	cmpl	$0, %ebx
	jne	.L1
	cmpl	$0, %eax
	jne	.L1
	jmp	.L2
.L1:
	movl	$1, %eax
.L2:
	leave
	ret
	leave
	ret
	.size	Or, .-Or
.globl And
	.type	And, @function
And:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	12(%ebp), %eax
	pushl	%eax
	movl	8(%ebp), %eax
	popl	%ebx
	cmpl	$0, %ebx
	je	.L3
	cmpl	$0, %eax
	je	.L3
	movl	$1, %eax
	jmp	.L4
.L3:
	movl	$0, %eax
.L4:
	leave
	ret
	leave
	ret
	.size	And, .-And
.globl Add
	.type	Add, @function
Add:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	12(%ebp), %eax
	pushl	%eax
	movl	8(%ebp), %eax
	popl	%ebx
	addl	%ebx,%eax
	leave
	ret
	leave
	ret
	.size	Add, .-Add
.globl Sub
	.type	Sub, @function
Sub:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	12(%ebp), %eax
	pushl	%eax
	movl	8(%ebp), %eax
	popl	%ebx
	subl	%ebx,%eax
	negl	%eax
	leave
	ret
	leave
	ret
	.size	Sub, .-Sub
.globl Negate
	.type	Negate, @function
Negate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	8(%ebp), %eax
	negl	%eax
	leave
	ret
	leave
	ret
	.size	Negate, .-Negate
.globl If
	.type	If, @function
If:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	8(%ebp), %eax
	cmpl	$0, %eax
	je	.L5
	call	println
	jmp	.L6
.L5:
	call	println
.L6:
	leave
	ret
	.size	If, .-If
.globl Callee
	.type	Callee, @function
Callee:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	call	println
	leave
	ret
	.size	Callee, .-Callee
.globl Call
	.type	Call, @function
Call:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	call	Callee
	leave
	ret
	.size	Call, .-Call
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$0, %esp
	movl	$88, %eax
	pushl	%eax
	movl	$78, %eax
	popl	%ebx
	cmpl	$0, %ebx
	jne	.L7
	cmpl	$0, %eax
	jne	.L7
	jmp	.L8
.L7:
	movl	$1, %eax
.L8:
	pushl	%eax
	call	printi
	call	println
	movl	$88, %eax
	pushl	%eax
	movl	$78, %eax
	pushl	%eax
	call	Or
	pushl	%eax
	call	printi
	call	println
	movl	$0, %eax
	leave
	ret
	leave
	ret
	.size	main, .-main
