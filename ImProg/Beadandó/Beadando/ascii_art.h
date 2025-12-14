#ifndef ASCII_ART_H
#define ASCII_ART_H

#include <stdio.h>


typedef struct
{
    char **rows;
    int width;
} Letter;

typedef struct
{
    int height;
    Letter letters[26];
} Alphabet;


int load_alphabet(const char *filename, Alphabet *alphabet);
void draw_str(const char *str, const Alphabet *alphabet);
void free_alphabet(Alphabet *alphabet);

#endif
