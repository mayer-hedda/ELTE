#include<stdio.h>
#include "my_utils.h"

//* Globális változó (bárhonnan elérhető a kódon belül)
// int valtozo = 7;         // Ilyet ne csináljunk!

// void szamlalo() {
//     // Lokális változó (csak a függvényen belül elérhető)
//     static int lokalisValtozo = 0;      // Statikus lokális változó, amely megőrzi értékét a függvényhívások között
//     ++lokalisValtozo;
//     printf("A lokalisValtozo erteke: %d\n", lokalisValtozo);
// }

//* Mindenképp legyen a main előtt deklarálva, hogy a main-ben tudjam használni, csak akkor lehet a main alatt definiálni
void szamlalo2();

int osszead(int szam1, int szam2);      //* Itt hívhatom máshogy a változókat, akkor is jól fog működni

int main() {
    // valtozo = 10; // A globális változó értékének módosítása

    // printf("A valtozo erteke: %d\n", valtozo);

    // for(int i = 0; i < 10; ++i) {
    //     szamlalo(); // Minden hívásnál a lokalisValtozo értéke növekszik
    // }

    // if (1) {
    //     int blokkValtozo = 5; // Blokk szintű lokális változó (csak a blokkban elérhető)
    //     printf("A blokkValtozo erteke: %d\n", blokkValtozo);
    // }
    //
    // printf("Osszeadas eredmenye: %d\n", osszead(3, 4));

    int a = 5;
    int b = 10;
    printf("Előtte: a = %d, b = %d\n", a, b);
    swap(&a, &b);  // Cím szerinti átadás
    printf("Utána: a = %d, b = %d\n", a, b);

    return 0;
}

void szamlalo2() {
    // Lokális változó (csak a függvényen belül elérhető)
    static int lokalisValtozo = 0;      // Statikus lokális változó, amely megőrzi értékét a függvényhívások között
    ++lokalisValtozo;
    printf("A lokalisValtozo erteke: %d\n", lokalisValtozo);
}

// int osszead(int a, int b) {
//     return a + b;
// }