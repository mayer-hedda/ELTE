#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#define size 10
#define MAX 100

// int sum(int* t)      // Ennek majd utána akrok nézni
int sum(int t[size])
{
    int szamlalo = 0;
    for (int i = 0; i < size; i++)
    {
        szamlalo += t[i];
    }

    return szamlalo;
}

void foo(int a)
{
    a = 7;
}

int maxkeres(int t[size])
{
    int legnagyobb = t[0];
    for (int i = 0; i < size; i++)
    {
        if (t[i] > legnagyobb)
        {
            legnagyobb = t[i];
        }
    }

    return legnagyobb;
}

// FELADAT: 1-100-ig véletlen számokkal feltölti a tömbömet
void fillArray(int t[size])
{
    for (int i = 0; i < size; i++)
    {
        t[i] = (rand() % MAX) + 1;
    }
}

// FELADAT: súlyozott összegek
int sum_szorzo(int t1[size], int t2[size])
{
    int sum = 0;
    for (int i = 0; i < size; i++)
    {
        sum += t1[i] * t2[i];
    }

    return sum;
}

int main()
{
    srand(time(NULL));

    // --- TÖMBÖK ---
    // int t[3];    // A t a lista elejére mutat --> t[0] azt jelöli, hogy a legelső elemtől mennyit léptünk, ezért t[1] a második elem
    // t[0] = 7;
    // printf("%d\n", t[0]);

    // int t[size];

    // for (size_t i = 0; i < size; i++)
    // {
    //     t[i] = i;
    //     // printf("t[%d] = %d\n", i, t[i]);
    // }

    // FELADAT: Ciklus ami összeadja a tömb elemeit
    // int szamlalo = 0;
    // for (int i = 0; i < size; i++)
    // {
    //     szamlalo += t[i];
    // }

    // fillArray(t);
    // printf("A tömb értékeinek összege: %d\n", sum(t));
    // printf("A legnagyobb értéke a tömbbnek: %d\n", maxkeres(t));

    // int jegyek[size] = {4, 5, 2, 3, 4, 2, 5, 3, 4, 5};
    // int kreditek[size] = {1, 1, 2, 2, 3, 3, 4, 5, 4, 6};

    // printf("Súlyozott összeg: %d\n", sum_szorzo(jegyek, kreditek));

    // double valos_atlag = sum_szorzo(jegyek, kreditek) / (double)sum(kreditek);
    // double osztondij_atlag = sum_szorzo(jegyek, kreditek) / 30.0;

    // printf("A valós átlag: %lf\n", valos_atlag);
    // printf("Az ösztöndíj átlag: %lf\n", osztondij_atlag);

    char* str = "almafa";

    // scanf("%s", str);
    // printf("%s\n", str);

    while(*str != '\0')
    {
        printf("%c", *str);
        ++str;
    }

    return 0;
}