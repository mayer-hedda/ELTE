#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "utils.h"
#define LEN 101

char* get_str(char* filename) {
    FILE* f = fopen(filename, "r");
    if (f == NULL) {
        printf("Hiányzó fájl!\n");
        return NULL;
    }
    char buff[LEN];
    fgets(buff, LEN, f);
    char* ret_str = malloc(strlen(buff) * sizeof(char));
    strcpy(ret_str, buff);
    fclose(f);
    return ret_str;
}

char** vers(char* filename, int* sorok) {
    FILE* f = fopen(filename, "r");
    if (f == NULL) {
        printf("Hiányzó fájl!\n");
        return NULL;
    }

    char buff[LEN];
    fgets(buff, LEN, f);
    *sorok = atoi(buff);
    char** vers = malloc(*sorok * sizeof(char*));

    for (int i = 0; i < *sorok; i++) {
        fgets(buff, LEN, f);
        vers[i] = malloc((strlen(buff)) * sizeof(char));
        strcpy(vers[i], buff);
    }
    fclose(f);
    return vers;

}
