#include "ascii_art.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


static void strip_newline(char *str)
{
    str[strcspn(str, "\r\n")] = 0;
}

int load_alphabet(const char *filename, Alphabet *alphabet) 
{
    FILE *f = fopen(filename, "r");

    if (!f)
    {
        perror("Nem sikerült megnyitni a megadott fájlt!");
        return 0;
    }

    if (fscanf(f, "%d", &alphabet->height) != 1)
    {
        fprintf(stderr, "Hiba: Nem olvasható a magasság!\n");
        fclose(f);
        return 0;
    }

    char buffer[1024];
    fgets(buffer, sizeof(buffer), f);


    for (int i = 0; i < 26; i++)
    {
        alphabet->letters[i].rows = (char**)malloc(alphabet->height * sizeof(char*));

        if (!alphabet->letters[i].rows)
        {
            fclose(f);
            return 0;
        }


        for (int j = 0; j < alphabet->height; j++)
        {
            if (!fgets(buffer, sizeof(buffer), f))
            {
                break;
            }

            strip_newline(buffer);

            alphabet->letters[i].rows[j] = strdup(buffer);

            if (j == 0)
            {
                alphabet->letters[i].width = strlen(buffer);
            }
        }
    }

    fclose(f);
    return 1;
}

void draw_str(const char *str, const Alphabet *alphabet)
{
    if (!str || !alphabet) return;

    for (int i = 0; i < alphabet->height; i++)
    {
        for (int j = 0; str[j] != '\0'; j++)
        {
            char c = str[j];

            if (isalpha(c))
            {
                int index = tolower(c) - 'a';
                if (index >= 0 && index < 26)
                {
                    printf("%s", alphabet->letters[index].rows[i]);
                }
            }
            else if (c == ' ')
            {
                printf("    ");
            }
        }
        printf("\n");
    }
}

void free_alphabet(Alphabet *alphabet)
{
    for (int i = 0; i < 26; i++)
    {
        for (int j = 0; j < alphabet->height; j++)
        {
            free(alphabet->letters[i].rows[j]);
        }
        
        free(alphabet->letters[i].rows);
    }
}
