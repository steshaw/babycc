//
// superc - Super C Compiler
//
// eax is used as the "accumulator" register
// ebx is used as the "temporary" register (used to get store value from the
//     expression stack).
//
// Need one register for swapping in div operator. (ebx)
// Need one register for function calls.
//
// The rest could be used as a faster "expression stack".
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>
#include <assert.h>

typedef enum {
    IfToken = 256, // Start after the ascii characters 0-255
    ElseToken,
    WhileToken,
    DoToken,
    BreakToken,

    OrToken,
    AndToken,

    EqualsToken,
    NotEqualsToken,

    IdentifierToken,
    NumberToken,

    IntToken,
    VoidToken,
} Token;

//---------------------------------------------------------------
//  Variable Declarations
//---------------------------------------------------------------
static char* parseString;
static int pos = 0;
static int lookahead;
static int numGlobals = 0;
static char* globalNames[256]; // XXX hard limit :-(
static char globalTypes[256];   // XXX hard limit :-(

// number of parameters only stored here for functions (not variables)
static int globalNumParams[256];   // XXX hard limit :-(

// number of parameters and locals (XXX little bit weird)
static int g_numParamsAndLocals = 0;
static int g_localDeclarations = 0;
// used to calculate offset
static int g_base = 0;
static char* g_paramNames[256]; // XXX hard limit :-(
//static char parameterTypes[256];   // XXX currently all integer

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

// --------------------------------------------------------------
/// clear the accumulator
// --------------------------------------------------------------
void EmitClear(void)
{
    // XXX Is there a cheaper way to load zero?
    // XXX i.e. Something like CLR on 68000?
    EmitLn("movl\t$0, %eax");
}

void EmitNegate(void)
{
    EmitLn("negl\t%eax");
}

void EmitNot(void)
{
    EmitLn("cmpl\t$0, %eax");
    EmitLn("sete\t%al");
    EmitLn("movzbl\t%al, %eax"); // XXX This isn't the movx instruction.
                                 // XXX What is it?
                                 // XXX Can't find it in the Intel manual.
}

void EmitLoadConst(char *num)
{
    char constant[256]; // FIXME yuk
    sprintf(constant, "$%s", num);
    EmitOp2("movl", constant, "%eax");
}

void EmitLoadTrue()
{
    EmitLoadConst("1"); // XXX could be a faster way of loading 1?
}

void EmitLoadFalse()
{
    EmitClear();
}

void EmitLoadVar(char *name)
{
    EmitOp2("movl", name, "%eax");
}

void EmitPush(void)
{
    EmitLn("pushl\t%eax");
}

void EmitPopAdd(void)
{
    EmitLn("popl\t%ebx");
    EmitLn("addl\t%ebx,%eax");
}

void EmitPopSub(void)
{
    EmitLn("popl\t%ebx");
    EmitLn("subl\t%ebx,%eax");
    EmitLn("negl\t%eax");
}

void EmitPopMul(void)
{
    EmitLn("popl\t%ebx");
    EmitLn("imul\t%ebx,%eax");
}

void EmitPopDiv(void)
{
    EmitLn("movl\t%eax,%ebx");
    EmitLn("popl\t%eax");
    EmitLn("cltd");
    EmitLn("idiv\t%ebx,%eax");
}

void EmitPopBranchTrue(char *label)
{
    EmitLn("popl\t%ebx");  // pop value from stack into temp
    EmitLn("cmpl\t$0, %ebx");
    EmitOp1("jne", label);
}

void EmitPopBranchFalse(char *label)
{
    EmitLn("popl\t%ebx");  // pop value from stack into temp
    EmitLn("cmpl\t$0, %ebx");
    EmitOp1("je", label);
}

void EmitBranchFalse(char *label)
{
    EmitLn("cmpl\t$0, %eax");
    EmitOp1("je", label);
}

void EmitBranchTrue(char *label)
{
    EmitOp2("cmpl", "$0", "%eax");
    EmitOp1("jne", label);
}

void EmitBranch(char *label)
{
    EmitOp1("jmp", label);
}

