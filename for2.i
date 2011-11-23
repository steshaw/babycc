# 1 "tests/for2.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "tests/for2.c"
int main()
{
    int i;
    int j;

    prints("before\n");

    for (i = 0; i < 2; i = i + 1) {
        for (j = 1; j < 11; j = j + 1) {
            printi(j);
            println();
        }
    }
}
