#include<stdio.h>

int main()
{
    // 1. Olvass be két számot, végezd el rajtuk az összes aritmetikai műveletet: *, +, -, /, %.
    int a, b;
    printf("Adj meg ket szamot: ");
    scanf("%d %d", &a, &b);
    printf("Osszeadás: %d\n", a + b);
    printf("Kivonás: %d\n", a - b);
    printf("Szorzás: %d\n", a * b);
    if (b != 0) {
        printf("Osztás: %d\n", a / b);
        printf("Maradék: %d\n", a % b);
    } else {
        printf("Nem lehet osztani nullával!\n");
    }


    // 2. Olvass be egy dátumot egybeírva: 20260223, és írd ki más formátumban: 2026.02.23.
    int datum;
    printf("Adj meg egy dátumot egybeírva (pl. 20260223): ");
    scanf("%d", &datum);
    int ev = datum / 10000;
    int honap = (datum / 100) % 100;
    int nap = datum % 100;
    printf("Datum: %d.%02d.%02d.\n", ev, honap, nap);


    // 3. Cserélj ki két számot csupán aritmetikai műveletek segítségével.
    int x, y;
    printf("Adj meg ket szamot (x es y): ");
    scanf("%d %d", &x, &y);
    printf("Eredeti ertekek: x = %d, y = %d\n", x, y);
    x = x + y; // x most a ket szam osszege
    y = x - y; // y most az eredeti x erteke
    x = x - y; // x most az eredeti y erteke
    printf("Csere utan: x = %d, y = %d\n", x, y);


    // 4. Állapítsd meg, hogy két vektor merőleges-e egymásra.
    int v1x, v1y, v2x, v2y;
    printf("Adj meg két vektort (v1x v1y v2x v2y): ");
    scanf("%d %d %d %d", &v1x, &v1y, &v2x, &v2y);
    int skalarszorzat = v1x * v2x + v1y * v2y;
    if (skalarszorzat == 0) {
        printf("A vektorok merőlegesek egymásra.\n");
    } else {
        printf("A vektorok nem merőlegesek egymásra.\n");
    }

    return 0;
}