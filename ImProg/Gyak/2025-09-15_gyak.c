#include <stdio.h>
#include <stdbool.h>

int main() {
    //* VÁLTOZÓK
    // int a = 7;
    // const b = 13; // const: konstans változó, értéke a program futása során nem változtathat
    // printf("%d\n", a); // %d: formátum specifikátor, egész szám kiírására szolgál (decimális érték)

    // a = 19;
    // // !b = 21; // hibát okoz, mert a b konstans változó
    // printf("%d\n", a);

    // printf("A megadott szám: %s\n", a % 2 == 0 ? "páros" : "páratlan"); // %s: formátum specifikátor, karakterlánc kiírására szolgál (string)

    //* BEVITEL
    // BOOLEAN
    // int a = true;   // A 0 hamis, minden más igaz
    // printf("Adj meg egy számot: ");
    // scanf("%d", &a); // &a: az 'a' változó memóriacímét adja meg, hogy a scanf oda tudja írni a beolvasott értéket
    // printf("A megadott szám: %d, %s\n", a, a % 2 == 0 ? "páros" : "páratlan");


    //* TÍPUSOK
    //* character
    // int a = 'a'; // karaktert is tárolhatunk int-ben, ilyenkor az ASCII kódját tárolja --> attól függ, hogy miként iratom ki
    // printf("A megadott karakter: %c, ASCII kódja: %d\n", a, a); // %c: formátum specifikátor, karakter kiírására szolgál (character)


    //* string
    // int a = (int)"Alma";
    // printf("A megadott karakterlánc: %s, memóriacíme: %d\n", "Alma", a); // %p: formátum specifikátor, memóriacím kiírására szolgál (pointer)


    //* float / double
    // Nem nézünk lebegőpontos számoknál egyenlőséget, mert nem minden esetben lesz pontosan egyenlő
    // int a = 7;
    // printf("%d\n", a);

    // double d = 7.0;

    // printf("%lf\n", d); // %lf: formátum specifikátor, dupla pontosságú lebegőpontos szám kiírására szolgál (long float)
    // printf("%f\n", d); // %f: formátum specifikátor, dupla pontosságú lebegőpontos szám kiírására szolgál (float)
    // printf("A két változó %s\n", a == d ? "egyenlő" : "nem egyenlő");


    //* MEMÓRIA TÚLCSORDULÁS
    // int a = 2147483647;
    // printf("%d\n", a);

    // a = a + 1;
    // printf("%d\n", a);


    unsigned int b = 4294967295;
    printf("%u\n", b); // %u: formátum specifikátor, előjel nélküli egész szám kiírására szolgál (unsigned)

    b = b + 1;
    printf("%u\n", b);

    return 0;
}