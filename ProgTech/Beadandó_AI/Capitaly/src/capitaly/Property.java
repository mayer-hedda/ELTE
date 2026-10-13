package capitaly;

/**
 * Megvásárolható ingatlan mező, amelyre házat is lehet építeni.
 */
public class Property extends Tile {

    public static final int BUY_COST = 1000;
    public static final int BUILD_COST = 4000;
    public static final int RENT = 500;
    public static final int RENT_WITH_HOUSE = 2000;

    private Player owner = null;
    private boolean hasHouse = false;
    private int index;

    /**
     * Beállítja a mező pályabeli sorszámát (a kiíráshoz).
     *
     * @param index a mező indexe (0-tól)
     */
    public void setIndex(int index) {
        this.index = index;
    }

    /**
     * Gazdátlan ingatlant a játékos megvásárolhat, a sajátjára házat építhet,
     * másénál bérleti díjat fizet a tulajdonosnak.
     *
     * @param player a rálépő játékos
     */
    @Override
    public void onStep(Player player) {
        if (owner == null) {
            if (player.tryToBuy(BUY_COST)) {
                owner = player;
                player.addProperty(this);
            }
        } else if (owner == player) {
            if (!hasHouse && player.tryToBuy(BUILD_COST)) {
                hasHouse = true;
            }
        } else {
            player.payTo(owner, getRent());
        }
    }

    /**
     * Visszaadja a fizetendő bérleti díjat.
     *
     * @return 500 ház nélkül, 2000 házzal
     */
    private int getRent() {
        return hasHouse ? RENT_WITH_HOUSE : RENT;
    }

    /**
     * Gazdátlanná teszi az ingatlant, és eltávolítja róla a házat.
     */
    public void release() {
        owner = null;
        hasHouse = false;
    }

    @Override
    public String toString() {
        return (index + 1) + ". mező" + (hasHouse ? " (házzal)" : "");
    }
}