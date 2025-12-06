//
// Created by Mayer Hedda on 2025. 12. 01..
//

#ifndef PROBAZH_BUSZMEGALLOK_H
#define PROBAZH_BUSZMEGALLOK_H

#define SIZE 10

typedef struct Megallo {
    char *name;
    int x;
    int y;
} Megallo_t;

void show_map(Megallo_t *tomb, int size);

#endif //PROBAZH_BUSZMEGALLOK_H