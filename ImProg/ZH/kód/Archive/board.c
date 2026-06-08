#include "board.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void clear_buffer(void) {
    int c;
    while ((c = getchar()) != '\n' && c != EOF);
}

void free_board(Board *board) {
    if (board == NULL) return;
    if (board->queens != NULL) {
        free(board->queens);
        board->queens = NULL;
    }
    board->size = 0;
    board->queen_num = 0;
}

bool create_board(Board *board, int size) {
    if (board == NULL) return false;
    
    free_board(board);
    
    board->size = size;
    board->queen_num = 0;
    board->queens = NULL; 
    return true;
}

void print_board(const Board *board) {
    if (board == NULL || board->size == 0) {
        fprintf(stderr, "Hiba: Nincs aktív tábla létrehozva!\n");
        return;
    }

    printf("  |");
    for (int i = 1; i <= board->size; i++) {
        printf(" %d", i);
    }
    printf("\n--+");
    for (int i = 1; i <= board->size; i++) {
        printf("--");
    }
    printf("\n");

    for (int r = 0; r < board->size; r++) {
        printf("%c |", 'A' + r);
        for (int c = 0; c < board->size; c++) {
            bool has_queen = false;
            for (int q = 0; q < board->queen_num; q++) {
                if (board->queens[q].x == c && board->queens[q].y == r) {
                    has_queen = true;
                    break;
                }
            }
            if (has_queen) {
                printf(" Q");
            } else {
                printf(" .");
            }
        }
        printf("\n");
    }
    printf("\n");
}

bool check_collision(const Board *board, int x, int y) {
    if (board == NULL) return false;

    for (int i = 0; i < board->queen_num; i++) {
        Queen q = board->queens[i];
        
        if (q.x == x || q.y == y) {
            return true;
        }
        if ((q.x - q.y == x - y) || (q.x + q.y == x + y)) {
            return true;
        }
    }
    return false;
}

void play_game(Board *board) {
    if (board == NULL || board->size == 0) {
        fprintf(stderr, "Hiba: Nem lehet játszani tábla nélkül!\n");
        return;
    }

    printf("--- Játék indult! (Kilépés: q vagy Q) ---\n");
    
    while (true) {
        print_board(board);
        printf("Adj meg egy koordinátát (pl. B2): ");
        
        char input[128];
        if (fgets(input, sizeof(input), stdin) == NULL) {
            return;
        }

        input[strcspn(input, "\n")] = 0;

        if (strcmp(input, "q") == 0 || strcmp(input, "Q") == 0) {
            printf("Visszatérés a főmenübe.\n");
            return;
        }

        if (strlen(input) < 2) {
            fprintf(stderr, "Hiba: Hibás formátum! Kérlek próbáld újra.\n");
            continue;
        }

        char row_char = toupper((unsigned char)input[0]);
        char col_char = input[1];

        int row_idx = row_char - 'A';
        int col_idx = col_char - '1'; 

        if (row_idx < 0 || row_idx >= board->size || col_idx < 0 || col_idx >= board->size) {
            fprintf(stderr, "Hiba: A koordináta a táblán kivül esik! Kérlek próbáld újra.\n");
            continue;
        }

        bool already_there = false;
        for (int i = 0; i < board->queen_num; i++) {
            if (board->queens[i].x == col_idx && board->queens[i].y == row_idx) {
                already_there = true;
                break;
            }
        }
        if (already_there) {
            fprintf(stderr, "Hiba: Ezen a mezőn már van egy királynő! Kérlek próbáld újra.\n");
            continue;
        }

        if (check_collision(board, col_idx, row_idx)) {
            printf("\nÜTÉS TÖRTÉNT!\n");
            printf("A játék véget ért.\n");
            printf("Elért pontszám (elhelyezett királynők száma): %d\n\n", board->queen_num);
            
            free_board(board);
            return;
        }

        Queen *temp = realloc(board->queens, (board->queen_num + 1) * sizeof(Queen));
        if (temp == NULL) {
            fprintf(stderr, "Memória hiba!\n");
            free_board(board);
            return;
        }
        board->queens = temp;
        
        board->queens[board->queen_num].x = col_idx;
        board->queens[board->queen_num].y = row_idx;
        board->queen_num++;
        
        printf("Sikeres lépés! Királynő elhelyezve.\n\n");
    }
}

