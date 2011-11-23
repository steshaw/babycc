# 1 "tests/while.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "tests/while.c"
int main()
{
    int i;
    i = 0;

    while (i < 10) {
        printi(i);
        println();

        i = i + 1;
    }
}
