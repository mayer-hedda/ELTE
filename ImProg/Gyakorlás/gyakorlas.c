#include <stdio.h>

int main() {
    // // 1. feladat:
    // int myAge = 23;
    // char myFavoriteLetter = 'H';

    // printf("%d éves vagyok és a kedvenc betűm a(z) %c.\n", myAge, myFavoriteLetter);


    // // 2. feladat:
    // int jelszo = 1234;
    // int tipp;

    // printf("Add meg a jelszót: ");
    // scanf("%d", &tipp);

    // if (tipp == jelszo) {
    //     printf("Helyes jelszó! Hozzáférés engedélyezve.");
    // } else {
    //     printf("Hibás jelszó!");
    // }


    // 3. feladat:
    int jelszo = 1234;
    int tipp;

    while (tipp != jelszo) {
        printf("Add meg a jelszót: ");
        scanf("%d", &tipp);

        if (tipp == jelszo) {
            printf("Siker!");
        } else {
            printf("Rossz jelszó! Próbáld újra.\n");
        }
    }

    return 0;
}