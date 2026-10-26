package capitaly;


/**
 *
 * @author mayerhedda
 */
public class Greedy extends Player {
    
    /**
     * Létrehoz egy mohó stratégiájú játékost.
     *
     * @param name a játékos neve
     */
    public Greedy(String name) {
        super(name);
    }
 
    /**
     * Mindig vásárol, ha a tőkéje fedezi az árat.
     *
     * @param price az ingatlan vagy a ház ára
     * @return {@code true}, ha van elég pénze
     */
    @Override
    public boolean wantsToBuy(int price) {
        return money >= price;
    }
}
