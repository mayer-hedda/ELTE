package capitaly;

/**
 * Óvatos játékos: egy körben legfeljebb a kör eleji tőkéje felét költi el.
 */
public class Careful extends Player {

    private int budget;

    public Careful(String name) {
        super(name);
    }

    /**
     * A kör elején a vásárlási keretet a tőke felére állítja.
     */
    @Override
    public void startRound() {
        budget = money / 2;
    }

    /**
     * Csak akkor vásárol, ha az ár belefér a keretbe; ekkor csökkenti a keretet.
     *
     * @param price az ár
     * @return igaz, ha vásárol
     */
    @Override
    protected boolean wantsToBuy(int price) {
        if (price > budget) {
            return false;
        }
        budget -= price;
        return true;
    }
}