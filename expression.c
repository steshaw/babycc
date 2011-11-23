#include <stdio.h>

int a;
int b;

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