#define PRIVATE
#define PUBLIC

PRIVATE void EmitRelationalOperator(char *setInstruction)
{
    EmitLn("popl\t%ebx");
    EmitLn("cmpl\t%ebx, %eax");
    EmitOp1(setInstruction, "al");
    EmitLn("movzbl\t%al, %eax");
}

//---------------------------------------------------------------
PUBLIC void EmitEquals(void)
{
    EmitRelationalOperator("sete");
}

//---------------------------------------------------------------
PUBLIC void EmitNotEquals(void)
{
    EmitRelationalOperator("setne");
}

//---------------------------------------------------------------
PUBLIC void EmitLessThan(void)
{
    EmitRelationalOperator("setl");
}

//---------------------------------------------------------------
PUBLIC void EmitGreaterThan(void)
{
    EmitRelationalOperator("setg");
}

PUBLIC void EmitStore(char *var)
{
    EmitOp2("movl", "%eax", var);
}

PUBLIC void EmitCall(char *name)
{
    EmitOp1("call", name);
}

//---------------------------------------------------------------
// Calculate offset for Pascal calling convention.
//
// The implementation is affected by function call conventions.
// XXX Currently not using C calling convention.
// XXX C has topsy turvy convention to support vargs.
//---------------------------------------------------------------
PRIVATE int CalcParamOffset(int n, int totalParams)
{
    return (totalParams-n) * 4 + 4;
}

//---------------------------------------------------------------
PUBLIC void EmitLoadParam(int n)
{
    int offset = CalcParamOffset(n, g_base);

    char param[256]; // FIXME yuk
    sprintf(param, "%d(%%ebp)", offset);
    EmitOp2("movl", param, "%eax");
}

//---------------------------------------------------------------
PUBLIC void EmitStoreParam(int n)
{
    int offset = CalcParamOffset(n, g_base);

    char param[256]; // FIXME yuk
    sprintf(param, "%d(%%ebp)", offset);
    EmitOp2("movl", "%eax", param);
}

//---------------------------------------------------------------
PUBLIC void EmitFunctionPreamble(char *name, int numLocals)
{
    printf(".globl %s\n", name);
    printf("\t.type\t%s, @function\n", name);
    printf("%s:\n", name);

    // function preamble
    EmitLn("pushl\t%ebp");
    EmitLn("movl\t%esp, %ebp");

    char op[256];
    sprintf(op, "subl\t$%d, %%esp", numLocals*4);
    // XXX This should have a different value for different # locals.
    EmitLn(op);
}

//---------------------------------------------------------------
PUBLIC void EmitFunctionPostamble(char *name)
{
    //EmitLn("popl\t%ebp");
    EmitLn("leave");
    EmitLn("ret");
    {
        char op[256];
        sprintf(op, ".size\t%s, .-%s", name, name);
        EmitLn(op);
    }

}

typedef enum {
    VariableType,
    FunctionType,
} NameType;

//---------------------------------------------------------------
PUBLIC void EmitGlobalVariableDefinitions(void)
{
    for (int i = 0; i < numGlobals; ++i) {
        if (globalTypes[i] == VariableType) {
            EmitOp2(".comm", globalNames[i], "4,4");
        }
    }
}

//===============================================================
// Lexer
//===============================================================
static Token g_token;
static char *g_tokenValue;

///---------------------------------------------------------------
///  Read New Character From Input Stream
///---------------------------------------------------------------
void GetChar(void)
{
    lookahead = parseString[pos]; // was: "lookahead = getchar();"
    ++pos;
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
    fprintf(stderr, "Error: %s.\n", s);
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
    //fprintf(stderr, "current token = '%s' (%c)\n", g_tokenValue, g_token);
    const char *e = " expected";
    char *newString = GcMalloc(strlen(s) + strlen(e) + 1);
    strcpy(newString, s);
    strcat(newString, e);

    Abort(newString);
}

void UndefinedIdentifier(char *s) __attribute__ ((noreturn));
void UndefinedIdentifier(char *s)
{
    fprintf(stderr, "Undefined identifier '%s'\n", s);
    exit(1);
}