void save_board(const Board *board) {
    if (board == NULL || board->size == 0) {
        fprintf(stderr, "Hiba: Nincs menthető tábla!\n");
        return;
    }

    char filename[128];
    printf("Adja meg a fájl nevet a mentéshez: ");
    if (fgets(filename, sizeof(filename), stdin) == NULL) return;
    filename[strcspn(filename, "\n")] = 0;

    FILE *f = fopen(filename, "w");
    if (f == NULL) {
        fprintf(stderr, "Hiba: A fájl nem nyitható meg írásra!\n");
        return;
    }

    fprintf(f, "%d\n", board->size);
    
    for (int i = 0; i < board->queen_num; i++) {
        fprintf(f, "%c%d\n", 'A' + board->queens[i].y, 1 + board->queens[i].x);
    }

    fclose(f);
    printf("Tábla sikeresen elmentve ide: %s\n", filename);
}

bool load_board(Board *board) {
    if (board == NULL) return false;

    char filename[128];
    printf("Adja meg a betöltendő fájl nevét: ");
    if (fgets(filename, sizeof(filename), stdin) == NULL) return false;
    filename[strcspn(filename, "\n")] = 0;

    FILE *f = fopen(filename, "r");
    if (f == NULL) {
        fprintf(stderr, "Hiba: A fájl nem nyitható meg!\n");
        return false;
    }

    int new_size;
    if (fscanf(f, "%d\n", &new_size) != 1) {
        fprintf(stderr, "Hiba: Hibás fájlformátum!\n");
        fclose(f);
        return false;
    }

    if (new_size < 5 || new_size > 9) {
        fprintf(stderr, "Hiba: A fájlban szereplő tábla mérete hibás (%d)! Csak 5-9 fogadható el.\n", new_size);
        fclose(f);
        return false;
    }

    Board temp_board;
    temp_board.size = new_size;
    temp_board.queen_num = 0;
    temp_board.queens = NULL;

    char line[128];

    while (fgets(line, sizeof(line), f) != NULL) {
        if (line[0] == '\n' || line[0] == '\r' || line[0] == '\0') continue;

        char r_char = toupper((unsigned char)line[0]);
        char c_char = line[1];

        int r_idx = r_char - 'A';
        int c_idx = c_char - '1';

        if (r_idx < 0 || r_idx >= temp_board.size || c_idx < 0 || c_idx >= temp_board.size) {
            fprintf(stderr, "Hiba: Hibás pozíció a fájlban (%c%c) - Kívül esik a táblán!\n", r_char, c_char);
            continue;
        }

        bool duplicate = false;
        for (int i = 0; i < temp_board.queen_num; i++) {
            if (temp_board.queens[i].x == c_idx && temp_board.queens[i].y == r_idx) {
                duplicate = true;
                break;
            }
        }
        if (duplicate) {
            fprintf(stderr, "Hiba: Hibás pozíció a fájlban (%c%c) - Már szerepelt korábban!\n", r_char, c_char);
            continue;
        }

        Queen *t_mem = realloc(temp_board.queens, (temp_board.queen_num + 1) * sizeof(Queen));
        if (t_mem == NULL) {
            fprintf(stderr, "Memória hiba!\n");
            free_board(&temp_board);
            fclose(f);
            return false;
        }
        temp_board.queens = t_mem;
        temp_board.queens[temp_board.queen_num].x = c_idx;
        temp_board.queens[temp_board.queen_num].y = r_idx;
        temp_board.queen_num++;
    }

    fclose(f);

    free_board(board);
    board->size = temp_board.size;
    board->queen_num = temp_board.queen_num;
    board->queens = temp_board.queens;

    printf("Tábla sikeresen betöltve! Elhelyezett királynők: %d\n", board->queen_num);
    return true;
}