void expression(){int b; int a; b = 9; a=8; }

void FunctionWith1Local(void)
{
    int a;
    //printf("FunctionWith1Local: a = %d\n", a);
    printi(a);
    println();
}

void FunctionWith2Local(void)
{
    int a;
    int b;
    //printf("FunctionWith2Local: a = %d\n", a);
    printi(a);
    //printf("FunctionWith2Local: b = %d\n", b);
    println();
}

void FunctionWithxLocals(void)
{
    int a = 10;
    int b = 20;
    int c = 30;
    int d = 40;
    int e = 50;
    //printf("FunctionWith3Local: a = %d\n", a);
    printi(a);
    println();
    //printf("FunctionWith3Local: b = %d\n", b);
    printi(b);
    println();
    //printf("FunctionWith3Local: c = %d\n", c);
    printi(c);
    println();
    //printf("FunctionWith3Local: d = %d\n", d);
    printi(d);
    println();
    //printf("FunctionWith3Local: e = %d\n", e);
    printi(e);
    println();
}

void Func1(int a)
{
    //printf("%d\n", a);
    printi(a);
    println();
}

void Func2(int a, int b)
{
    //printf("%d\n", a);
    printi(a);
    println();
    //printf("%d\n", b);
    printi(b);
    printi(a);
}

void Func3(int a, int b, int c)
{
    //printf("%d\n", a);
    printi(a);
    println();
    //printf("%d\n", b);
    printi(b);
    println();
    //printf("%d\n", c);
    printi(c);
    println();
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
        println();
        //printf("a == 10\n");
    else
        println();
        //printf("a != 10\n");
}

void Callee(void)
{
    //printf("Hello World!\n");
    println();
}

void Call(void)
{
    Callee();
}

int main(void)
{
    printi(88 || 78);
    println();
    printi(Or(88, 78));
    println();
    //printf("%d\n", 88 || 78);
    //printf("%d\n", Or(88,78));

    //FunctionWith1Local();
    //FunctionWith2Local();
    //FunctionWithxLocals();

    return 0;
}
