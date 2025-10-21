#include<stdio.h>
#include<math.h>

#define HEIGHT 5
#define WIDTH 7

int strLenSajat (char* str) 
{
    int size = 0;
    while (*str != '\0')
    {
        ++str;
        ++size;
    }

    return size;
}

int hexToDec (char* str)
{
    int size = strLenSajat(str);
    int result = 0;
    int dec;

    for (int i = 0; i < size; i++)
    {
        if ('0' <= str[i] && str[i] <= '9')
        {
        dec = str[i] - '0';
        }
        else 
        {
            dec = str[i] - 'a' + 10;
        }
        result += dec * pow(16, size - i-1);
    }

    return result;
}

void szorzotabla (int t[HEIGHT][WIDTH])
{
    for (int i = 0; i < HEIGHT; i++)
    {
        for (int j = 0; j < WIDTH; j++)
        {
            t[i][j] = i*j;
        }
    }
}

int hatvany_fgv (int alap, int hatvany)
{
    if (hatvany == 1)
    {
        return alap;
    }
    return alap * (hatvany_fgv(alap, hatvany-1));
}

int main(int argc, char** argv)     // argc: argument count, argv: argument value
{
    // printf("A main függvényemnek %d bemenete van\n", argc);
    // for (int i = 0; i < argc; i++)
    // {
    //     printf("%s\n", argv[i]);
    // }


    // Feladat hex to decimal
    // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, a, b, c, d, e, f, (10 == 16)
    // char str[100];
    // scanf("%s", str);
    // printf("A szám decimálisan: %d", hexToDec(str));


    // int tomb[HEIGHT][WIDTH];
    // szorzotabla(tomb);

    // for (int i = 0; i < 5; i++)
    // {
    //     for (int j = 0; j < 7; j++)
    //     {
    //         printf("%d\t", tomb[i][j]);
    //     }
    //     printf("\n");
    // }


    // Feladat
    // szám aminek a hatványait
    // ahány hatványát
    int a = argv[1][0] - '0';
    int b = argv[2][0] - '0';

    printf("%d == %f", hatvany_fgv(a, b), pow(a, b));
}