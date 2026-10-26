package capitaly;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayDeque;
import java.util.Queue;
import java.util.Scanner;


/**
 *
 * @author mayerhedda
 */
public class FileDice implements Dice {
    private final Queue<Integer> rolls = new ArrayDeque<>();
 
    /**
     * Beolvassa a dobásokat a megadott fájlból. A fájl 1 és 6 közötti egész számok
     * szóközzel vagy sortöréssel elválasztott sorozata.
     *
     * @param file a dobásokat tartalmazó fájl elérési útja
     * @throws FileNotFoundException ha a fájl nem található
     * @throws IllegalArgumentException ha a fájlban nem szám vagy 1–6 tartományon kívüli érték van
     */
    public FileDice(String file) throws FileNotFoundException {
        try (Scanner sc = new Scanner(new File(file))) {
            while (sc.hasNext()) {
                if (!sc.hasNextInt()) {
                    throw new IllegalArgumentException("Hibás dobás a fájlban: " + sc.next());
                }
                int r = sc.nextInt();
                if (r < 1 || r > 6) {
                    throw new IllegalArgumentException("A dobásnak 1 és 6 közé kell esnie: " + r);
                }
                rolls.add(r);
            }
        }
    }
 
    /**
     * Visszaadja a fájlból beolvasott következő dobást, és eltávolítja a sorból.
     *
     * @return a következő rögzített dobás
     * @throws NoSuchElementException ha a dobások elfogytak
     */
    @Override
    public int roll() {
        return rolls.remove();
    }
}
