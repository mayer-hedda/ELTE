package capitaly;

/**
 * A pálya egy mezője.
 */
public abstract class Tile {

    /**
     * Végrehajtja a mező hatását a rálépő játékosra.
     *
     * @param player a rálépő játékos
     */
    public abstract void onStep(Player player);
}