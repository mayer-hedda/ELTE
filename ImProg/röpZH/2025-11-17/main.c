#include <stdio.h>
#include <stdlib.h>
#include "utils.h"

int main(void) {
    FILE *gandalf = fopen("gandalf.txt", "r");
    if (gandalf == NULL) {
        perror("Error opening file");
        return 1;
    }

    char *decoded = uncoding_ceasar(gandalf);
    if (decoded == NULL) {
        fprintf(stderr, "Decoding failed\n");
        fclose(gandalf);
        return 1;
    }

    printf("%s", decoded);

    free(decoded);
    fclose(gandalf);
    return 0;
}