package capitaly;

/**
 * Kocka interfész.
 */
public interface Dice {

    /**
     * Dob a kockával.
     *
     * @return a dobott érték (1–6)
     */
    int roll();

    /**
     * Megadja, hogy lehet-e még dobni. Véletlen kockánál mindig igaz.
     *
     * @return igaz, ha van még dobás
     */
    default boolean hasNext() {
        return true;
    }
}