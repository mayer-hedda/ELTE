#ifndef QUEEN_H
#define QUEEN_H

typedef struct {
    int x;
    int y;
} Queen;

typedef struct {
    int size;
    int queen_num;
    Queen* queens;
} Board;

Board* create_board(int size);
void free_board(Board* board);

void print_board(const Board* board);

int is_valid_position(const Board* board, int x, int y);
int is_conflict(const Board* board, int x, int y);

int add_queen(Board* board, int x, int y);

void play_game(Board* board);

int save_board(const Board* board, const char* filename);
Board* load_board(const char* filename);

#endif