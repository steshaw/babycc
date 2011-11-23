int a;
int b;

int c(void)
{
    return 10*b;
}

int expression(void)
{
    a = 2;
    b = 3;

    return a*c();
}
