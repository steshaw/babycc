long test(unsigned int ui, int i, short s, unsigned short us,
          char c, unsigned char uc, long l, unsigned long ul,
          int x, short y)
{
    char c1;
    int i1;
    char c2;

    ui = 1;
    i = 2;
    s = 3;
    us = 4;
    c = 5;
    uc = 6;
    l = 7;
    ul = 8;
    x = 9;
    y = 10;
    c1 = 11;
    c2 = 12;
    i1 = 13;
    return c2;
}

char ret;
int x=100;

int main(int argc, char **argv, char **envp)
{
    unsigned char uc;
    static short y = 99;
    short s;
    char c;
    unsigned short us;
    static int i;
    unsigned int ui;
    long l;
    unsigned long ul;

    ret = test(ui, i, s, us, c, uc, l, ul, x, y);
    return 0;
}
