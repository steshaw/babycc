#include <stdio.h>

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
