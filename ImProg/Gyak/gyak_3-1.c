/*
Írj egy programot, ami gondol egy számra.
A felhasználónak ki kell találnia, hogy mi az.
A program csak annyit reagál, hogy kisebb vagy nagyobb a szám.
A program számolja, hogy hány találatból sikerült kitalálnia.
A program a kitaláláskor írja ki, hogy mennyi találat kellett
a kitaláláshoz és értékelje a felhasználót (pl. Béna vagy, mázlista, stb.)
attól függően, hogy mennyi tipp kellett
A programnak legyen 3 nehézsége: 0-10, 0-100, 0-1000
A program ne lépjen ki, legyen egy menüje, amibe visszatér
addig, amíg a felhasználó nem választja a "Kilépés menüpontot"
Használjatok függvényeket
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void playGame(int difficulty);

void menu() {
    int choice;
    int diff; 

    do {
        printf("\n--- MENÜ ---\n");
        printf("1. Játék indítása\n");
        printf("2. Kilépés\n");
        printf("Válassz egy opciót: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                printf("Válassz nehézséget (1: 0-10, 2: 0-100, 3: 0-1000): ");
                scanf("%d", &diff);
                playGame(diff);
                break;
            case 2:
                printf("Kilépés...\n");
                break;
            default:
                printf("Érvénytelen választás, próbáld újra.\n");
        }
    } while (choice != 2);
}

void playGame(int difficulty) {
    int maxNumber;
    switch (difficulty) {
        case 1: maxNumber = 10; break;
        case 2: maxNumber = 100; break;
        case 3: maxNumber = 1000; break;
        default:
            printf("Érvénytelen nehézség, visszatérés a menüre.\n");
            return;
    }

    int numberToGuess = (rand() % maxNumber) + 1;
    int guess;
    int attempts = 0;

    printf("\nGondoltam egy számra 0 és %d között. Találd ki!\n", maxNumber);
    
    do {
        printf("Tipp: ");
        if (scanf("%d", &guess) != 1) { 
            printf("Kérlek, számot adj meg!\n");
            while(getchar() != '\n'); 
            continue;
        }
        
        attempts++;
        if (guess < numberToGuess) {
            printf("Nagyobb!\n");
        } else if (guess > numberToGuess) {
            printf("Kisebb!\n");
        } else {
            printf("Gratulálok! Kitaláltad a számot %d tippből!\n", attempts);
            
            if (attempts == 1) {
                printf("Csaltál!\n");
            } else if (attempts <= 3) {
                printf("Mázlista vagy!\n");
            } else if (attempts <= 7) {
                printf("Nem rossz, egész ügyes!\n");
            } else {
                printf("Béna vagy, ez túl sokáig tartott.\n");
            }
        }
    } while (guess != numberToGuess);
}

int main() {
    srand(time(NULL));
    menu();
    return 0;
}