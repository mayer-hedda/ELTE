package capitaly;

import java.io.FileNotFoundException;


/**
 * 
 * @author mayerhedda
 */
public class Capitaly {

    /**
     * 
     * @author mayerhedda
     * 
     * Elindítja a szimulációt, és kiírja a győztest a vagyonával együtt.
     * Használat:
     *   java capitaly.Main jatek.txt              (véletlen kockával)
     *   java capitaly.Main jatek.txt dobasok.txt  (fájlból olvasott dobásokkal)
     * 
     * @param args az első a paraméterfájl, a második (nem kötelező) a dobásokat tartalmazó fájl
     */
    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Használat: java capitaly.Main <játékfájl> [dobásfájl]");
            return;
        }
        try {
            Dice dice = args.length >= 2 ? new FileDice(args[1]) : new RandomDice();
            Game game = new Game(args[0], dice);
            Player winner = game.run();
            System.out.println("A győztes: " + winner);
        } catch (FileNotFoundException e) {
            System.out.println("Nem található a fájl: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            System.out.println("Hibás bemenet: " + e.getMessage());
        }
    }
    
}
