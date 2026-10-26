package capitaly;

import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author mayerhedda
 */
public abstract class Player {
    
    /** Az induló tőke, amelyet minden játékos megkap. */
    public static final int START_MONEY = 10000;
    /** A játékos aktuális tőkéje. A leszármazottak a döntésekhez olvassák. */
    protected int money = START_MONEY;
 
    private final String name;
    private int position = 0;
    private boolean out = false;
    private final List<Property> properties = new ArrayList<>();
 
    /**
     * Létrehoz egy játékost az induló tőkével, a pálya első mezőjén.
     *
     * @param name a játékos neve
     */
    protected Player(String name) {
        this.name = name;
    }
 
    /**
     * Lépteti a játékost a körpályán. A pálya végén túllépve elölről folytatja.
     *
     * @param steps a dobott szám, ennyit lép
     * @param size  a pálya hossza
     */
    public void move(int steps, int size) {
        position = (position + steps) % size;
    }
 
    /**
     * Kifizeti a megadott összeget egy másik játékosnak vagy a banknak.
     * Ha a játékosnak nincs elég pénze, kiesik a játékból.
     *
     * @param amount a fizetendő összeg
     * @param to     a kedvezményezett játékos, vagy {@code null}, ha a bank kapja
     * @return {@code true}, ha a fizetés sikerült; {@code false}, ha a játékos kiesett
     */
    public boolean pay(int amount, Player to) {
        if (money < amount) {
            goBankrupt();
            return false;
        }
        money -= amount;
        if (to != null) {
            to.receive(amount);
        }
        return true;
    }
 
    /**
     * Jóváírja a megadott összeget a játékos tőkéjén.
     *
     * @param amount a kapott összeg
     */
    public void receive(int amount) {
        money += amount;
    }
 
    /**
     * Ingatlanvásárlás vagy házépítés: levonja az árat a tőkéből, és ha az ingatlan
     * még nem szerepel a játékos birtokai között, felveszi a listába.
     * A hívónak előtte a `wantsToBuy` metódussal kell ellenőriznie a döntést.
     *
     * @param p     a megvásárolt vagy beépített ingatlan
     * @param price a fizetendő ár
     */
    public void buy(Property p, int price) {
        money -= price;
        if (!properties.contains(p)) {
            properties.add(p);
        }
    }
 
    /**
     * Kör eleji előkészítés, amelyet a játék minden kör elején meghív.
     * Az alaposztályban nem csinál semmit; a stratégiák felüldefiniálhatják.
     */
    public void startTurn() { }
 
    /**
     * A játékos stratégiája: eldönti, hogy vásárol-e az adott áron.
     *
     * @param price az ingatlan vagy a ház ára
     * @return {@code true}, ha a játékos vásárolni szeretne
     */
    public abstract boolean wantsToBuy(int price);
 
    /**
     * Kiesteti a játékost: megjelöli kiesettként, az ingatlanjai újra gazdátlanok lesznek,
     * a házai pedig elvesznek.
     */
    public void goBankrupt() {
        out = true;
        for (Property p : properties) {
            p.reset();
        }
        properties.clear();
    }
 
    /**
     * Visszaadja a játékos nevét.
     *
     * @return a játékos neve
     */
    public String getName() { return name; }
 
    /**
     * Visszaadja a játékos aktuális tőkéjét.
     *
     * @return a tőke Petákban
     */
    public int getMoney() { return money; }
 
    /**
     * Visszaadja, melyik mezőn áll a játékos.
     *
     * @return a mező indexe (0-tól számozva)
     */
    public int getPosition() { return position; }
 
    /**
     * Megadja, hogy a játékos kiesett-e.
     *
     * @return {@code true}, ha a játékos már nincs játékban
     */
    public boolean isOut() { return out; }
 
    /**
     * Visszaadja a játékos ingatlanjait.
     *
     * @return a birtokolt ingatlanok listája
     */
    public List<Property> getProperties() { return properties; }
 
    /**
     * A játékos vagyonának szöveges leírása: név, stratégia, tőke és ingatlanok.
     *
     * @return a játékos leírása a végeredmény kiírásához
     */
    @Override
    public String toString() {
        return name + " (" + getClass().getSimpleName() + "), tőke: " + money
                + " Peták, ingatlanok: " + (properties.isEmpty() ? "nincs" : properties);
    }
}
