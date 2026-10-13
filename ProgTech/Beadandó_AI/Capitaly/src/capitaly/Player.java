package capitaly;

import java.util.ArrayList;
import java.util.List;

/**
 * Absztrakt játékos; a vásárlási döntést a stratégiák valósítják meg.
 */
public abstract class Player {

    public static final int START_MONEY = 10000;

    protected final String name;
    protected int money = START_MONEY;
    protected int position = -1;
    protected boolean active = true;
    protected final List<Property> properties = new ArrayList<>();

    /**
     * Létrehoz egy játékost induló tőkével.
     *
     * @param name a játékos neve
     */
    protected Player(String name) {
        this.name = name;
    }

    /**
     * A játékost a megadott pozícióra helyezi.
     *
     * @param position az új pozíció
     */
    public void moveTo(int position) {
        this.position = position;
    }

    /**
     * Megnöveli a játékos tőkéjét.
     *
     * @param amount a kapott összeg
     */
    public void receive(int amount) {
        money += amount;
    }

    /**
     * Befizet a banknak; ha nincs rá fedezet, a játékos csődbe megy.
     *
     * @param amount a fizetendő összeg
     * @return igaz, ha sikerült fizetni
     */
    public boolean pay(int amount) {
        if (!canAfford(amount)) {
            goBankrupt();
            return false;
        }
        money -= amount;
        return true;
    }

    /**
     * Fizet egy másik játékosnak; ha nincs rá fedezet, a játékos csődbe megy.
     *
     * @param other  a kedvezményezett játékos
     * @param amount a fizetendő összeg
     * @return igaz, ha sikerült fizetni
     */
    public boolean payTo(Player other, int amount) {
        if (!pay(amount)) {
            return false;
        }
        other.receive(amount);
        return true;
    }

    /**
     * Megadja, hogy a játékos ki tudja-e fizetni az összeget.
     *
     * @param amount az összeg
     * @return igaz, ha van rá fedezet
     */
    public boolean canAfford(int amount) {
        return money >= amount;
    }

    /**
     * Hozzáadja az ingatlant a játékos birtokaihoz.
     *
     * @param property az ingatlan
     */
    public void addProperty(Property property) {
        properties.add(property);
    }

    /**
     * Kiejti a játékost: inaktívvá teszi, ingatlanjait felszabadítja.
     */
    public void goBankrupt() {
        active = false;
        for (Property property : properties) {
            property.release();
        }
        properties.clear();
    }

    /**
     * A kör elején hívódik meg; alapból nem csinál semmit.
     */
    public void startRound() {
    }

    /**
     * Megpróbál vásárolni a megadott áron (telket vagy házat).
     *
     * @param price az ár
     * @return igaz, ha a vásárlás megtörtént
     */
    public boolean tryToBuy(int price) {
        if (!canAfford(price) || !wantsToBuy(price)) {
            return false;
        }
        money -= price;
        return true;
    }

    /**
     * A stratégia dönti el, hogy él-e a játékos a vásárlási lehetőséggel.
     * Csak akkor hívódik meg, ha a játékosnak van fedezete.
     *
     * @param price az ár
     * @return igaz, ha vásárolni szeretne
     */
    protected abstract boolean wantsToBuy(int price);

    public String getName() {
        return name;
    }

    public int getMoney() {
        return money;
    }

    public int getPosition() {
        return position;
    }

    public boolean isActive() {
        return active;
    }

    public List<Property> getProperties() {
        return properties;
    }

    /**
     * Szövegesen visszaadja a játékos nevét, tőkéjét és ingatlanjait.
     *
     * @return a játékos leírása
     */
    @Override
    public String toString() {
        String owned = properties.isEmpty() ? "nincs" : properties.toString();
        return name + " (" + getClass().getSimpleName() + "), tőke: " + money
                + " Peták, ingatlanok: " + owned;
    }
}