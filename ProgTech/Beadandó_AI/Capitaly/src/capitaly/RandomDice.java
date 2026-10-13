package capitaly;

import java.util.Random;

/**
 * Véletlenszerű dobásokat adó kocka.
 */
public class RandomDice implements Dice {

    private final Random random = new Random();

    /**
     * Véletlenszerű dobás 1 és 6 között.
     *
     * @return a dobott érték
     */
    @Override
    public int roll() {
        return random.nextInt(6) + 1;
    }
}