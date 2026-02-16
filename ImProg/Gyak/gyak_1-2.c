#include <stdio.h>

int main()
{
    int a;
    printf("a: %d\n", a);     // Nem inicializált változó értéke: random érték

    const int b = 10;        // Nem változtatható érték
    printf("b: %d\n", b);
    if (b % 2 == 0)
    {
        printf("The number is even.\n");
    }
    else 
    {
        printf("The number is odd.\n");
    }

    printf("The number is %s\n", (b % 2 == 0) ? "even." : "odd.");     // Ternary operator



    int number;
    do {
        printf("Enter a number: ");
        scanf("%d", &number);
    }
    while (number % 2 == 0);     // Do-while ciklus: legalább egyszer lefut, majd ellenőrzi a feltételt


    printf("Avg of 5 and 6: %.2f\n", (5 + 6) / 2.);     // Átlag számítása: osztásnál float típus használata a pontos eredményért

    return 0;
}