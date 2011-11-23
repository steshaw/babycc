#include <stdio.h>

int a;
int b;

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

int d(void)
{
    int a = 1;
    int b = 2;

    return a - -b;
}

int c(void)
{
    if (a == 10)
        printf("a == 10\n");
    else
        printf("a != 10\n");

    return 10*b;
}

int expression(void)
{
    a = 2;
    b = 3;

    return a*c();
}
