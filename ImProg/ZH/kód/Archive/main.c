#include <stdio.h>
#include <stdlib.h>
#include "board.h"

void print_welcome_message(void) {
    printf("====================================================\n");
    printf("                   N-KIRÁLYNŐ JÁTÉK!                \n");
    printf("====================================================\n");
    printf("Szabályok:\n");
    printf("- Helyezz el minél több királynőt egy NxN-es táblán.\n");
    printf("- A királynők nem üthetik egymást se sorban, se     \n");
    printf("  oszlopban, se pedig átlósan.                      \n");
    printf("- Ha ütés okozó lépést teszel, a játék véget ér!    \n");
    printf("====================================================\n\n");
}

int main(void) {
    Board board = { .size = 0, .queen_num = 0, .queens = NULL };
    
    print_welcome_message();

    int choice;
    bool running = true;

    while (running) {
        printf("--- FŐMENÜ ---\n");
        printf("0. Exit\n");
        printf("1. Print current board\n");
        printf("2. Play\n");
        printf("3. Create new board with size\n");
        printf("4. Load board\n");
        printf("5. Save board\n");
        printf("Választás: ");

        if (scanf("%d", &choice) != 1) {
            if (feof(stdin)) {
                printf("\nKilépés...\n");
                break;
            } else {
                fprintf(stderr, "Hiba: Érvenytelen bemenet! Kérlek számot adj meg.\n");
                clear_buffer();
                continue;
            }
        }
        clear_buffer();

        switch (choice) {
            case 0:
                printf("Kilépés...\n");
                running = false;
                break;
            case 1:
                print_board(&board);
                break;
            case 2:
                play_game(&board);
                break;
            case 3: {
                int size;
                printf("Adja meg a tábla méretét (5-9): ");
                if (scanf("%d", &size) != 1) {
                    fprintf(stderr, "Hiba: Érvenytelen méret!\n");
                    clear_buffer();
                } else {
                    clear_buffer();
                    if (size < 5 || size > 9) {
                        fprintf(stderr, "Hiba: A méretnek 5 és 9 között kell lennie!\n");
                    } else {
                        if (create_board(&board, size)) {
                            printf("Új, %dx%d-es tábla sikeresen létrehozva!\n", size, size);
                        }
                    }
                }
                break;
            }
            case 4:
                load_board(&board);
                break;
            case 5:
                save_board(&board);
                break;
            default:
                fprintf(stderr, "Hiba: Hibás választás! Kérlek 0-5 közötti számot adj meg.\n");
                break;
        }
        printf("\n");
    }

    free_board(&board);

    return 0;
}