/**
 *
 * eax is used as the "accumulator" register
 * ebx is used as the "temporary" register (used to get store value from the
 *                                          expression stack)
 *
 * Need one register for swapping in div operator. (ebx)
 * Need one register for function calls.
 *
 * The rest could be used as a faster "stack".
 */

/*
 * Registers (as reported by ddd):
 *  
 *  XXX where is al?
 *
 * Integer registers:
 *      eax
 *      ecx
 *      edx
 *      ebx
 *      esp
 *      ebp
 *      esi
 *      edi
 *      eip
 *      eflags
 *      cs
 *      ss
 *      ds
 *      es
 *      fs
 *      gs
 *
 * Other registers:
 *      st0-7
 *      fctrl
 *      fstat
 *      ftag
 *      fiseg
 *      fioff
 *      foseg
 *      fooff
 *      fop
 *      xmm0-7
 *      mxcsr
 *      mm0-7
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>


/*
XXX here is an example of using snprintf from the man page
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
char *
make_message(const char *fmt, ...) {
 // Guess we need no more than 100 bytes.
 int n, size = 100;
 char *p;
 va_list ap;
 if ((p = malloc (size)) == NULL)
    return NULL;
 while (1) {
    // Try to print in the allocated space.
    va_start(ap, fmt);
    n = vsnprintf (p, size, fmt, ap);
    va_end(ap);
    // If that worked, return the string.
    if (n > -1 && n < size)
       return p;
    // Else try again with more space.
    if (n > -1)    // glibc 2.1
       size = n+1; // precisely what is needed
    else           // glibc 2.0
       size *= 2;  // twice the old size
    if ((p = realloc (p, size)) == NULL)
       return NULL;
 }
}
*/


enum Token {
    IF = 256, // Start after the ascii characters 0-255
    ELSE,
    WHILE,
    DO,
    BREAK,
    TrueToken,
    FalseToken,
    OrToken,
    AndToken,
    EqualsToken,
    NotEqualsToken,
    LessThanToken,
    GreaterThanToken,
};



//---------------------------------------------------------------
//  Variable Declarations
//---------------------------------------------------------------
static char* parseString;
static int pos = 0;
static int lookahead;
static int numGlobals = 0;
static char* globalNames[256]; // XXX hard limit :-(

//---------------------------------------------------------------
// Add global to globalNames array for later emission in the 
// postamble.
//---------------------------------------------------------------
void RegisterGlobal(char *name)
{
    // return if registered already
    for (int i = 0; i < numGlobals; ++i) {
        if (strcmp(globalNames[i], name) == 0) return; // XXX inefficient
    }

    // register
    globalNames[numGlobals] = name;
    ++numGlobals;
}

void* SafeMalloc(int n)
{
    void *result;
    result = malloc(n);
    if (result == NULL) {
        fprintf(stderr, "SafeMalloc: out of memory\n");
        abort();
    }
    
    return result;
}

// pretend to have garbage-collection
void *GcMalloc(int n)
{
    return SafeMalloc(n);
}

char *GcStrDup(char *s)
{
    char *newString = GcMalloc(strlen(s) + 1);
    strcpy(newString, s);
    return newString;
}

//===============================================================
// Assembly Emitter
//===============================================================
static int labelNum = 0;

char *NewLabel()
{
    ++labelNum;
    char label[256];
    sprintf(label, ".L%d", labelNum);

    return GcStrDup(label);
}

// --------------------------------------------------------------
//  Output a String with Tab
// --------------------------------------------------------------
void Emit(char *s)
{
    printf("\t%s", s);
}

// --------------------------------------------------------------
//  Output a String with "\t" and "\n"
// --------------------------------------------------------------
void EmitLn(char *s)
{
   Emit(s);
   printf("\n");
}

void EmitLabel(char *label)
{
    printf("%s:\n", label);
}

// --------------------------------------------------------------
// Emit operation with one parameter
// --------------------------------------------------------------
void EmitOp1(char *instruction, char *p1)
{
    char op[256];
    sprintf(op, "%s\t%s\n", instruction, p1);
    Emit(op);
}

// --------------------------------------------------------------
// Emit operation with two parameters
// --------------------------------------------------------------
void EmitOp2(char *instruction, char *p1, char *p2)
{
    char op[256];
    sprintf(op, "%s\t%s, %s\n", instruction, p1, p2);
    Emit(op);
}

