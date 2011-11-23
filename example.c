#include <stdio.h>

void expression(){int b; int a; b = 9; a=8; }

void FunctionWith1Local(void)
{
    int a;
    printf("FunctionWith1Local: a = %d\n", a);
}

void FunctionWith2Local(void)
{
    int a;
    int b;
    printf("FunctionWith2Local: a = %d\n", a);
    printf("FunctionWith2Local: b = %d\n", b);
}

void FunctionWithxLocals(void)
{
    int a = 10;
    int b = 20;
    int c = 30;
    int d = 40;
    int e = 50;
    printf("FunctionWith3Local: a = %d\n", a);
    printf("FunctionWith3Local: b = %d\n", b);
    printf("FunctionWith3Local: c = %d\n", c);
    printf("FunctionWith3Local: d = %d\n", d);
    printf("FunctionWith3Local: e = %d\n", e);
}

void Func1(int a)
{
    printf("%d\n", a);
}

void Func2(int a, int b)
{
    printf("%d\n", a);
    printf("%d\n", b);
}

void Func3(int a, int b, int c)
{
    printf("%d\n", a);
    printf("%d\n", b);
    printf("%d\n", c);
}

void CallFunc1(void)
{
    Func1(99);
}

void CallFunc2(void)
{
    Func2(98, 99);
}

void CallFunc3(void)
{
    Func3(97, 98, 99);
}

int Equals(int a, int b)
{
    return a == b;
}

int NotEquals(int a, int b)
{
    return a != b;
}

int LessThan(int a, int b)
{
    return a < b;
}

int GreaterThan(int a, int b)
{
    return a > b;
}

int Not(int a)
{
    return !a;
}

int Or(int a, int b)
{
    return a || b;
}

int And(int a, int b)
{
    return a && b;
}

int Add(int a, int b)
{
    return a + b;
}

int Sub(int a, int b)
{
    return a - b;
}

int Negate(int n)
{
    return -n;
}

void If(int a)
{
    if (a)
        printf("a == 10\n");
    else
        printf("a != 10\n");
}

void Callee(void)
{
    printf("Hello World!\n");
}

void Call(void)
{
    Callee();
}

int main(void)
{
    printf("%d\n", 88 || 78);
    printf("%d\n", Or(88,78));

    FunctionWith1Local();
    FunctionWith2Local();
    FunctionWithxLocals();

    return 0;
}

