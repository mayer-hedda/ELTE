package capitaly;

import java.util.List;

/**
 * A kör alakú játékpálya.
 */
public class Board {

    private final List<Tile> tiles;

    /**
     * Létrehozza a pályát a megadott mezőkből.
     *
     * @param tiles a mezők sorrendben
     */
    public Board(List<Tile> tiles) {
        this.tiles = tiles;
    }

    /**
     * Visszaadja a pálya mezőinek számát.
     *
     * @return a mezők száma
     */
    public int size() {
        return tiles.size();
    }

    /**
     * Visszaadja a megadott pozíción lévő mezőt.
     *
     * @param position a mező indexe (0-tól)
     * @return a mező
     */
    public Tile getTile(int position) {
        return tiles.get(position);
    }

    /**
     * Kiszámolja az új pozíciót; a pálya végén körbefordul.
     * A kezdő pozíció -1 (a játékosok az első mező előtt állnak).
     *
     * @param position a jelenlegi pozíció
     * @param steps    a dobott érték
     * @return az új pozíció
     */
    public int nextPosition(int position, int steps) {
        return (position + steps) % size();
    }
}