//===============================================================
// Lexer
//===============================================================

struct Keyword {
    char *keyword;
    int keywordLength;
    enum Token token;
};

#define DEF_KEYWORD(kw, t) {kw, strlen(kw), t}

struct Keyword keywords[] = {
    DEF_KEYWORD("if", IF),
    DEF_KEYWORD("else", ELSE),
    DEF_KEYWORD("while", WHILE),
    DEF_KEYWORD("do", DO),
    DEF_KEYWORD("break", BREAK),
    DEF_KEYWORD("true", TrueToken),
    DEF_KEYWORD("false", FalseToken),
    DEF_KEYWORD("||", OrToken),
    DEF_KEYWORD("&&", AndToken),
    DEF_KEYWORD("==", EqualsToken),
    DEF_KEYWORD("!=", NotEqualsToken),
    DEF_KEYWORD("<", LessThanToken),
    DEF_KEYWORD(">", GreaterThanToken),
};

// calculate the size of a static array
#define ARRAYSIZE(x) (sizeof(x)/sizeof(*x))

///---------------------------------------------------------------
///  Read New Character From Input Stream
///---------------------------------------------------------------
void GetChar(void)
{
    // XXX this is quite inefficient
    bool found = false;
    for (int i = 0; i < ARRAYSIZE(keywords); ++i) {
        if (strncmp(parseString+pos, keywords[i].keyword, 
                    keywords[i].keywordLength) == 0) 
        {
            lookahead = keywords[i].token;
            pos += keywords[i].keywordLength;
            found = true;
            break;
        }
    }

    if (!found) {
        lookahead = parseString[pos]; // was: "lookahead = getchar();"
        ++pos;
    }
}

// --------------------------------------------------------------
void EatWhite(void)
{
    while (isspace(lookahead)) {
        GetChar();
    }
}

// --------------------------------------------------------------
//  Report an Error
// --------------------------------------------------------------
void Error(char *s)
{
    fprintf(stderr, "Error: %s (position %d).\n", s, pos);
}

// --------------------------------------------------------------
//  Report Error and Halt
// --------------------------------------------------------------
void Abort(char *s) __attribute__ ((noreturn));

void Abort(char *s)
{
    Error(s);
    exit(1);
}

// --------------------------------------------------------------
//  Report What Was Expected
// --------------------------------------------------------------
void Expected(char *s) __attribute__ ((noreturn));
void Expected(char *s)
{
    const char *e = " expected";
    char *newString = GcMalloc(strlen(s) + strlen(e) + 1);
    strcpy(newString, s);
    strcat(newString, e);

    Abort(newString);
}

// --------------------------------------------------------------
//  Match a Specific Input Character
// --------------------------------------------------------------
void Match(int c)
{
    if (lookahead == c) {
        GetChar();
        EatWhite();
    }
    else if (c == '\0') {
        Expected("End of stream");
    }
    else {
        char s[] = "'_'";
        s[1] = c;
        Expected(s);
    }
}

// --------------------------------------------------------------
//  Get an Identifier
// --------------------------------------------------------------
char* GetName()
{
    if (!isalpha(lookahead)) Expected("Name");

    char name[256];
    int i = 0;

    while (isalnum(lookahead)) {
       name[i++] = lookahead;
       GetChar();
    }
    name[i++] = '\0';
    EatWhite();

    // heap allocate the result
    char *result = GcMalloc(i);
    strcpy(result, name);
    return result;
}

// --------------------------------------------------------------
//  Get a Number
// --------------------------------------------------------------
char* GetNum()
{
    if (!isdigit(lookahead)) Expected("Integer");

    char value[256]; // XXX hard limit
    int i = 0;

    while (isdigit(lookahead)) {
       value[i++] = lookahead;
       GetChar();
    }
    value [i++] = '\0';
    EatWhite();

    // heap allocate the result
    char *result = GcMalloc(i);
    strcpy(result, value);
    return result;
}

static bool IsBoolean(int token)
{
    return token == TrueToken || token == FalseToken;
}

// --------------------------------------------------------------
static bool GetBoolean()
{
    if (lookahead == TrueToken) {
        return true;
    }
    else if (lookahead == FalseToken) {
        return false;
    }
    else {
        Expected("Boolean literal");
    }
}