void DuplicateIdentifier(char *s)
{
    fprintf(stderr, "Duplicate identifier '%s'\n", s);
    exit(1);
}


int GlobalNameIndex(char *name)
{
    for (int i = 0; i < numGlobals; ++i) {
        if (strcmp(globalNames[i], name) == 0) return i;
        // XXX this could be inefficient - could replace with
        // XXX pointer equality if symbols are first "interned"
    }
    return numGlobals;
}

int ParamNameIndex(char *name)
{
    for (int i = 0; i < g_numParamsAndLocals; ++i) {
        if (strcmp(g_paramNames[i], name) == 0) return i;
        // XXX this could be inefficient - could replace with
        // XXX pointer equality if symbols are first "interned"
    }
    return numGlobals;
}


bool IsNameDefined(char *name, char *table[], int numEntries)
{
    for (int i = 0; i < numEntries; ++i) {
        if (strcmp(table[i], name) == 0) return true;
        // XXX this could be inefficient - could replace with
        // XXX pointer equality if symbols are first "interned"
    }
    return false;
}

bool IsGlobalNameDefined(char *name)
{
    return IsNameDefined(name, globalNames, numGlobals);
}

bool IsParamNameDefined(char *name)
{
    return IsNameDefined(name, g_paramNames, g_numParamsAndLocals);
}


//---------------------------------------------------------------
// Check variable is defined. 
//
// Returns true when global, false when param and not all all
// when not defined.
//---------------------------------------------------------------
bool CheckDefined(char *name)
{
    if (IsGlobalNameDefined(name)) {
        return true;
    }
    else if (IsParamNameDefined(name)) {
        return false;
    }
    else {
        UndefinedIdentifier(name);
    }
}

/*
 * Probably not need with C
 */
/*
void CheckVarDefined(char *name)
{
    int index = GlobalNameIndex(name);
    if (index == numGlobals) {
        UndefinedIdentifier(name);
    }
    else if (globalTypes[index] != VariableType) {
        fprintf(stderr, "%s should be a variable!\n", name);
        exit(1);
    }
}
*/


//---------------------------------------------------------------
// Add global to globalNames array for later emission in the 
// postamble.
//---------------------------------------------------------------
void RegisterGlobal(char *name, NameType type, int numParams)
{
    if (IsGlobalNameDefined(name)) {
        DuplicateIdentifier(name);
    }

    // register
    globalNames[numGlobals] = name;
    globalTypes[numGlobals] = type;
    globalNumParams[numGlobals] = numParams;
    ++numGlobals;
}

void RegisterParam(char *name)
{
    if (IsParamNameDefined(name)) {
        DuplicateIdentifier(name);
    }

    // register
    g_paramNames[g_numParamsAndLocals] = name;
    //g_paramTypes[g_numParamsAndLocals] = type;
    ++g_numParamsAndLocals;
}


typedef struct {
    char *keyword;
    int length;
    Token token;
} Keyword;

#define DEF_KEYWORD(kw, t) {kw, strlen(kw), t}

Keyword keywords[] = {
    DEF_KEYWORD("if", IfToken),
    DEF_KEYWORD("else", ElseToken),
    DEF_KEYWORD("while", WhileToken),
    DEF_KEYWORD("do", DoToken),
    DEF_KEYWORD("break", BreakToken),
    DEF_KEYWORD("int", IntToken),
    DEF_KEYWORD("void", VoidToken),
};


// calculate the size of a static array
#define ARRAYSIZE(x) (sizeof(x)/sizeof(*x))

//---------------------------------------------------------------
Token LookupKeyword(char *name)
{
    for (int i = 0; i < ARRAYSIZE(keywords); ++i) {
        if (strcmp(name, keywords[i].keyword) == 0) {
            return keywords[i].token;
        }
    }
    return -1;
}

