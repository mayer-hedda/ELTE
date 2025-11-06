#include<stdio.h>
#include "my_utils.h"


void szamlalo() {
    static int szamlalo = 0;
    szamlalo = osszead(szamlalo, 1);
    printf("A szamlalo erteke: %d\n", szamlalo);
}

int osszead(int a, int b) {
    return a + b;
}

void swap(int* a, int* b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

int* bigger(int* a, int* b) {
    if (*a > *b) {
        return a;
    } else if (*b > *a) {
        return b;
    }
    return NULL;
}