// --------------------------------------------------------------
//  Initialize
// --------------------------------------------------------------
void Init(char *s)
{
    parseString = s;
    GetChar();
    EatWhite();
}

//===============================================================
// Parser
//===============================================================

void Identifier(void)
{
    char *name = GetName();
    if (lookahead == '(') {
        // function call
        Match('(');
        //Expression(); // XXX not doing parameters yet
        char s[256];
        sprintf(s, "call\t%s", name);
        EmitLn(s);
        Match(')');
    }
    else {
        // variable reference
        char s[256];
        sprintf(s, "movl\t%s, %%eax", name);
        EmitLn(s);
        RegisterGlobal(name);
    }
}

//---------------------------------------------------------------
// factor ::= "(" expression ")"
//          | (variable ["(" expression ")"]
//          | number
//---------------------------------------------------------------
void Factor(void)
{
    void Expression(void);

    if (lookahead == '(') {
        Match('(');
        Expression();
        Match(')');
    }
    else if (isalpha(lookahead)) {
        Identifier();
    }
    else {
        char num[256];
        sprintf(num, "$%s", GetNum());
        EmitOp2("movl", num, "%eax");
    }
}

void SignedFactor(void)
{
    if (lookahead == '+') {
        GetChar();
    }
    else if (lookahead == '-') {
        GetChar();
        if (isdigit(lookahead)) {
            char negNum[256];
            sprintf(negNum, "$-%s", GetNum());
            EmitOp2("movl", negNum, "%eax");
        }
        else {
            Factor();
            EmitLn("negl %eax");
        }
    }
    else Factor();
}

//---------------------------------------------------------------
void Multiply(void)
{
    Match('*');
    Factor();
    EmitLn("popl\t%ebx");
    EmitLn("imul\t%ebx,%eax");
}

//---------------------------------------------------------------
void Divide(void)
{
    Match('/');
    Factor();
    EmitLn("movl\t%eax,%ebx");
    EmitLn("popl\t%eax");
    EmitLn("cltd");
    EmitLn("idiv\t%ebx,%eax");
}

//---------------------------------------------------------------
// Recnognise a "term"
//---------------------------------------------------------------
void Term(void)
{
    SignedFactor();
    while (lookahead == '*' || lookahead == '/') {
        EmitLn("pushl\t%eax");
        switch (lookahead) {
            case '*': Multiply(); break;
            case '/': Divide(); break;
        };
    }
}

//---------------------------------------------------------------
// Recognize and Translate an Add }
//---------------------------------------------------------------
void Add(void)
{
    Match('+');
    Term();
    EmitLn("popl\t%ebx");
    EmitLn("addl\t%ebx,%eax");
}

//---------------------------------------------------------------
// Recognize and Translate a Subtract
//---------------------------------------------------------------
void Subtract(void)
{
    Match('-');
    Term();
    EmitLn("popl\t%ebx");
    EmitLn("subl\t%ebx,%eax");
    EmitLn("negl\t%eax");
}

//---------------------------------------------------------------
bool IsAddOp()
{
    return lookahead == '+' || lookahead == '-';
}

//---------------------------------------------------------------
// Parse and Translate a Math Expression
//---------------------------------------------------------------
void Expression(void)
{
    Term();

    while (IsAddOp(lookahead)) {
        EmitLn("pushl\t%eax");
        switch (lookahead) {
            case '+': Add(); break;
            case '-': Subtract(); break;
        }
    }

}

static void BooleanTerm(void); // forward declaration

//---------------------------------------------------------------
// Implements short-cut || operator.
//---------------------------------------------------------------
void Or(void)
{
    Match(OrToken);
    BooleanTerm();

    char *trueLabel = NewLabel();
    char *endLabel = NewLabel();

    // compare first false/zero
    EmitLn("popl\t%ebx");  // pop value from stack into temp
    EmitLn("cmpl\t$0, %ebx");
    EmitOp1("jne", trueLabel);

    // compare second with false/zero
    EmitLn("cmpl\t$0, %eax");
    EmitOp1("jne", trueLabel);
    EmitOp1("jmp", endLabel);

    // load 1/true
    EmitLabel(trueLabel);
    EmitLn("movl\t$1, %eax");

    EmitLabel(endLabel);
}