Keyword operators[] = {
    DEF_KEYWORD("||", OrToken),
    DEF_KEYWORD("&&", AndToken),
    DEF_KEYWORD("==", EqualsToken),
    DEF_KEYWORD("!=", NotEqualsToken),
    DEF_KEYWORD("<", '<'),
    DEF_KEYWORD(">", '>'),
    DEF_KEYWORD("+", '+'),
    DEF_KEYWORD("-", '-'),
    DEF_KEYWORD("*", '*'),
    DEF_KEYWORD("/", '/'),
    DEF_KEYWORD("=", '='),
    DEF_KEYWORD("!", '!'),
};

bool IsOp()
{
    switch (lookahead) {
        case '+':
        case '-':
        case '*':
        case '/':
        case '<':
        case '>':
        case '|': 
        case '&':
        case '=':
        case '!':
            return true;
        default:
            return false;
    }
}

//---------------------------------------------------------------
void GetOperator(void)
{
    if (!IsOp(lookahead)) Expected("Operator");

    //LookupOperator(parseString+pos-1);
    char *s = parseString+pos-1;
    for (int i = 0; i < ARRAYSIZE(operators); ++i) {
        if (strncmp(s, operators[i].keyword, operators[i].length) == 0) {
            for (int j = 0; j < operators[i].length; ++j) {
                GetChar();
            }
            g_tokenValue = operators[i].keyword;
            g_token = operators[i].token;
            return;
        }
    }
    assert(false && "unreachable");
}

// --------------------------------------------------------------
//  Get an Identifier or Keyword
//
//  identifier ::= letter (letter|digit)*
// --------------------------------------------------------------
void GetName(void)
{
    if (!isalpha(lookahead)) Expected("Name");

    char name[256]; // FIXME
    int i = 0;

    do {
       name[i++] = lookahead;
       GetChar();
    }
    while (isalnum(lookahead));
    name[i++] = '\0';

    // heap allocate the result
    g_tokenValue = GcStrDup(name);

    Token keywordToken = LookupKeyword(g_tokenValue);
    if (keywordToken == -1) {
        g_token = IdentifierToken;
    }
    else g_token = keywordToken;
}

// --------------------------------------------------------------
//  Get a Number
//
//  number ::= digit+
// --------------------------------------------------------------
void GetNum(void)
{
    if (!isdigit(lookahead)) Expected("Integer");

    char value[256]; // FIXME hard limit + no-bounds checking
    int i = 0;

    do {
       value[i++] = lookahead;
       GetChar();
    }
    while (isdigit(lookahead));
    value [i++] = '\0';

    // heap allocate the result
    g_token = NumberToken;
    g_tokenValue = GcStrDup(value);
}

void Scan(void)
{
    EatWhite();
    if (isalpha(lookahead)) {
        GetName();
    }
    else if (isdigit(lookahead)) {
        GetNum();
    }
    else if (IsOp()) {
        GetOperator();
    }
    else if (lookahead == '{' || lookahead == '}' ||
             lookahead == '(' || lookahead == ')' ||
             lookahead == ',' || lookahead == ';')
    {
        g_token = lookahead;
        char *g_tokenValue = GcStrDup(" ");
        g_tokenValue[0] = lookahead;
        GetChar();
    }
    else if (lookahead == '\0') {
        g_token = lookahead;
        g_tokenValue = "EOS";
    }
    else {
        fprintf(stderr, "input character = '%c'\n", lookahead);
        Error("bad character in input");
    }
}

// --------------------------------------------------------------
//  Match a Specific Input Character
// --------------------------------------------------------------
void Match(int token)
{
    if (g_token == token) {
        Scan();
    }
    else if (token == '\0') {
        Expected("End of stream");
    }
    else {
        // FIXME - Need PrintToken here
        char s[] = "'_'";
        s[1] = token;
        Expected(s);
    }
}

// --------------------------------------------------------------
//  Initialize
// --------------------------------------------------------------
void Init(char *s)
{
    parseString = s;
    GetChar();
    Scan();

    for (int i = 0; i < 256; ++i) {
        g_paramNames[i] = "";
    }
}

//===============================================================
// Parser
//===============================================================

