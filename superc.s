	.file	"superc.c"
	.local	i
	.comm	i,4,4
	.local	numGlobals
	.comm	numGlobals,4,4
	.text
.globl RegisterGlobal
	.type	RegisterGlobal, @function
RegisterGlobal:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$0, -4(%ebp)
.L2:
	movl	-4(%ebp), %eax
	cmpl	numGlobals, %eax
	jl	.L5
	jmp	.L3
.L5:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	globalNames(,%edx,4), %eax
	movl	%eax, (%esp)
	call	strcmp
	testl	%eax, %eax
	jne	.L4
	jmp	.L1
.L4:
	leal	-4(%ebp), %eax
	incl	(%eax)
	jmp	.L2
.L3:
	movl	numGlobals, %edx
	movl	8(%ebp), %eax
	movl	%eax, globalNames(,%edx,4)
	incl	numGlobals
.L1:
	leave
	ret
	.size	RegisterGlobal, .-RegisterGlobal
	.section	.rodata
.LC0:
	.string	"SafeMalloc: out of memory\n"
	.text
.globl SafeMalloc
	.type	SafeMalloc, @function
SafeMalloc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	malloc
	movl	%eax, -4(%ebp)
	cmpl	$0, -4(%ebp)
	jne	.L8
	movl	$.LC0, 4(%esp)
	movl	stderr, %eax
	movl	%eax, (%esp)
	call	fprintf
	call	abort
.L8:
	movl	-4(%ebp), %eax
	leave
	ret
	.size	SafeMalloc, .-SafeMalloc
.globl GcMalloc
	.type	GcMalloc, @function
GcMalloc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	SafeMalloc
	leave
	ret
	.size	GcMalloc, .-GcMalloc
.globl GcStrDup
	.type	GcStrDup, @function
