package capitaly;

import java.util.Random;


/**
 *
 * @author mayerhedda
 */
public class RandomDice implements Dice {
    private final Random random = new Random();
 
    /**
     * Létrehoz egy véletlen kockát.
     */
    public RandomDice() { }
 
    /**
     * Véletlenszerű dobás.
     *
     * @return egy egyenletes eloszlású szám 1 és 6 között
     */
    @Override
    public int roll() {
        return random.nextInt(6) + 1;
    }
}
