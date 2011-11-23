#include <stdio.h>

extern int expression();

void printi(int i) {
    printf("%d", i);
}

void prints(char *s) {
    printf("%s", s);
}

void println(void)
{
    putchar('\n');
}
