#ifndef BOARD_H
#define BOARD_H

#include <stdio.h>
#include <stdbool.h>

typedef struct {
    int x;
    int y;
} Queen;

typedef struct {
    int size;
    int queen_num;
    Queen *queens;
} Board;

void free_board(Board *board);
bool create_board(Board *board, int size);
void print_board(const Board *board);
bool check_collision(const Board *board, int x, int y);
void play_game(Board *board);
void save_board(const Board *board);
bool load_board(Board *board);
void clear_buffer(void);

#endif