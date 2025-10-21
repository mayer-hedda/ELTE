#include<stdio.h>
#include<stdlib.h>
#include<time.h>

#define ROW 7
#define COLUMN 10
#define RANDOM rand() % 100


int main() 
{
    srand(time(NULL));

    // Kincsestérkép alapja 10x7 + 1 vastag keret
    printf("############\n");
    for (int row = 0; row < ROW; row++) 
    {
        for (int column = 0; column < COLUMN; column++)
        {
            if (column == 0)
            {
                printf("#");
            }
            
            // Kincs elhelyezése 15% eséllyel
            if (RANDOM < 15)
            {
                printf("X");
            }
            else
            {
                printf(" ");
            }

            if (column == COLUMN-1)
            {
                printf("#\n");
            }
        }
    }
    printf("############\n");

    return 0;
}