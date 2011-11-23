#include <stdio.h>

int f()
{
    return 101;
}

extern int expression();

int main()
{
    printf("%d\n", expression());
    return 0;
}
