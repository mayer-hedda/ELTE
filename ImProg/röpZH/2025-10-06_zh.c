#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define count 10
int main()
{
    for (size_t i = 0; i < count; i++)
    {
        srand(time(NULL));
        printf("%crodo %caggins\n",
                    rand() % ('Z' - 'A') + 'A',
                    rand() % ('Z' - 'A') + 'A');
    }
    return 0;
}