void BooleanExpression(void); // currently the top-level expression

void Param(void)
{
    BooleanExpression();
    EmitPush(); // FIXME - C needs to push in reverse order
}

//---------------------------------------------------------------
void FunctionCall(char *name)
{
    int numParams = 0;
    // function call
    Match('(');
    if (g_token != ')') {
        Param(); ++numParams;
        while (g_token == ',') {
            Match(',');
            Param(); ++numParams;
        }
    }
    Match(')');

    bool isGlobal = CheckDefined(name);

    // Check that parameters match.
    int index = GlobalNameIndex(name);
    if (numParams != globalNumParams[index]) {
        Abort("attempt call with incorrect number of arguments");
    }


    if (isGlobal) {
        EmitCall(name);
    }
    else {
        Abort("trying to call a variable - function types not yet supported");
    }
}

//---------------------------------------------------------------
void Identifier(void)
{
    char *name = g_tokenValue;
    Match(IdentifierToken);
    if (g_token == '(') {
        FunctionCall(name);
    }
    else {
        // variable reference
        bool isGlobal = CheckDefined(name);
        if (isGlobal) {
            EmitLoadVar(name);
        }
        else {
            int index = ParamNameIndex(name);
            EmitLoadParam(index);
        }
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

    if (g_token == '(') {
        Match('('); // could be Scan();
        Expression();
        Match(')');
    }
    else if (g_token == IdentifierToken) {
        Identifier();
    }
    else if (g_token == NumberToken) {
        EmitLoadConst(g_tokenValue);
        Match(NumberToken);
    }
    else {
        Expected("one of '(', <number>, <identifier>");
    }
}

void SignedFactor(void)
{
    if (g_token == '+') {
        Match('+');
    }
    else if (g_token == '-') {
        Match('-');
        if (g_token == NumberToken) {
            char negNum[256];
            sprintf(negNum, "-%s", g_tokenValue);
            EmitLoadConst(negNum);
            Match(NumberToken);
        }
        else {
            Factor();
            EmitNegate();
        }
    }
    else Factor();
}

//---------------------------------------------------------------
void Multiply(void)
{
    Match('*');
    Factor();
    EmitPopMul();
}

//---------------------------------------------------------------
void Divide(void)
{
    Match('/');
    Factor();
    EmitPopDiv();
}

//---------------------------------------------------------------
// Recnognise a "term"
//---------------------------------------------------------------
void Term(void)
{
    SignedFactor();
    while (g_token == '*' || g_token == '/') {
        EmitPush();
        switch (g_token) {
            case '*': Multiply(); break;
            case '/': Divide(); break;
            default:
                assert(false && "unreachable");
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
    EmitPopAdd();
}

//---------------------------------------------------------------
// Recognize and Translate a Subtract
//---------------------------------------------------------------
void Subtract(void)
{
    Match('-');
    Term();
    EmitPopSub();
}

//---------------------------------------------------------------
bool IsAddOp(Token token)
{
    return token == '+' || token == '-';
}

//---------------------------------------------------------------
// Parse and Translate a Math Expression
//---------------------------------------------------------------
void Expression(void)
{
    Term();

    while (IsAddOp(g_token)) {
        EmitPush();
        switch (g_token) {
            case '+': Add(); break;
            case '-': Subtract(); break;
            default:
                assert(false && "unreachable");
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

    EmitPopBranchTrue(trueLabel); // compare top-of-stack
    EmitBranchTrue(trueLabel);    // compare accumulator

    // If both values were false then skip to end as the accumulator 
    // already holds the false value.
    EmitBranch(endLabel);

    EmitLabel(trueLabel);
    EmitLoadTrue();

    EmitLabel(endLabel);
}

//---------------------------------------------------------------
static bool IsRelOp(Token token)
{
    switch (token) {
        case EqualsToken:
        case NotEqualsToken:
        case '<':
        case '>':
            return true;
        default: 
            return false;
    }
}

typedef void (*Emitter)(void);
//---------------------------------------------------------------
void RelationalOperator(Token token, Emitter emitter)
{
    Match(token);
    Expression();
    emitter();
}

//---------------------------------------------------------------
void Equals(void)
{
    RelationalOperator(EqualsToken, EmitEquals);
}

//---------------------------------------------------------------
void NotEquals(void)
{
    RelationalOperator(NotEqualsToken, EmitNotEquals);
}

//---------------------------------------------------------------
void LessThan(void)
{
    RelationalOperator('<', EmitLessThan);
}

//---------------------------------------------------------------
void GreaterThan(void)
{
    RelationalOperator('>', EmitGreaterThan);
}

//---------------------------------------------------------------
// relation ::= expression [relop expression]
//---------------------------------------------------------------
static void Relation(void)
{
    Expression();
    if (IsRelOp(g_token)) {
        EmitPush();
        switch (g_token) {
            case EqualsToken: Equals(); break;
            case NotEqualsToken: NotEquals(); break;
            case '<': LessThan(); break;
            case '>': GreaterThan(); break;
            default:
                assert(false && "unreachable");
        }
    }
}

//---------------------------------------------------------------
static void NotFactor(void)
{
    if (g_token == '!') {
        Match('!');
        Relation(); // was BooleanFactor();

        EmitNot();
    }
    else Relation();// was else BooleanFactor();
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

    // compare first false
    EmitPopBranchFalse(falseLabel);

    // compare second with false
    EmitBranchFalse(falseLabel);
    EmitLoadConst("1");
    EmitBranch(endLabel);

    EmitLabel(falseLabel);
    EmitLoadFalse();

    EmitLabel(endLabel);
}

//---------------------------------------------------------------
void BooleanTerm(void)
{
    NotFactor();
    while (g_token == AndToken) {
        EmitPush();
        And();
    }
}


//---------------------------------------------------------------
void BooleanExpression(void)
{
    BooleanTerm();
    while (g_token == OrToken) {
        EmitPush();
        Or();
    }
}

//---------------------------------------------------------------
void Assignment(void)
{
    char *name = g_tokenValue;
    Match(IdentifierToken);
    bool isGlobal = CheckDefined(name);
    Match('=');
    BooleanExpression();
    // variable reference
    if (isGlobal) {
        EmitStore(name);
    }
    else {
        int index = ParamNameIndex(name);
        EmitStoreParam(index);
    }
}

//---------------------------------------------------------------
void If(char *innermostLoopLabel)
{
    void Statement(char *innermostLoopLabel);

    Match(IfToken);
    char *label1 = NewLabel();
    char *label2 = label1;
    BooleanExpression();

    // skip if condition not true
    EmitBranchFalse(label1);
//    EmitOp1("je", label1); // FIXME the BranchFalse does cmpl too!!!!!!
    Statement(innermostLoopLabel);

    if (g_token == ElseToken) {
        Match(ElseToken);
        label2 = NewLabel();
        EmitBranch(label2);
        EmitLabel(label1);
        Statement(innermostLoopLabel);
    }

    EmitLabel(label2);
}

//---------------------------------------------------------------
void While()
{
    void Statement(char *innermostLoopLabel);

    Match(WhileToken);
    char *conditionLabel = NewLabel();
    EmitLabel(conditionLabel);
    BooleanExpression();

    char *endLabel = NewLabel();
    // terminate loop if condition is false
    EmitBranchFalse(endLabel); 
    // XXX EmitBranchFalse does cmpl!!!!!!!!!!!!!!!!!!!
    Statement(endLabel);
    EmitBranch(conditionLabel);
    EmitLabel(endLabel);
}

//---------------------------------------------------------------
void DoWhile()
{
    void Statement(char *innermostLoopLabel);

    Match(DoToken);
    char *startLabel = NewLabel();
    char *endLabel = NewLabel();
    EmitLabel(startLabel);
    Statement(endLabel);
    Match(WhileToken);
    BooleanExpression();
    EmitOp1("jne", startLabel);
    EmitLabel(endLabel);
}

//---------------------------------------------------------------
void Break(char* innermostLoopLabel)
{
    Match(BreakToken);
    if (innermostLoopLabel == NULL) {
        Abort("break statement not within loop");
    }
    EmitBranch(innermostLoopLabel);
}

//---------------------------------------------------------------
void Statement(char* innermostLoopLabel)
{
    void Block(char *innermostLoopLabel);

    if (g_token == '{') {
        Block(innermostLoopLabel);
    }
    else if (g_token == IfToken) {
        If(innermostLoopLabel);
    }
    else if (g_token == WhileToken) {
        While();
    }
    else if (g_token == DoToken) {
        DoWhile();
    }
    else if (g_token == BreakToken) {
        Break(innermostLoopLabel);
    }
    else {
        Assignment();
    }
    if (g_token == ';') {
        Match(';');
    }
}

void Statements(char *innermostLoopLabel)
{
    while (g_token == IfToken || g_token == WhileToken || 
           g_token == DoToken || g_token == BreakToken ||
           g_token == IdentifierToken)
    {
        Statement(innermostLoopLabel);
    }
}

void LocalDeclarations(void)
{
    g_localDeclarations = 0;
    while (g_token == IntToken) {
        Match(IntToken);
        char *name = g_tokenValue;
        Match(IdentifierToken);
        RegisterParam(name);
        ++g_localDeclarations;
        if (g_token == ';') {
            Match(';');
        }
    }
}

//---------------------------------------------------------------
void Block(char *innermostLoopLabel)
{
    Match('{');
    LocalDeclarations();
    Statements(innermostLoopLabel);
    Match('}');
}

typedef enum {
    Int,
    Void
} Type;


void FormalParam(void)
{
    char *name = g_tokenValue;
    Match(IdentifierToken);
    RegisterParam(name);
}

void FunctionDecl(char *name, Type type)
{
    // clear number of parameters in global param table
    g_numParamsAndLocals = 0;

    //FormalParameters();
    Match('(');
    if (g_token != ')') {
        FormalParam();
        while (g_token == ',') {
            Match(',');
            FormalParam();
        }
    }
    Match(')');

    g_base = g_numParamsAndLocals;
    g_numParamsAndLocals += 2; // XXX may be wrong

    // register before Block() for recursive function calls
    RegisterGlobal(name, FunctionType, g_base);

    // XXX This is a modified copy of Block() right here.
    // XXX It was necessary to delay EmitFunctionPreamble until
    // XXX the number of local variable is known.
    Match('{');
    LocalDeclarations();
    EmitFunctionPreamble(name, g_localDeclarations);
    Statements(NULL);
    Match('}');
    EmitFunctionPostamble(name);
    /*
    fprintf(stderr, "func %s(%d) : %s\n", name, g_numParams, 
            (type == Int)? "int" : "void");
    */
}

void VariableDecl(char *name, Type type)
{
    if (type == Void) {
        Abort("variable cannot be of type void");
    }
    //fprintf(stderr, "var %s : %s\n", name, (type == Int)? "int" : "void");
    RegisterGlobal(name, VariableType, -1);
    if (g_token == ';') {
        Match(';');
    }
}

//---------------------------------------------------------------
// root ::= type name
//---------------------------------------------------------------
void Root(void)
{
    while (g_token != '\0') {
        Type type;
        if (g_token == IntToken) {
            Match(IntToken);
            type = Int;
        }
        else if (g_token == VoidToken) {
            Match(VoidToken);
            type = Void;
        }
        else {
            Abort("expecting 'int' or 'void'");
        };

        char *name = g_tokenValue;
        Match(IdentifierToken);
        if (g_token == '(') {
            FunctionDecl(name, type);
        }
        else {
            VariableDecl(name, type);
        }

    }
    Match('\0');
    EmitGlobalVariableDefinitions();
}

// --------------------------------------------------------------
int main(int argc, char* argv[])
{
    if (argc != 2) {
        fprintf(stderr, "usage: superc \"<expression>\"\n");
        exit(2);
    }
    Init(argv[1]);
    Root();

    return 0;
}
