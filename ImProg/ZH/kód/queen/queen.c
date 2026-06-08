#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "queen.h"

Board* create_board(int size) {
    if (size < 5 || size > 9) {
        return NULL;
    }

    Board* board = malloc(sizeof(Board));

    if (board == NULL) {
        return NULL;
    }

    board->size = size;
    board->queen_num = 0;
    board->queens = NULL;

    return board;
}

void free_board(Board* board) {
    if (board == NULL) {
        return;
    }

    free(board->queens);
    free(board);
}

void print_board(const Board* board) {
    if (board == NULL) {
        printf("No board exists.\n");
        return;
    }

    int i;
    int j;

    printf(" |");

    for (i = 1; i <= board->size; i++) {
        printf("%d ", i);
    }

    printf("\n");

    printf("-+");

    for (i = 0; i < board->size * 2; i++) {
        printf("-");
    }

    printf("\n");

    for (i = 0; i < board->size; i++) {
        printf("%c|", 'A' + i);

        for (j = 0; j < board->size; j++) {
            int found = 0;

            int k;

            for (k = 0; k < board->queen_num; k++) {
                if (board->queens[k].x == j &&
                    board->queens[k].y == i) {
                    found = 1;
                    break;
                }
            }

            if (found) {
                printf("Q ");
            } else {
                printf(". ");
            }
        }

        printf("\n");
    }
}

int is_valid_position(const Board* board, int x, int y) {
    if (board == NULL) {
        return 0;
    }

    return x >= 0 &&
           x < board->size &&
           y >= 0 &&
           y < board->size;
}

int is_conflict(const Board* board, int x, int y) {
    if (board == NULL) {
        return 1;
    }

    int i;

    for (i = 0; i < board->queen_num; i++) {
        Queen q = board->queens[i];

        if (q.x == x || q.y == y) {
            return 1;
        }

        if (abs(q.x - x) == abs(q.y - y)) {
            return 1;
        }
    }

    return 0;
}

int add_queen(Board* board, int x, int y) {
    if (board == NULL) {
        return 0;
    }

    Queen* temp = realloc(
        board->queens,
        (board->queen_num + 1) * sizeof(Queen)
    );

    if (temp == NULL) {
        return 0;
    }

    board->queens = temp;

    board->queens[board->queen_num].x = x;
    board->queens[board->queen_num].y = y;

    board->queen_num++;

    return 1;
}

void play_game(Board* board) {
    if (board == NULL) {
        printf("No board exists.\n");
        return;
    }

    char input[128];

    while (1) {
        printf("Enter coordinate (example: B2) or Q to quit: ");

        if (fgets(input, sizeof(input), stdin) == NULL) {
            return;
        }

        if (toupper(input[0]) == 'Q') {
            return;
        }

        if (strlen(input) < 2) {
            printf("Invalid input.\n");
            continue;
        }

        int y = toupper(input[0]) - 'A';
        int x = input[1] - '1';

        if (!is_valid_position(board, x, y)) {
            printf("Invalid position.\n");
            continue;
        }

        if (is_conflict(board, x, y)) {
            printf("Game over.\n");
            printf("Score: %d\n", board->queen_num);

            free(board->queens);
            board->queens = NULL;
            board->queen_num = 0;

            return;
        }

        if (!add_queen(board, x, y)) {
            fprintf(stderr, "Memory allocation failed.\n");
            return;
        }

        print_board(board);
    }
}

int save_board(const Board* board, const char* filename) {
    if (board == NULL || filename == NULL) {
        return 0;
    }

    FILE* file = fopen(filename, "w");

    if (file == NULL) {
        return 0;
    }

    fprintf(file, "%d\n", board->size);

    int i;

    for (i = 0; i < board->queen_num; i++) {
        fprintf(
            file,
            "%d %d\n",
            board->queens[i].x,
            board->queens[i].y
        );
    }

    fclose(file);

    return 1;
}

Board* load_board(const char* filename) {
    if (filename == NULL) {
        return NULL;
    }

    FILE* file = fopen(filename, "r");

    if (file == NULL) {
        return NULL;
    }

    int size;

    if (fscanf(file, "%d", &size) != 1) {
        fclose(file);
        return NULL;
    }

    if (size < 5 || size > 9) {
        fclose(file);
        return NULL;
    }

    Board* board = create_board(size);

    if (board == NULL) {
        fclose(file);
        return NULL;
    }

    int x;
    int y;

    while (fscanf(file, "%d %d", &x, &y) == 2) {
        if (!is_valid_position(board, x, y)) {
            printf("Invalid position in file.\n");
            continue;
        }

        int duplicate = 0;

        int i;

        for (i = 0; i < board->queen_num; i++) {
            if (board->queens[i].x == x &&
                board->queens[i].y == y) {
                duplicate = 1;
                break;
            }
        }

        if (duplicate) {
            printf("Duplicate position in file.\n");
            continue;
        }

        add_queen(board, x, y);
    }

    fclose(file);

    return board;
}