//---------------------------------------------------------------
static bool IsRelOp()
{
    switch (lookahead) {
        case EqualsToken:
        case NotEqualsToken:
        case LessThanToken:
        case GreaterThanToken:
            return true;
        default: 
            return false;
    }
}

//---------------------------------------------------------------
void RelationalOperator(enum Token token, char *setInstruction)
{
    Match(token);
    Expression();
    EmitLn("popl\t%ebx");
    EmitLn("cmpl\t%ebx, %eax");
    EmitOp1(setInstruction, "al");
    EmitLn("movzbl\t%al, %eax");
}

//---------------------------------------------------------------
void Equals(void)
{
    RelationalOperator(EqualsToken, "sete");
}

//---------------------------------------------------------------
void NotEquals(void)
{
    RelationalOperator(NotEqualsToken, "setne");
}

//---------------------------------------------------------------
void LessThan(void)
{
    RelationalOperator(LessThanToken, "setl");
}

//---------------------------------------------------------------
void GreaterThan(void)
{
    RelationalOperator(GreaterThanToken, "setg");
}

//---------------------------------------------------------------
// relation ::= expression [relop expression]
//---------------------------------------------------------------
static void Relation(void)
{
    Expression();
    if (IsRelOp()) {
        EmitLn("push\t%eax");
        switch (lookahead) {
            case EqualsToken: Equals(); break;
            case NotEqualsToken: NotEquals(); break;
            case LessThanToken: LessThan(); break;
            case GreaterThanToken: GreaterThan(); break;
        }
    }
}

//---------------------------------------------------------------
static void BooleanFactor(void)
{
    if (IsBoolean(lookahead)) {
        if (GetBoolean()) {
            Match(TrueToken);
            EmitLn("movl\t$1, %eax");// could use -1 and then bitwize not is 0
        }
        else {
            Match(FalseToken);
            // XXX Is there a cheaper way to load zero?
            // XXX i.e. Something like CLR on 68000?
            EmitLn("movl\t$0, %eax"); 
        }
    }
    else Relation();
}

static void NotFactor(void)
{
    if (lookahead == '!') {
        Match('!');
        BooleanFactor();

        EmitLn("cmpl\t$0, %eax");
	EmitLn("sete\t%al");
	EmitLn("movzbl\t%al, %eax"); // XXX is this the movzx instruction?
    }
    else BooleanFactor();
}

//---------------------------------------------------------------
// Implements short-cut && operator.
//---------------------------------------------------------------
void And(void)
{
    Match(AndToken);
    NotFactor();

    char *falseLabel = NewLabel();
    char *endLabel = NewLabel();

    // compare first false/zero
    EmitLn("popl\t%ebx");  // pop value from stack into temp
    EmitLn("cmpl\t$0, %ebx");
    EmitOp1("je", falseLabel);

    // compare second with false/zero
    EmitLn("cmpl\t$0, %eax");
    EmitOp1("je", falseLabel);
    EmitOp1("jmp", endLabel);

    // load 0/false
    EmitLabel(falseLabel);
    EmitLn("movl\t$0, %eax");

    EmitLabel(endLabel);
}

void BooleanTerm(void)
{
    NotFactor();
    while (lookahead == AndToken) {
        EmitLn("pushl\t%eax");
        And();
    }
}

//---------------------------------------------------------------
void BooleanExpression(void)
{
    BooleanTerm();
    while (lookahead == OrToken) {
        EmitLn("push\t%eax");
        Or();
    }
}

//---------------------------------------------------------------
void Assignment(void)
{
    char *name = GetName();
    RegisterGlobal(name);
    Match('=');
    BooleanExpression();
    /*
    char op[256];
    sprintf(op, "movl %%eax, %s", name);
    EmitLn(op);
    */
    EmitOp2("movl", "%eax", name);
}

