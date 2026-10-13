package capitaly;

/**
 * Szolgáltatás mező: a rálépő játékos díjat fizet a banknak.
 */
public class Service extends Tile {

    private final int fee;

    public Service(int fee) {
        this.fee = fee;
    }

    /**
     * A rálépő játékos befizeti a díjat a banknak.
     *
     * @param player a rálépő játékos
     */
    @Override
    public void onStep(Player player) {
        player.pay(fee);
    }
}