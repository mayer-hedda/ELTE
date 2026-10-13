package capitaly;

/**
 * Mohó játékos: mindig vásárol, ha van rá fedezete.
 */
public class Greedy extends Player {

    public Greedy(String name) {
        super(name);
    }

    /**
     * Mindig vásárolni akar.
     *
     * @param price az ár
     * @return mindig igaz
     */
    @Override
    protected boolean wantsToBuy(int price) {
        return true;
    }
}