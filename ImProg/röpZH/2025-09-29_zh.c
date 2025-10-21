/*
Frodó és Samu elindultak nagy kaladjukra a Megyétől a Pajkos Póniig.

Egyszer csak Samu megáll és azt mondja: "Még soha nem voltam ilyen messze a megyétől."
Majd lép egyet és megismétli. Újra és újra, amig el nem érnek céljukhoz.

Hányszor mondta el a szövegét Samu?

Samu az alábbi kódot használta:

#include<stdio.h>
#define LEPESEK 4759
int main()
{
    int i;
    for(i = 0; i <= LEPESEK; ++i)
    {
        printf("Még soha nem voltam ilyen messze a megyétől.");
    }
    return 0;
}
*/
#include<stdio.h>
#define LEPESEK 4759
int main()
{
    int szamlalo = 0;
    int i;
    for(i = 0; i <= LEPESEK; ++i)
    {
        szamlalo++;
        // printf("Még soha nem voltam ilyen messze a megyétől.");
    }
    printf("%d", szamlalo);
    return 0;
}