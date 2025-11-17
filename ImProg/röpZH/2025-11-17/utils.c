#include "utils.h"

char* uncoding_ceasar(FILE* text) {
    for (int i = 0; text[i] != '\0'; i++) {
        text[i] = text[i + 1];
    }

    return text;
}