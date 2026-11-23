package capitaly;


/**
 *
 * @author mayerhedda
 */
public class Lucky extends Field {
    private final int prize;
 
    /**
     * Létrehoz egy szerencse mezőt a megadott nyereménnyel.
     *
     * @param prize a játékosnak jóváírandó összeg
     */
    public Lucky(int prize) {
        this.prize = prize;
    }
 
    /**
     * Jóváírja a nyereményt a rálépő játékosnak.
     *
     * @param p a mezőre lépő játékos
     */
    @Override
    public void onStep(Player p) {
        p.receive(prize);
    }
 
    /**
     * Visszaadja a mező nyereményét.
     *
     * @return a jóváírandó összeg
     */
    public int getPrize() { return prize; }
}
