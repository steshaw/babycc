/**
 *
 * eax is used as the "accumulator" register
 * ebx is used as the "temporary" register (used to get store value from the 
 *                                          expression stack)
 *
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
// factor ::= "(" expression ")" | number
//---------------------------------------------------------------
void Factor(void)
{
    void Expression(void );

    if (lookahead == '(') {
        Match('(');
        Expression();
        Match(')');
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
            default: Expected("'*' or '/'");
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
// Recognize and Translate a Subtract }
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
void EmitPreamble(void)
{
    printf(".globl expression\n");
    printf("\t.type\texpression, @function\n");
    printf("expression:\n");

    // function preamble
    EmitLn("pushl\t%ebp");
    EmitLn("movl\t%esp, %ebp");
}

//---------------------------------------------------------------
void EmitPostamble(void)
{
    EmitLn("pop\t%ebp");
    EmitLn("ret");
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
            default: Expected("'+' or '-'");
        }
    }

}

//---------------------------------------------------------------
void Top(void)
{
    EmitPreamble();

    Expression();

    EmitPostamble();

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