//---------------------------------------------------------------
void If(char *innermostLoopLabel)
{
    void Statement(char *innermostLoopLabel);

    Match(IF);
    char *label1 = NewLabel();
    char *label2 = label1;
    BooleanExpression();

    // skip if condition not true
    {
        char op[256];
        sprintf(op, "je\t%s\n", label1);
        Emit(op);
    }
    Statement(innermostLoopLabel);

    if (lookahead == ELSE) {
        Match(ELSE);
        label2 = NewLabel();
        {
            char op[256];
            sprintf(op, "jmp\t%s", label2);
            EmitLn(op);
        }
        EmitLabel(label1);
        Statement(innermostLoopLabel);
    }

    EmitLabel(label2);
}

//---------------------------------------------------------------
void While()
{
    void Statement(char *innermostLoopLabel);

    Match(WHILE);
    char *conditionLabel = NewLabel();
    EmitLabel(conditionLabel);
    BooleanExpression();

    char *endLabel = NewLabel();
    // terminate loop if condition is not true (i.e. equals zero)
    EmitOp1("je", endLabel);
    Statement(endLabel);
    EmitOp1("jmp", conditionLabel);
    EmitLabel(endLabel);
}

//---------------------------------------------------------------
void DoWhile()
{
    void Statement(char *innermostLoopLabel);

    Match(DO);
    char *startLabel = NewLabel();
    char *endLabel = NewLabel();
    EmitLabel(startLabel);
    Statement(endLabel);
    Match(WHILE);
    BooleanExpression();
    EmitOp1("jne", startLabel);
    EmitLabel(endLabel);
}

//---------------------------------------------------------------
void Break(char* innermostLoopLabel)
{
    Match(BREAK);
    if (innermostLoopLabel == NULL) {
        Abort("break statement not within loop");
    }
    EmitOp1("jmp", innermostLoopLabel);
}

//---------------------------------------------------------------
void Statement(char* innermostLoopLabel)
{
    void Block(char *innermostLoopLabel);

    if (lookahead == '{') {
        Block(innermostLoopLabel);
    }
    else if (lookahead == IF) {
        If(innermostLoopLabel);
    }
    else if (lookahead == WHILE) {
        While();
    }
    else if (lookahead == DO) {
        DoWhile();
    }
    else if (lookahead == BREAK) {
        Break(innermostLoopLabel);
    }
    else {
        Assignment();
    }
}

void Statements(char *innermostLoopLabel)
{
    while (lookahead == IF || lookahead == WHILE || 
           lookahead == DO || lookahead == BREAK ||
           isalpha(lookahead))
    {
        Statement(innermostLoopLabel);
    }
}

//---------------------------------------------------------------
void Block(char *innermostLoopLabel)
{
    Match('{');
    Statements(innermostLoopLabel);
    Match('}');
}

//---------------------------------------------------------------
void EmitFunctionPreamble(char *name)
{
    printf(".globl %s\n", name);
    printf("\t.type\t%s, @function\n", name);
    printf("%s:\n", name);

    // function preamble
    EmitLn("pushl\t%ebp");
    EmitLn("movl\t%esp, %ebp");
}

//---------------------------------------------------------------
void EmitFunctionPostamble(char *name)
{
    EmitLn("popl\t%ebp");
    EmitLn("ret");
    {
        char op[256];
        sprintf(op, ".size\t%s, .-%s", name, name);
        EmitLn(op);
    }

}

//---------------------------------------------------------------
void EmitGlobalVariableDefinitions(void)
{
    for (int i = 0; i < numGlobals; ++i) {
        char op[256];
        sprintf(op, ".comm\t%s,4,4", globalNames[i]);
        EmitLn(op);
    }
}

//---------------------------------------------------------------
void Top(void)
{
    EmitFunctionPreamble("expression");

    if (lookahead == '{') {
        Block(NULL);
    }
    else {
        Statements(NULL);
    }

    EmitFunctionPostamble("expression");
    EmitGlobalVariableDefinitions();

    Match('\0'); // end of stream
}

/*
//---------------------------------------------------------------
void BooleanTop(void)
{
    EmitFunctionPreamble("expression");

    BooleanExpression();

    EmitFunctionPostamble("expression");
    EmitGlobalVariableDefinitions();

    Match('\0'); // end of stream
}
*/

// --------------------------------------------------------------
//  Main Program
// --------------------------------------------------------------
int main(int argc, char*argv[])
{
    if (argc != 2) {
        fprintf(stderr, "usage: superc \"<expression>\"\n");
        exit(2);
    }
    Init(argv[1]);
    Top();

    return 0;
}
