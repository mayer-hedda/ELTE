package capitaly;

import java.util.List;

/**
 * A játék menetét vezérlő osztály.
 */
public class Game {

    /** Biztonsági korlát, hogy a játék véletlen dobásokkal se fusson végtelenül. */
    private static final int MAX_ROUNDS = 10000;

    private final Board board;
    private final Dice dice;
    private final List<Player> players;
    private int round = 0;

    /**
     * Létrehoz egy új játékot.
     *
     * @param tiles   a pálya mezői
     * @param players a játékosok
     * @param dice    a használt kocka
     */
    public Game(List<Tile> tiles, List<Player> players, Dice dice) {
        this.board = new Board(tiles);
        this.players = players;
        this.dice = dice;
    }

    /**
     * Addig játssza a köröket, amíg a játék véget nem ér.
     *
     * @return a győztes játékos
     */
    public Player run() {
        while (!isOver()) {
            playRound();
        }
        return getWinner();
    }

    /**
     * Lejátszik egy teljes kört: minden aktív játékos sorra kerül.
     */
    private void playRound() {
        round++;
        for (Player player : players) {
            if (player.isActive()) {
                player.startRound();
            }
        }
        for (Player player : players) {
            if (isOver()) {
                return;
            }
            takeTurn(player);
        }
    }

    /**
     * Lebonyolítja egy játékos lépését: dob, lép, és végrehajtja a mező hatását.
     *
     * @param player a soron következő játékos
     */
    private void takeTurn(Player player) {
        if (!player.isActive()) {
            return;
        }
        int roll = dice.roll();
        int newPosition = board.nextPosition(player.getPosition(), roll);
        player.moveTo(newPosition);
        board.getTile(newPosition).onStep(player);
    }

    /**
     * Megadja, hogy véget ért-e a játék: legfeljebb egy aktív játékos maradt,
     * elfogytak a rögzített dobások, vagy elértük a körök maximális számát.
     *
     * @return igaz, ha a játék véget ért
     */
    private boolean isOver() {
        long activeCount = players.stream().filter(Player::isActive).count();
        return activeCount <= 1 || !dice.hasNext() || round >= MAX_ROUNDS;
    }

    /**
     * Visszaadja a győztest: a még aktív játékosok közül a legnagyobb tőkéjűt
     * (ha csak egy maradt, akkor őt).
     *
     * @return a győztes játékos
     */
    public Player getWinner() {
        Player winner = null;
        for (Player player : players) {
            if (player.isActive()
                    && (winner == null || player.getMoney() > winner.getMoney())) {
                winner = player;
            }
        }
        return winner;
    }
}