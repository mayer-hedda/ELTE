package capitaly;


/**
 *
 * @author mayerhedda
 */
public class Careful extends Player {
    private int budget;
 
    /**
     * Létrehoz egy óvatos stratégiájú játékost.
     *
     * @param name a játékos neve
     */
    public Careful(String name) {
        super(name);
    }
 
    /**
     * A kör elején beállítja a költési keretet a tőke felére.
     */
    @Override
    public void startTurn() {
        budget = money / 2;
    }
 
    /**
     * Csak akkor vásárol, ha az ár belefér a kör költési keretébe.
     *
     * @param price az ingatlan vagy a ház ára
     * @return {@code true}, ha az ár nem nagyobb a hátralévő keretnél
     */
    @Override
    public boolean wantsToBuy(int price) {
        return price <= budget && money >= price;
    }
 
    /**
     * Elvégzi a vásárlást, és az árat levonja a kör költési keretéből is.
     *
     * @param p     a megvásárolt vagy beépített ingatlan
     * @param price a fizetendő ár
     */
    @Override
    public void buy(Property p, int price) {
        super.buy(p, price);
        budget -= price;
    }
}
