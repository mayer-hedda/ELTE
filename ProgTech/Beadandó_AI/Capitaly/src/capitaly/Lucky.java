package capitaly;

/**
 * Szerencse mező: a rálépő játékos pénzt kap.
 */
public class Lucky extends Tile {

    private final int reward;

    public Lucky(int reward) {
        this.reward = reward;
    }

    /**
     * A rálépő játékos megkapja a jutalmat.
     *
     * @param player a rálépő játékos
     */
    @Override
    public void onStep(Player player) {
        player.receive(reward);
    }
}