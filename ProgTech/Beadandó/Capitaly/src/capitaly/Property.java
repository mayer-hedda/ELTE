package capitaly;


/**
 *
 * @author mayerhedda
 */
public class Property extends Field {
    
    /** Az ingatlan vételára. */
    public static final int PRICE = 1000;
    /** A házépítés ára. */
    public static final int HOUSE_PRICE = 4000;
    /** A fizetendő díj, ha nincs ház az ingatlanon. */
    public static final int RENT = 500;
    /** A fizetendő díj, ha van ház az ingatlanon. */
    public static final int RENT_WITH_HOUSE = 2000;
 
    private final int index;
    private Player owner;
    private boolean hasHouse;
 
    /**
     * Létrehoz egy gazdátlan, ház nélküli ingatlant.
     *
     * @param index az ingatlan sorszáma a pályán (0-tól számozva)
     */
    public Property(int index) {
        this.index = index;
    }
 
    /**
     * Lekezeli, ha egy játékos az ingatlanra lép:
     *   - ha gazdátlan, a játékos stratégiája szerint megveheti;
     *   - ha a játékosé és még nincs rajta ház, házat építhet rá;
     *   - ha másé, a játékos díjat fizet a tulajdonosnak (500 Peták ház nélkül, 2000 Peták házzal).</li>
     *
     * @param p az ingatlanra lépő játékos
     */
    @Override
    public void onStep(Player p) {
        if (owner == null) {
            if (p.wantsToBuy(PRICE)) {
                p.buy(this, PRICE);
                owner = p;
            }
        } else if (owner == p) {
            if (!hasHouse && p.wantsToBuy(HOUSE_PRICE)) {
                p.buy(this, HOUSE_PRICE);
                hasHouse = true;
            }
        } else {
            p.pay(hasHouse ? RENT_WITH_HOUSE : RENT, owner);
        }
    }
 
    /**
     * Alaphelyzetbe állítja az ingatlant: törli a tulajdonost és a házat.
     * A tulajdonos kiesésekor hívódik meg, így az ingatlan újra megvásárolható lesz.
     */
    public void reset() {
        owner = null;
        hasHouse = false;
    }
 
    /**
     * Visszaadja az ingatlan tulajdonosát.
     *
     * @return a tulajdonos, vagy {@code null}, ha az ingatlan gazdátlan
     */
    public Player getOwner() { return owner; }
 
    /**
     * Megadja, hogy áll-e ház az ingatlanon.
     *
     * @return {@code true}, ha van rajta ház
     */
    public boolean hasHouse() { return hasHouse; }
 
    /**
     * Visszaadja az ingatlan sorszámát a pályán.
     *
     * @return a mező indexe (0-tól számozva)
     */
    public int getIndex() { return index; }
 
    /**
     * Az ingatlan szöveges leírása a végeredmény kiírásához.
     *
     * @return például {@code "Ingatlan #3 (házzal)"}
     */
    @Override
    public String toString() {
        return "Ingatlan #" + index + (hasHouse ? " (házzal)" : "");
    }
}
