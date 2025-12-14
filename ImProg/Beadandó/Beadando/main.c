#include "ascii_art.h"
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, "Használat: %s <ábécé_fájl>\n", argv[0]);
        return 1;
    }

    Alphabet myAlphabet;

    if (!load_alphabet(argv[1], &myAlphabet))
    {
        fprintf(stderr, "Hiba: Nem sikerült betölteni az ábécé-t.\n");
        return 2;
    }

    printf("Sikeres betöltés!\n");


    char input_buffer[256];
    while (1)
    {
        printf("Írj be egy szöveget: ");
        fflush(stdout); 

        if (fgets(input_buffer, sizeof(input_buffer), stdin) == NULL)
        {
            printf("\n");
            break;
        }

        input_buffer[strcspn(input_buffer, "\r\n")] = 0;

        if (strlen(input_buffer) == 0)
        {
            continue;
        }

        draw_str(input_buffer, &myAlphabet);
        printf("\n");
    }

    free_alphabet(&myAlphabet);

    return 0;
}
