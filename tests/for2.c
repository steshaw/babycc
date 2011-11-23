int main()
{
    int i;
    int j;

    prints("before\n")

    for (i = 0; i < 2; i = i + 1) {
        prints("in first for\n");
        for (j = 1; j < 11; j = j + 1) {
            prints("in second for\n")
            printi(j);
            println();
        }
    }
}
