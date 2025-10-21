#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX 10

int main()
{
    // 1970 óta eltelt másodpercek
    // printf("%d\n", time(NULL));

    // srand(1);   // Ez egy seed-et ad
    // printf("%d\n", rand());     // A seed alapján generál egy számot, ha többször lefuttatom, minden alkalommal ugyanazt fogja kiadni
    
    // Csak egyszer szabad meghívni, hogy működjön a kód
    // srand(time(NULL));
    // printf("%d\n", rand());

    /*
    1. FELADAT:
    6 oldalú kocka dobások szimmulálása
    */
    // srand(time(NULL));
    // printf("%d\n", (rand() % 6) + 1);       // 1-6 terjedő random számot ad vissza

    /*
    2. FELADAT
    Kitalálós játék:
        Ha kisebb -> kiírja hogy kisebb a szám
        Ha nagyobb -> kiírja hogy nagyobb a szám
        Ha eltalálta -> kiírja hogy gratulálunk és leáll a program
    */
    //srand(time(NULL));

    //int randomszam = (rand() % 10) + 1;

    //int probalkozas;
    //int probalkozasok_szama;
    //while (probalkozas != randomszam) {

    //    printf("1-10-ig tippelj egy számot: ");
    //    scanf("%d", &probalkozas);      // Beolvasásnál ronthatja a programot, ha a végére teszek egy sortörést!!!

    //    if(probalkozas > randomszam) {
    //        printf("A szám amire gondoltam ennél kisebb!\n");
    //    } else if(probalkozas < randomszam) {
    //        printf("A szám amire gondoltam ennél nagyobb!\n");
    //    } else {
    //        printf("Gratulálok, eltaláltad!\n");
    //    }

    //    ++probalkozasok_szama;
    //}

    //switch (MAX / probalkozasok_szama) {
    //    case 0: printf("Nagyon jó voltál\n"); break;
    //    case 1: printf("Átlagos voltál\n"); break;
    //    default: printf("Nagyon rossz voltál\n"); break;
    //}


    /*
    3. FELADAT:
    Szökőév-e
    */
    int ev;

    printf("Adj meg egy évszámot: ");
    scanf("%d", &ev);

    bool szokoev_e = (ev % 4 == 0 && ev % 100 != 0) || ev % 400 == 0;
    switch ((int) szokoev_e) {
        case 1: printf("A megadott év szökőév!\n"); break;
        default: printf("A megadott év NEM szökőév!\n");
    }

    return 0;
}