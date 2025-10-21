#include<stdio.h>

int main () 
{
    int size = 5;
    int t[size];

    int a;
    int* p = &a;
    p = &(int)p;
    printf("cim: %p, érték: %d\n", p, *p);

    int a = 7;
    int b = 15;
    int* p = &a;
    int** pp = &p;
    *pp = &b;

    printf("cim: %p, érték: %d\n", p, *p);
    *pp = &b;
    printf("cim: %p, érték: %d\n", p, *p);
    *p = &b;

    printf("a értéke: %d\n", a);
    printf("b értéke: %d\n", b);
}