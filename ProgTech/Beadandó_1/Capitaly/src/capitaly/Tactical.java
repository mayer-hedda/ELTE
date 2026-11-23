package capitaly;


/**
 *
 * @author mayerhedda
 */
public class Tactical extends Player {
    private int chances = 0;
 
    /**
     * Létrehoz egy taktikus stratégiájú játékost.
     *
     * @param name a játékos neve
     */
    public Tactical(String name) {
        super(name);
    }
 
    /**
     * Számolja a vásárlási lehetőségeket: az 1., 3., 5. stb. lehetőséggel él
     * (ha van elég pénze), a páratlanokat kihagyja.
     *
     * @param price az ingatlan vagy a ház ára
     * @return {@code true}, ha ez páratlan sorszámú lehetőség, és van elég pénze
     */
    @Override
    public boolean wantsToBuy(int price) {
        chances++;
        boolean skip = chances % 2 != 0;
        return !skip && money >= price;
    }
}
