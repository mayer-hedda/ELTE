#include<stdio.h>

int main()
{
    // KIIRATÁS
    printf("Hello World!\n");
    printf("Hédy\n");

    /*
        %d - decimal
        %f - float
        %c - char
        %s - (string) char* / char[] -> character array
    */
    printf("1500 + 1800 = %d\n", 1500 + 1800);
    printf("10 / 3 = %.2f\n", 10. / 3);         // 2 tizedesjegyre kerekítve


    // BEOLVASÁS
    int rect_a, rect_b, rad;
    printf("One side of a rectangel: ");
    scanf("%d", &rect_a);
    printf("Other side of a rectangel: ");
    scanf("%d", &rect_b);

    printf("Area: %d\n", rect_a * rect_b);
    printf("Perimeter: %d\n", 2 * (rect_a + rect_b));


    printf("Radius of the circle: ");
    scanf("%d", &rad);
    const float PI = 3.141592;

    printf("Area: %.2f\n", PI * rad * rad);
    printf("Perimeter: %.2f\n", 2 * PI * rad);


    char name[20];
    printf("Your name: ");
    scanf("%s", name);      // &name[0] -> name
    printf("Hello %s!\n", name);

    return 0;
}