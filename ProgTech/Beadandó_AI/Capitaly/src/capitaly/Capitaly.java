package capitaly;

import java.io.IOException;
import java.util.Queue;
import java.util.Scanner;

/**
 * A Capitaly társasjáték szimulációjának belépési pontja.
 *
 * @author mayerhedda
 */
public class Capitaly {

    /**
     * A program belépési pontja. Beolvassa a játékfájlt (és opcionálisan a
     * kockadobás-fájlt), lefuttatja a játékot, majd kiírja a győztest a
     * tőkéjével és az ingatlanjaival.
     *
     * @param args [0] a játékfájl neve, [1] (opcionális) a kockadobás-fájl neve;
     *             ha nincs megadva, a program a konzolról kéri be őket
     */
    public static void main(String[] args) {
        String gameFile;
        String diceFile;

        if (args.length > 0) {
            gameFile = args[0];
            diceFile = args.length > 1 ? args[1] : "";
        } else {
            Scanner in = new Scanner(System.in);
            System.out.print("Játékfájl neve: ");
            gameFile = in.nextLine().trim();
            System.out.print("Kockadobás-fájl neve (üres = véletlen dobás): ");
            diceFile = in.nextLine().trim();
        }

        try {
            GameData data = Reader.readGame(gameFile);

            Dice dice;
            if (diceFile.isEmpty()) {
                dice = new RandomDice();
            } else {
                Queue<Integer> rolls = Reader.readDice(diceFile);
                dice = new ScriptedDice(rolls);
            }

            Game game = new Game(data.tiles, data.players, dice);
            Player winner = game.run();

            System.out.println("A győztes: " + winner);
        } catch (IOException e) {
            System.err.println("Hiba a fájl olvasásakor: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            System.err.println("Hibás bemenet: " + e.getMessage());
        }
    }
}