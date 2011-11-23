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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef int bool;

//===============================================================
// Lexer
//===============================================================

//---------------------------------------------------------------
//  Variable Declarations
//---------------------------------------------------------------
char *parseString;
int i = 0;
char lookahead;
int numGlobals = 0;
char globalNames[256]; // XXX hard limit :-(

//---------------------------------------------------------------
// Add global to globalNames array for later emission in the 
// postamble.
//---------------------------------------------------------------
void RegisterGlobal(char c)
{
    // return if registered already
    for (int i = 0; i < numGlobals; ++i) {
        if (globalNames[i] == c) return;
    }

    // register
    globalNames[numGlobals] = c;
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


///---------------------------------------------------------------
///  Read New Character From Input Stream
///---------------------------------------------------------------
void GetChar(void)
{
   //lookahead = getchar();
   lookahead = parseString[i];
   ++i;
}

// --------------------------------------------------------------
//  Report an Error
// --------------------------------------------------------------
void Error(char *s)
{
    fprintf(stderr, "\nError: %s.\n", s);
}

// --------------------------------------------------------------
//  Report Error and Halt
// --------------------------------------------------------------
void Abort(char *s)
{
   Error(s);
   abort();
}

// --------------------------------------------------------------
//  Report What Was Expected
// --------------------------------------------------------------
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
void Match(char c)
{
    if (lookahead == c) {
        GetChar();
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
//  XXX identifier is a single character!!!
// --------------------------------------------------------------
char GetName()
{
   if (!isalpha(lookahead)) Expected("Name");

   char result = tolower(lookahead);
   GetChar();
   return result;
}

// --------------------------------------------------------------
//  Get a Number
// --------------------------------------------------------------
char GetNum()
{
   if (!isdigit(lookahead)) Expected("Integer");

   char result = lookahead;
   GetChar();
   return result;
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

// --------------------------------------------------------------
//  Initialize
// --------------------------------------------------------------
void Init(char *s)
{
    parseString = s;
    GetChar();
}

//===============================================================
// Parser
//===============================================================


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
        char name = GetName();
        if (lookahead == '(') {
            // function call
            Match('(');
            //Expression(); // XXX not doing parameters yet
            char s[256];
            sprintf(s, "call\t%c", name);
            EmitLn(s);
            Match(')');
        }
        else {
            // variable reference
            char s[256];
            sprintf(s, "movl\t%c, %%eax", name);
            EmitLn(s);
            RegisterGlobal(name);
        }
    }
    else {
        char s[256];
        sprintf(s, "movl\t$%c, %%eax", GetNum());
        EmitLn(s);
    }
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
    Factor();
    while (lookahead == '*' || lookahead == '/') {
        EmitLn("push\t%eax");
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
    if (IsAddOp(lookahead)) {
        EmitLn("movl\t$0,%eax");
    }
    else Term();

    while (IsAddOp(lookahead)) {
        EmitLn("push\t%eax");
        switch (lookahead) {
            case '+': Add(); break;
            case '-': Subtract(); break;
        }
    }

}

//---------------------------------------------------------------
void Assignment(void)
{
    char name = GetName();
    RegisterGlobal(name);
    Match('=');
    Expression();
    char op[256];
    sprintf(op, "movl %%eax, %c", name);
    EmitLn(op);
    /*
    EmitLn('LEA ' + Name + '(PC),A0');
    EmitLn('MOVE D0,(A0)')
    */
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
    EmitLn("pop\t%ebp");
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
        sprintf(op, ".comm\t%c,4,4", globalNames[i]);
        EmitLn(op);
    }
}

//---------------------------------------------------------------
void Top(void)
{
    EmitFunctionPreamble("expression");
    Assignment();
    EmitFunctionPostamble("expression");

    EmitGlobalVariableDefinitions();

    Match('\0'); // end of stream
}

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
