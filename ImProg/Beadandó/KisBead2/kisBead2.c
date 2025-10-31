#include<stdio.h>
#include<stdlib.h>
#include<time.h>

#define ROW 7
#define COLUMN 10
#define RANDOM rand() % 100
#define FRAME "############\n"

typedef enum {
    EMPTY = ' ',
    TREASURE = 'X'
} CellType;

void map_init(CellType map[ROW][COLUMN]) {
    for (int row = 0; row < ROW; row++) {
        for (int column = 0; column < COLUMN; column++) {
            if (RANDOM < 15) {
                map[row][column] = TREASURE;
            } else {
                map[row][column] = EMPTY;
            }
        }
    }
}

void map_print(CellType map[ROW][COLUMN]) {
    printf(FRAME);

    for (int row = 0; row < ROW; row++) {
        printf("#");

        for (int column = 0; column < COLUMN; column++) {
            printf("%c", map[row][column]);
        }

        printf("#\n");
    }

    printf(FRAME);
}

void dwarf_init(CellType map[ROW][COLUMN]) {
    srand(time(NULL));
    map_init(map);
}

int main() {
    CellType map[ROW][COLUMN];

    dwarf_init(map);
    map_print(map);

    return 0;
}