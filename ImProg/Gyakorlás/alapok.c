#include <stdio.h>

int main() {

    // // KIIRATÁS:
    // printf("Ez egy sima kiiratás.");

    // /*
    // int - decimal       --> %d
    // char - char         --> %c
    // */
    // int magassag = 10;
    // char betu = 'A';

    // printf("A betű magassága: %d sor.\n", magassag);
    // printf("A betű amit tárolunk: %c\n", betu);


    // // BEKÉRÉS:
    // int kor;

    // printf("Hány éves vagy? ");
    // /*
    // Adat bekérése:
    //     kor     --> érték
    //     &kor    --> memóriacím
    // */
    // scanf("%d", &kor);


    // // ELÁGAZÁS:
    // if (kor >= 18 && kor < 100) {
    //     printf("Felnőtt vagy, de még nem túl idős.");
    // }

    // if (kor >= 18) {
    //     printf("Bejöhetsz a buliba.");
    // } else {
    //     printf("Sajnos nem jöhetsz be a buliba.");
    // }

    // // printf("Értem, tehát %d éves vagy.\n", kor);


    // // CIKLUSOK:
    // int szamlalo = 5;

    // while (szamlalo > 0) {
    //     printf("%d...\n", szamlalo);

    //     szamlalo--;
    // }
    // printf("KILÖVÉS!\n\n");
    
    // for (int i = 0; i < 5; i++) {
    //     printf("Ez a(z) %d. ismétlés.\n", i+1);
    // }


    // // TÖMBÖK:
    // int jegyek[3];

    // jegyek[0] = 5;
    // jegyek[1] = 4;
    // jegyek[2] = 5;

    // for (int i = 0; i < 3; i++) {
    //     printf("A(z) %d. vizsga jegye: %d\n", i+1, jegyek[i]);
    // }


    char nev[50];

    printf("Hogy hívnak? ");
    scanf("%s", nev);

    printf("Szia %s! Remélem felkészültél.\n", nev);

    return 0;
}