package capitaly;

import java.util.List;

/**
 * A beolvasott játékadatokat (mezők, játékosok) összefogó osztály.
 */
public class GameData {

    public final List<Tile> tiles;
    public final List<Player> players;

    /**
     * Létrehozza a játékadatokat.
     *
     * @param tiles   a pálya mezői sorrendben
     * @param players a játékosok sorrendben
     */
    public GameData(List<Tile> tiles, List<Player> players) {
        this.tiles = tiles;
        this.players = players;
    }
}