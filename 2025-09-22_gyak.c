#include <stdio.h>
#include <math.h>

#define PI 3.14

int main()
{
  /*
  1. feladat: Ascii kód átalakítása
  69 103 121 32 103 121 117 114 117 32 109 105 110 100 32 102 101 108 101 116 116
  */
  // int c = 0;
  // scanf("%d", &c);
  // while (c != -1) {
  //     printf("%c", c);
  //     scanf("%d", &c);
  // }

  /*
  2. feladat: Kisbetűk beolvasása és nagybetűkké alakítása
  */
  // char c;
  // int diff = 0;

  // scanf("%c", &c);
  // while (c != EOF) {
  //     if (c >= 'a' && c <= 'z') {
  //         diff = 'A' - 'a';
  //     } else if (c >= 'A' && c <= 'Z') {
  //         diff = 'a' - 'A';
  //     }
  //     printf("%c", c + diff);
  //     diff = 0;
  //     scanf("\n%c", &c);
  // }

  // char c = 0;
  // int diff = 0;
  // int len = 7;
  // int i;

  // scanf("%d", &len);
  // for (i = 0; i < len; ++i)
  // {
  //   scanf("%c", &c);

  //   if (c >= 'a' && c <= 'z')
  //   {
  //     diff = 'A' - 'a';
  //   }
  //   else if (c >= 'A' && c <= 'Z')
  //   {
  //     diff = 'a' - 'A';
  //   }

  //   printf("%c", c + diff);
  //   diff = 0;
  // }



  // ------ a++ vagy ++a
  // int a = 5;
  // printf("%d %d %d\n", a, a++, ++a);



  // Matematikai műveletek
  // int a = 5;
  // int b = 2;

  // int osszeg = a + b;
  // int kulonbseg = a - b;
  // int szorzat = a * b;
  // int hanyados = a / b; // egész osztás
  // int maradek = a % b; // egész osztás maradéka
  // float hatvany = pow(a, b); // a^b
  // double hanyados2 = (double)a / b; // valós osztás

  // printf("%f\n", hatvany);




  // Feladat: Számítsa ki a kör kerületét és területét, ha a sugara adott!
  double r;
  printf("Adja meg a kor sugara: ");
  scanf("%lf", &r);
  printf("A kor \n\tkerulete: %f, \n\tterulete: %f\n", 2 * r * PI, r * r * PI);

  return 0;
}