#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

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


// --------------------------------------------------------------
//  Read New Character From Input Stream
// --------------------------------------------------------------
void GetChar()
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
void Term()
{
    char s[256];
    sprintf(s, "movl\t$%c, %%eax", GetNum());
    EmitLn(s);
}

//---------------------------------------------------------------
// Recognize and Translate an Add }
//---------------------------------------------------------------
void Add()
{
   Match('+');
   Term();
   EmitLn("addl\t%ebx,%eax");
}

//---------------------------------------------------------------
// Recognize and Translate a Subtract }
//---------------------------------------------------------------
void Subtract()
{
   Match('-');
   Term();
   EmitLn("subl\t%ebx,%eax");
   EmitLn("negl\t%eax");
}

//---------------------------------------------------------------
void EmitPreamble()
{
    printf(".globl expression\n");
    printf("\t.type\texpression, @function\n");
    printf("expression:\n");

    // function preamble
    EmitLn("pushl\t%ebp");
    EmitLn("movl\t%esp, %ebp");
}

//---------------------------------------------------------------
void EmitPostamble()
{
    EmitLn("popl\t%ebp");
    EmitLn("ret");
}

//---------------------------------------------------------------
// Parse and Translate a Math Expression
//---------------------------------------------------------------
void Expression()
{
    EmitPreamble();

    Term();
    while (lookahead == '+' || lookahead == '-') {
        EmitLn("movl\t%eax,%ebx");
        switch (lookahead) {
            case '+': Add(); break;
            case '-': Subtract(); break;
            default: Expected("'+' or '-'");
        }
    }

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
    Expression();

    return 0;
}
