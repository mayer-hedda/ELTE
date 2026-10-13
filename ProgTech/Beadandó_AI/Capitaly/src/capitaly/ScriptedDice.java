package capitaly;

import java.util.Queue;

/**
 * Előre rögzített dobásokat visszaadó kocka (teszteléshez).
 */
public class ScriptedDice implements Dice {

    private final Queue<Integer> rolls;

    /**
     * Létrehozza a kockát a rögzített dobásokkal.
     *
     * @param rolls a dobások sorrendben
     */
    public ScriptedDice(Queue<Integer> rolls) {
        this.rolls = rolls;
    }

    /**
     * Visszaadja a következő rögzített dobást.
     *
     * @return a dobott érték
     * @throws IllegalStateException ha elfogytak a dobások
     */
    @Override
    public int roll() {
        if (rolls.isEmpty()) {
            throw new IllegalStateException("Elfogytak a rögzített dobások.");
        }
        return rolls.poll();
    }

    /**
     * Megadja, hogy van-e még rögzített dobás.
     *
     * @return igaz, ha van még dobás
     */
    @Override
    public boolean hasNext() {
        return !rolls.isEmpty();
    }
}