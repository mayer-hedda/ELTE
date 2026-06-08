#include <stdio.h>
#include <stdlib.h>

#include "queen.h"

void print_menu() {
    printf("\n");
    printf("0. Exit\n");
    printf("1. Print current board\n");
    printf("2. Play\n");
    printf("3. Create new board with size\n");
    printf("4. Load board\n");
    printf("5. Save board\n");
    printf("Choice: ");
}

int main() {
    Board* board = NULL;

    printf("N-Queens Game\n");
    printf("Place queens so they do not attack each other.\n");

    while (1) {
        print_menu();

        int choice;

        if (scanf("%d", &choice) != 1) {
            break;
        }

        while (getchar() != '\n');

        if (choice == 0) {
            break;
        }

        else if (choice == 1) {
            print_board(board);
        }

        else if (choice == 2) {
            play_game(board);
        }

        else if (choice == 3) {
            int size;

            printf("Enter board size (5-9): ");

            if (scanf("%d", &size) != 1) {
                while (getchar() != '\n');
                printf("Invalid input.\n");
                continue;
            }

            while (getchar() != '\n');

            if (size < 5 || size > 9) {
                printf("Invalid size.\n");
                continue;
            }

            free_board(board);

            board = create_board(size);

            if (board == NULL) {
                fprintf(stderr, "Memory allocation failed.\n");
            }
        }

        else if (choice == 4) {
            char filename[128];

            printf("Filename: ");

            if (fgets(filename, sizeof(filename), stdin) == NULL) {
                continue;
            }

            int i = 0;

            while (filename[i] != '\0') {
                if (filename[i] == '\n') {
                    filename[i] = '\0';
                    break;
                }

                i++;
            }

            Board* loaded = load_board(filename);

            if (loaded == NULL) {
                printf("Failed to load board.\n");
                continue;
            }

            free_board(board);
            board = loaded;
        }

        else if (choice == 5) {
            if (board == NULL) {
                printf("No board exists.\n");
                continue;
            }

            char filename[128];

            printf("Filename: ");

            if (fgets(filename, sizeof(filename), stdin) == NULL) {
                continue;
            }

            int i = 0;

            while (filename[i] != '\0') {
                if (filename[i] == '\n') {
                    filename[i] = '\0';
                    break;
                }

                i++;
            }

            if (!save_board(board, filename)) {
                printf("Failed to save board.\n");
            }
        }

        else {
            printf("Invalid menu option.\n");
        }
    }

    free_board(board);

    return 0;
}