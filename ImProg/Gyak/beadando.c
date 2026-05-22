#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define FLASK_SIZE 3
#define RESET "\033[0m"
#define BG_RED "\033[41m"
#define BG_GREEN "\033[42m"
#define BG_YELLOW "\033[43m"
#define BG_BLUE "\033[44m"
#define BG_MAGENTA "\033[45m"
#define BG_CYAN "\033[46m"
#define BG_WHITE "\033[47m"

const char* colors[] = {BG_RED, BG_GREEN, BG_YELLOW, BG_BLUE, BG_MAGENTA, BG_CYAN, BG_WHITE};

typedef struct {
    int levels[FLASK_SIZE];
    int count;
} Flask;

void display_game(Flask *flasks, int n) {
    printf("\n");
    for (int i = FLASK_SIZE - 1; i >= 0; i--) {
        for (int j = 0; j < n; j++) {
            printf("|");
            if (i < flasks[j].count) {
                printf("%s  %s", colors[flasks[j].levels[i]], RESET);
            } else {
                printf("  ");
            }
            printf("| ");
        }
        printf("\n");
    }

    for (int j = 0; j < n; j++) printf(" %d   ", j + 1);
    printf("\n\n");
}

void shuffle_liquids(Flask *flasks, int n) {
    int num_colors = n - 1;
    int total_units = num_colors * FLASK_SIZE;
    int *temp_pool = malloc(total_units * sizeof(int));
    for (int i = 0; i < num_colors; i++) {
        for (int j = 0; j < FLASK_SIZE; j++) {
            temp_pool[i * FLASK_SIZE + j] = i;
        }
    }
    for (int i = total_units - 1; i > 0; i--) {
        int j = rand() % (i + 1);
        int temp = temp_pool[i];
        temp_pool[i] = temp_pool[j];
        temp_pool[j] = temp;
    }
    for (int i = 0; i < num_colors; i++) {
        flasks[i].count = FLASK_SIZE;
        for (int j = 0; j < FLASK_SIZE; j++) {
            flasks[i].levels[j] = temp_pool[i * FLASK_SIZE + j];
        }
    }
    flasks[n - 1].count = 0;
    free(temp_pool);
}

int is_valid_move(Flask *from, Flask *to) {
    if (from->count == 0) {
        printf("\nHiba: A forrás üveg üres!\n");
        return 0;
    }
    if (to->count == FLASK_SIZE) {
        printf("\nHiba: A cél üveg tele van!\n");
        return 0;
    }
    if (to->count > 0 && from->levels[from->count - 1] != to->levels[to->count - 1]) {
        printf("\nHiba: Csak azonos színt önthet azonosra!\n");
        return 0;
    }
    return 1;
}

int check_win(Flask *flasks, int n) {
    for (int i = 0; i < n; i++) {
        if (flasks[i].count == 0) continue;
        if (flasks[i].count != FLASK_SIZE) return 0;
        for (int j = 1; j < FLASK_SIZE; j++) {
            if (flasks[i].levels[j] != flasks[i].levels[0]) return 0;
        }
    }
    return 1;
}

int main() {
    int n;
    srand(time(NULL));
    printf("Adja meg az üvegek számát (2-7): ");
    if (scanf("%d", &n) != 1 || n < 2 || n > 7) {
        return 1;
    }
    Flask *game = malloc(n * sizeof(Flask));
    shuffle_liquids(game, n);
    char src_char, dest_char;
    while (1) {
        display_game(game, n);
        if (check_win(game, n)) {
            printf("Gratulálok, megoldotta!\nKilépés...\n");
            break;
        }
        printf("Honnan (1-%d, q=kilépés): ", n);
        scanf(" %c", &src_char);
        if (src_char == 'q') { 
            printf("Kilépés...\n"); 
            break; 
        }
        printf("Hova (1-%d, q=kilépés): ", n);
        scanf(" %c", &dest_char);
        if (dest_char == 'q') break;
        int src = src_char - '1';
        int dest = dest_char - '1';
        if (src >= 0 && src < n && dest >= 0 && dest < n) {
            if (is_valid_move(&game[src], &game[dest])) {
                int color_to_move = game[src].levels[game[src].count - 1];
                while (game[src].count > 0 && 
                       game[src].levels[game[src].count - 1] == color_to_move && 
                       game[dest].count < FLASK_SIZE) {
                    game[dest].levels[game[dest].count] = color_to_move;
                    game[dest].count++;
                    game[src].count--;
                }
            }
        } else {
            printf("\nHiba: Érvénytelen sorszám!\n");
        }
    }
    free(game);
    return 0;
}