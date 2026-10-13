package capitaly;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

/**
 * A bemeneti szövegfájlok beolvasásáért felelős osztály.
 */
public class Reader {

    private Reader() {
    }

    /**
     * Beolvassa a megadott fájlból a pálya mezőit és a játékosokat.
     *
     * @param fileName a játékfájl neve
     * @return a beolvasott mezők és játékosok
     * @throws IOException ha a fájl nem olvasható
     */
    public static GameData readGame(String fileName) throws IOException {
        List<String> lines = new ArrayList<>();
        for (String line : Files.readAllLines(Path.of(fileName))) {
            if (!line.isBlank()) {
                lines.add(line.trim());
            }
        }

        int row = 0;
        try {
            int tileCount = Integer.parseInt(lines.get(row++));
            List<Tile> tiles = new ArrayList<>();
            for (int i = 0; i < tileCount; i++) {
                Tile tile = parseTile(lines.get(row++));
                if (tile instanceof Property property) {
                    property.setIndex(i);
                }
                tiles.add(tile);
            }

            int playerCount = Integer.parseInt(lines.get(row++));
            List<Player> players = new ArrayList<>();
            for (int i = 0; i < playerCount; i++) {
                players.add(parsePlayer(lines.get(row++)));
            }

            if (tiles.isEmpty() || players.isEmpty()) {
                throw new IllegalArgumentException("üres pálya vagy nincs játékos");
            }
            return new GameData(tiles, players);
        } catch (IndexOutOfBoundsException e) {
            throw new IllegalArgumentException("a fájl kevesebb sort tartalmaz a vártnál");
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("hibás szám a(z) " + row + ". sorban");
        }
    }

    /**
     * Beolvassa az előre rögzített kockadobásokat a megadott fájlból.
     *
     * @param fileName a kockadobás-fájl neve
     * @return a dobások sora a fájlbeli sorrendben
     * @throws IOException ha a fájl nem olvasható
     */
    public static Queue<Integer> readDice(String fileName) throws IOException {
        Queue<Integer> rolls = new LinkedList<>();
        String content = Files.readString(Path.of(fileName)).trim();
        if (content.isEmpty()) {
            return rolls;
        }
        for (String token : content.split("\\s+")) {
            int value = Integer.parseInt(token);
            if (value < 1 || value > 6) {
                throw new IllegalArgumentException("érvénytelen dobás: " + value);
            }
            rolls.add(value);
        }
        return rolls;
    }

    /**
     * Egy sor alapján létrehozza a megfelelő mezőt.
     * Elfogadott formák: "property", "service 500", "lucky 1000"
     * (vagy röviden: "P", "S 500", "L 1000").
     *
     * @param line a mezőt leíró sor
     * @return a létrehozott mező
     */
    private static Tile parseTile(String line) {
        String[] parts = line.split("\\s+");
        String type = parts[0].toLowerCase();
        switch (type) {
            case "property", "p":
                return new Property();
            case "service", "s":
                return new Service(Integer.parseInt(parts[1]));
            case "lucky", "l":
                return new Lucky(Integer.parseInt(parts[1]));
            default:
                throw new IllegalArgumentException("ismeretlen mezőtípus: " + parts[0]);
        }
    }

    /**
     * Egy sor alapján létrehozza a játékost a nevével és a stratégiájával.
     * Elfogadott forma: "Név greedy|careful|tactical" (vagy G / C / T).
     *
     * @param line a játékost leíró sor
     * @return a létrehozott játékos
     */
    private static Player parsePlayer(String line) {
        String[] parts = line.split("\\s+");
        if (parts.length < 2) {
            throw new IllegalArgumentException("hiányzó stratégia: " + line);
        }
        String name = parts[0];
        String strategy = parts[1].toLowerCase();
        switch (strategy) {
            case "greedy", "g", "mohó", "moho":
                return new Greedy(name);
            case "careful", "c", "óvatos", "ovatos":
                return new Careful(name);
            case "tactical", "t", "taktikus":
                return new Tactical(name);
            default:
                throw new IllegalArgumentException("ismeretlen stratégia: " + parts[1]);
        }
    }
}