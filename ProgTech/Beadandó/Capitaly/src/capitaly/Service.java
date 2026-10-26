package capitaly;


/**
 *
 * @author mayerhedda
 */
public class Service extends Field {
    private final int fee;
 
    /**
     * Létrehoz egy szolgáltatás mezőt a megadott díjjal.
     *
     * @param fee a banknak fizetendő összeg
     */
    public Service(int fee) {
        this.fee = fee;
    }
 
    /**
     * A játékos befizeti a díjat a banknak. Ha nincs elég pénze, kiesik.
     *
     * @param p a mezőre lépő játékos
     */
    @Override
    public void onStep(Player p) {
        p.pay(fee, null); // null = a bank kapja
    }
 
    /**
     * Visszaadja a mező díját.
     *
     * @return a banknak fizetendő összeg
     */
    public int getFee() { return fee; }
}