GcStrDup:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	strlen
	incl	%eax
	movl	%eax, (%esp)
	call	GcMalloc
	movl	%eax, -4(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	strcpy
	movl	-4(%ebp), %eax
	leave
	ret
	.size	GcStrDup, .-GcStrDup
	.local	labelNum
	.comm	labelNum,4,4
	.section	.rodata
.LC1:
	.string	".L%d"
	.text
.globl NewLabel
	.type	NewLabel, @function
NewLabel:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$280, %esp
	incl	labelNum
	movl	labelNum, %eax
	movl	%eax, 8(%esp)
	movl	$.LC1, 4(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	GcStrDup
	leave
	ret
	.size	NewLabel, .-NewLabel
	.section	.rodata
.LC2:
	.string	"\t%s"
	.text
.globl Emit
	.type	Emit, @function
Emit:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	leave
	ret
	.size	Emit, .-Emit
	.section	.rodata
.LC3:
	.string	"\n"
	.text
.globl EmitLn
	.type	EmitLn, @function
EmitLn:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	Emit
	movl	$.LC3, (%esp)
	call	printf
	leave
	ret
	.size	EmitLn, .-EmitLn
	.section	.rodata
.LC4:
	.string	"%s:\n"
	.text
.globl EmitLabel
	.type	EmitLabel, @function
EmitLabel:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	printf
	leave
	ret
	.size	EmitLabel, .-EmitLabel
	.section	.rodata
.LC5:
	.string	"%s\t%s\n"
	.text
.globl EmitOp1
	.type	EmitOp1, @function
EmitOp1:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$280, %esp
	movl	12(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC5, 4(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	Emit
	leave
	ret
	.size	EmitOp1, .-EmitOp1
	.section	.rodata
.LC6:
	.string	"if"
.LC7:
	.string	"else"
.LC8:
	.string	"while"
.LC9:
	.string	"do"
.LC10:
	.string	"break"
.LC11:
	.string	"true"
.LC12:
	.string	"false"
.globl keywords
	.data
	.align 32
	.type	keywords, @object
	.size	keywords, 84
keywords:
	.long	.LC6
	.long	2
	.long	256
	.long	.LC7
	.long	4
	.long	257
	.long	.LC8
	.long	5
	.long	258
	.long	.LC9
	.long	2
	.long	259
	.long	.LC10
	.long	5
	.long	260
	.long	.LC11
	.long	4
	.long	261
	.long	.LC12
	.long	5
	.long	262
	.text
.globl GetChar
	.type	GetChar, @function
GetChar:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movb	$0, -5(%ebp)
	movl	$0, -12(%ebp)
.L17:
	cmpl	$6, -12(%ebp)
	jbe	.L20
	jmp	.L18
.L20:
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %ebx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	movl	-12(%ebp), %eax
	movl	parseString, %ecx
	addl	%eax, %ecx
	movl	keywords+4(%ebx), %eax
	movl	%eax, 8(%esp)
	movl	keywords(%edx), %eax
	movl	%eax, 4(%esp)
	movl	%ecx, (%esp)
	call	strncmp
	testl	%eax, %eax
	jne	.L19
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	keywords+8(%eax), %eax
	movl	%eax, lookahead
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	keywords+4(%eax), %edx
	leal	-12(%ebp), %eax
	addl	%edx, (%eax)
	movb	$1, -5(%ebp)
	jmp	.L18
.L19:
	leal	-12(%ebp), %eax
	incl	(%eax)
	jmp	.L17
.L18:
	cmpb	$0, -5(%ebp)
	jne	.L16
	movl	i, %eax
	addl	parseString, %eax
	movsbl	(%eax),%eax
	movl	%eax, lookahead
	incl	i
.L16:
	addl	$20, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	GetChar, .-GetChar
.globl EatWhite
	.type	EatWhite, @function
EatWhite:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	nop
.L24:
	call	__ctype_b_loc
	movl	%eax, %ecx
	movl	lookahead, %eax
	leal	(%eax,%eax), %edx
	movl	(%ecx), %eax
	movzwl	(%eax,%edx), %eax
	andl	$8192, %eax
	testl	%eax, %eax
	jne	.L26
	jmp	.L23
.L26:
	call	GetChar
	jmp	.L24
.L23:
	leave
	ret
	.size	EatWhite, .-EatWhite
	.section	.rodata
.LC13:
	.string	"Error: %s (position %d).\n"
	.text
.globl Error
	.type	Error, @function
Error:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	i, %eax
	movl	%eax, 12(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC13, 4(%esp)
	movl	stderr, %eax
	movl	%eax, (%esp)
	call	fprintf
	leave
	ret
	.size	Error, .-Error
.globl Abort
	.type	Abort, @function
Abort:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	Error
	movl	$1, (%esp)
	call	exit
	.size	Abort, .-Abort
	.section	.rodata
.LC14:
	.string	" expected"
	.text
.globl Expected
	.type	Expected, @function
Expected:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	$.LC14, -8(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	strlen
	movl	%eax, %ebx
	movl	-8(%ebp), %eax
	movl	%eax, (%esp)
	call	strlen
	leal	(%eax,%ebx), %eax
	incl	%eax
	movl	%eax, (%esp)
	call	GcMalloc
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	strcpy
	movl	-8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	strcat
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	Abort
	.size	Expected, .-Expected
	.section	.rodata
.LC15:
	.string	"End of stream"
.LC16:
	.string	"'_'"
	.text
.globl Match
	.type	Match, @function
Match:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	lookahead, %eax
	cmpl	8(%ebp), %eax
	jne	.L31
	call	GetChar
	call	EatWhite
	jmp	.L30
.L31:
	cmpl	$0, 8(%ebp)
	jne	.L33
	movl	$.LC15, (%esp)
	call	Expected
.L33:
	movl	.LC16, %eax
	movl	%eax, -4(%ebp)
	movzbl	8(%ebp), %eax
	movb	%al, -3(%ebp)
	leal	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	Expected
.L30:
	leave
	ret
	.size	Match, .-Match
	.section	.rodata
.LC17:
	.string	"Name"
	.text
.globl GetName
	.type	GetName, @function
GetName:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$296, %esp
	call	__ctype_b_loc
	movl	%eax, %ecx
	movl	lookahead, %eax
	leal	(%eax,%eax), %edx
	movl	(%ecx), %eax
	movzwl	(%eax,%edx), %eax
	andl	$1024, %eax
	testl	%eax, %eax
	jne	.L36
	movl	$.LC17, (%esp)
	call	Expected
.L36:
	movl	$0, -268(%ebp)
.L37:
	call	__ctype_b_loc
	movl	%eax, %ecx
	movl	lookahead, %eax
	leal	(%eax,%eax), %edx
	movl	(%ecx), %eax
	movzwl	(%eax,%edx), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L39
	jmp	.L38
.L39:
	movl	-268(%ebp), %eax
	leal	-8(%ebp), %edx
	addl	%edx, %eax
	leal	-256(%eax), %edx
	movzbl	lookahead, %eax
	movb	%al, (%edx)
	leal	-268(%ebp), %eax
	incl	(%eax)
	call	GetChar
	jmp	.L37
.L38:
	movl	-268(%ebp), %eax
	leal	-8(%ebp), %edx
	addl	%edx, %eax
	subl	$256, %eax
	movb	$0, (%eax)
	leal	-268(%ebp), %eax
	incl	(%eax)
	call	EatWhite
	movl	-268(%ebp), %eax
	movl	%eax, (%esp)
	call	GcMalloc
	movl	%eax, -272(%ebp)
	leal	-264(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-272(%ebp), %eax
	movl	%eax, (%esp)
	call	strcpy
	movl	-272(%ebp), %eax
	leave
	ret
	.size	GetName, .-GetName
	.section	.rodata
.LC18:
	.string	"Integer"
	.text
.globl GetNum
	.type	GetNum, @function
GetNum:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$296, %esp
	call	__ctype_b_loc
	movl	%eax, %ecx
	movl	lookahead, %eax
	leal	(%eax,%eax), %edx
	movl	(%ecx), %eax
	movzwl	(%eax,%edx), %eax
	andl	$2048, %eax
	testl	%eax, %eax
	jne	.L41
	movl	$.LC18, (%esp)
	call	Expected
.L41:
	movl	$0, -268(%ebp)
.L42:
	call	__ctype_b_loc
	movl	%eax, %ecx
	movl	lookahead, %eax
	leal	(%eax,%eax), %edx
	movl	(%ecx), %eax
	movzwl	(%eax,%edx), %eax
	andl	$2048, %eax
	testl	%eax, %eax
	jne	.L44
	jmp	.L43
.L44:
	movl	-268(%ebp), %eax
	leal	-8(%ebp), %edx
	addl	%edx, %eax
	leal	-256(%eax), %edx
	movzbl	lookahead, %eax
	movb	%al, (%edx)
	leal	-268(%ebp), %eax
	incl	(%eax)
	call	GetChar
	jmp	.L42
.L43:
	movl	-268(%ebp), %eax
	leal	-8(%ebp), %edx
	addl	%edx, %eax
	subl	$256, %eax
	movb	$0, (%eax)
	leal	-268(%ebp), %eax
	incl	(%eax)
	call	EatWhite
	movl	-268(%ebp), %eax
	movl	%eax, (%esp)
	call	GcMalloc
	movl	%eax, -272(%ebp)
	leal	-264(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-272(%ebp), %eax
	movl	%eax, (%esp)
	call	strcpy
	movl	-272(%ebp), %eax
	leave
	ret
	.size	GetNum, .-GetNum
	.section	.rodata
.LC19:
	.string	"Boolean literal"
	.text
.globl GetBoolean
	.type	GetBoolean, @function
GetBoolean:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$261, lookahead
	jne	.L46
	movl	$1, -4(%ebp)
	jmp	.L45
.L46:
	cmpl	$262, lookahead
	jne	.L48
	movl	$0, -4(%ebp)
	jmp	.L45
.L48:
	movl	$.LC19, (%esp)
	call	Expected
.L45:
	movl	-4(%ebp), %eax
	leave
	ret
	.size	GetBoolean, .-GetBoolean
.globl Init
	.type	Init, @function
Init:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, parseString
	call	GetChar
	call	EatWhite
	leave
	ret
	.size	Init, .-Init
	.section	.rodata
.LC20:
	.string	"call\t%s"
.LC21:
	.string	"movl\t%s, %%eax"
.LC22:
	.string	"movl\t$%s, %%eax"
	.text
.globl Factor
	.type	Factor, @function
Factor:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$296, %esp
	cmpl	$40, lookahead
	jne	.L52
	movl	$40, (%esp)
	call	Match
	call	Expression
	movl	$41, (%esp)
	call	Match
	jmp	.L51
.L52:
	call	__ctype_b_loc
	movl	%eax, %ecx
	movl	lookahead, %eax
	leal	(%eax,%eax), %edx
	movl	(%ecx), %eax
	movzwl	(%eax,%edx), %eax
	andl	$1024, %eax
	testl	%eax, %eax
	je	.L54
	call	GetName
	movl	%eax, -12(%ebp)
	cmpl	$40, lookahead
	jne	.L55
	movl	$40, (%esp)
	call	Match
	movl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC20, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLn
	movl	$41, (%esp)
	call	Match
	jmp	.L51
.L55:
	movl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC21, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLn
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	RegisterGlobal
	jmp	.L51
.L54:
	call	GetNum
	movl	%eax, 8(%esp)
	movl	$.LC22, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLn
.L51:
	leave
	ret
	.size	Factor, .-Factor
	.section	.rodata
.LC23:
	.string	"popl\t%ebx"
.LC24:
	.string	"imul\t%ebx,%eax"
	.text
.globl Multiply
	.type	Multiply, @function
Multiply:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$42, (%esp)
	call	Match
	call	Factor
	movl	$.LC23, (%esp)
	call	EmitLn
	movl	$.LC24, (%esp)
	call	EmitLn
	leave
	ret
	.size	Multiply, .-Multiply
	.section	.rodata
.LC25:
	.string	"movl\t%eax,%ebx"
.LC26:
	.string	"popl\t%eax"
.LC27:
	.string	"cltd"
.LC28:
	.string	"idiv\t%ebx,%eax"
	.text
.globl Divide
	.type	Divide, @function
Divide:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$47, (%esp)
	call	Match
	call	Factor
	movl	$.LC25, (%esp)
	call	EmitLn
	movl	$.LC26, (%esp)
	call	EmitLn
	movl	$.LC27, (%esp)
	call	EmitLn
	movl	$.LC28, (%esp)
	call	EmitLn
	leave
	ret
	.size	Divide, .-Divide
	.section	.rodata
.LC29:
	.string	"push\t%eax"
	.text
.globl Term
	.type	Term, @function
Term:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	call	Factor
.L61:
	cmpl	$42, lookahead
	je	.L63
	cmpl	$47, lookahead
	je	.L63
	jmp	.L60
.L63:
	movl	$.LC29, (%esp)
	call	EmitLn
	movl	lookahead, %eax
	movl	%eax, -4(%ebp)
	cmpl	$42, -4(%ebp)
	je	.L65
	cmpl	$47, -4(%ebp)
	je	.L66
	jmp	.L61
.L65:
	call	Multiply
	jmp	.L61
.L66:
	call	Divide
	jmp	.L61
.L60:
	leave
	ret
	.size	Term, .-Term
	.section	.rodata
.LC30:
	.string	"addl\t%ebx,%eax"
	.text
.globl Add
	.type	Add, @function
Add:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$43, (%esp)
	call	Match
	call	Term
	movl	$.LC23, (%esp)
	call	EmitLn
	movl	$.LC30, (%esp)
	call	EmitLn
	leave
	ret
	.size	Add, .-Add
	.section	.rodata
.LC31:
	.string	"subl\t%ebx,%eax"
.LC32:
	.string	"negl\t%eax"
	.text
.globl Subtract
	.type	Subtract, @function
Subtract:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$45, (%esp)
	call	Match
	call	Term
	movl	$.LC23, (%esp)
	call	EmitLn
	movl	$.LC31, (%esp)
	call	EmitLn
	movl	$.LC32, (%esp)
	call	EmitLn
	leave
	ret
	.size	Subtract, .-Subtract
.globl IsAddOp
	.type	IsAddOp, @function
IsAddOp:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movb	$0, -1(%ebp)
	cmpl	$43, lookahead
	je	.L73
	cmpl	$45, lookahead
	je	.L73
	jmp	.L72
.L73:
	movb	$1, -1(%ebp)
.L72:
	movzbl	-1(%ebp), %eax
	leave
	ret
	.size	IsAddOp, .-IsAddOp
	.section	.rodata
.LC33:
	.string	"movl\t$0,%eax"
	.text
.globl Expression
	.type	Expression, @function
Expression:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	lookahead, %eax
	movl	%eax, (%esp)
	call	IsAddOp
	testb	%al, %al
	je	.L75
	movl	$.LC33, (%esp)
	call	EmitLn
	jmp	.L77
.L75:
	call	Term
.L77:
	movl	lookahead, %eax
	movl	%eax, (%esp)
	call	IsAddOp
	testb	%al, %al
	jne	.L79
	jmp	.L74
.L79:
	movl	$.LC29, (%esp)
	call	EmitLn
	movl	lookahead, %eax
	movl	%eax, -4(%ebp)
	cmpl	$43, -4(%ebp)
	je	.L81
	cmpl	$45, -4(%ebp)
	je	.L82
	jmp	.L77
.L81:
	call	Add
	jmp	.L77
.L82:
	call	Subtract
	jmp	.L77
.L74:
	leave
	ret
	.size	Expression, .-Expression
	.section	.rodata
.LC34:
	.string	"movl %%eax, %s"
	.text
.globl Assignment
	.type	Assignment, @function
Assignment:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$296, %esp
	call	GetName
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	RegisterGlobal
	movl	$61, (%esp)
	call	Match
	call	Expression
	movl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC34, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLn
	leave
	ret
	.size	Assignment, .-Assignment
	.section	.rodata
.LC35:
	.string	"je\t%s\n"
.LC36:
	.string	"jmp\t%s"
	.text
.globl If
	.type	If, @function
If:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$552, %esp
	movl	$256, (%esp)
	call	Match
	call	NewLabel
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)
	call	Expression
	movl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC35, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	Emit
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	Statement
	cmpl	$257, lookahead
	jne	.L87
	movl	$257, (%esp)
	call	Match
	call	NewLabel
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC36, 4(%esp)
	leal	-536(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-536(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLn
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLabel
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	Statement
.L87:
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLabel
	leave
	ret
	.size	If, .-If
	.section	.rodata
.LC37:
	.string	"je"
.LC38:
	.string	"jmp"
	.text
.globl While
	.type	While, @function
While:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$258, (%esp)
	call	Match
	call	NewLabel
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLabel
	call	Expression
	call	NewLabel
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC37, (%esp)
	call	EmitOp1
	movl	-8(%ebp), %eax
	movl	%eax, (%esp)
	call	Statement
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC38, (%esp)
	call	EmitOp1
	movl	-8(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLabel
	leave
	ret
	.size	While, .-While
	.section	.rodata
.LC39:
	.string	"jne"
	.text
.globl DoWhile
	.type	DoWhile, @function
DoWhile:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$259, (%esp)
	call	Match
	call	NewLabel
	movl	%eax, -4(%ebp)
	call	NewLabel
	movl	%eax, -8(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLabel
	movl	-8(%ebp), %eax
	movl	%eax, (%esp)
	call	Statement
	movl	$258, (%esp)
	call	Match
	call	Expression
	movl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC39, (%esp)
	call	EmitOp1
	movl	-8(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLabel
	leave
	ret
	.size	DoWhile, .-DoWhile
	.section	.rodata
	.align 32
.LC40:
	.string	"break statement not within loop"
	.text
.globl Break
	.type	Break, @function
Break:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$260, (%esp)
	call	Match
	cmpl	$0, 8(%ebp)
	jne	.L91
	movl	$.LC40, (%esp)
	call	Abort
.L91:
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC38, (%esp)
	call	EmitOp1
	leave
	ret
	.size	Break, .-Break
.globl Statement
	.type	Statement, @function
Statement:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$123, lookahead
	jne	.L93
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	Block
	jmp	.L92
.L93:
	cmpl	$256, lookahead
	jne	.L95
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	If
	jmp	.L92
.L95:
	cmpl	$258, lookahead
	jne	.L97
	call	While
	jmp	.L92
.L97:
	cmpl	$259, lookahead
	jne	.L99
	call	DoWhile
	jmp	.L92
.L99:
	cmpl	$260, lookahead
	jne	.L101
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	Break
	jmp	.L92
.L101:
	call	Assignment
.L92:
	leave
	ret
	.size	Statement, .-Statement
.globl Statements
	.type	Statements, @function
Statements:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	nop
.L104:
	cmpl	$256, lookahead
	je	.L106
	cmpl	$258, lookahead
	je	.L106
	cmpl	$259, lookahead
	je	.L106
	cmpl	$260, lookahead
	je	.L106
	call	__ctype_b_loc
	movl	%eax, %ecx
	movl	lookahead, %eax
	leal	(%eax,%eax), %edx
	movl	(%ecx), %eax
	movzwl	(%eax,%edx), %eax
	andl	$1024, %eax
	testl	%eax, %eax
	jne	.L106
	jmp	.L103
.L106:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	Statement
	jmp	.L104
.L103:
	leave
	ret
	.size	Statements, .-Statements
.globl Block
	.type	Block, @function
Block:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$123, (%esp)
	call	Match
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	Statements
	movl	$125, (%esp)
	call	Match
	leave
	ret
	.size	Block, .-Block
	.section	.rodata
.LC41:
	.string	".globl %s\n"
.LC42:
	.string	"\t.type\t%s, @function\n"
.LC43:
	.string	"pushl\t%ebp"
.LC44:
	.string	"movl\t%esp, %ebp"
	.text
.globl EmitFunctionPreamble
	.type	EmitFunctionPreamble, @function
EmitFunctionPreamble:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC41, (%esp)
	call	printf
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC42, (%esp)
	call	printf
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	printf
	movl	$.LC43, (%esp)
	call	EmitLn
	movl	$.LC44, (%esp)
	call	EmitLn
	leave
	ret
	.size	EmitFunctionPreamble, .-EmitFunctionPreamble
	.section	.rodata
.LC45:
	.string	"pop\t%ebp"
.LC46:
	.string	"ret"
.LC47:
	.string	".size\t%s, .-%s"
	.text
.globl EmitFunctionPostamble
	.type	EmitFunctionPostamble, @function
EmitFunctionPostamble:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$280, %esp
	movl	$.LC45, (%esp)
	call	EmitLn
	movl	$.LC46, (%esp)
	call	EmitLn
	movl	8(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC47, 4(%esp)
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-264(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLn
	leave
	ret
	.size	EmitFunctionPostamble, .-EmitFunctionPostamble
	.section	.rodata
.LC48:
	.string	".comm\t%s,4,4"
	.text
.globl EmitGlobalVariableDefinitions
	.type	EmitGlobalVariableDefinitions, @function
EmitGlobalVariableDefinitions:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$296, %esp
	movl	$0, -12(%ebp)
.L111:
	movl	-12(%ebp), %eax
	cmpl	numGlobals, %eax
	jl	.L114
	jmp	.L110
.L114:
	movl	-12(%ebp), %eax
	movl	globalNames(,%eax,4), %eax
	movl	%eax, 8(%esp)
	movl	$.LC48, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	sprintf
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	EmitLn
	leal	-12(%ebp), %eax
	incl	(%eax)
	jmp	.L111
.L110:
	leave
	ret
	.size	EmitGlobalVariableDefinitions, .-EmitGlobalVariableDefinitions
	.section	.rodata
.LC49:
	.string	"expression"
	.text
.globl Top
	.type	Top, @function
Top:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$.LC49, (%esp)
	call	EmitFunctionPreamble
	cmpl	$123, lookahead
	jne	.L116
	movl	$0, (%esp)
	call	Block
	jmp	.L117
.L116:
	movl	$0, (%esp)
	call	Statements
.L117:
	movl	$.LC49, (%esp)
	call	EmitFunctionPostamble
	call	EmitGlobalVariableDefinitions
	movl	$0, (%esp)
	call	Match
	leave
	ret
	.size	Top, .-Top
	.section	.rodata
.LC50:
	.string	"usage: superc \"<expression>\"\n"
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
	cmpl	$2, 8(%ebp)
	je	.L119
	movl	$.LC50, 4(%esp)
	movl	stderr, %eax
	movl	%eax, (%esp)
	call	fprintf
	movl	$2, (%esp)
	call	exit
.L119:
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	Init
	call	Top
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.local	parseString
	.comm	parseString,4,4
	.local	lookahead
	.comm	lookahead,4,4
	.local	globalNames
	.comm	globalNames,1024,32
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.3.3 (Debian 20040401)"
