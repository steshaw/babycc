#include <stdio.h>
#include <limits.h>

/*
char
AddChar(char a, char b)
{
    return a + b;
}
*/

int
AddInt(int a, int b)
{
    return a + b;
}

void foo(void)
{
    AddInt(10, 12);
    AddInt(10, 12);
}

/*
char g_c;
signed char g_sc;
unsigned char g_uc;
*/

int main(int argc, char* argv[], char *argp[])
{
    /*
    char c = AddChar('A', 'B');
    printf("A = %d\n", 'A');
    printf("B = %d\n", 'B');
    printf("'%c' %d\n", c, (int)c);
    g_c = 'A';
    g_sc = g_c;
    g_uc = g_c;
    printf("---%c-%c-%c\n", g_c, g_sc, g_uc);
    */

    foo();
}
