#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#define SIZE 10

int main(void) {
    /*char* str = get_str("gandalf.txt");
    printf("%s\n", str);
    free(str);*/

    /*int t1[SIZE];
    int* t2 = malloc(SIZE * sizeof(int));

    for (int i = 0; i < SIZE; i++) {
        t1[i] = i;
        t2[i] = i;
    }

    free(t2);*/

    int sorok;
    char** v = vers("vers.txt", &sorok);
    for (int i = 0; i < sorok; i++) {
        printf("%s", v[i]);
        free(v[i]);
    }

    free(v);

    return 0;
}