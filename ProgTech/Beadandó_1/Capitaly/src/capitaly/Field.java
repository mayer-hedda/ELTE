package capitaly;


/**
 *
 * @author mayerhedda
 */
public abstract class Field {
    
    /**
     * Létrehoz egy mezőt. Csak a leszármazott osztályok hívják.
     */
    protected Field() { }
 
    /**
     * Végrehajtja a mező hatását a rálépő játékosra
     * (vásárlás, díjfizetés vagy nyeremény jóváírása).
     *
     * @param p a mezőre lépő játékos
     */
    public abstract void onStep(Player p);
}
