package capitaly;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Scanner;


/**
 *
 * @author mayerhedda
 */
public class Game {
    private final Board board = new Board();
    private final List<Player> players = new ArrayList<>();
    private final Dice dice;
 
    /**
     * Beolvassa a játék paramétereit a fájlból, és felépíti a pályát és a játékosokat.
     * A fájl formátuma: a pálya hossza, majd soronként a mezők
     * ({@code Property}, {@code Service <díj>} vagy {@code Lucky <nyeremény>}),
     * ezután a játékosok száma, végül soronként a játékosok neve és stratégiája
     * ({@code Greedy}, {@code Careful} vagy {@code Tactical}).
     *
     * @param file a paraméterfájl elérési útja
     * @param dice a játékban használt kocka
     * @throws FileNotFoundException ha a fájl nem található
     * @throws IllegalArgumentException ha a fájl tartalma hibás
     */
    public Game(String file, Dice dice) throws FileNotFoundException {
        this.dice = dice;
        try (Scanner sc = new Scanner(new File(file))) {
            int length = readInt(sc);
            for (int i = 0; i < length; i++) {
                board.addField(readField(sc, i));
            }
            int count = readInt(sc);
            for (int i = 0; i < count; i++) {
                players.add(readPlayer(sc));
            }
        }
        if (board.size() == 0) {
            throw new IllegalArgumentException("A pálya nem lehet üres.");
        }
        if (players.isEmpty()) {
            throw new IllegalArgumentException("Nincs egyetlen játékos sem.");
        }
    }
 
    /**
     * Lejátssza a játékot: sorban következnek a játékosok, amíg egyetlen aktív játékos marad.
     * Ha közben elfogynak a fájlból olvasott dobások, a legtöbb pénzzel rendelkező
     * aktív játékos nyer.
     *
     * @return a győztes játékos
     */
    public Player run() {
        try {
            while (activeCount() > 1) {
                for (Player p : players) {
                    if (activeCount() <= 1) {
                        break;
                    }
                    playTurn(p);
                }
            }
        } catch (NoSuchElementException e) {
            // Elfogytak a rögzített dobások: a játék itt véget ér.
        }
        return leader();
    }
 
    /**
     * Lebonyolítja egy játékos körét: kör eleji előkészítés, dobás, lépés,
     * majd a célmező hatásának végrehajtása. Kiesett játékos esetén nem csinál semmit.
     *
     * @param p a soron következő játékos
     */
    private void playTurn(Player p) {
        if (p.isOut()) {
            return;
        }
        p.startTurn();
        int steps = dice.roll();
        p.move(steps, board.size());
        board.getField(p.getPosition()).onStep(p);
    }
 
    /**
     * Megszámolja, hány játékos van még játékban.
     *
     * @return az aktív játékosok száma
     */
    private int activeCount() {
        int n = 0;
        for (Player p : players) {
            if (!p.isOut()) {
                n++;
            }
        }
        return n;
    }
 
    /**
     * Megkeresi a legtöbb pénzzel rendelkező aktív játékost.
     *
     * @return a vezető játékos, vagy {@code null}, ha senki sincs játékban
     */
    private Player leader() {
        Player best = null;
        for (Player p : players) {
            if (!p.isOut() && (best == null || p.getMoney() > best.getMoney())) {
                best = p;
            }
        }
        return best;
    }
 
    /**
     * Visszaadja a játék összes résztvevőjét (a kiesetteket is).
     *
     * @return a játékosok listája
     */
    public List<Player> getPlayers() { return players; }
 
    /**
     * Beolvas egy nemnegatív egész számot.
     *
     * @param sc a beolvasáshoz használt Scanner
     * @return a beolvasott szám
     * @throws IllegalArgumentException ha nem szám következik, vagy a szám negatív
     */
    private static int readInt(Scanner sc) {
        if (!sc.hasNextInt()) {
            throw new IllegalArgumentException("Számot vártam, de ez jött: "
                    + (sc.hasNext() ? sc.next() : "fájl vége"));
        }
        int n = sc.nextInt();
        if (n < 0) {
            throw new IllegalArgumentException("Negatív szám: " + n);
        }
        return n;
    }
 
    /**
     * Beolvas egy mezőt: a típusát, és ha szolgáltatás vagy szerencse mező, az összegét is.
     *
     * @param sc    a beolvasáshoz használt Scanner
     * @param index a mező sorszáma a pályán
     * @return a létrehozott mező
     * @throws IllegalArgumentException ha a mező hiányzik vagy ismeretlen a típusa
     */
    private static Field readField(Scanner sc, int index) {
        if (!sc.hasNext()) {
            throw new IllegalArgumentException("Hiányzó mező: " + index);
        }
        String type = sc.next().toLowerCase();
        switch (type) {
            case "property": case "ingatlan":
                return new Property(index);
            case "service": case "szolgaltatas":
                return new Service(readInt(sc));
            case "lucky": case "szerencse":
                return new Lucky(readInt(sc));
            default:
                throw new IllegalArgumentException("Ismeretlen mezőtípus: " + type);
        }
    }
 
    /**
     * Beolvas egy játékost (név és stratégia), és létrehozza a megfelelő típusú objektumot.
     *
     * @param sc a beolvasáshoz használt Scanner
     * @return a létrehozott játékos
     * @throws IllegalArgumentException ha a név vagy a stratégia hiányzik, vagy ismeretlen a stratégia
     */
    private static Player readPlayer(Scanner sc) {
        if (!sc.hasNext()) {
            throw new IllegalArgumentException("Hiányzó játékosnév.");
        }
        String name = sc.next();
        if (!sc.hasNext()) {
            throw new IllegalArgumentException("Hiányzó stratégia: " + name);
        }
        String strategy = sc.next().toLowerCase();
        switch (strategy) {
            case "greedy": case "moho":
                return new Greedy(name);
            case "careful": case "ovatos":
                return new Careful(name);
            case "tactical": case "taktikus":
                return new Tactical(name);
            default:
                throw new IllegalArgumentException("Ismeretlen stratégia: " + strategy);
        }
    }
}
