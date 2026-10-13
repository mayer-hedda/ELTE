package capitaly;

/**
 * Taktikus játékos: minden második vásárlási lehetőséget kihagy.
 */
public class Tactical extends Player {

    private boolean skipNext = false;

    public Tactical(String name) {
        super(name);
    }

    /**
     * Felváltva vásárol és hagy ki lehetőséget (az elsőnél vásárol).
     *
     * @param price az ár
     * @return igaz, ha most vásárol
     */
    @Override
    protected boolean wantsToBuy(int price) {
        boolean buy = !skipNext;
        skipNext = !skipNext;
        return buy;
    }
}